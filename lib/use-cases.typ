#let usecase(title, description: "", diagram: "", diagram_caption: "", stakeholders: (), level: 2) = {
	let content = [
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

	show figure.where(
		kind: "usecase",
	): set align(left)

	show figure.caption.where(
		kind: "usecase",
	): it => {
		set align(left)
		set figure.caption(position: top)
		heading([#it], level: level)
	}

	figure(
		content,
		caption: figure.caption(
			title,
			position: top,
		),
		supplement: [Use Case],
		kind: "usecase",
	)
}

= Testing

#let foo = heading([foo], numbering: "1.")

#foo <foo>

@foo
