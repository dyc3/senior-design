= Monolith Discovery <Chapter::MonolithDiscovery>

In order to establish connections with Monoliths, the Balancer needs to know the network address of each Monolith. This is done through a process called discovery. The discovery process is responsible for finding the network address of each Monolith and connecting to it. @Figure::general-sequence-discovery shows the sequence diagram for the discovery process.

There are 2 different discovery modes: Polling and Continuous. Polling is used for `MonolithDiscoverer`s that do not provide real time updates (Like `FlyMonolithDiscoverer`), and Continuous is used for `MonolithDiscoverer`s that do provide real time updates (Like `HarnessMonolithDiscoverer`). The discovery process is ultimately the same for both modes.

#figure(
  image("figures/general-class-discovery.svg"),
  caption: "Class Diagram for the Monolith Discovery Process."
) <Figure::general-class-discovery>

#figure(
  image("figures/general-sequence-discovery.svg"),
  caption: "Sequence Diagram for the Monolith Discovery Process."
) <Figure::general-sequence-discovery>

== Implementation

There are three current implementations of the `MonolithDiscoverer` trait.

#figure(
  image("figures/monolith-discoverers.svg", width: 85%),
  caption: "Class Diagram for Monolith Discoverers."
) <Figure::monolith-discoverers>

The first implementation is used when connecting to the instance of the monolith on fly.io. Before connecting the user inputs the port that the monolith should listen on for the load balancer connection and a string representing the fly app. These properties are both encapsulated by the `FlyDiscoveryConfig` struct.

To discover the monolith, the configuration and a query are passed into the discoverer struct, `FlyMonolithDiscoverer`. In order to connect to the instance on fly.io, an IPv6 DNS lookup is created using the query `global.<fly app name>.internal` #cite(<fly-dns-lookups>). The discovery process uses the results of the lookup and connects the balancer.

The second implementation is used when manually connecting to any instance excluding the one on fly.io and the discovery process works slightly differently. Any number of monolith connections, represented by the `MonolithConnectionConfig` are passed into the manual discoverer. The discoverer then clones the monoliths and connects.

`HarnessMonolithDiscoverer` is the third implementation and is used for testing with the harness. The discoverer opens a port and listens for incoming websocket connections. When a connection is made, the discoverer listens for a message from the harness dictating all the monoliths that are visible to the balancer.
