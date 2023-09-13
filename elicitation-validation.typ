= Requirements Elicitation & Validation <Chapter::ElicitationValidation>

== Elicitation

The problem domain is very will known, so not a ton of outside information was necessary. The following methods were used to elicit requirements.

- Brainstorming
- Research
- User interviews to verify requirements, and project motivation

== Validation Plan

The success of this project can be measured by the following metrics.

=== Quality Validation

- The frontend must work identically when connecting to the balancer as it does when connecting to a monolith.
- All E2E integration tests must pass with and without the balancer.

=== Performance Validation

- The Balancer must be able to handle thousands of clients sending/receiving about 2-6 messages/sec, with about 5 clients per room.
- Requires a custom performance testing harness.

=== Balancing Validation

- The Balancer should generally evenly distribute load across all Monoliths.
