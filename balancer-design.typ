= Balancer Design

== Internal Architecture

#figure(
	image("figures/balancer-internals-class.svg"),
	caption: "Class diagram showing the structure and relationships between types in the Balancer.",
) <Figure::balancer-internals-class>

Shown in @Figure::balancer-internals-class is the internal structure of the Balancer. The Balancer will discover Monoiths using the `MonolithDiscoverer` (a process further described in @Chapter::MonolithDiscovery), and the `MonolithConnectionManager` will establish connections to each Monolith. `Balancer` will update `BalancerContext` according to the messages it receives from `BalancerLink`. `Balancer` will then use `BalancerContext` to route messages to the appropriate Monoliths. Clients work similarly, except that they establish connections to the Balancer via `BalancerService`. `BalancerService` handles proxying HTTP requests to the appropriate Monoliths, and also accepting and upgrading WebSocket connections.

== Package Structure

In Rust, packages are called "crates". The Balancer and Harness is split into multiple crates, as seen in @Figure::balancer-crates. The reason for this is that cargo, the Rust package manager, treats crates as the unit of compilation. This means that if you change a single line of code in a crate, the entire crate must be recompiled. By splitting the Balancer into multiple crates, we can reduce the amount of code that needs to be recompiled when a change is made.

#figure(
	image("figures/balancer-crates.svg"),
	caption: "Package diagram showing the Balancer and Harness crates.",
) <Figure::balancer-crates>

== Dependencies

#let dependencies = toml("Cargo.toml")

#figure(
	table(
		[*Dependencies*],
		[#dependencies.workspace]
	),
	caption: "External dependencies required by the balancer"
)

#table(
	[*External Dependencies*],
	[*Package Name/Description*],
	[anyhow: Error handling],
	[async-trait: Support for asyncronous functions in traits],
	[bytes: Utility library for working with bytes],
	[clap: Command line argument parser],
	[console-subscriber: Debugging for asyncronous Rust],
	[figment: File parsing],
	[futures-util: Combinators and utilities for working with Futures, Streams, Sinks, and the AsyncRead and AsyncWrite traits],
	[hyper:HTTP implementation for Rust],
	[hyper-util: Do common things with hyper],
	[http-body-util: Asyncronous operations on HTTP body],
	[once_cell: Generics],
	[pin-project: Pin projection in configs],
	[prometheus: Metrics],
	[rand: Random Numbers],
	[reqwest: High level HTTP Client],
	[serde: Serializing and deserializing Rust data structures],
	[serde_json: JSON parsing],
	[test-context: Custom setup and teardown for testing without needing a test harness],
	[tokio: Building blocks for writing network applications],
	[tokio-tungstenite: Implementation of WebSockets],
	[tokio-util: Utilities for working with Tokio],
	[tracing: Logging and diagnostics],
	[tracing-subscriber: Client tracing],
	[tungstenite: Websockets],
	[typeshare: Types and functions for code that defines or uses #[typeshare] types],
	[url: Implementation of URL standard in Rust],
)
