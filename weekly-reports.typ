= Weekly Reports <reports>

#import "lib/misc.typ": github

== Week Report 22 (3/28/2024) <report-w22>

*What we did this week*
- Completed: Make monolith discovery polling interval configurable #github("dyc3/opentogethertube", 1295)
- Delayed: Make port for `dns_server` optional in `DnsDiscoveryConfig` #github("dyc3/opentogethertube", 1450)
- In Progress: #github("dyc3/opentogethertube", 1385)

*Tasks for next week*
- Add legend to panel describing what each node means #github("dyc3/opentogethertube", 1427)
- Reassigned: Make monolith load balancing algorithm configurable #github("dyc3/opentogethertube", 1294)

*Figures Updated*
- Updated: @Figure::service-discoverers

#figure(
  image("figures/sprint-screenshots/Sprint27.png"),
  caption: "Screenshot of Sprint 27."
) <Figure::Sprint27>

== Week Report 21 (3/21/2024) <report-w21>

*What we did over break*
- Completed: Make Balancer IDS constant from the perspective of monoliths #github("dyc3/opentogethertube", 1338)
- Completed: Fix E2E tests consistently failing #github("dyc3/opentogethertube", 1492)
- Completed: Add typos to CI checks #github("dyc3/senior-design", 338)
- Completed: Add figure file names in document #github("dyc3/senior-design", 332)
- Created a new visualization view that fixes the layout and performance issues of the other views
- *Started slow rollout of balancer to production environment*, currently routing 5% of clients to balancer

*Tasks for next week*
- Make port for `dns_server` optional in `DnsDiscoveryConfig` #github("dyc3/opentogethertube", 1450)
- Upgrade to typst v0.11.0 #github("dyc3/senior-design", 336)
- Make monolith load balancing algorithm configurable #github("dyc3/opentogethertube", 1294)
- Make monolith discovery polling interval configurable #github("dyc3/opentogethertube", 1295)
- Panel does not handle large number of rooms very well #github("dyc3/opentogethertube", 1423)
- Panel jitters when refreshing data, even if the data does not change #github("dyc3/opentogethertube", 1424)
- Add legend to panel describing what each node means #github("dyc3/opentogethertube", 1427)
- Fix balancer memory leak #github("dyc3/opentogethertube", 1540)
- `/api/state` endpoint needs to be authenticated #github("dyc3/opentogethertube", 1466)

*Figures Updated*
- Added: @Figure::vis-collector-component
- Updated: @Figure::components-monolith
- Updated: @Figure::deployment-current
- Updated: @Figure::deployment-new

#figure(
  image("figures/sprint-screenshots/Sprint25.png"),
  caption: "Screenshot of Sprint 25."
) <Figure::Sprint25>

#figure(
  image("figures/sprint-screenshots/Sprint26.png"),
  caption: "Screenshot of Sprint 26."
) <Figure::Sprint26>

== Week Report 20 (3/7/2024) <report-w20>

*What we did this week*
- Completed: Add config in dns discoverer to overwrite dns server to Chris #github("dyc3/opentogethertube", 1337)
- Completed: Fix message parsing error #github("dyc3/opentogethertube", 1339)
- Completed: Add preview failure when requesting youtube channel #github("dyc3/opentogethertube", 1447)
- Completed: Fix permissions in permanent rooms not saving #github("dyc3/opentogethertube", 1410)
- Completed: Elevator Pitch Outline
- Delayed: Make Balancer IDS constant from the perspective of monoliths #github("dyc3/opentogethertube", 1338)
- Delayed: Make monolith discovery polling interval configurable #github("dyc3/opentogethertube", 1295)

*Tasks for next week*
- Continue to manually test load balancer for bugs
- Integrate Zod for HTTP request validation #github("dyc3/opentogethertube", 1385)
- Adjust the visualization to handle a larger number of rooms better #github("dyc3/opentogethertube", 1423)
- Add legend to `ott-vis-panel` describing what each node means #github("dyc3/opentogethertube", 1427)
- Make the load balancing algorithm configurable #github("dyc3/opentogethertube", 1294)
- Brainstorm visualization node layouts

