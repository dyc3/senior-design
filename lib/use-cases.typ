#let usecase_counter = counter(figure.where(kind: "usecase"))

#let usecase(title, description: "", diagram: "", diagram_caption: "", stakeholders: (), level: 2) = {
	let content = align(left)[
		#heading([Use Case #usecase_counter.display(): #title], level: level)

		#if stakeholders.len() > 0 {
			[*Stakeholders*

			#list(stakeholders)
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

= Testing

#usecase(
	[Foo],
	description: "This is a foo use case",
) <foo>

Link to @foo
