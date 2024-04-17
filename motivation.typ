= Project Introduction & Motivation <motivation>

OpenTogetherTube is a website that allows users to watch videos together. It is a free and open source alternative to services like Watch2Gether and Kosmi. It is currently deployed at #link("https://opentogethertube.com")[opentogethertube.com]. The website is built using a monolithic architecture in Node.js. While this was a huge boon initially for developing new features quickly, it's starting to show it's cracks.

@Figure::deployment-current shows how OTT is currently deployed in production today, and @Figure::components-monolith shows the internal components of the Monolith.

#figure(
  image("figures/deploy/deployment-current.svg"),
  caption: "Deployment Diagram: High level overview of the current, typical OTT production deployment"
) <Figure::deployment-current>

#figure(
  image("figures/monolith/components-monolith.svg", width: 80%),
  caption: "Component Diagram: High level overview of Monolith internal components"
) <Figure::components-monolith>

This architecture has a few drawbacks:

- It is impossible to scale the application horizontally. This means that the application can only be scaled vertically, which is more expensive, and has limits.
- Node.js is asynchronous, but single threaded, which significantly limits the amount of vertical scaling that can be done.
- OTT's userbase is growing (although slowly), and the current architecture will not be able to handle the load in the future.
- OTT is very brittle in some areas. It is very easy to break the application by making a small change, and frequent downtime, even if brief, pushes users away. Being able to minimize the impact of a Monolith crash is extremely valuable.
- Because only one instance of the Monolith is running at a time, it is impossible to do multi-region deployments, which harms responsiveness for users in other regions.

In order to address these issues, we propose an additional, optional service that can be placed in front of the OTT Monolith and act as a load balancer. This load balancer will be able to distribute load across multiple instances of the OTT Monolith, and will enable future work to be done to make OTT more robust and scalable.

There currently is no off the shelf load balancer that would be appropriate for OTT's use case, for reasons that will be discussed in the following chapters. This project aims to create a load balancer that is specifically designed for OTT's use case, but ultimately could be generalized to other applications.

Additionally, this project will enable lots of future work to be done to make OTT more robust and scalable. This includes things like blue-green deployments.
