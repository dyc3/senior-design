#import "@preview/in-dexter:0.0.5": *

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

#req("The harness must be able to generate simulated traffic for fuzz testing.", mustHave, 1)
#req("The harness must be able to probed the balancer for its current state to make assertions in tests.", mustHave, 1)
#req("The harness must ...", mustHave, 1)
