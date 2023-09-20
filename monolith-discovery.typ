= Monolith Discovery <Chapter::MonolithDiscovery>

To connect, the load balancer must must know the network addresses of the monoliths, and this process of figuring out where the monoliths are is discovery.

The first case is connecting to the instance of the monolith on fly.io. Before connecting the user inputs the port that the monolith should listen on for the load balancer connection and a string representing the fly app. These properties are both encapsulated by the FlyDiscoveryCongig struct.

To discover the monolith, the configuration and a query are passed into the discoverer struct, FlyMonolithDiscoverer. In order to connect to the instance on fly.io, the query string is formatted and then a connection attempts. An IPv6 lookup is created using the query from before and a response is awaited asynchronously. The discovery process uses the results of the lookup and connects the balancer.

#figure(
  image("figures/fly-class-discovery.svg", height: 50%, width: 50%),
  caption: "Class Diagram for Monolith Discovery of Instance on Fly.io."
) <Figure::fly-class-discovery>

Discovery works slightly differently when connecting to any instance excluding the one on fly.io. Any number of monolith connections, represented by the MonolithConnectionConfig are passed into the manual discoverer. The discoverer then clones the monoliths and connects.

#figure(
  image("figures/manual-class-discovery.svg", height: 50%, width: 50%),
  caption: "Class Diagram for Manual Monolith Discovery."
) <Figure::manual-class-discovery>