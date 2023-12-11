= Balancer Design

== Package Structure

In Rust, packages are called "crates". The Balancer and Harness is split into multiple crates, as seen in @Figure::balancer-crates. The reason for this is that cargo, the Rust package manager, treats crates as the unit of compilation. This means that if you change a single line of code in a crate, the entire crate must be recompiled. By splitting the Balancer into multiple crates, we can reduce the amount of code that needs to be recompiled when a change is made.

#figure(
	image("figures/balancer-crates.svg"),
	caption: "Package diagram showing the Balancer and Harness crates.",
) <Figure::balancer-crates>
