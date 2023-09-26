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

== Test Results

Test results need to be aggregated and reported in a way that is easy to understand. The Harness should be able to report the results of a single test, or the results of a group of tests. There should be a configuration option to specify which aggregated report type to use, as well as a configuration option to specify where to write the report to (either stdout, or a file).

Aggregated Report types:
- Pretty-printed
- JSON

Failed tests should be reported with:
- Which assertion failed, or what line of code failed
- Logs from the Balancer
- Message logs from the Monoliths and Clients

The logs should always be written to files in a folder named after the test that failed.
