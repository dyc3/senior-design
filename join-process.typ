#import "@preview/in-dexter:0.0.5": *

= Join Process <Chapter::JoinProcess>

There are 2 types of nodes in this architecture. The first type is the OTT Monolith, which refers to the current node.js monolithic server. The second type is the Smart Load Balancer, which needs to know which Monoliths control which rooms, and how to route requests to the correct Monolith.

For the sake of simplicity, the initial implementation of the Balancer will be a single node. This can be upgraded to a cluster of load balancers in the future.

#figure(
  image("figures/client-reconnect-sequence.svg"),
  caption: "Sequence diagram for proposed new join behavior."
) <Figure::client-reconnect-sequence>

== Joining a Loaded Room

In the Monolith, "loading" a room is literally creating an instance of a room in memory.

Shown in @Figure::join-room-happy-path, the client is joining a room that is already loaded on a Monolith node. First, the client initiates a WebSocket connection to the Balancer, in the form of a HTTP request with the GET method, and headers to indicate that a protocol upgrade is required. The client immediately sends an "auth" message to convey their identity to the Balancer. The Balancer looks at the path of the request and extracts the room name, and references it's internal hashmap to find the Monolith that is hosting the room. The Balancer then opens a WebSocket connection using the auth token provided by the client.

If the client fails to provide an auth token, the Balancer must terminate the connection as "timed out".

#figure(
  image("figures/join-room-happy-path.svg"),
  caption: "Joining an already loaded room, the most simple scenario."
) <Figure::join-room-happy-path>

=== Monolith Gossip Protocol

Balancers must be able to determine which Monolith nodes are hosting which rooms.

Monolith nodes must gossip to Balancer nodes to inform them of the rooms that they have loaded. This also implies that they must notify all Balancers of their existence on startup. The Balancer must maintain a hashmap of room names to Monolith nodes.

They must also maintain a hashmap of Monolith nodes to a list of rooms that they are hosting to verify that only one Monolith is hosting a room at a time. When the gossip is received, the Balancer must check to see if, in the event a Balancer finds more than one Monolith is hosting a room, it must randomly select one of the Monoliths to be the authoritative node for that room, and inform other Monoliths that they must unload the room. This method will not work as effectively if there is more than one Balancer, but it is a simple solution for the initial implementation.

Monoliths must gossip:

- when a connection to a Balancer is established
- when a room is loaded
- when a room is unloaded
- at a maximum interval of 20 seconds (eg. if 20 seconds pass without a room being loaded or unloaded, the Monolith must gossip)

The gossip message must contain a list of rooms that the Monolith is hosting (@Figure::gossip-class-diag). To save on bandwidth, when a room is loaded or unloaded, only information about that room is sent to the Balancer in the form of "load" and "unload" messages.

#figure(
  image("figures/gossip-class-diag.svg", width: 20%),
  caption: "Simplified gossip class diagram."
) <Figure::gossip-class-diag>

== Creating or Loading Rooms

The client will have three options: generating a temporary room with a uuid, creating a temporary room with inputs, and creating a permanent room that can be rejoined in the future.

The options follow similar sequence paths, as shown in @Figure::create-room-diag. The client starts a new Balancer connection through the WebSocket, then the Balancer is responsible for deciding which node is best fit to handle the additional room. Once the right one is picked, the room is instantiated on that Monolith and the client connects. Before proceeding with the client connection, the Balancer must wait for the Monolith to confirm that the room has been loaded. If the room is not loaded within a certain amount of time, the Balancer must terminate the connection as "timed out".

Room generation requires no inputs from the client, instead a new uuid is automatically used as the room name. On the other hand, room creation has the client submit a set of inputs for the name and settings of the room. Generation only provides temporary rooms that are discarded after the room is unloaded. Creation can provide either temporary or permanent rooms, depending on the client inputs during the initial process. The settings for permanent rooms are stored in postgres even after being unloaded so that they persist and can be called upon to be reloaded at any point in the future.

#figure(
  image("figures/create-room-diag.svg"),
  caption: "Creating or generating a new room."
) <Figure::create-room-diag>

=== Lifetime of a Room

Rooms are only kept loaded in memory if there are clients that are connected to them. If a room is loaded and there are no clients connected, it will be unloaded after a certain amount of time.

#figure(
  image("figures/room-keepalive-timing.svg"),
  caption: "A timing diagram describing the lifetime of a loaded Room in a Monolith's memory."
) <Figure::room-keepalive-timing>

=== Monolith Node Selection <Section::MonolithNodeSelection>

The Balancer must be able to select the Monolith that is most appropriate to handle the join. Specifically:

- If the requested room is already loaded, the Balancer must select the Monolith that is hosting the room.
- Otherwise, the Balancer must select the Monolith with the lowest number of loaded rooms. The Monolith will load the room on demand, if it exists in the database.

== Joining an Unloaded Room
When a user tries to join a permanent room in OpenTogetherTube, the request is first received by the Balancer.
The Balancer forwards the request to one of the available Monoliths based on the current load balancing algorithm (See @Section::MonolithNodeSelection).
This process is shown in @Figure::unloaded-room.

#figure(
  image("figures/use-cases/unloaded-room.svg"),
  caption: "Sequence diagram for a client joining an unloaded room."
) <Figure::unloaded-room>
