= Team Declaration

== Team

Name: OTT

Members:
- Carson McManus
- Christopher Roddy
- Victor Giraldo
- Michael Moreno

== Mission Statement

Our mission is to build a load balancer for stateful applications meant to enable legacy, monolithic systems to scale horizontally.

While most all web applications have state in the form of a database, we define a stateful application as one that requires state to be maintained in the application itself for the health of the overall system. For example, a chat application that stores messages in a database is stateful, but a chat application that stores messages in memory is not. The latter can be scaled horizontally trivially, but the former cannot. Generally, these applications perform operations on the state that are more complex than simple CRUD operations, and/or involve 2 way communication with the client.

Examples of stateful applications include:
- Video conferencing applications
- Multiplayer games
- CRUD applications that use database sharding to distribute database load

Ultimately, the product will be a reverse proxy (similar to nginx or apache) you can place in front of a legacy application that will allow you to scale the application horizontally without worrying about the state of the application. All that would be needed from the customer is routing configuration based on their application's needs.

However, for the purpose of limiting the scope of this project, we will be focusing on a single application: OpenTogetherTube. OpenTogetherTube (OTT) is a watch party application that allows users to watch online videos together. It is a stateful application because it an open websocket connection to each client, and groups those clients into rooms. Our efforts will be focused on making the Node.js server (aka the Monolith) scalable.

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
