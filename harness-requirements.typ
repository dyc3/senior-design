= Test Harness Requirements

In order for the test harness to be effective, it must be able to cover as much code of the balancer as possible. In order to do so, typical unit tests are insufficient to test complex cases like network fragmentation, adding and removing monoliths, etc.

Requirement priority is in ascending order, with P1 being the highest priority and P5 being the lowest.

== Requirements

#let mustHave = [Must Have]
#let shouldHave = [Should Have]
#let couldHave = [Could Have]
#let wouldBeNiceToHave = [Would Be Nice To Have]

#let priority(pri) = {
	[P] + str(pri)
};

#let req(text, necessity, pri) = {
	priority(pri) + [ ] + necessity + [ ] + text
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
