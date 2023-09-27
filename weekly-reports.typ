= Weekly Reports <reports>

== Week Report 1 (09/13/2023) <report-w1>

*What we did this week*

- Wrote up a project description to share with potential team mates
- Search for potential team mates
- Rewrote how balancer-monolith connections work, they now go in the opposite direction (balancer -> monolith) instead of (monolith -> balancer) because it decreases latency when starting up the balancer.
- Finalized team

*Tasks for next week*

- Set up a new repo for the load balancer spec
- Convert load balancer spec from latex to typst
- Update load balancer spec to reflect current implementation
- Determine the best way to do integration tests for the load balancer
- Determine requirements for the load balancer testing harness
- Get dev environment set up for Chris

*Risks*

- Chris is not experienced with Rust which may slow down development
	- Carson will be available to help Chris with Rust

== Week Report 2 (09/20/2023) <report-w2>

*What we did this week*

- Set up a new repo for the load balancer spec
- Converted load balancer spec from latex to typst
- Updated some parts of the load balancer spec to reflect current implementation
    - The remaining inconsistencies will be fixed as we come upon them.
- Determined the best way to do integration tests for the load balancer
- Determined some requirements for the load balancer testing harness
- Got dev environment set up for Chris
- Got the spec to have the elements that are in the latex template
- Fixed some lint CI job failures

*Tasks for next week*

- Document Monolith discovery process
- Development plan document
- Finish requirements for the load balancer testing harness
- Specify Room Migration process
- Start designing the load balancer testing harness
- Implement lazy room state loading from Redis

== Week Report 3 (09/27/2023) <report-w3>

*What we did this week*

- Documented Monolith discovery process
- Wrote development plan document
- Finished requirements for the load balancer testing harness
- Specified Room Migration process
- Started designing the load balancer testing harness
- Implemented lazy room state loading from Redis

*Tasks for next week*

- Continue designing the load balancer testing harness, prototype it
  - Emulated Monoliths, Clients
  - Test aggregation
- Dev plan slides for presentation
- Fix a bug in the load balancer, #link("https://github.com/dyc3/opentogethertube/issues/1076", [#1076])
- Fix some of the figures in the discovery chapter of the spec
-