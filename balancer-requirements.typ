= Requirements <Chapter::balancer-requirements>

== Introduction

As elaborated in @Chapter::SolutionOverview, the goal is to create a load balancer that meets the requirements specified in this chapter.

== Stakeholders

- End Users
  - People that use any instance of OTT to watch videos
- Self-hosters
   - People that host their own instance of OTT
- Developers/Maintainers
  - The authors of this document
- Fly.io
  - The platform that hosts OTT
- Video Providers
  - The platforms that host the videos that are watched on OTT
  - YouTube, Vimeo, etc.

== Key Concepts

See @glossary

#import "lib/requirements.typ": *

== User Requirements <Section::req-user>

#figure(
  table(
    columns: 1,
    [#req("Current End User Experience must be maintained or improved", mustHave, 1, usecase: [@Section::usecase-end-user])],
    [#req("Self-hosters must not be required to use the load balancer", mustHave, 1)],
    [#req("Must not allow multiple Monoliths to load the same room at the same time", mustHave, 1)],
    [#req("Must not allow external users to pose as a Monolith to the Balancer", mustHave, 1)],
  ),
  caption: [Balancer User Requirements]
)

== System Requirements <Section::req-system>

#figure(
  table(
    columns: 1,
    [#req("Should fit within Fly.io's smallest machine (1 core, 256 MB RAM)", shouldHave, 3)],
    [#req("Must be runnable in a Docker container", mustHave, 1)],
    [#req("Should minimize Docker image size", shouldHave, 3)],
  ),
  caption: [Balancer System Requirements]
)

== Non-Funcional Requirements <Section::req-nonfunc>

#figure(
  table(
    columns: 1,
    [#req("Capable of handling current OTT traffic (about 80 concurrent users max)", mustHave, 2)],
    [#req("Must run on Linux", mustHave, 1)],
    [#req("Must be very fault tolerant", mustHave, 1)],
    [#req("Clients must be able to interface with OTT with and without the Balancer with minimal code changes.", mustHave, 1)],
    [#req("Must be safe scale, do multi-region deployments", mustHave, 3)],
  ),
  caption: [Balancer Non-Functional Requirements]
)

== Domain Requirements <Section::req-domain>

#figure(
  table(
    columns: 1,
    [#req("Balancer should follow best practices with regards to HTTP", couldHave, 4)],
    [#req("OTT must remain in compliance with the YouTube API Terms of Service", mustHave, 5)],
  ),
  caption: [Balancer Domain Requirements]
)
