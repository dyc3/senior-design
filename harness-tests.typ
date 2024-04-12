= Test Harness Tests

In this section, tests used to test the harness will be outlined.

=== Test: Malformed WebSocket Connection Does Not Crash Balancer

Scenario: A client with an incorrectly formatted header connects through a load balancer instance to OTT. WebSocket protocol dictates this should crash whatever is currently running, but this cannot happen when maintaining a highly available service. (@Figure::malformed-websocket-test-sequence)

#figure(
  image("figures/malformed-websocket-test-sequence.svg", width: 70%),
  caption: [Structure for Malformed WebSocket Test]
) <Figure::malformed-websocket-test-sequence>

Desired Sequence:
+ TestRunner creates Client
+ Client connects to Balancer
+ Client sends dataframe with the rsv2 and rsv3 bits set
+ TestRunner asserts Balancer is alive
+ Balancer disconnects Client
