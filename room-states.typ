#import "@preview/in-dexter:0.0.5": *

= Maintaining Room State <Chapter::RoomState>

== Lost Balancer-Monolith Connections

When a Balancer-Monolith connection is lost, clients connected to that monolith need to be handled appropriately. Otherwise, the accuracy of room state is compromised.
All client connections that are in rooms on the lost monolith are no longer valid, so they need to be disconnected and removed
from their rooms. From there, they can reconnect to a monolith with a new websocket connection to the balancer.

== Duplicate Rooms Across Monoliths <Section::duplicate-rooms-across-monoliths>

Two monolith nodes should never have the same room loaded, as the load balancer should be directing all connections for a given room to the designated monolith using its preserved states.
In the case that this does happen, the system is then in a bad state and it must be resolved. The planned solution to this issue is to have the load balancer unload rooms that were not the
first instance of that particular room. This means that the duplicate instances would be unloaded and the clients could then rejoin the room in a healthy state. In order to accomplish this,
every room must have a timestamp associated with it, designating the time it was loaded. Then, in the case of duplication, the timestamps can be compared and the more recently loaded
instances can be handled appropriately. Following this, clients who were connected to a bad load of a room should be redirected to the home page where they can enter a new flow of room
creation or room joining.

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
