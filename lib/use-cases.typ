#let usecase_counter = counter("usecase")

#let usecase(title, description: "", diagram: "", diagram_caption: "", stakeholders: (), level: 2) = {
	usecase_counter.step()

	let label_content = [Use Case #usecase_counter.display()]
	set align(left)

	let content = [
		#heading([#label_content: #title], level: level)

		#if stakeholders.len() > 0 {
			[*Stakeholders*

			#list(stakeholders)
			]
		}

		#description

		#if diagram != "" {
			figure(
				image("../figures/" + diagram),
				caption: diagram_caption,
			)
		}
	]

	figure(
		content,
		caption-pos: top,
		// uncomment when upgrading to typst 0.8.0
		// caption: align(left, figure.caption(
		// 	position: top,
		// 	heading(title, level: level)
		// )),
		caption: align(left, heading(title, level: level)),
		supplement: [Use Case],
		kind: "usecase",
	)
}

= Testing

#let foo = heading([foo], numbering: "1.")

#foo <foo>

@foo
