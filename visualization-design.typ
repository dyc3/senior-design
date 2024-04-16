= Visualization Design <Chapter::Visualization-Design>

The visualization serves a dual purpose: To communicate the functionality of the load balancer at a glance to a non-technical audience, and to serve as a useful debugging tool during development.

#figure(
  image("figures/vis/DOM-class-visualization.svg"),
  caption: "Class Diagram Explaining How a Component using React and D3.js is Rendered to the DOM"
) <Figure::DOM-class-visualization>

== Hosting

Due to time constraints, the visualization will be self-hosted on the user's machine. If needed, a subdomain of OpenTogetherTube can be established at a later time.

== Frameworks/Libraries

The visualization must be ready before the innovation exposition on April 26 and is not the main focus of the project. With this in mind D3.js, Grafana, and React have been selected for development.

#figure(
  image("figures/vis/visualization-package.svg", width: 50%),
  caption: "Package Diagram for Visualization"
) <Figure::visualization-package>

The figure above represents the three major libraries and frameworks utlized to create the visualization. Both Grafana and D3.js have dependencies on React in the context of creating a web-app (like the visualization) and one of the major technical challenges of creating the visualization will be integrating D3.js into a Grafana panel.

The fesability of developing a plugin with grafana compatible with was a point of concern, however there is documented evidence of such plugins being built. Additionally, setting up a project with D3.js and Grafana is also well documented, there are no forseen reasons or evidence (at the original time of writing: 1/13/24) that any of these technologies are incompatible. Below are some helpful links:

- D3.js Getting Started: https://d3js.org/getting-started
- Grafana Quick Start: https://grafana.com/developers/plugin-tools/
- Grafana Example Plugins: https://grafana.com/developers/plugin-tools/plugin-examples/
- Grafana and D3.js: https://community.grafana.com/t/build-a-panel-plugin-with-d3-js/35450

#figure(
  table(
    columns: 2,
    [*View*],[*Graph Type*],
    [Region], [D3.js Force Graph],
    [Latency Graph], [Grafana Panel],
    [Traffic Heat Map], [Grafana Panel],
    [Traffic/Time], [Grafana Panel]
  ),
  caption: "Visualization Views and Graph Type"
) <Table::visualization-types>

== Grafana

Grafana is an open source data motitoring platform allowing users to explore metrics from any storage location #cite(<grafana-basic-about>). In the context of the visualization, Grafana is a framework that does most of the heavy lifting associated with building a data visualization tool.

#figure(
  image("figures/vis/visualization-class-high-level.svg", height: 30%),
  caption: "High Level Class Diagram of Grafana Visualization Structure"
) <Figure::visualization-class-high-level>

Grafana contains dashboards, and dashboards contain panels, the "building blocks" of the platform. Panels have a data source that can be linked to a database and a query editor for performing operations on the source. Multiple queries can be configured to display multiple values (or graphs) within the same panel #cite(<grafana-panel-info>).

=== How Grafana Plugins Work

Grafana plugins are built using React, and are essentially a web application that is embedded into a Grafana dashboard. The plugin is a separate project from the dashboard, and is built using the Grafana Toolkit. The plugin is then added to a dashboard as a panel, and the dashboard is then added to a Grafana instance. The plugin is then able to query data from the Grafana instance, and display it in the panel. See @Figure::grafana-plugin-hierarchy.

#figure(
  image("figures/vis/grafana-plugin-hierarchy.svg", height: 50%),
  caption: "Class diagram showing the relationship between Grafana, the plugin, and dashboards."
) <Figure::grafana-plugin-hierarchy>

== D3.js

D3.js is an open source JavaScript library for visualizing data and has a low-level approach that gives the developer a lot of flexibility in how their data is displayed. D3.js is advertised as an alternative to doing it yourself, not as an alternative to a high-level charting library #cite(<d3-info>).

The reason for using this library is because of its embrace of web standards like SVG and to allow creation of visualizations that would be harder to implement into a Grafana panel without D3.js.

== Data Format

The visualization will need to receive an array of balancers:

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

Each room has a name, and clients that are connected. The clients themselves are not necessary to be read by the visualization, but rather just the number and id of clients in each room:

```json
room = {
  name: string,
  clients: Client[],
}
```

```json
client = {
  id: string
}
```

== Data Gathering

The load balancer is one part of a distributed system, and many instances of the Balancer can be active simultaneously. One instance of the visualization should have the capability of receiving information from multiple Balancers, and should do so in real time. Additionally, the visualization should have the capability of receiving data from both the official deployment of OTT on fly.io and self-hosted instances.

