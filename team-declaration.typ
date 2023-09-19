#import "@preview/in-dexter:0.0.5": *

= Team Declaration

== Team

Name: OTT

Members:
- Carson McManus
- Christopher Roddy

== Mission Statement

Our mission is to build a load balancer for stateful applications meant to enable legacy, monolithic systems to scale horizontally. To manage scope, we will focus solely on making it work for OpenTogetherTube.

Ultimately, the product will be a program you can place in front of a legacy application that will allow you to scale the application horizontally without worrying about the state of the application. All that would be needed from the customer is routing configuration based on their application's needs.

== Key Drivers

- It is impossible to scale the application horizontally. This means that the application can only be scaled vertically, which is more expensive, and has limits.
- Node.js is asynchronous, but single threaded, which significantly limits the amount of vertical scaling that can be done.
- OTT's userbase is growing (although slowly), and the current architecture will not be able to handle the load in the future.
- OTT is very brittle in some areas. It is very easy to break the application by making a small change, and frequent downtime, even if brief, pushes users away. Being able to minimize the impact of a Monolith crash is extremely valuable.
- Because only one instance of the Monolith is running at a time, it is impossible to do multi-region deployments, which harms responsiveness for users in other regions.

See @motivation for more details.

== Key Constraints

- Changes to the Monolith must not affect current deployments. The load balancer must be optional, it should still be possible to run a single instance of the Monolith without the load balancer.
- The Balancer must be able to handle any number of Monolith instances, and work well with any number of other Balancers.
- Adding or removing Monoliths or Balancers to the system should just work. The system should be able to handle changes to the number of instances without any downtime, and without any negative impact on users.
