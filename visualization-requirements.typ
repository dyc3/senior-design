#import "lib/requirements.typ": *

= Visualization Requirements

The load balancer will be showcased at the innovation expo in April. To help communicate functionality, a graph visualizer will be developed to accompany the load balancer. The visualization(s) will be web-based and interactive for seamless setup on the day of the expo and to gather/retain attention at the booth.

== Requirements

#figure(
  table(
    columns: 1,
    [#req("Should be eye catching to get more people to stop at the booth", shouldHave)],
    [#req("Must run on a production environment", mustHave)],
    [#req("Must gather metrics from the balancer", mustHave)],
    [#req("Must have options for different views", mustHave)],
    [#req("Points on the graph should be draggable", wouldBeNiceToHave)],
    [#req("Should be able to interact with the state of the balancer", wouldBeNiceToHave)]
  ),
  caption: "Visualization Requirements"
)

== Paper Prototype

An initial sketch-up and description of the visualization:

#figure(
  image("figures/visualization-paper-prototype.png"),
  caption: "Paper Prototype for Balancer Visualization"
  )

To make it interactive, anyone that comes up to the booth should be able to add a monolith onto the screen. Ideally, all the on-screen components should be physics objects with no gravity loosely tethered to one another. Anytime a room is created it should be “spawned” from the appropriate monolith, and anytime a new client joins, it should be vacuumed into the balancer and should not reappear until they join a room. There shouldn’t be more than a couple monoliths, rooms, or clients on-screen at a time for the sake of space and if too many are present they should be “condensed” into one larger object that shakes around almost like it’s about to pop.