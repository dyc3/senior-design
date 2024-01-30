= Visualization Design

The visualization serves a dual purpose: To communicate the functionality of the load balancer at a glance to a non-technical audience, and to serve as a useful debugging tool during development.

== Hosting

Due to time constraints, the visualization will be self-hosted on the user's machine. If needed, a subdomain of OpenTogetherTube can be established at a later time.

== Frameworks/Libraries

The visualization must be ready before the innovation exposition on April 26 and is not the main focus of the project. With this in mind D3.js, Grafana, and React have been selected for development.

The fesability of developing a plugin with grafana compatible with was a point of concern, however there is documented evidence of such plugins being built. Additionally, setting up a project with D3.js and Vue.js is also well documented, there are no forseen reasons or evidence (at the original time of writing: 1/13/24) that any of these technologies are incompatible. Below are some helpful links:

- D3.js Getting Started: https://d3js.org/getting-started
- Grafana Quick Start: https://grafana.com/developers/plugin-tools/
- Grafana Example Plugins: https://grafana.com/developers/plugin-tools/plugin-examples/
- Grafana and D3.js: https://community.grafana.com/t/build-a-panel-plugin-with-d3-js/35450
- Grafana and Vue.js: https://github.com/westc/grafana-vuehtml-panel

It is unlikely D3.js will be required for any visualization views other than the Default and Region views.

#figure(
  table(
    columns: 2,
    [*View*],[*Graph Type*],
    [Default], [D3.js Force Graph],
    [Region], [D3.js Force Graph],
    [Latency Graph], [Grafana Panel],
    [Traffic Heat Map], [Grafana Panel],
    [Traffic/Time], [Grafana Panel]
  ),
  caption: "Visualization Views and Graph Type"
)

== Data Format

The visualization will need to recieve an array of balancers:

```json
balancers = []
```

Each balancer must have a state, and from that state, the following is needed:

```json
balancer = {
  monoliths: Monolith[],
  region: string,
}
```
While not explicitly required, having a complete count of the number of clients would be helpful for the purposes of the traffic graph would be helpful. A way to measure and fetch server latency is also needed.

Each monolith contains rooms:

```json
monolith = {
  rooms: Room[],
}
```

Each room has a name, and clients that are connected. The clients themselves are not necessary to be read by the visualization, but rather just the number of clients in each room:

```json
room = {
  name: string,
  clients: int
}
```

== Recieving Information From Balancers

The load balancer is one part of a distributed system, and many instances of the balancer can be active simultaneously. One instance of the visualization should have the capability of recieving information from multiple balancers, and should do so in real time. Additionally, the visualization should have the capability of recieving data from both the official deployment of OTT on fly.io and self-hosted instances.

There are two possible ways of gathering data from the balancer:

- Querying Prometheus with Grafana: Grafana supports querying Prometheus, and there is documentation linked below on a quick start for creating a new data source. Given the balancer has already integrated Prometheus for metrics, this is the preferred method for gathering data. There is no mention on compatibility with D3.js, but assuming there are no issues integrating D3.js into a Grafana panel, this should not be a problem. #cite(<grafana-prometheus-visualization>)

- Directly Querying Fly.io: This method involves setting up a VPN connection using WireGuard to connect through Fly.io's 6PN private network. Documentation is linked #cite(<DNS-discover-wireguard>)

== Development Schedule

#figure(
  table(
    columns: 2,
    [*Milestone*],[*Date*],
    [Design Finalized],[1/20/24],
    [Prototype],[1/30/24],
    [Views Finished],[2/20/24],
    [Testing/Refactoring],[3/5/24],
    [Visualization Complete],[3/12/24],
  ),
  caption: "Development Schedule for Graph Visualizer"
)
