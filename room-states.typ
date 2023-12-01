#import "@preview/in-dexter:0.0.5": *

= Maintaining Room State <Chapter::RoomState>

Room State#index[Room State] refers to the state of a Room, which includes, but is not limited to, the following:
- Room Settings (title, description, visibility, queue mode, etc.)
- The current video
- Video Queue
- A list of users in the room

As required by @Req::single-entity, from any client connecting to OTT, it must always appear that OTT is a single entity, even though it could be a distributed system. This means that from anywhere in the world, if 2 clients join a room called "foo", they should see the same state of the Room.

In this document, when we say something is in a "good" or "healthy" state, we mean that the system is functioning as expected and the state of the system is consistent across all Balancers and Monoliths. When we say something is in a "bad" state, we mean that the system is not functioning as expected and the state of the system is inconsistent across Balancers and Monoliths.

== Lost Balancer-Monolith Connections

When a Balancer-Monolith connection is lost, clients connected to that monolith need to be handled appropriately. Otherwise, the accuracy of room state is compromised.
All client connections that are in rooms on the lost monolith are no longer valid, so they need to be disconnected and removed
from their rooms. From there, they can reconnect to a monolith with a new websocket connection to the balancer.

== Duplicate Rooms Across Monoliths <Section::duplicate-rooms-across-monoliths>

As required by @Req::room-uniqueness, 2 Monoliths must never have the same room loaded, as the load balancer should be directing all connections for a given room to the designated monolith for that room.
In the case that this does happen, the system is in a bad state and it must be resolved. This can occur as a race condition within the context of any number of Balancers. The planned solution to this issue is to have the load balancer unload rooms that were not the
first instance of that particular room. This means that the duplicate instances would be unloaded and the clients could then rejoin the room in a healthy state.

In order to accomplish this, every room must be accociated with a "load epoch". The load epoch #index[load epoch] is a system global atomic counter that is incremented every time a room is loaded, maintained in redis.
When a room is loaded, the load epoch is incremented and the room is associated with the current load epoch. There is no need to ever reset the load epoch to 0. If the value rolls over, then the system will still function correctly. However, it must remain in the range of an unsigned 32 bit integer, because javascript does not support 64 bit integers #cite(<mdn-js-int>).

Whenever the Balancer is notified of the room load and the room is already loaded, it checks to see if the load epoch of the new room is less than the load epoch of the existing room. If it is, then the old room is unloaded, clients are kicked, and the new room is treated as the source of truth.
Otherwise, the new room is unloaded and the old room is treated as the source of truth.

#figure(
  image("figures/duplicate-rooms.svg"),
  caption: "Correcting system state following duplicate room instances."
) <Figure::duplicate-rooms>

== Maintaining Room State Across Service Restarts <Section::state-across-restarts>

When OTT is deployed, the Monolith is restarted. In order to make this not disruptive to end users, room state is constantly being flushed to redis. When OTT starts up, it gets a list of all the rooms that were loaded and tries to restore their state. The problem is that if a monolith restarts, then it will load all the rooms that are in redis. In a deployment with more than one monolith, this results in rooms existing on more than one monolith.

It's possible to simply allow the system to reach equilibrium using the mechanism described in @Section::duplicate-rooms-across-monoliths. However, this would result in a high memory usage on the Monolith upon startup. It would also result in a lot of unnecessary network traffic and load on redis.

The solution is to have rooms be lazy loaded from redis when they are needed. This means that when a client tries to join a room, if the room state is in redis, then the room state will be restored from redis. If the room state is not in redis, then the room will be loaded from the database. This also makes it easier to handle losing Monoliths. If a Monolith is lost, then the clients can reconnect and they will be routed to a new Monolith, which will load the room from redis.

== Migrating Room State Between Monoliths

The solution outlined in @Section::state-across-restarts also enables the ability to migrate room state between Monoliths. #index-main[migration] When a Monolith shuts down, all the clients will be disconnected. When they reconnect, they will be routed to a new Monolith. The new Monolith will load the room state from redis. This results in the room state having been migrated to the new Monolith.
