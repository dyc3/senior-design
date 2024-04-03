#import "@preview/fletcher:0.4.2" as fletcher: node, edge
#import "@preview/t4t:0.3.2": *
#import "@preview/cades:0.3.0": qr-code

#let stevens-red = rgb(160, 1, 42)
#let stevens-gray = rgb(127, 129, 130)

#set par(
  justify: true,
  leading: 0.60em,
)
#set page(
    footer: [
      #set align(horizon)
      #line(length: 100%, stroke: stevens-gray + 3pt)
      #stack(
        dir: ltr,
        image("expo/branding/stevens-logo.svg", width: 7.25in - 1.25in),
        h(1fr),
        image("expo/branding/expo-logo.svg", width: 22.88in - 15.75in)
      )
    ],
  width: 24in,
  height: 36in,
  margin: (
    rest: 1in,
    bottom: 4in,
  ),
)
#set text(
  size: 30pt,
  font: "Saira",
)

#set figure(supplement: none)

#show heading.where(level: 1): it => [
  #set text(
    size: 135pt,
    weight: 600,
    fill: stevens-red,
    stretch: 75%,
  )
  #block(smallcaps(it.body))
]

#show heading.where(level: 2): it => [
  #set align(center)
  #set text(
    size: 48pt,
    weight: "bold",
    fill: stevens-red,
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

#let server-on-fire = server("expo/icons/emergengy-heat.svg", size: 2.5in, label: [Application])
#let server-healthy = server("expo/icons/check-circle.svg", size: 1.5in, label: [Application])
#let server-balancer = server("expo/icons/balance.svg", size: 2in, label: [Load Balancer])
#let users = icon("expo/icons/groups.svg", size: (2.5in, 1.5in), label: [Lots of Users])

#let spread-edges(count, width: 0.4, offset: 0) = {
  range(count).map(i => {
    let y = offset + math.lerp(-width/2, width/2, i / (count - 1))
    edge((0, y), (1, y), "-|>")
  })
}

#let users-outset = 0.3in

#let draw-single() = {
  fletcher.diagram(
    edge-stroke: 0.1in,
    spacing: 3in,
    mark-scale: 65%,
    node((0, 0), [#users], outset: users-outset, shape: rect),
    ..spread-edges(4, width: 0.3),
    node((1, 0), [#server-on-fire], shape: rect),
  )
}

#let draw-balanced() = {
  fletcher.diagram(
    edge-stroke: 0.1in,
    spacing: (3in, 0in),
    mark-scale: 65%,

    node((0, 1), [#users], outset: users-outset, shape: rect),
    ..spread-edges(4, width: 0.7, offset: 1),
    node((1, 1), [#server-balancer], outset: 0.3in, shape: rect),
    edge((1, 1), (2, 0), "-|>", bend: 20deg),
    edge((1, 1), (2, 1), "-|>"),
    edge((1, 1), (2, 2), "-|>", bend: -20deg),
    node((2, 0), server-healthy, shape: rect),
    node((2, 1), server-healthy, shape: rect),
    node((2, 2), server-healthy, shape: rect),
  )
}

#let ott = icon("expo/icons/ott-logo.svg", size: 2in, label: [OTT])
#let tv = icon("expo/icons/live-tv.svg", size: 1in)
#let person = icon("expo/icons/person.svg", size: 1in)

#let draw-ott() = {
  set text(size: 24pt)
  let people = range(3).map(i => (i, 1))

  let diag = fletcher.diagram(
    edge-stroke: 0.05in,
    spacing: (0.25in, 1.5in),
    mark-scale: 50%,
    node-inset: 0in,

    node((1, 0), [#ott]),
    ..people.map(p => node(p, [
      #stack(tv, person, spacing: 0in)
    ])),
    ..people.map(p => edge(p, (1, 0), "<|-|>",
      label: [Sync],
      label-fill: white,
      label-anchor: "center",
    )),
  )

  box(
    stroke: black + 4pt,
    inset: 0.5in,
    diag,
  )
}

#let draw-horizontal-vs-vertical() = {
  set text(size: 24pt)
  set align(horizon + center)
  let server-little = icon("expo/icons/dns.svg", size: 1in)
  let server-big = icon("expo/icons/dns.svg", size: 1.8in)
  let vertical = fletcher.diagram(
    edge-stroke: 0.05in,
    spacing: 1.5in,
    mark-scale: 50%,

    node((0, 0), [#server-little], shape: rect),
    edge((0, 0), (1, 0), "-|>", label: [Scale Up]),
    node((1, 0), [#server-big], shape: rect),
  )
  let horizontal = fletcher.diagram(
    edge-stroke: 0.05in,
    spacing: 1.5in,
    mark-scale: 50%,
    node((0, 0), [#server-little], shape: rect),
    edge((0, 0), (1, 0), "-|>", label: [Scale Up]),
    ..range(3).map(i => {
      let y = math.lerp(-0.5, 0.5, i / 2)
      node((1, y), [#server-little], shape: rect)
    }),
    ..range(3).map(i => {
      let y = math.lerp(-0.5, 0.5, i / 2)
      node((1.5, y), [#server-little], shape: rect)
    }),
  )
  stack(
    dir: ltr,
    h(1fr),
    figure(
      vertical,
      caption: figure.caption([Vertical Scaling], position: top)
    ),
    h(1fr),
    figure(
      horizontal,
      caption: figure.caption([Horizontal Scaling], position: top)
    ),
    h(1fr),
  )
}

#align(
  horizon,
  stack(dir: ltr,
    heading([OTT Load Balancer]),
    h(1fr),
    // TODO: maybe have this point to something we can change the redirect of later
    qr-code(width: 135pt, color: stevens-red, "https://expo.opentogethertube.com"),
  )
)

#align(
  horizon,
  stack(
    dir: ltr,
    line(length: 100% - 1in, stroke: stevens-red + 3pt),
    h(0.2in),
    image("expo/branding/stevens-star.svg", width: 0.8in)
  )
)

#text(
  size: 48pt,
)[
  *Victor Giraldo, Carson McManus, Michael Moreno, Christopher Roddy* \
  Software Engineering Department, Advised by Prof. Darian Muresan
]

#grid(
  rows: (auto, auto),
  row-gutter: 0.5in,

  columns(2)[
  == Unlocking Scalability for Stateful Applications

- Our project's goal is to build a load balancer for stateful applications to allow legacy systems to scale horizontally.
- Horizontal scaling refers to adding additional nodes, while vertical scaling is adding more power to current machines.
- OTT's userbase is steadily expanding, and the current infrastructure is incapable of accommodating the anticipated growth. Horizontal scaling is not possible due to the applications' stateful nature.

#draw-horizontal-vs-vertical()

#colbreak()

== Proof of Concept (OTT)

- OpenTogetherTube (OTT) is a website that allows users to watch videos together.
- Implementation of the load balancer will allow an application to be deployed around the world, lower latency for users, improve reliability, and allow for a larger number of simultaneous users.
- The load balancer allows for the allocation of rooms across multiple servers, preserving the seamless synchronization of state to users anywhere in the world.

#figure(
  draw-ott(),
  caption: figure.caption([Users in a Room watching a video], position: top)
)
],
[
  #set align(center)
  #text(size: 40pt, [Before])

  #draw-single()

  #text(size: 40pt, [After])

  #draw-balanced()
],
)
