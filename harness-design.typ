= Test Harness Design

Each `Test` must be managed and executed by a `TestRunner`. The `TestRunner` is responsible for initializing an instance of the Balancer, and cleaning it up when the test is complete. The `TestRunner` is also responsible for executing the test, and indicating the results.

A `Test` is defined as a function that can create emulated Clients and Monoliths, send and recceive messages from the Balancer, and make assertions what the Balancer should do.

#figure(
	image("figures/harness-test-runner-topology.svg"),
	caption: [The Topology of a `TestRunner` inside the Harness, and how it relates to the Balancer and the `Test` being executed.]
) <Figure::harness-test-runner-topology>

== Auth Tokens

Auth tokens must be present in all the places they would normally be, but they do not need to be verified in a testing environment. Therefore, all HTTP requests that would have auth tokens should have them, but they should be ignored by the Balancer, and emulated Monoliths.

== Emulated Monoliths

Emulated Monoliths are not actual Monoliths, they merely act like them. To that end, each emulated Monolith needs to listen on 2 ports each (one for normal http traffic, and one for the balancer websocket connections). This also means that there needs to be a Monolith discoverer that the harness can use to convey the correct ports to the Balancer. (@Section::HarnessMonolithDiscovery)

== Emulated Clients

Emulated Clients are similar to emulated Monoliths, but they do not need to listen on any ports. They merely need to be able to connect to the Balancer, and send/receive messages. They should behave like a normal client, and they should optionally be able to keep track of the room state they are connected to.

== Conveying Emulated Monoliths to Balancer Discovery <Section::HarnessMonolithDiscovery>

TODO: write about Balancer's `HarnessMonolithDiscoverer` and Harness' `DiscoveryProvider`
