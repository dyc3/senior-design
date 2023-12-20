#import "lib/requirements.typ": *

= Visualization Requirements

The load balancer will be showcased at the innovation expo in April. To help communicate functionality, a graph visualizer will be developed to accompany the load balancer.

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
  )
)

== Paper Prototype

TODO: Import Picture of Paper Prototype