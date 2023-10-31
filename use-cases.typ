#import "lib/use-cases.typ": usecase, usecase_flows

= Use Cases <Chapter::UseCases>

#usecase(
  [Hosting the official website's current production deployment],
  description: [In this use case, the maintainer of OTT is hosting the official website, OpenTogetherTube.com. The website needs to remain deployable to Fly.io, and the deployment pipelines need to continue to be functional.],
  diagram: "use-case-maint.svg",
) <UseCase::maintaining>

#usecase_flows(
  basic: ("Maintainer attempts deployment to Fly.io",
          "Deployment to Fly.io succeeds",
          "Maintainer accesses diagnostics",
          "Maintainer views logs, stack traces, or collects metrics"),
  alt: ("Maintainer attempts deployment to Fly.io",
        "Deployment to Fly.io fails",
        "Maintainer troubleshoots deployment failure"),
)

#usecase(
  [Self-hosting an instance of OTT],
  description: [In this use case, a user is hosting an instance of OTT on their own server. The user may or may not be using docker to deploy their instance. It should remain possible to deploy an instance of OTT without starting additional services (other than what's currently required). Current deployments must continue to work when the user updates their instance of OTT.],
  diagram: "use-case-self-host.svg",
) <UseCase::self-host>

#usecase_flows(
  basic: ("User sets up local instance of OTT",
          "User attempts deployment",
          "Deployment succeeds",
          "User can utilize self-hosted version of OTT"),
  alt: ("User sets up local instance of OTT",
          "User attempts deployment",
          "Deployment fails",
          "User troubleshoots deployment failure"),
)

#usecase(
  [Using any instance of OTT as an end user],
  description: [In this use case, an end user is using the website to watch videos. The end user must not see any difference between the current version of OTT and the new version of OTT with the load balancer. This implies that no changes to the client must be necessary.],
  diagram: "use-case-enduser.svg",
) <UseCase::end-user>

#usecase_flows(
  basic: ("User connects to OTT website",
          "User creates permanent or temporary room",
          "User shares link to room",
          "Any number of people join the room",
          "User watches videos in queue"),
  alt: ("User connects to OTT website",
        "OTT website is down",
        "User cannot watch videos"),
)
