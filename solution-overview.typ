= Solution Overview <Chapter::SolutionOverview>

== Current Architecture

The Monolith's current internals is shown in @Figure::monolith-class-current. It heavily uses redis to communicate between the RoomManager and ClientManager. As clients send messages to the Monolith, the ClientManager handles them and sends them to the RoomManager. The RoomManager receives and processes the messages. Rooms are entirely managed by the RoomManager. When rooms send messages to clients, it must go back through the ClientManager. This is because the ClientManager is the only component that knows which clients are in which rooms.

#figure(
  image("figures/monolith/monolith-class-current.svg", width: 40%),
  caption: "Class diagram for the Monolith's internals, before any changes were made to support the Balancer."
) <Figure::monolith-class-current>

It suffers from years of ad-hoc development, and is not designed to scale. It's riddled with technical debt from previous attempts at horizontal scaling. In it's current state, it is not possible to add more monoliths without causing room synchronization issues. The solution to this problem is to use a load balancer.

== A Smart Load Balancer

The solution to scaling OTT is to use a load balancer. The Balancer will be an optional, seperate component that would be deployed alongside the Monoliths.

=== What is a load balancer?

A load balancer is a server that distributes load across multiple servers. It is a common solution to the problem of scaling a web application.

The load balancer must be able to:

- Distribute load across multiple Monoliths
- Forward HTTP requests to the correct Monolith
- Send WebSocket messages to the correct Monolith


These requirements imply that a normal HTTP load balancer (like nginx) will not work, and the need for a specialized implementation. The specifics of how the load balancer will work will be discussed in the following chapters.

== New Architecture

With the load balancer, OTT's architecture will look like this: @Figure::deployment-new

#figure(
  image("figures/deploy/deployment-new.svg"),
  caption: [Deployment Diagram: High level overview of OTT's new architecture with a load balancer. A diagram of OTT's production deployment is shown in @Figure::deployment-geo.]
) <Figure::deployment-new>

@Figure::monolith-class-new shows what the Monolith's internals will look like after we take into account the load balancer.

#figure(
  image("figures/monolith/monolith-class-new.svg"),
  caption: "The Monolith's new internals"
) <Figure::monolith-class-new>

Note how the connection to the balancer is optional. The main differences between this and @Figure::monolith-class-current are:
+ Monoliths now have 2 types of clients representing how the client is connecting to the Monolith.
+ The RoomManager and ClientManager no longer communicate through Redis.

== Production deployment

Fly abstracts away the details of deploying applications to specific computers. Instead, Fly provides "machines" that are effectively docker container instances. Machines can be deployed to multiple regions, but a machine can only be deployed to one region at a time because it maps directly to a physical server. Machines belong to "Apps", which represents a base docker image from which machines are created.

The plan is to deploy OTT in multiple regions. Currently, OTT is deployed in the `ewr` region in Newark, NJ. `ewr` will remain the primary region. The `cdg` region will be the secondary region, located in Paris. To save on cost, exactly 1 Balancer and 1 Monolith will be deployed in each region. @Figure::deployment-geo shows how OTT will be deployed in production. `fly-proxy` is a reverse proxy managed by Fly that sits in front of every Fly application. It is used to terminate TLS and provide a single hostname for all applications. All inter-app communication is done in a wireguard network, encrypted.

#figure(
  image("figures/deploy/deployment-geo.svg"),
  caption: "Deployment Diagram: How OTT will be deployed in production across multiple regions."
) <Figure::deployment-geo>
