#set par(justify: true)
#set page(footer: [#line(length: 100%, stroke: rgb(160, 1, 42))])

#show heading.where(level: 1): it => [

  #set text(17pt, weight: "regular", fill: rgb(160, 1, 42))
  #block(smallcaps(it.body))
]

#show heading.where(level: 2): it => [
  #set align(center)
  #set text(17pt, weight: "regular", fill: rgb(160, 1, 42))
  #block(smallcaps(it.body))
]

= OTT Load Balancer

#line(length: 100%, stroke: rgb(160, 1, 42))

Members: Victor Giraldo, Carson McManus, Michael Moreno, Christopher Roddy

Software Engineering Department.

Advised by Prof. Darian Muresan

#columns(2)[
  == Unlocking Scalability for Stateful Applications

- Our project's goal is to build a load balancer for stateful applications to allow legacy systems to scale horizontally. Horizontal scaling refers to adding additional nodes, while vertical scaling is adding more power to current machines. For the sake of limiting our scope, we chose to focus on a single application: OpenTogetherTube (OTT).
- OTT's userbase is steadily expanding, and the current infrastructure is incapable of accommodating the anticipated growth. Horizontal scaling is not an option, leaving vertical scaling as the only possible viable, but it is both costlier and subject to many limitations.

== Proof of Concept (OTT)

- OTT is a website that allows users to watch videos together.
- The figures below depict the current and proposed new architecture for OTT. The balancer will distribute load between multiple instances of a Monolith, while the Monolith will be responsible for managing rooms.
- Implementation of the load balancer will allow an application to be deployed around the world, lower latency for users, improve reliability, and allow for a larger number of simultaneous users.

#figure(
  image("figures/deploy/deployment-current.svg"),
  caption: "Current Architecture"
) <Figure::deployment-current>

#figure(
  image("figures/deploy/deployment-new.svg"),
  caption: "New Architecture"
) <Figure::deployment-new>
]
