
#let necessity_box(necessity, bgcolor: rgb("#cecfcf")) = {
	box(
		fill: bgcolor,
		inset: (x: 2pt, y: 2pt),
		outset: (x: 2pt, y: 2pt),
		necessity
	)
}

#let mustHave = necessity_box("Must Have", bgcolor: rgb("#ff6365"))
#let shouldHave = necessity_box("Should Have", bgcolor: rgb("#ecff09"))
#let couldHave = necessity_box("Could Have", bgcolor: rgb("#1ae53e"))
#let wouldBeNiceToHave = necessity_box("Would Be Nice To Have", bgcolor: rgb("#009dff"))

#let req(text, necessity, priority, usecase: "") = {
	let metadata = [#necessity]
	if (usecase != "") {
		let content = box(
			fill: rgb("#94ffe2"),
			inset: (x: 2pt, y: 2pt),
			outset: (x: 2pt, y: 2pt),
			usecase
		)
		metadata = [#metadata #content]
	}
	figure(
		metadata,
		caption: text,
		supplement: [Requirement],
		kind: "req")
};
