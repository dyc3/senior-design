= Weekly Reports <reports>

#import "lib/misc.typ": github

== Week Report 14 (1/25/2023) <report-w14>

*What we did over break*

- Onboarded Victor
- fixed misc bugs in the load balancer

*What we did this week*

- Planned out development for the visualization interface
- Prototyped the `Default` visalization
- fixed misc bugs in the load balancer
- Onboarded Micheal

*Tasks for next week*

- Integrate the `Default` visualization into a grafana panel
- Determine how information will be passed from the load balancer to the visualizations
- Create a monolith discoverer for docker-compose environments
- make monolith ids constant across the system instead of being generated on connect
- fix misc bugs in the load balancer

== Week Report 13 (12/13/2023) <report-w13>

*What we did this week*

- Minor doc updates with requested changes from previous review
- Added new figures for 4+1 view: @Figure::balancer-internals-class, @Figure::deployment-geo, @Figure::balancer-crates
- Added region field to emulated monoliths #github("dyc3/opentogethertube", 1127)
- Added use case for expo demo @UseCase::visualization-interface
- Slides for today's presentation

*Tasks for next week*

- Delayed: Implement unicast room message handling in the load balancer #github("dyc3/opentogethertube", 1100)
- Continued: Manual testing of the load balancer to find bugs, create harness tests for them
- Continued: expo demo visualization requirements and design
- Dependency upgrades
- Prioritize allocating rooms on monoliths in the same region as the Balancer #github("dyc3/opentogethertube", 1170)

== Week Report 12 (12/06/2023) <report-w12>

*What we did this week*

- Made requested doc changes from previous review
- Minor refactors to harness tests
- Minor refactors to balancer protocol code
- Stuff for IDE
- Started work on visualizations for expo demo

*Tasks for next week*

- Continued: Manual testing of the load balancer to find bugs, create harness tests for them
- Delayed: Implement unicast room message handling in the load balancer #github("dyc3/opentogethertube", 1100)
- Delayed: Add region field to emulated monoliths #github("dyc3/opentogethertube", 1127)
- Slides for presentation next week

== Week Report 11 (11/29/2023) <report-w11>

*What we did this week*

- Review: Generalize emulated monolith behavior #github("dyc3/opentogethertube", 1129)
- Rework the discovery section of the doc
- Other misc doc changes

*Tasks for next week*

- Continued: Manual testing of the load balancer to find bugs, create harness tests for them
- Delayed: Implement unicast room message handling in the load balancer #github("dyc3/opentogethertube", 1100)
- Delayed: Add region field to emulated monoliths #github("dyc3/opentogethertube", 1127)
- Make requested doc changes from previous review

== Week Report 10 (11/15/2023) <report-w10>

*What we did this week*

- Set up prometheus metrics for the load balancer #github("dyc3/opentogethertube", 1094)
- Continued: Manual testing of the load balancer to find bugs, create harness tests for them
- Add region field to balancer config #github("dyc3/opentogethertube", 1126)
- PR Created: Generalize emulated monolith behavior #github("dyc3/opentogethertube", 1129)
- Updated @UseCase::self-host with more detailed flows

*Tasks for next week*

- Continued: Manual testing of the load balancer to find bugs, create harness tests for them
- Review: Generalize emulated monolith behavior #github("dyc3/opentogethertube", 1129)
- Delayed: Implement unicast room message handling in the load balancer #github("dyc3/opentogethertube", 1100)
- Delayed: Add region field to emulated monoliths #github("dyc3/opentogethertube", 1127)

== Week Report 9 (11/08/2023) <report-w9>

*What we did this week*

- Add region field to balancer protocol #github("dyc3/opentogethertube", 1121)
- Re-evaluated severity of load/join bug #github("dyc3/opentogethertube", 1101) to be not as important
- Implemented unloading duplicate rooms #github("dyc3/opentogethertube", 1130)
- Added a script to auto-bump version numbers for releases #github("dyc3/opentogethertube", 1122)

*Tasks for next week*

