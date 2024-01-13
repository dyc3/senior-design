= Visualization Design

The visualization serves a dual purpose: To communicate the functionality of the load balancer at a glance to a non-technical audience, and to serve as a useful debugging tool during development.

== Hosting

Due to time constraints, the visualization will be self-hosted on the user's machine. If needed, a subdomain of OpenTogetherTube can be established at a later time.

== Frameworks/Libraries

The visualization must be ready before the innovation exposition on April 26 and is not the main focus of the project. With this in mind, Vue.js, D3.js have been selected for development due to their popularity, ease of use, and low-learning curve. Grafana has also been added to the technology stack of the visualization since developing a plugin could save significant amounts of time in fetching data from balancers and the fly.io deployment of OTT.

The fesability of developing a plugin with grafana compatible with was a point of concern, however there is documented evidence of such plugins being built. Additionally, setting up a project with D3.js and Vue.js is also well documented, there are no forseen reasons or evidence (at the time of writing: 1/13/24) that any of these technologies are incompatible. Below are some helpful links:

- Vue.js Documentation: https://vuejs.org/guide/introduction.html
- D3.js Getting Started: https://d3js.org/getting-started
- Grafana Quick Start: https://grafana.com/developers/plugin-tools/
- Grafana Example Plugins: https://grafana.com/developers/plugin-tools/plugin-examples/
- Grafana and D3.js: https://community.grafana.com/t/build-a-panel-plugin-with-d3-js/35450
- Grafana and Vue.js: https://github.com/westc/grafana-vuehtml-panel
- Vue.js and D3.js: https://blog.logrocket.com/data-visualization-vue-js-d3/

It is unlikely D3.js will be required for any visualization views other than the Default and Region views.

#figure(
  table(
    columns: 2,
    [*View*],[*Graph Type*],
    [Default], [TBD],
    [Region], [TBD],
    [Latency Graph], [TBD],
    [Traffic Heat Map], [TBD],
    [Traffic/Time], [TBD]
  ),
  caption: "Visualization Views and Graph Type"
)

== Gathering Data

TBD

== Development Schedule

#figure(
  table(
    columns: 2,
    [*Milestone*],[*Date*],
    [Design Finalized],[1/17/24],
    [Prototype],[1/26/24],
    [Views Finished],[2/15/24],
    [Testing/Refactoring],[2/29/24],
    [Visualization Complete],[3/7/24],
  ),
  caption: "Development Schedule for Graph Visualizer"
)
