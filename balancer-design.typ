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

#let cargo = toml("Cargo.toml")
#let crates = cargo.workspace.dependencies

#let build_table(data) = {
  let keys = data.keys()
	let rows = ()

	for (key, value) in data {
		if(type(value) == str) {
			rows.push((key, value, ""))
		} 
		else if(type(value) == dictionary) {
			let row = (key,)
			
			if(value.keys().contains("version")) { row.push(value.version) }
			else if(value.keys().contains("path")) { row.push(value.path) }
			else if(value.keys().contains("git")) { row.push(value.git) }

			if(value.keys().contains("features")) {
				let features = value.features.join(", ")

				row.push(features)
			}
			else if(value.keys().contains("rev")) { row.push(value.rev) }
			else { row.push("") }

			rows.push(row)
		}
		else {
			rows.push((key, "", ""))
		}
	}

	table(
		columns: 3,
		[*Crate*],[*Version*],[*Features*],
		..rows.flatten()
	)
}

#figure(
	build_table(crates),
	caption: "External Rust dependencies required for all workspace crates"
)