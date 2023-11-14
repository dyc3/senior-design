#let usecase(title, description: none, stakeholders: (), basic_flow: (), alt_flows: (), prereq: ()) = {
	let content = ()

	if stakeholders.len() > 0 {
		content.push([*Stakeholders*

			#list(..stakeholders)
		])
	}

	if description != none {
		content.push([*Description*

		#description])
	}

	if prereq.len() > 0 {
		content.push([*Prerequisites*

			#list(..prereq)
		])
	}

	if basic_flow.len() > 0 {
		content.push([*Basic Flow*

			#list(..basic_flow)
		])
	}

	if alt_flows.len() > 0 {
		for alt_flow in alt_flows {
			content.push([*Alternate Flow*

				#list(..alt_flow)
			])
		}
	}

	// prevent splitting individual blocks between pages
	// content = content.map(c => {
	// 	block(
	// 		breakable: false,
	// 		c,
	// 	)
	// })

	figure(
		align(left, table(
			columns: 1,
			..content,
		)),
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
