#import "lib/requirements.typ": *

= Visualization

The load balancer will be showcased at the innovation expo in April. To help communicate functionality, a graph visualizer will be developed to accompany the load balancer. The visualization(s) will be web-based and interactive for seamless setup on the day of the expo and to gather/retain attention at the booth.

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
    [#req("Navigation between visualizations must be intuitive", mustHave)],
    [#req("Should support multiple balancers", shouldHave)],
    [#req("Many monoliths, rooms, or users on-screen at once must be condensed into one point", mustHave)],
    [#req("Should play an animation when a new user joins through the balancer", wouldBeNiceToHave)],
    [#req("Monoliths should grow with the number of rooms", wouldBeNiceToHave)],
    [#req("Rooms should grow with the number of clients", wouldBeNiceToHave)],
    [#req("Balancer node should never be smaller than a monolith", mustHave)],
    [#req("Monolith nodes should never be smaller than a room", mustHave)],
    [#req("Components should be physics objects in a no-gravity environment", wouldBeNiceToHave)]
  ),
  caption: "Basic Visualization Requirements"
)

== Default

A figma mockup and description of the default visualization:

#figure(
  image("figures/basic-graph-visualizer.png"),
  caption: "Figma Mockup of Default Balancer Visualization"
  )

This figure represents the default case of one balancer being active, and no specific views/groupings (such as region) being active. As new monoliths are instantiated, they will appear on screen tethered to the balancer. As new rooms are instantiated, they will appear on-screen alongside the client that created them tethered to the appropriate monolith. Clients will not appear on-screen until they are connected to a room. When a monolith goes offline, the node representing it and any clients connected to that monolith should dissappear The room(s) connected to the (now disconnected) monolith should remain on-screen for some predetermined amount of time in the case a client connected to that room reconnects so it can be tethered to a new monolith.

