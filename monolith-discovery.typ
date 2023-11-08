= Monolith Discovery <Chapter::MonolithDiscovery>

To connect, the load balancer must know the network addresses of the monoliths, and this process of figuring out where the monoliths are is discovery.

This is crucial to the ability of the balancer to function when considering the point of the load balancer is to distribute incoming connections more efficently. Discovery must be a continual process since new connections can always appear. When an active connection disconnects, the discoverer should keep track of this so the balancer can free space.

Before anything else, the discoverer needs a host or ip address to find the monolith instance since the balancer and monolith aren't dependent on one another, and a port to listen on for incoming connections. After connecting, the discoverer must continuously listen on the specified port for new incoming connections and keep track of any disconnections. The balancer should also be updated regularly on the results of the discovery process.

#figure(
  image("figures/general-class-discovery.svg", width: 50%),
  caption: "Class Diagram for the Monolith Discovery Process."
) <Figure::general-class-discovery>

#figure(
  image("figures/general-sequence-discovery.svg", width: 50%),
  caption: "Sequence Diagram for the Monolith Discovery Process."
) <Figure::general-sequence-discovery>

== Implementation

There are three current implementations of the discoverer.

#figure(
  image("figures/monolith-discoverers.svg", width: 85%),
  caption: "Class Diagram for Monolith Discoverers."
) <Figure::fly-class-discovery>

The first implementation is used when connecting to the instance of the monolith on fly.io. Before connecting the user inputs the port that the monolith should listen on for the load balancer connection and a string representing the fly app. These properties are both encapsulated by the `FlyDiscoveryConfig` struct.

To discover the monolith, the configuration and a query are passed into the discoverer struct, `FlyMonolithDiscoverer`. In order to connect to the instance on fly.io, an IPv6 DNS lookup is created using the query `global.<fly app name>.internal` #cite(<fly-dns-lookups>). The discovery process uses the results of the lookup and connects the balancer.

The second implementation is used when manually connecting to any instance excluding the one on fly.io and the discovery process works slightly differently. Any number of monolith connections, represented by the `MonolithConnectionConfig` are passed into the manual discoverer. The discoverer then clones the monoliths and connects.

`HarnessMonolithDiscoverer` is the third implementation and is used for testing with the harness. The discoverer opens a port and listens for incoming websocket connections. When a connection is made, the discoverer listens for a message from the harness dictating all the monoliths that are visible to the balancer.
