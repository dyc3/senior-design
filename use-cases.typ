#import "lib/use-cases.typ": usecase

= Use Cases <Chapter::UseCases>

#usecase(
  [Hosting the official website's current production deployment],
  description: [
    In this use case, the maintainer of OTT is hosting the official website, OpenTogetherTube.com. The website needs to remain deployable to Fly.io, and the deployment pipelines need to continue to be functional.

    Deployment diagrams for with and without the load balancer can be found in @Figure::deployment-current and @Figure::deployment-new, respectively.
  ],
  basic_flow: ("Maintainer attempts deployment to Fly.io",
          "Deployment to Fly.io succeeds",
          "Maintainer accesses diagnostics",
          "Maintainer views logs, stack traces, or collects metrics"),
  alt_flows: (("Maintainer attempts deployment to Fly.io",
        "Deployment to Fly.io fails",
        "Maintainer troubleshoots deployment failure"),)
) <UseCase::maintaining>

#figure(
  image("figures/use-case-maint.svg"),
  caption: [Use Case diagram for @UseCase::maintaining],
)

#pagebreak()

#usecase(
  [Self-hosting an instance of OTT],
  description: [
    In this use case, a user is hosting an instance of OTT on their own server. The user may or may not be using docker to deploy their instance. It should remain possible to deploy an instance of OTT without starting additional services (other than what's currently required). Current deployments must continue to work when the user updates their instance of OTT.

    Deployment diagrams for with and without the load balancer can be found in @Figure::deployment-current and @Figure::deployment-new, respectively.
  ],
  prereq: (
    [User can clone a git repository],
    [User has a computer with docker installed],
    [User has a computer with docker-compose installed],
  ),
  basic_flow: (
    [User clones OTT repository],
    [User runs `docker-compose up`],
    [User waits for containers to start],
    [User navigates to `localhost:8080` in browser],
    [User can utilize self-hosted version of OTT as end user],
  ),
  alt_flows: (
    (
      [User writes configuration file for Monolith],
      [User configures reverse proxy to point to OTT's configured port],
      [User configures DNS for a custom domain to point to their reverse proxy],
      [User runs `docker-compose up` (does *not* include Balancer)],
      [User waits for containers to start],
      [User navigates to custom domain in browser],
      [User can utilize self-hosted version of OTT as end user],
    ),
    (
      [User writes configuration file for Monolith],
      [User writes configuration file for Balancer],
      [User configures reverse proxy to point to Balancer port],
      [User configures DNS for a custom domain to point to their reverse proxy],
      [User runs `docker-compose up` (includes Balancer)],
      [User waits for containers to start],
      [User navigates to custom domain in browser],
      [User can utilize self-hosted version of OTT as end user],
    ),
  )
) <UseCase::self-host>

#figure(
  image("figures/use-case-self-host.svg"),
  caption: [Use Case diagram for @UseCase::self-host],
)

#pagebreak()

#usecase(
  [Using OTT as an end user],
  description: [In this use case, an end user is using the website to watch videos. The end user must not see any difference between the current version of OTT and the new version of OTT with the load balancer. This implies that no changes to the client must be necessary.],
  basic_flow:
    (
      "User connects to OTT website",
      "User creates permanent or temporary room",
      "User shares link to room",
      "Any number of people join the room",
      "User watches adds videos to queue",
      "User watches videos in queue"
    ),
  alt_flows: (
    (
      "User connects to OTT website",
      "User creates permanent or temporary room",
      "User tweaks room settings or permissions",
      "User shares link to room",
      "Any number of people join the room",
      "User watches adds videos to queue",
      "User watches videos in queue"
    ),
    (
      "Users connects to OTT website",
      "OTT automatically loads a permanent room",
      "Any number of people join the room",
      "User watches adds videos to queue",
      "User watches videos in queue"
    ),
  )
) <UseCase::end-user>

#figure(
  image("figures/use-case-enduser.svg"),
  caption: [Activity diagram for @UseCase::end-user],
)
