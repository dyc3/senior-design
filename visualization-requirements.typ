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
    [#req("Points on the graph should be draggable", wouldBeNiceToHave)],
    [#req("Should be able to interact with the state of the balancer", wouldBeNiceToHave)],
    [#req("Should support multiple balancers", shouldHave)],
    [#req("Many monoliths, rooms, or users on-screen at once must be condensed into one point", mustHave)],
    [#req("Should play an animation when a new user joins through the balancer", wouldBeNiceToHave)],
    [#req("Monoliths should grow with the number of rooms", wouldBeNiceToHave)],
    [#req("Rooms should grow with the number of clients", wouldBeNiceToHave)],
    [#req("Balancer node should never be smaller than a monolith", mustHave)],
    [#req("Monolith nodes should never be smaller than a room", mustHave)],
    [#req("Components should be physics objects in a no-gravity environment", wouldBeNiceToHave)],
    [#req("Must be configurable to fetch from self-hosted instance or fly.io deployment of OpenTogetherTube", mustHave)],
    [#req("Must effectively communicate functionality to a non-technical audience", mustHave)],
    [#req("Must function as a useful debugging tool", mustHave)],
  ),
  caption: "General Visualization Requirements"
) <Table::visualization-requirements>

== Types of Visualizations

There will be multiple types of visualizations to show different aspects of the system. They are as follows:

=== Global

The purpose of the global visualization is to show functionality and overall state of the Balancer to an audience. As a result, it's expected that only one balancer will be on-screen at any given time for this visualization since its function is to communicate the concept of a load balancer and how it applies to OpenTogetherTube.

#figure(
  image("figures/vis/basic-graph-visualizer.png"),
  caption: "Figma Mockup of Global Balancer Visualization"
) <Figure::basic-graph-visualizer>

This figure represents the global case of one Balancer being active, and no specific views/groupings (such as region) being active. As new Monoliths are instantiated, they will appear on screen tethered to the Balancer. As new rooms are instantiated, they will appear on-screen alongside the client that created them tethered to the appropriate Monolith. Clients will not appear on-screen until they are connected to a room. When a Monolith goes offline, the node representing it and any clients connected to that Monolith should disappear The room(s) connected to the (now disconnected) Monolith should remain on-screen for some predetermined amount of time in the case a client connected to that room reconnects so it can be tethered to a new Monolith.

=== Monolith View

Most visitors to the innovation expo booth will not know what a load balancer is, or why it is important. The purpose of this visualization is to show the process of connecting from start to finish.

#figure(
  image("figures/vis/monolith-view-visualization.png"),
  caption: "Figma Mockup Monolith View"
  ) <Figure::monolith-view-visualization>

When clicking on a specific Monolith, the screen pictured above should appear. When a client joins, an animation should play showing a client enter the Balancer node, move to the Monolith, and then to the associated room. As a stylistic choice, clients should move with a delay from node-to-node in a single-file line, with any excess clients staying inside the current node until there is room to exit the current node.

=== Region

The purpose of this visualization is to show the the scale of the load balancer, and how multiple instances of the Balancer interact.

#figure(
  image("figures/vis/region-visualization.png"),
  caption: "Figma Mockup of Region Visualization"
) <Figure::region-visualization>

This visualization is a bit different than the others since multiple instances of the balancer will be on-screen at the same time. Balancer nodes will be unique, but grouping for Monoliths, rooms, and clients will be active by global. No animations aside from node movement will be implemented since this visualization is expected to take the most screen space.

=== Traffic Heat Map

The purpose of this visualization is to show where user traffic is coming from

#figure(
  image("figures/vis/traffic-heat-visualization.png"),
  caption: "Figma Mockup of Traffic Heat Map Visualization"
) <Figure::traffic-heat-visualization>

This visualization will display a world map with heat circles in regions where there is user traffic. Higher concentrations of users will correspond to a bubble with a warmer color.

=== User Traffic Graph

The purpose of this visualization is to show the total amount of user traffic to OpenTogetherTube over a selected period of time

#figure(
  image("figures/vis/user-traffic-visualization.png"),
  caption: "Figma Mockup of User Traffic Visualization"
) <Figure::user-traffic-visualization>

The x-axis represents time, the y-axis represents OTT traffic

=== Latency Graph

The purpose of this visualization is to show average server latency in real time

#figure(
  image("figures/vis/latency-graph-visualization.png"),
  caption: "Figma Mockup of Latency Graph Visualization"
) <Figure::latency-graph-visualization>

The x-axis represents time, the y-axis represents server latency
