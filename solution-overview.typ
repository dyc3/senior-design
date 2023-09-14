= Solution Overview <Chapter::SolutionOverview>

== Current Architecture

The Monolith's current internals is shown in @Figure::monolith-class-current.

#figure(
  image("figures/monolith-class-current.png", width: 40%),
  caption: "Class diagram for the Monolith's current internals"
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
  image("figures/deployment-new.png"),
  caption: "High level overview of OTT's new architecture with a load balancer"
) <Figure::deployment-new>

@Figure::monolith-class-new shows what the Monolith's internals will look like after we take into account the load balancer.

#figure(
  image("figures/monolith-class-new.png"),
  caption: "The Monolith's new internals"
) <Figure::monolith-class-new>

Note how the connection to the balancer is optional. The main differences between this and @Figure::monolith-class-current are:
+ Monoliths now have 2 types of clients representing how the client is connecting to the Monolith.
+ The RoomManager and ClientManager no longer communicate through Redis.