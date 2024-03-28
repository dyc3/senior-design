#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import "@preview/t4t:0.3.2": *

#set par(
  justify: true,
  leading: 0.65em * 1.2,
)
#set page(
  footer: [#line(length: 100%, stroke: rgb(160, 1, 42))],
  width: 24in,
  height: 36in,
)
#set text(
  size: 30pt,
  font: "Saira",
)

#show heading.where(level: 1): it => [
  #set text(
    size: 135pt,
    weight: 500,
    fill: rgb(160, 1, 42),
    stretch: 75%,
  )
  #block(smallcaps(it.body))
]

#show heading.where(level: 2): it => [
  #set align(center)
  #set text(
    size: 48pt,
    weight: "bold",
    fill: rgb(160, 1, 42),
  )
  #block(smallcaps(it.body))
]

#let icon(icon, subicon: none, size: 4in, label: none) = {
  let width = size
  let height = size
  if type(size) == array {
    width = size.at(0)
    height = size.at(1)
  }
  box(
    width: width,
    height: height,
  )[
    #image(
      icon,
      width: 100%,
      height: 100%
    )
    #if subicon != none {
      place(
        bottom + right,
        dx: 0.3in,
        dy: 0.3in,
      )[
        #circle(
          fill: white,
          width: width / 2,
          height: width / 2,
          stroke: none,
          place(
            center + horizon,
            image(
              subicon,
              width: width / 2,
              height: width / 2
            )
          )
        )
      ]
    }
    #if label != none {
      set align(center + horizon)
      set text(size: width / 8)
      label
    }
  ]
}

#let server(status_icon, size: 4in, label: none) = {
  icon(
    "expo/icons/dns.svg",
    subicon: status_icon,
    size: size,
    label: label,
  )
}

#let server-on-fire = server("expo/icons/emergengy-heat.svg", size: 3in, label: [Application])
#let server-healthy = server("expo/icons/check-circle.svg", size: 2in, label: [Application])
#let server-balancer = server("expo/icons/check-circle.svg", size: 2in, label: [Load Balancer])
#let users = icon("expo/icons/groups.svg", size: (3in, 2in), label: [Lots of Users])

#let spread-edges(count, width: 0.4, offset: 0) = {
  range(count).map(i => {
    let y = offset + math.lerp(-width/2, width/2, i / (count - 1))
    edge((0, y), (1, y), "-|>")
  })
}

#let draw-single(
  target
) = {
  fletcher.diagram(
    edge-stroke: 0.1in,
    spacing: 3in,
    mark-scale: 50%,
    node((0, 0), [#users]),
    ..spread-edges(4, width: 0.3),
    node((1, 0), [#server-on-fire]),
  )
}

#let draw-balanced(
  target
) = {
  fletcher.diagram(
    edge-stroke: 0.1in,
    spacing: (3in, 0in),
    mark-scale: 50%,

    node((0, 1), [#users]),
    ..spread-edges(4, width: 0.5, offset: 1),
    node((1, 1), [#server-balancer]),
    edge((1, 1), (2, 0), "-|>", bend: 20deg),
    edge((1, 1), (2, 1), "-|>"),
    edge((1, 1), (2, 2), "-|>", bend: -20deg),
    node((2, 0), target),
    node((2, 1), target),
    node((2, 2), target),
  )
}

= OTT Load Balancer

#line(length: 100%, stroke: rgb(160, 1, 42))

Members: Victor Giraldo, Carson McManus, Michael Moreno, Christopher Roddy

Software Engineering Department.

Advised by Prof. Darian Muresan

#box(
  height: 40%,

  columns(2)[
  == Unlocking Scalability for Stateful Applications

- Our project's goal is to build a load balancer for stateful applications to allow legacy systems to scale horizontally. Horizontal scaling refers to adding additional nodes, while vertical scaling is adding more power to current machines. For the sake of limiting our scope, we chose to focus on a single application: OpenTogetherTube (OTT).
- OTT's userbase is steadily expanding, and the current infrastructure is incapable of accommodating the anticipated growth. Horizontal scaling is not an option, leaving vertical scaling as the only possible viable, but it is both costlier and subject to many limitations.

#colbreak()

== Proof of Concept (OTT)

- OTT is a website that allows users to watch videos together.
- The figures below depict the current and proposed new architecture for OTT. The balancer will distribute load between multiple instances of a Monolith, while the Monolith will be responsible for managing rooms.
- Implementation of the load balancer will allow an application to be deployed around the world, lower latency for users, improve reliability, and allow for a larger number of simultaneous users.

]
)

#set align(center)
#draw-single(server-on-fire)
#draw-balanced(server-healthy)
