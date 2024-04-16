#import "lib/requirements.typ": *

= Visualization

The load balancer will be showcased at the innovation exposition in April. To help communicate functionality, a graph visualizer will be developed to accompany the load balancer. The visualization will be a single, multiscreen web-application for ease of navigation. The visualization will also be interactive for seamless setup on the day of the exposition to gather/retain attention at the booth.

== Requirements

#figure(
  table(
    columns: 1,
    [#req("Should be eye catching to get more people to stop at the booth", shouldHave)],
    [#req("Must run on a production environment", mustHave)],
    [#req("Must gather number of monoliths, rooms within each monolith, and users in each room from the balancer", mustHave)],
    [#req("Must have options for different views", mustHave)],
    [#req("Should be able to interact with the state of the balancer", wouldBeNiceToHave)],
    [#req("Should support multiple balancers", shouldHave)],
    [#req("Should play an animation when a new user joins through the balancer", wouldBeNiceToHave)],
    [#req("Must be able to configure the size of nodes", mustHave)],
    [#req("Must be configurable to fetch from self-hosted instance or fly.io deployment of OpenTogetherTube", mustHave)],
    [#req("Must effectively communicate functionality to a non-technical audience", mustHave)],
    [#req("Must function as a useful debugging tool", mustHave)],
    [#req("Must assign unique colors to each type of node", mustHave)],
    [#req("Must have a legend", mustHave)],
    [#req("Must not display offensive material from user generated content during the Expo", mustHave)],
  ),
  caption: "General Visualization Requirements"
) <Table::visualization-requirements>

== Types of Visualizations

There will be multiple types of visualizations to show different aspects of the system. They are as follows:

=== Region View

The purpose of this visualization is to how different resources are spread across different regions.

#figure(
  image("figures/vis/region-view.png"),
  caption: "The Region View displaying sample data showing 2 Balancers and 2 Monoliths in ewr, 1 Balancer and 1 Monolith in cdg."
) <Figure::region-view>

=== Tree View

The purpose of this visualization is to show the logical hierarchy of resources in the system.

#figure(
  image("figures/vis/tree-view.png"),
  caption: "The Tree View displaying sample data showing 3 Balancers (center, orange) and 3 Monoliths (green), with rooms (purple) attached to each Monolith, and clients (red) attached to each room."
) <Figure::tree-view>

=== Topology View

The purpose of this visualization is to show the physical layout of resources in the system.

#figure(
  image("figures/vis/topology-view.png", width: 80%),
  caption: "The Topology View displaying sample data showing 2 Balancers and 2 Monoliths in ewr, 1 Balancer and 1 Monolith in cdg."
) <Figure::topology-view>

=== Traffic Heat Map

The purpose of this visualization is to show where user traffic is coming from.

#figure(
  image("figures/vis/traffic-heat-visualization.png"),
  caption: "Figma Mockup of Traffic Heat Map Visualization"
) <Figure::traffic-heat-visualization>

This visualization will display a world map with heat circles in regions where there is user traffic. Higher concentrations of users will correspond to a bubble with a warmer color.

=== User Traffic Graph

The purpose of this visualization is to show the total amount of user traffic to OpenTogetherTube over a selected period of time.

#figure(
  image("figures/vis/user-traffic-visualization.png"),
  caption: "Figma Mockup of User Traffic Visualization"
) <Figure::user-traffic-visualization>

The x-axis represents time, the y-axis represents OTT traffic

=== Latency Graph

The purpose of this visualization is to show average server latency in real time.

#figure(
  image("figures/vis/latency-graph-visualization.png"),
  caption: "Figma Mockup of Latency Graph Visualization"
) <Figure::latency-graph-visualization>

The x-axis represents time, the y-axis represents server latency.
