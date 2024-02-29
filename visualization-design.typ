= Visualization Design <Chapter::Visualization-Design>

The visualization serves a dual purpose: To communicate the functionality of the load balancer at a glance to a non-technical audience, and to serve as a useful debugging tool during development.

#figure(
  image("figures/vis/visualization-component.svg"),
  caption: "Component Diagram Showing the File Structure and Dependencies of the Visualization"
) <Figure::visualization-component>

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

It is unlikely D3.js will be required for any visualization views other than the Global and Region views.

#figure(
  table(
    columns: 2,
    [*View*],[*Graph Type*],
    [Global], [D3.js Force Graph],
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

== Data Gathering

The load balancer is one part of a distributed system, and many instances of the balancer can be active simultaneously. One instance of the visualization should have the capability of recieving information from multiple balancers, and should do so in real time. Additionally, the visualization should have the capability of recieving data from both the official deployment of OTT on fly.io and self-hosted instances.

Grafana supports querying Prometheus, and there is documentation linked below on a quick start for creating a new data source. Given the balancer has already integrated Prometheus for metrics, this is the preferred method for gathering data. There is no mention on compatibility with D3.js, but assuming there are no issues integrating D3.js into a Grafana panel, this should not be a problem. #cite(<grafana-prometheus-visualization>)

== Recieving Information From Load Balancers

Grafana is a tool primarily meant for time series data, and no current data source plugins support receiving the type of information needed. To add support a custom data source must be created.

=== Balancer Discovery

While the visualization is running: Multiple instances of the balancer can be active simultaneously, new instances can become active, and instances can go offline. The addresses of these balancers are not known at runtime, so a discovery process similiar to @Chapter::ServiceDiscovery must run to collect data from the discovered balancers.

In order to achieve this, a new rust crate will be created to handle this discovery process. Implementation will likely be similar to @Chapter::ServiceDiscovery. A port will be opened to listen for active instances of the balancer. When a connection or connections are found, the balancer discoverer clones the balancer(s) and connects.

=== Querying Balancers

#figure(
  image("figures/vis/visualization-balancer-datasource-sequence.svg"),
  caption: "Sequence Diagram Explaining How Grafana Recieves Data From Load Balancers"
) <Figure::visualization-balancer-datasource-sequence>

=== Collection and Aggregation

Data collection will be handled by Grafana with a custom datasource that allows serialized JSON data to be passed in to the panel and then into the associated React component.

Data gathered must also be aggregated, an example Grafana aggregation rule can be found below:

```json
{
  "metric": "process_start_time_seconds",
  "drop_labels": ["container", "instance", "namespace", "pod"],
  "aggregations": ["sum:counter"],
  "aggregation_interval": "60s",
}
```

More information on data aggregation rules in Grafana can be found here: #cite(<grafana-data-aggregation>).

=== Data Source Setup Instructions From Grafana Documentation

To pull metrics from Prometheus into a Grafana panel, Prometheus must first be added as a data source. This requires provisioning the data source:

```yaml
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    # Access mode - proxy (server in the UI) or direct (browser in the UI).
    url: http://localhost:9090
    jsonData:
      httpMethod: POST
      manageAlerts: true
      prometheusType: Prometheus
      prometheusVersion: 2.44.0
      cacheLevel: 'High'
      disableRecordingRules: false
      incrementalQueryOverlapWindow: 10m
      exemplarTraceIdDestinations:
        # Field with internal link pointing to data source in Grafana.
        # datasourceUid value can be anything, but it should be unique across all defined data source uids.
        - datasourceUid: my_jaeger_uid
          name: traceID

        # Field with external link.
        - name: traceID
          url: 'http://localhost:3000/explore?orgId=1&left=%5B%22now-1h%22,%22now%22,%22Jaeger%22,%7B%22query%22:%22$${__value.raw}%22%7D%5D'
```

This is an example configuration for provisioning a Prometheus data source. Once this is done, Prometheus must be configured to scrape metrics from Grafana by editing the configuration file (`grafana.ini` or `custom.ini`):

```ini
# Metrics available at HTTP URL /metrics and /metrics/plugins/:pluginId
[metrics]
# Disable / Enable internal metrics
enabled           = true

# Disable total stats (stat_totals_*) metrics to be generated
disable_total_stats = false

# basic_auth_username =
# basic_auth_password =
```

Setting a username and password is optional, only set if you want to require authorization to view the metrics endpoint. After the configuration file is edited as shown above and Grafana is restarted, the metrics should be accessable at http://localhost:3000/metrics.

Next, add the job to your `prometheus.yml` file. Example:

```yaml
- job_name: 'grafana_metrics'

   scrape_interval: 15s
   scrape_timeout: 5s

   static_configs:
     - targets: ['localhost:3000']
```

This example job instructs Prometheus to scrape from port 3000 every 15 seconds. After adding the job, restart Prometheus and it should appear on the targets tab.

Finally in Grafana, hover your mouse over the Configuration (gear) icon on the left sidebar and then click Data Sources. Select the Prometheus data source, and on the Dashboards tab, import the Grafana metrics dashboard. All scaped metrics should now be available.

=== Data Source Setup Instructions From Prometheus

To create a Prometheus data source in Grafana:

- Click on the "cogwheel" in the sidebar to open the Configuration menu.
- Click on "Data Sources".
- Click on "Add data source".
- Select "Prometheus" as the type.
- Set the appropriate Prometheus server URL (for example, http://localhost:9090/)
- Adjust other data source settings as desired (for example, choosing the right Access method).
- Click "Save & Test" to save the new data source.

To create a new Grafana graph:

- Click the graph title, then click "Edit".
- Under the "Metrics" tab, select your Prometheus data source (bottom right).
- Enter any Prometheus expression into the "Query" field, while using the "Metric" field to lookup metrics via autocompletion.
- To format the legend names of time series, use the "Legend format" input. For example, to show only the method and status labels of a returned query result separated by a dash, you could use the legend format string {{method}} - {{status}}.
- Tune other graph settings until you have a working graph.

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

The custom panel will be structured as shown in @Figure::panel-internal-class. It will be able to render the global view (@Figure::basic-graph-visualizer), and region view (@Figure::region-visualization). The panel will provide a selector in `PanelOptions` to switch between the two views.

#figure(
  image("figures/vis/panel-internal-class.svg", height: 80%),
  caption: "Class diagram of the custom Grafana panel, showing it's internal structure."
) <Figure::panel-internal-class>
