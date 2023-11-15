= Visualization

We need a way to visualize #index[visualize] the system in a way that is easy to understand and shows the various components working together. The purpose of this visualization is for debugging, and to show the system to others for demonstration purposes during the innovation expo. #index[demo]

== Demo Requirements

#import "lib/requirements.typ": *

#figure(
	table(
		columns: 1,
		[#req("Must visualize the connections between Clients and Monoliths", mustHave)],
		[#req("Must visualize what rooms are open and what Clients are in them", mustHave)],
		[#req("Must visualize what Monoliths have which rooms", mustHave)],
		[#req("Must censor swears, slurs, and NSFW from any user generated content (room names, video titles, user names)", mustHave)],
		[#req("Could be real-time", couldHave)],
		[#req("Could have animations for state changes", couldHave)],
		[#req("Should render consistently and deterministically. Repeated renders of identical source data should not cause visual elements to jump around the screen.", shouldHave)],
		[#req("Visualize messages as they flow through the system", wouldBeNiceToHave)],
		[#req("Could display playback state on Rooms", couldHave)],
	),
	caption: [Visualization Requirements]
)

== Visualization: System State Tree

The purpose of this visualization is to show the state of the entire system as it appears from the perspective of a single Balancer. It should look something like this:

#figure(
	image("figures/visualization/system-state-tree.png", width: 50%)
	caption: [Visualization: System State Tree]
)

This could be used as a starting point for the visualization: https://observablehq.com/@d3/tree/2

== Visualization: Data Flow Graph

The purpose of this visualization is to show the flow of data between all Nodes in the system. It should take the form of an undirected graph, where each node is a Balancer, Monolith, or Room. The edges between Balancers and Monoliths represents the WebSocket connection between them. The edges between Monoliths and Rooms represents which Rooms are managed by which Monoliths.

As messages are sent and received by the Balancers, they should be displayed on the graph in the form of an animated circle that moves from the sender to the receiver.

It should look something like this:

#figure(
	image("figures/visualization/data-flow-graph.png", width: 50%)
	caption: [Visualization: Data Flow Graph]
)

== System Design

TODO: elaborate

- Web based
- using D3.js for visualization
- using websockets for real-time data
- Balancer will output `tracing` events to logs
- Visualizer will read `tracing` events from logs, convert them to json, and send them verbatim to all visualizer clients
