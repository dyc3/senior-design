= Test Harness Requirements

In order for the test harness to be effective, it must be able to cover as much code of the Balancer as possible. To do so, typical unit tests are insufficient to test complex cases like network fragmentation, adding and removing monoliths, etc.

== Requirements

#import "lib/requirements.typ": *

#figure(
	table(
		columns: 1,
		[#req("Must be able to generate simulated traffic for fuzz testing.", shouldHave)],
		[#req("Must be able to cover as much of the load balancer as possible. (Code coverage)", mustHave)],
		[#req("Must be able to emulate the behavior of Monoliths and Clients.", mustHave)],
		[#req("Should be able to test multiple instances of the balancer at once.", wouldBeNiceToHave)],
		[#req("Should have the option to run tests using a real Monolith", wouldBeNiceToHave)],
		[#req("Must be able to specify tests that emit traffic in a specific order. (Sequential tests)", mustHave)],
		[#req("Should minimize the amount of code that needs to be written to create a test.", shouldHave)],
		[#req("Must be runnable in a CI environment.", mustHave)],
		[#req("Must be able to generate enough traffic to stress test the balancer.", shouldHave)],
		[#req("Must be able to detect when the Balancer panics or otherwise crashes when a test is executing.", mustHave)],
		[#req("Should be able to run tests in parallel.", shouldHave)]
	),
	caption: [Harness Requirements]
)

== Example Tests

In this section, we will go over some example tests that the test harness should be able to run. In each figure below, the dotted line originating from each named example client represents the appropriate destination.

=== Test: Balancer should route traffic to the correct Monolith

Scenario setup: There should be 2 Monoliths, both with 1 room each. There should be 2 clients connected to the Balancer trying to connect to the respective rooms. (@Figure::2m2r2c)

#figure(
	image("figures/harness/test-scenarios/2m2r2c.svg", width: 50%),
	caption: [Routing Users To Correct Monolith]
) <Figure::2m2r2c>

Desired sequence:
+ Client Alice connects to room Foo
+ Client Bob connects to room Bar
+ Client Alice sends a chat message to room Foo
+ Assert that Monolith 1 received the message from Alice
+ Client Bob sends a chat message to room Bar
+ Assert that Monolith 2 received the message from Bob

In the instance where multiple Monoliths are active, when a client connects through the Balancer it should route them first to the appropriate Monolith, and then to the appropriate room. If a client chooses to send a message after successfully joining the message should broadcast to the entire room, but not outside of the given room or Monolith.

=== Test: Balancer should route traffic to the correct clients

Scenario setup: There should be 1 Monolith with 2 rooms. There should be 3 clients, 2 connected to the same room and 1 connected to the other room. (@Figure::1m2r3c)

#figure(
	image("figures/harness/test-scenarios/1m2r3c.svg", width: 50%),
	caption: [Routing Users To Correct Room]
) <Figure::1m2r3c>

Desired sequence:
+ Client Alice connects to room Foo
+ Client Bob connects to room Foo
+ Client Carol connects to room Bar
+ Client Alice sends a chat message to room Foo
+ Assert that Client Bob received the message from Alice
+ Assert that Carol did not receive the message from Alice

When multiple clients connect through the balancer to a monolith containing multiple rooms, they should all first be routed to the monolith, and then to the appropriate room. Clients should only receive messages from users in the same room.

=== Test: Balancer should handle losing a Monolith gracefully

Scenario setup: There should be 2 Monoliths, both with 1 room each. There should be 2 clients connected to the Balancer trying to connect to the respective rooms. (@Figure::2m2r2c)

#figure(
	image("figures/harness/test-scenarios/2m2r2c.svg", width: 50%),
	caption: [Routing Users When Monolith Goes Offline]
)

Desired sequence:
+ Client Alice connects to room Foo
+ Client Bob connects to room Bar
+ Monolith 2 goes offline
+ Balancer kicks Bob
+ Bob reconnects to room Bar
+ Balancer routes traffic to Monolith 1
+ Monolith 1 creates a new room Bar
+ Assert that Bob is in the new room Bar

In the case of multiple Monoliths, when one goes offline all clients connected at the time of the crash are kicked from their rooms. When a client attempts reconnection, if the given Monolith is still offline the client should be routed to a Monolith that's still online, and the room they were in before disconnecting should be reloaded within the new Monolith.
