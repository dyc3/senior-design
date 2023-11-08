= Test Harness Design

The test harness utilizes Rust's libtest to aggregate and run tests. For each test function, we add a setup and teardown step to spin up and tear down the Balancer (as provided by the `test-context` #cite(<crate-test-context>) crate), and then we run the test function. The test function is responsible for creating emulated Monoliths and Clients, and sending/receiving messages from the Balancer. The test function is also responsible for making assertions about what the Balancer should do.

This allows us to utilize Rust's testing framework and take advantage of the reporting and test discovery features it provides.

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

When emulated Monoliths are created, they need to convey their existence to the Balancer. To that end, the `TestRunner` should also manage a `DiscoveryProvider` that connects to the Balancer and tells it about the emulated Monoliths that are running. For the harness to connect, the balancer first needs a port to listen on. Assuming the port binds correctly, the discoverer will listen until a harness connects, and then store references to all emulated monoliths given by the discovery provider. To handle connecting to the balancer, the harness uses the `DiscoveryProvider` mentioned earlier. The provider takes in a set of emulated monoliths, and connects to the same port the discoverer is listening on.
