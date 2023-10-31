#let usecase_counter = counter(figure.where(kind: "usecase"))

#let usecase(title, description: "", diagram: "", diagram_caption: "", stakeholders: (), level: 2) = {
	let content = align(left)[
		#heading([Use Case #usecase_counter.display(): #title], level: level)

		#if stakeholders.len() > 0 {
			[*Stakeholders*

			#list(..stakeholders)
			]
		}

		#description

		#if diagram != "" {
			let caption = if diagram_caption == "" { [Use Case: #title] } else { diagram_caption }
			figure(
				image("../figures/" + diagram),
				caption: caption,
			)
		}
	]

	figure(
		content,
		supplement: [Use Case],
		kind: "usecase",
	)
}

#let userstory(stakeholder, want, why) = {
	let content = [As a *#stakeholder*, I want *#want* so that *#why*]

	figure(
		[],
		caption: content,
		supplement: [User Story],
		kind: "userstory",
	)
}

#let usecase_flows(basic: (), alt: ()) = {
	figure(
		table(
			columns: 2,
			[*Basic Flow*], [*Alternate Flow*],
			[#list(..basic)], [#list(..alt)]
		),
		supplement: [Use Case Flow],
		kind: "usecase-flow",
	)
}

= Testing

#usecase(
	[Foo],
	description: "This is a foo use case",
) <foo>

Link to @foo

#userstory(
	[User],
	[foo],
	[bar],
) <bar>

Link to @bar

#usecase_flows(
	basic: ("foo", "bar"),
	alt: ("oof", "rab")
)