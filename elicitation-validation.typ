= Requirements Elicitation & Validation <Chapter::ElicitationValidation>

== Elicitation

The problem domain is very well known, so not much outside information is necessary. The following methods were used to elicit requirements.

- Brainstorming
- Research
- User interviews to verify requirements
- Project motivation

== Validation Plan

The success of this project can be measured by the following metrics.

=== Quality Validation

- The frontend must work identically when connecting to the Balancer as it does when connecting to a Monolith.
- All E2E integration tests must pass with and without the Balancer.

=== Performance Validation

- The Balancer must be able to handle thousands of clients sending/receiving about 2 to 6 messages/sec, with about 5 clients per room.

We will use k6, a load testing tool @k6-load-testing, to script out different scenarios to validate the performance of the entire system. k6 uses JavaScript to write load tests, and can be run in a distributed fashion to simulate a large number of clients.

==== Scenario: `average-load`

This scenario aims to roughly approximate the average peak load of the system as it would be in production. In production, there are anywhere from 0 to 5 clients per room, across about 50 rooms. However, the ratio of clients to rooms is usually anywhere in the range 1 to 2 clients per room. Realistically, client activity varies greatly because if nothing is happening to change the state of the room, no messages are being sent. This will not be accurately simulated in this scenario for the sake of simplicity.

Clients will randomly join rooms for a random amount of time (~2 minutes), and then leave. While connected, the clients will send messages and make HTTP requests randomly, according to what makes sense based on the state of the room. For example, if the there is no video playing, a client will not send a "play" message.

#figure(
	image("figures/load-tests/average-load-class.svg", width: 50%),
	caption: [Class diagram for the `average-load` scenario],
) <Figure::average-load-class>

=== Balancing Validation

- The Balancer should generally evenly distribute load across all Monoliths.
