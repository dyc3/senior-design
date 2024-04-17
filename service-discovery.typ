= Service Discovery <Chapter::ServiceDiscovery>

In order to establish connections with Monoliths, the Balancer needs to know the network address of each Monolith. Similarly, the collector needs to know the network addresses of Balancers for visualization. This is done through a process called discovery. The discovery process is responsible for finding the network address of each Monolith and connecting to it. @Figure::discovery-sequence shows the sequence diagram for the discovery process.

There are 2 different discovery modes: Polling and Continuous. Polling is used for `ServiceDiscoverer`s that do not provide real time updates (Like `FlyServiceDiscoverer`), and Continuous is used for `ServiceDiscoverer`s that do provide real time updates (Like `HarnessServiceDiscoverer`). The discovery process is ultimately the same for both modes.

#figure(
  image("figures/discovery/discovery-class.svg"),
  caption: "Class Diagram for the Service Discovery Process."
) <Figure::discovery-class>

#figure(
  image("figures/discovery/discovery-sequence.svg"),
  caption: "Sequence Diagram for the Service Discovery Process."
) <Figure::discovery-sequence>

== Implementation

The current implementations of the `ServiceDiscoverer` trait are diagrammed in @Figure::service-discoverers.

#figure(
  image("figures/discovery/service-discoverers.svg", width: 85%),
  caption: "Class Diagram for Service Discoverers."
) <Figure::service-discoverers>

The first implementation is used when connecting to the instance of the Monolith on fly.io. Before connecting the user inputs the port that the Monolith should listen on for the load balancer connection and a string representing the fly app. These properties are both encapsulated by the `FlyDiscoveryConfig` struct.

To discover the Monolith, the configuration and a query are passed into the discoverer struct, `FlyServiceDiscoverer`. In order to connect to the instance on fly.io, an IPv6 DNS lookup is created using the query `global.<fly app name>.internal` #cite(<fly-dns-lookups>). The discovery process uses the results of the lookup and connects the Balancer.

The second implementation is used when manually connecting to any instance excluding the one on fly.io and the discovery process works slightly differently. Any number of monolith connections, represented by the `ConnectionConfig` are passed into the manual discoverer. The discoverer then clones the Monoliths and connects.

`HarnessServiceDiscoverer` is the third implementation and is used for testing with the harness. The discoverer opens a port and listens for incoming WebSocket connections. When a connection is made, the discoverer listens for a message from the harness dictating all the Monoliths that are visible to the Balancer.

The fourth implementation comes in the form of `DnsServiceDiscoverer` when connecting the Monolith to the Docker DNS server. This process follows a similar procedure to that of `FlyServiceDiscoverer` but queries IPv4 addresses instead of IPv6 addresses as Docker does not support IPv6 addresses.
