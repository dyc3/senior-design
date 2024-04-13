= Dev Plan

== Roles and Responsibilities

Development Lead: Carson McManus \
Architect: Carson McManus \
Developers: Carson McManus, Christopher Roddy \
Test Lead: Christopher Roddy \
Testers: Christopher Roddy, Carson McManus \
Documentation: Carson McManus, Christopher Roddy \
System Admin: Carson McManus \
User Advocate: Christopher Roddy

== Method

- Software
  - Languages: Rust
  - Operating Systems: Linux
  - Deployment method: Docker

- Hardware
  - Deployed on Fly.io
  - 1 CPU
  - 256MB RAM

- Review Process
  - 1 code review per pull request, required before merge
  - All builds and tests must pass before merge

- Build Plan
  - Builds will be triggered on every pull request, and on every merge to master

- Modification Request Process
  - All modification requests must be submitted as a pull request to the spec repo
  - All modification requests must be approved by at least one other developer


=== Backup Plan

Fly provides a mechanism to replay network requests to a different instance of the application. If the Load Balancer doesn't work as planned, some of the work can be salvaged by utilizing this feature instead.

== Virtual and Real Workspaces

All sprint planning and issue tracking will be done on GitHub, tracked in this project: https://github.com/users/dyc3/projects/4

The repos we will be working in:
- https://github.com/dyc3/opentogethertube
- https://github.com/dyc3/senior-design

== Communication Plan

- Sprint Planning: On Wednesday mornings, we will meet to discuss what we will be working on for the next sprint.
- Heartbeat Meetings: On Monday mornings, we will touch base and sync up on what we have been working on.
- Issue Meetings: If there are any specific issues that are blocking work, we will meet to discuss them and come up with a solution. These meetings will be held on an as-needed basis.

== Timeline and Milestones

Tentative Timeline:
- End of October: Prototype Test Harness with some test cases
- End of November: Many more test cases, and finding and filing bugs in the Balancer
- End of January: Finalize Test Harness, and start the process of polishing the Balancer
- End April: Finalize Balancer, Complete validation of the Balancer with production deployment

== Testing Plan

Unit tests will be written for all functions and methods where it makes sense, using Rust's integrated testing framework. Integration tests will be created to test the functionality of the load balancer as a whole.

== Risks

- Both the Rust ecosystem and Async Rust are relatively young, and there may be some issues with the libraries we use.
- We could fail to addequately account for all the possible race conditions that could occur in a distributed environment.

== Assumptions

- We assume that the Fly.io platform will be able to handle the load of the project.

== IRB Protocol

Not necessary for this project.

== Required Resources and Budget

#figure(
	table(columns: 3,
		[Resource], [Cost], [Source],
		[Hosting], [Approx. \$2-4 / month], [Fly.io],
	)
)