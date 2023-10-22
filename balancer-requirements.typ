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
    [#req("Current End User Experience must be maintained or improved", mustHave, 1, usecase: [@UseCase::end-user])],
    [#req("Self-hosters must not be required to use the load balancer", mustHave, 1, usecase: [@UseCase::self-host])],
    [#req("Must not allow multiple Monoliths to load the same room at the same time", mustHave, 1, usecase: [@UseCase::end-user])],
    [#req("Must not allow external users to pose as a Monolith to the Balancer", mustHave, 1)],
    [#req("Must provide sufficient configurability", mustHave, 3, usecase: [@UseCase::maintaining])],
    [#req("Should be easily configurable", shouldHave, 3, usecase: [@UseCase::maintaining])],
    [#req("Should not require any external services (like Redis or Kafka)", shouldHave, 2)],
  ),
  caption: [Balancer User Requirements]
)

== System Requirements <Section::req-system>

#figure(
  table(
    columns: 1,
    [#req("Should fit within Fly.io's smallest machine (1 core, 256 MB RAM)", shouldHave, 3, usecase: [@UseCase::maintaining])],
    [#req("Must be runnable in a Docker container", mustHave, 1, usecase: [@UseCase::maintaining, @UseCase::self-host])],
    [#req("Should minimize Docker image size", shouldHave, 3, usecase: [@UseCase::maintaining, @UseCase::end-user])],
  ),
  caption: [Balancer System Requirements]
)

== Non-Funcional Requirements <Section::req-nonfunc>

#figure(
  table(
    columns: 1,
    [#req("Capable of handling current OTT traffic (about 80 concurrent users max)", mustHave, 2, usecase: [@UseCase::end-user])],
    [#req("Must run on Linux", mustHave, 1, usecase: [@UseCase::maintaining, @UseCase::self-host])],
    [#req("Must run in Docker", mustHave, 1, usecase: [@UseCase::maintaining, @UseCase::self-host])],
    [#req("Must be very fault tolerant", mustHave, 1, usecase: [@UseCase::maintaining])],
    [#req("Clients must be able to interface with OTT with and without the Balancer with minimal code changes.", mustHave, 1, usecase: [@UseCase::end-user])],
    [#req("Must be safe scale horizontally", mustHave, 3, usecase: [@UseCase::maintaining])],
    [#req("Must be safe to do multi-region deployments", mustHave, 3, usecase: [@UseCase::maintaining])],
  ),
  caption: [Balancer Non-Functional Requirements]
)

== Domain Requirements <Section::req-domain>

#figure(
  table(
    columns: 1,
    [#req("Balancer should follow best practices with regards to HTTP", couldHave, 4, usecase: [@UseCase::end-user])],
    [#req("OTT must remain in compliance with the YouTube API Terms of Service", mustHave, 5, usecase: [@UseCase::maintaining])],
    [#req("The Balancer must comply with the GDPR.", mustHave, 4, usecase: [@UseCase::maintaining])],
  ),
  caption: [Balancer Domain Requirements]
)