*Figures Updated*
- Added: @Figure::visualization-datasource-smoketest-sequence
- Updated: @Figure::full-package-diagram
- Updated: @Figure::service-discoverers
- Updated: @Figure::visualization-balancer-datasource-sequence

#figure(
  image("figures/sprint-screenshots/Sprint24.png"),
  caption: "Screenshot of Sprint 24."
) <Figure::Sprint24>

== Week Report 19 (2/29/2024) <report-w19>

*What we did this week*
- Completed: Make `ott-vis-datasource` communicate with `ott-collector` #github("dyc3/opentogethertube", 1358)
- Completed: Allow cross origin requests for `ott-collector`
- Completed: Performed further repo maintenance
- Completed: Make `ott-collector` discover balancers #github("dyc3/opentogethertube", 1360)
- Completed: Make `ott-collector` collect system state #github("dyc3/opentogethertube", 1361)
- Completed: MVP for visualization
- Delayed: Fix message parsing error #github("dyc3/opentogethertube", 1339)

*Tasks for next week*
- Continue to manually test load balancer for bugs
- Make Balancer IDS constant from the perspective of monoliths #github("dyc3/opentogethertube", 1338)
- Reassigned add config in dns discoverer to overwrite dns server to Chris #github("dyc3/opentogethertube", 1337)

*Figures Updated*
- Added: @Figure::create-endpoint-activity
- Added: @Figure::service-discoverers
- Added: @Figure::visualization-balancer-datasource-sequence
- Updated: @Figure::discovery-class
- Updated: @Figure::discovery-sequence
- Updated: @Figure::full-package-diagram
- Updated: @Figure::monolith-id-sequence

#figure(
  image("figures/sprint-screenshots/Sprint23.png"),
  caption: "Screenshot of Sprint 23."
) <Figure::Sprint23>

== Week Report 18 (2/22/2024) <report-w18>

*What we did this week*
- Completed: Add command line flags to both the monolith and balancer to validate their configs and exit #github("dyc3/opentogethertube", 1296) #github("dyc3/opentogethertube", 1297)
- Completed: Got rid of unused dependencies.
- Completed: Upgrade certain dependencies.
- Completed: Added average load test that better approximates average peak load of system in production.
- Completed: Fixed OTT-Common import
- Completed: Lean Canvas for IDE

*Tasks for next week*
- Continue to manually test load balancer for bugs
- Delayed: Add tests for malformed websocket packets #github("dyc3/opentogethertube", 1206)
- Delayed: Make the monolith polling interval configurable #github("dyc3/opentogethertube", 1295)
- Delayed: Determine how information will be passed from the load balancer to the visualizations #github("dyc3/senior-design", 224)
- Fix message parsing error in Balancer #github("dyc3/opentogethertube", 1339)
- Make the datasource communicate with `ott-collector` #github("dyc3/opentogethertube", 1358)
- Create `ott-collector` crate for collecting system state #github("dyc3/opentogethertube", 1357)
- New docker compose for combing `ott-vis` and `ott-datasource` #github("dyc3/opentogethertube", 1359)
- Fix bug where balancer does not detect disconnected clients sometimes #github("dyc3/opentogethertube", 1343)
- Make `ott-collector` discover balancers #github("dyc3/opentogethertube", 1360)

*Figures Updated*
- Added: @Figure::average-load-class
- Added: @Figure::visualization-balancer-datasource-sequence
- Updated: @Figure::balancer-channels-client-monolith
- Updated: @Figure::panel-internal-class

#figure(
  image("figures/sprint-screenshots/Sprint22.png"),
  caption: "Screenshot of Sprint 22."
) <Figure::Sprint22>

== Week Report 17 (2/15/2024) <report-w17>

