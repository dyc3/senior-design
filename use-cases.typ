#import "lib/use-cases.typ": usecase

= Use Cases <Chapter::UseCases>

#usecase(
  [Deploy to Fly],
  description: [
    In this use case, the maintainer of OTT is hosting the official website, OpenTogetherTube.com. The website needs to remain deployable to Fly.io, and the deployment pipelines need to continue to be functional.

    Deployment diagrams for with and without the load balancer can be found in @Figure::deployment-current and @Figure::deployment-new, respectively.
  ],
  diagram: [@Figure::use-case-maint],
  basic_flow: ("Maintainer attempts deployment to Fly.io",
          "Deployment to Fly.io succeeds"),
  alt_flows: (("Maintainer attempts deployment to Fly.io",
        "Deployment to Fly.io fails",
        "Maintainer troubleshoots deployment failure"),)
) <UseCase::maintaining>

#usecase(
  [Access Diagnostics],
  description: [
    In this use case, the maintainer of OTT is hosting the official website, OpenTogetherTube.com. The system needs to allow the maintainer to access diagnostics for the system to troubleshoot issues. This includes logs, stack traces, and metrics.
  ],
  diagram: [@Figure::use-case-maint],
  prereq: (
    "Maintainer has access to Fly",
    "OTT is already deployed to Fly",
  ),
  basic_flow: (
    "Maintainer runs `fly log`",
    "Maintainer reads logs, stack traces in real time"
  ),
  alt_flows: (
    (
      "Maintainer configures Fly app to collect metrics",
      "Maintainer browses to Fly hosted grafana dashboard",
      "Maintainer views metrics, creates dashboards, or creates alerts",
    ),
    (
      "Maintainer configures on-premesis prometheus instance to collect metrics",
      "Maintainer browses to on-premesis hosted grafana",
      "Maintainer views metrics, creates dashboards, or creates alerts",
    ),
  )
) <UseCase::troubleshoot>

#figure(
  image("figures/use-cases/use-case-maint.svg"),
  caption: [Use Case diagram for @UseCase::maintaining and @UseCase::troubleshoot],
) <Figure::use-case-maint>

#pagebreak()

#usecase(
  [Deploy OTT],
  description: [
    In this use case, a user is hosting an instance of OTT on their own server. The user may or may not be using docker to deploy their instance. It should remain possible to deploy an instance of OTT without starting additional services (other than what's currently required). Current deployments must continue to work when the user updates their instance of OTT.

    Deployment diagrams for with and without the load balancer can be found in @Figure::deployment-current and @Figure::deployment-new, respectively.
  ],
  diagram: [@Figure::use-case-self-host],
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
  image("figures/use-cases/use-case-self-host.svg"),
  caption: [Use Case diagram for @UseCase::self-host],
) <Figure::use-case-self-host>

#pagebreak()

#usecase(
  [Using OTT as an end user],
  description: [In this use case, an end user is using the website to watch videos. The end user must not see any difference between the current version of OTT and the new version of OTT with the load balancer. This implies that no changes to the client must be necessary.],
  diagram: [@Figure::use-case-enduser],
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
  image("figures/use-cases/use-case-enduser.svg", width: 30%),
  caption: [Activity diagram for @UseCase::end-user],
) <Figure::use-case-enduser>

#usecase(
  [Interface with Visualization],
  description: [In this use case, a vistor comes up to our booth on the day of the innovation expo and interacts with the visualization for the load balancer. The visualization must be a completely seperate system that the load balancer interacts with.],
  basic_flow: 
  (
    "Visitor approaches booth",
    "Visitor adds or removes any number of monoliths",
    "Monoliths appear/dissappear from the screen appropriately",
    "Visitor connects through the balancer to OTT",
    "Visitor adds and joins room",
    "Room appears on screen tethered to the appropriate monolith",
    "Client appears on screen tethered to the appropriate room",
    "Client disconnects",
    "Client dissappears from visualization screen",
    "Visitor walks away"
  ),
  alt_flows: 
  (
    (
      "Visitor approaches booth",
      "Visitor adds or removes any number of monoliths",
      "Monoliths appear/dissappear from the screen appropriately",
      "Visitor connects through the balancer to OTT",
      "Visitor adds and joins room",
      "Room appears on screen tethered to the appropriate monolith",
      "Client appears on screen tethered to the appropriate room",
      "Visitor removes the monolith the client is currently connected to",
      "Client is forcibly disconnected",
      "Client disappears from visualization screen",
      "Room is retethered to appropriate monolith",
      "Client reconnects through the balancer to OTT",
      "Client rejoins the room they created",
      "Client reappears on visualization screen",
      "Client disconnects",
      "Client dissappears from visualization screen",
      "Visitor walks away"
    ),
    (
      "Visitor approaches booth",
      "Visitor connects through the balancer to OTT",
      "Visitor joins an already existing room",
      "Client appears on screen tethered to the appropriate room",
      "Client disconnects",
      "Client dissappears from visualization screen",
      "Visitor walks away"
    ),
    (
      "Visitor approaches booth",
      "Visitor is uninterested",
      "Visitor walks away"
    )
  )
) <UseCase::visualization-interface>

#figure(
  image("figures/use-cases/use-case-visualization-interface.svg"),
  caption: [Use Case Diagram for @UseCase::visualization-interface]
)