- Set up prometheus metrics for the load balancer #github("dyc3/opentogethertube", 1094)
- Implement unicast room message handling in the load balancer #github("dyc3/opentogethertube", 1100)
- Continued: Manual testing of the load balancer to find bugs, create harness tests for them
- Generalize emulated monolith behavior #github("dyc3/opentogethertube", 1129)
- Add region field to balancer config #github("dyc3/opentogethertube", 1126)
- Add region field to emulated monoliths #github("dyc3/opentogethertube", 1127)

== Week Report 8 (11/01/2023) <report-w8>

*What we did this week*

- Decided on a versioning scheme for OTT
- Worked on the load balancer requirements (@Chapter::balancer-requirements)
- allow the load balancer to force a monolith to unload a room
- Presentation slides for use cases and requirements

*Tasks for next week*

- Set up prometheus metrics for the load balancer #github("dyc3/opentogethertube", 1094)
- Implement unicast room message handling in the load balancer #github("dyc3/opentogethertube", 1100)
- Add region field to balancer protocol #github("dyc3/opentogethertube", 1121)
- Manual testing of the load balancer to find bugs, create harness tests for them

== Week Report 7 (10/25/2023) <report-w7>

*What we did this week*

- Refined the load balancer requirements (@Chapter::balancer-requirements)
- Made use cases for the load balancer linkable in requirements
- Continued working on resolving race conditions in the load balancer

*Tasks for next week*

- Come up with a versioning scheme and release schedule for OTT.
  - and add it to OTT client builds, load balancer
- allow the load balancer to force a monolith to unload a room
- Continue refining the load balancer requirements (@Chapter::balancer-requirements)
- Presentation slides for use cases and requirements

*Delayed Tasks*

- Set up prometheus metrics for the load balancer #github("dyc3/opentogethertube", 1094)
- Implement unicast room message handling in the load balancer #github("dyc3/opentogethertube", 1100)

== Week Report 6 (10/18/2023) <report-w6>

*What we did this week*

- Fixed a bug in the load balancer, #github("dyc3/opentogethertube", 1076)
- Resolved a race condition in the load balancer, #github("dyc3/opentogethertube", 1101)
- Added a git commit hash to page footer of OTT client builds
- Set up typeshare for codegen of shared types between the load balancer and monoliths
- Made requirements in this document linkable
- Let emulated monoliths track which rooms they have loaded.
- Started working on the new requirements chapter (@Chapter::balancer-requirements)

*Tasks for next week*

- Set up prometheus metrics for the load balancer #github("dyc3/opentogethertube", 1094)
- Implement unicast room message handling in the load balancer #github("dyc3/opentogethertube", 1100)
- Finish the new requirements chapter (@Chapter::balancer-requirements)

== Week Report 5 (10/11/2023) <report-w5>

*What we did this week*

- Generalized some common functionality in Emulated Monoliths and Clients
- Created some more harness tests for request routing
- Added mock HTTP server to Emulated Monoliths

*Tasks for next week*

- Fix a bug in the load balancer, #github("dyc3/opentogethertube", 1076)
- Resolve a race condition in the load balancer, #github("dyc3/opentogethertube", 1101)
- Set up prometheus metrics for the load balancer
- Implement unicast room message handling in the load balancer
- Investigate adding git commit hash to OTT client builds

== Week Report 4 (10/04/2023) <report-w4>

*What we did this week*

- Continued designing the load balancer testing harness
- Created our first actually useful test for the load balancer: `discovery_add_remove`
- Prototype Emulated Monoliths, Clients
- Resolved test aggregation
- Dev plan slides for presentation

*Tasks for next week*

- Generalize some common functionality in Emulated Monoliths and Clients
- Fix a bug in the load balancer, #github("dyc3/opentogethertube", 1076)
- Have emulated Monoliths also listen for HTTP requests, and send mock responses

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
- Fix a bug in the load balancer, #github("dyc3/opentogethertube", 1076)
- Fix some of the figures in the discovery chapter of the spec

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
