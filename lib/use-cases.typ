#let usecase_counter = counter(figure.where(kind: "usecase"))

#let usecase(title, description: "", diagram: none, diagram_caption: none, stakeholders: ()) = {
	let content = ()

	if stakeholders.len() > 0 {
		content.push([*Stakeholders*

			#list(..stakeholders)
		])
	}

	if description != "" {
		content.push([*Description*

		#description])
	}

	if diagram != none {
		let caption = if diagram_caption == none { [Use Case: #title] } else { diagram_caption }
		content.push([#figure(
			image("../figures/" + diagram),
			caption: caption,
		)])
	}

	figure(
		table(
			columns: 1,
			..content,
		),
		caption: figure.caption(
			position: top,
			title
		),
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