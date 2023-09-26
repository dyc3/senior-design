= Test Harness Requirements
//make the formatting of requirements pretty
In order for the test harness to be effective, it must be able to cover as much code of the balancer as possible. In order to do so, typical unit tests are insufficient to test complex cases like network fragmentation, adding and removing monoliths, etc.

Requirement priority is in ascending order, with P1 being the highest priority and P5 being the lowest.

== Requirements

#let mustHave = [Must Have]
#let shouldHave = [Should Have]
#let couldHave = [Could Have]
#let wouldBeNiceToHave = [Would Be Nice To Have]

#let VERY_HIGH = 1
#let HIGH = 2
#let MEDIUM = 3
#let LOW = 4
#let VERY_LOW = 5

#let priority(pri) = {
	if(pri == VERY_HIGH) { rgb("#FF0407") }
	else if(pri == HIGH) { rgb("#ff390a") }
	else if(pri == MEDIUM) { rgb("#ecff09") }
	else if(pri == LOW) { rgb("#1ae53e") }
	else if(pri == VERY_LOW) { rgb("#1800FF") }
};

#let req(text, necessity, pri) = {
	"-" + necessity + [ ] + text + [ ] + square(size: 5pt, fill: priority(pri)) + [ ] + "\n"
};

#req("Must be able to generate simulated traffic for fuzz testing.", shouldHave, 3)
#req("Must be able to probe the balancer for its current state to make assertions in tests.", mustHave, 3)
#req("Must be able to cover as much of the load balancer as possible. (Code coverage)", mustHave, 2)
#req("Must be able to emulate the behavior of Monoliths and Clients.", mustHave, 1)
#req("Should be able to test multiple instances of the balancer at once.", wouldBeNiceToHave, 5)
#req("Should have the option to run tests using a real Monolith", wouldBeNiceToHave, 4)
#req("Must be able to specify tests that emit traffic in a specific order. (Sequencial tests)", mustHave, 1)
#req("Should minimize the amount of code that needs to be written to create a test.", shouldHave, 2)
#req("Must be runnable in a CI environment.", mustHave, 2)
#req("Must be able to generate enough traffic to stress test the balancer.", shouldHave, 3)

== Example Tests

In this section, we will go over some example tests that the test harness should be able to run.

=== Test: Balancer should route traffic to the correct Monolith

Scenario setup: There should be 2 Monoliths, both with 1 room each. There should be 2 clients connected to the balancer trying to connect to the respective rooms. (@Figure::scenario-2m2r2c)

#figure(
	image("figures/test-scenarios/2m2r2c.svg", width: 50%)
) <Figure::scenario-2m2r2c>

Desired sequence:
+ Client Alice connects to room Foo
+ Client Bob connects to room Bar
+ Client Alice sends a chat message to room Foo
+ Assert that Monolith 1 received the message from Alice
+ Client Bob sends a chat message to room Bar
+ Assert that Monolith 2 received the message from Bob

=== Test: Balancer should route traffic to the correct clients

Scenario setup: There should be 1 Monolith with 2 rooms. There should be 3 clients, 2 connected to the same room and 1 connected to the other room. (@Figure::scenario-1m2r3c)

#figure(
	image("figures/test-scenarios/1m2r3c.svg", width: 50%)
) <Figure::scenario-1m2r3c>

Desired sequence:
+ Client Alice connects to room Foo
+ Client Bob connects to room Foo
+ Client Carol connects to room Bar
+ Client Alice sends a chat message to room Foo
+ Assert that Client Bob received the message from Alice
+ Assert that Carol did not receive the message from Alice

=== Test: Balancer should handle losing a Monolith gracefully

Scenario setup: There should be 2 Monoliths, both with 1 room each. There should be 2 clients connected to the balancer trying to connect to the respective rooms. (@Figure::scenario-2m2r2c-2)

#figure(
	image("figures/test-scenarios/2m2r2c.svg", width: 50%)
) <Figure::scenario-2m2r2c-2>

Desired sequence:
+ Client Alice connects to room Foo
+ Client Bob connects to room Bar
+ Monolith 2 goes offline
+ Balancer kicks Bob
+ Bob reconnects to room Bar
+ Balancer routes traffic to Monolith 1
+ Monolith 1 creates a new room Bar
+ Assert that Bob is in the new room Bar