Grafana supports querying Prometheus, and there is documentation linked below on a quick start for creating a new data source. Given the Balancer has already integrated Prometheus for metrics, this is the preferred method for gathering data. There is no mention on compatibility with D3.js, but assuming there are no issues integrating D3.js into a Grafana panel, this should not be a problem. #cite(<grafana-prometheus-visualization>)

== Receiving Information From Load Balancers

Grafana is a tool primarily meant for time series data, and no current data source plugins support receiving the type of information needed. To add support a custom data source must be created.

=== Balancer Discovery

While the visualization is running: Multiple instances of the Balancer can be active simultaneously, new instances can become active, and instances can go offline. The addresses of these Balancers are not known at runtime, so a discovery process similar to @Chapter::ServiceDiscovery must run to collect data from the discovered Balancers.

In order to achieve this, a new rust crate will be created to handle this discovery process. Implementation will likely be similar to @Chapter::ServiceDiscovery. A port will be opened to listen for active instances of the Balancer. When a connection or connections are found, the Balancer discoverer clones the Balancer(s) and connects.

=== Querying Balancers

#figure(
  image("figures/vis/visualization-balancer-datasource-sequence.svg"),
  caption: "Sequence Diagram Explaining How Grafana Receives Data From Load Balancers"
) <Figure::visualization-balancer-datasource-sequence>

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
) <Table::visualization-dev-schedule>

== Panel Structure

The custom panel will be structured as shown in @Figure::panel-internal-class. It will be able to render the region view (@Figure::region-visualization), the tree view, and the topology view. The panel will provide a selector in `PanelOptions` to switch between the views.

#figure(
  image("figures/vis/panel-internal-class.svg", height: 80%),
  caption: "Class diagram of the custom Grafana panel, showing it's internal structure."
) <Figure::panel-internal-class>

== Streamed Events

The visualization will be able to receive streamed events from the Balancers for realtime updates of the visualization. The collector is responsible for receiving these events and passing them to the datasource via WebSockets. The panel will then update the visualization accordingly. @Figure::vis-collector-component shows how the collector interacts with the visualization.

#figure(
  image("figures/vis/vis-collector-component.svg"),
  caption: [Component diagram showing the internal components of the collector and how they interact with the rest of the system.]
) <Figure::vis-collector-component>

In the Balancer, events are sourced directly from the Balancer's logs via a `Layer` from the `tracing` crate.

== Dev Environment
#import "balancer-design.typ": text-box

There are 4 components that need to be running in order to have the visualization working correctly:
+ Grafana instance
+ Collector
+ Balancer
+ Monolith

See @Section::dev-env for instructions on running the Monolith with the Balancer.

The easiest way to do this is with the `with-balancer.docker-compose.yml` file. This file will run the balancer, monolith, and collector in a docker-compose environment.

#text-box(
  raw("docker-compose -f docker/with-balancer.docker-compose.yml up -d")
)

#let vis-dev-env-figure(path, caption, balancer-config, collector-config, commands) = {
	figure(
		grid(
			columns: 2,
			gutter: 20pt,
			image(path),
			align(left)[
				#grid(
					gutter: 10pt,
					[
						`balancer.toml`

						#text-box(
							raw(balancer-config, lang: "toml"),
						)
					],
					[
						`collector.toml`

						#text-box(
							raw(collector-config, lang: "toml"),
						)
					],
					[
						`Commands to run:`

						#text-box(
							raw(commands, lang: "bash"),
						)
					]
				)
			]
		),
		caption: caption,
	)
}

#vis-dev-env-figure(
  "figures/dev-env/vis-dev-env-docker.svg",
  "Visualization Development Environment Setup (with docker)",
  read("data/dev-env/balancer.docker.toml"),
  read("data/dev-env/collector.docker.toml"),
	read("data/dev-env/commands-vis-docker.txt"),
) <Figure::vis-dev-env-docker>

Alternatively, @Figure::vis-dev-env-no-docker shows how to run the balancer, monolith, and collector without docker.

#vis-dev-env-figure(
  "figures/dev-env/vis-dev-env-no-docker.svg",
  "Visualization Development Environment Setup (without docker)",
  read("data/dev-env/balancer.no-docker.toml"),
  read("data/dev-env/collector.no-docker.toml"),
  read("data/dev-env/commands-vis-no-docker.txt"),
) <Figure::vis-dev-env-no-docker>

=== Checklist

- Ensure Grafana is accessible at #link("http://localhost:3500")
- Ensure both the datasource and panel have been built
- Ensure the balancer is running
  - Make sure an api key is set in the config
- Ensure the monolith is running
  - Make sure load balancing is enabled
- Ensure the collector is running and accessible at #link("http://localhost:8000")
  - Make sure the collector is configured with the balancer's api key