*What we did this week*
- Completed: Add Monolith Discoverer that works for any dns server #github("dyc3/opentogethertube", 1239)
- Completed: Add datsource package #github("dyc3/opentogethertube", 1300)
- Completed: Restructure `ott-vis` to allow for multiple visualizations #github("dyc3/opentogethertube", 1281)
- Completed: Update `GlobalView` to use `SystemState` for rendering #github("dyc3/opentogethertube", 1286)
- Completed: Add `RegionView` to `ott-vis` #github("dyc3/opentogethertube", 1252)
- Completed: Have the balancer handle websocket pings #github("dyc3/opentogethertube", 1320)

*Tasks for next week*
- Continue to manually test load balancer for bugs
- Delayed: Add command line flags to both the monolith and balancer to validate their configs and exit #github("dyc3/opentogethertube", 1296) #github("dyc3/opentogethertube", 1297)
- Delayed: Add tests for malformed websocket packets #github("dyc3/opentogethertube", 1206)
- Delayed: Make the monolith polling interval configurable #github("dyc3/opentogethertube", 1295)
- Delayed: Determine how information will be passed from the load balancer to the visualizations #github("dyc3/senior-design", 224)

*Figures Updated*
- Added: @Figure::balancer-channels-client-monolith
- Updated: @Figure::service-discoverers
- Added: @Figure::malformed-websocket-test-sequence
- Added: @Figure::monolith-id-sequence
- Added: @Figure::DOM-class-visualization
- Updated: @Figure::panel-internal-class

#figure(
  image("figures/sprint-screenshots/Sprint21.png"),
  caption: "Screenshot of Sprint 21."
) <Figure::Sprint21>


== Week Report 16 (2/8/2024) <report-w16>

*What we did this week*
- Update @Figure::full-package-diagram
- Update @Figure::balancer-crates
- Update @Figure::manage-balanacer-connections-class
- Minor change to @Figure::monolith-selection-internals-class
- The "Default" visualization has been renamed to "Global"
- Completed: Business Model Canvas for IDE
- Completed: Make monolith ids constant across the system instead of being generated on connect #github("dyc3/opentogethertube", 1251)
- Completed: Add other panels to provisioned dashboard #github("dyc3/opentogethertube", 1280)
- Completed: Set up datasource package #github("dyc3/opentogethertube", 1300)
- Completed: Integrate the `Global` visualization into a grafana panel #github("dyc3/opentogethertube", 1262)

*Tasks for next week*
- Continue to manually test load balancer for bugs
- Delayed: Create a monolith discoverer for docker-compose environments #github("dyc3/opentogethertube", 1239)
- Delayed: Determine how information will be passed from the load balancer to the visualizations #github("dyc3/senior-design", 224)
- Add command line flags to both the monolith and balancer to validate their configs and exit #github("dyc3/opentogethertube", 1296) #github("dyc3/opentogethertube", 1297)
- Restructure `ott-vis` to allow for multiple visualizations #github("dyc3/opentogethertube", 1281)
- Make the monolith polling interval configurable #github("dyc3/opentogethertube", 1295)
- Delayed: Add tests for malformed websocket packets #github("dyc3/opentogethertube", 1206)

#figure(
  image("figures/sprint-screenshots/Sprint20.png"),
  caption: "Screenshot of Sprint 20."
) <Figure::Sprint20>

== Week Report 15 (2/1/2024) <report-w15>

*What we did this week*
- Minor update to @Figure::balancer-internals-class
- Added new figure to describe internals of MonolithSelection trait: @Figure::monolith-selection-internals-class
- Ensured all members could run multiple monoliths and load balancers on their systems for manual testing
- Updated @Figure::service-discoverers with new implementation for docker
- Added information to explain Grafana and D3.js

*Tasks for next week*
- Manually test load balancer for bugs
- Delayed: Integrate the `Default` visualization into a grafana panel
- Delayed: Determine how information will be passed from the load balancer to the visualizations
- Delayed: Create a monolith discoverer for docker-compose environments
- Delayed: Make monolith ids constant across the system instead of being generated on connect

== Week Report 14 (1/25/2024) <report-w14>

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
- Make monolith ids constant across the system instead of being generated on connect
- Fix misc bugs in the load balancer

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
