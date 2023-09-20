#set document(
	title: "Dev Plan - OTT Load Balancer",
	author: ("Carson McManus", "Christopher Roddy")
)

#set align(center)

= OTT Load Balancer

Carson McManus, Christopher Roddy

OTT Load Balancer

#figure(
	table(columns: 3,
		[Version], [Date], [Comment],
		[1], [2023-09-20], [Initial version],
	)
)

#set align(left)

= Introduction

= Roles and Responsibilities

Development Lead: Carson McManus
Architect: Carson McManus
Developers: Carson McManus, Christopher Roddy
Test Lead: Christopher Roddy
Testers: Christopher Roddy, Carson McManus
Documentation: Carson McManus, Christopher Roddy
System Admin: Carson McManus
User Advocate: Christopher Roddy

= Method

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


== Backup Plan

Fly provides a mechanism to replay network requests to a different instance of the application. If the Load Balancer doesn't work as planned, some of the work can be salvaged by utilizing this feature instead.

= Virtual and Real Workspaces

All sprint planning and issue tracking will be done on GitHub, tracked in this project: #link("https://github.com/users/dyc3/projects/4")

The repos we will be working in:
- https://github.com/dyc3/opentogethertube
- https://github.com/dyc3/senior-design

= Communication Plan

= Timeline and Milestones

= Testing Plan

Unit tests will be written for all functions and methods where it makes sense, using Rust's integrated testing framework. Integration tests will be created to test the functionality of the load balancer as a whole.

= Risks

- The Rust ecosystem is still relatively young, and there may be some issues with the libraries we use.
- Async Rust is still in its infancy, and there may be some issues with the libraries we use.
- We could fail to addequately account for all the possible race conditions that could occur in a distributed environment.

= Assumptions

- We assume that the Fly.io platform will be able to handle the load of the project.

= IRB Protocol

Not necessary for this project.

= Required Resources and Budget

#figure(
	table(columns: 3,
		[Resource], [Cost], [Source],
		[Hosting], [Approx. \$2-4 / month], [Fly.io],
	)
)