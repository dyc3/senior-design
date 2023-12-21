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

== Development Environment

@Figure::ports-1-monolith and @Figure::ports-2-monolith, demonstrate how to set up any number of Balancers and Monoliths. The listening ports are configurable, and they are labeled on the diagrams in the format `ENVIRONMENT_VAR=value`. Additionally, corresponding balancer configurations are shown to the right of the diagrams.

#figure(
	grid(
		columns: (2fr, 1fr),
		image("figures/dev-env/ports-1-monolith.svg", height: 50%),
		align(left)[
			`balancer.toml`
			```toml
			[discovery]
			method = "manual"

			[[discovery.monoliths]]
			host = "localhost"
			port = 3002
			```

			Commands to run:
			```bash
			# Terminal 0 - Balancer
			cargo run --bin ott-balancer-bin -- --config-path env/balancer.toml
			# Terminal 1 - Monolith
			yarn run start
			```
		]
	),
	caption: "Diagram showing how ports for each process should be configured for development, shown on the left. Note that the values shown in this diagram are the default values, so you shouldn't need to set any environment variables to get this configuration. However, you will need this specific config file for the balancer to work, shown on the right.",
) <Figure::ports-1-monolith>

#figure(
	grid(
		columns: (2fr, 1fr),
		image("figures/dev-env/ports-2-monolith.svg", height: 50%),
		align(left)[
			`balancer.toml`
			```toml
			[discovery]
			method = "manual"

			[[discovery.monoliths]]
			host = "localhost"
			port = 3002

			[[discovery.monoliths]]
			host = "localhost"
			port = 3004
			```

			Commands to run:
			```bash
			# Terminal 0 - Balancer
			cargo run --bin ott-balancer-bin -- --config-path env/balancer.toml
			# Terminal 1 - Monolith 0
			yarn run start
			# Terminal 2 - Monolith 1
			PORT=3003 BALANCING_PORT=3004 yarn run start
			```
		]
	),
	caption: "Diagram showing the same thing as @Figure::ports-1-monolith, but with two Monoliths instead of one. Note that for the 2nd Monolith, you *will* need to set the environment.",
) <Figure::ports-2-monolith>
