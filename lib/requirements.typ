
#let necessity_box(necessity) = {
	box(
		fill: rgb("#cecfcf"),
		inset: (x: 2pt, y: 2pt),
		outset: (x: 2pt, y: 2pt),
		necessity
	)
}

#let mustHave = necessity_box("Must Have")
#let shouldHave = necessity_box("Should Have")
#let couldHave = necessity_box("Could Have")
#let wouldBeNiceToHave = necessity_box("Would Be Nice To Have")

#let VERY_HIGH = 1
#let HIGH = 2
#let MEDIUM = 3
#let LOW = 4
#let VERY_LOW = 5

#let priority_box(pri) = {
	let color = "#999999";
	if(pri == VERY_HIGH) { color = "#FF0407" }
	else if(pri == HIGH) { color = "#ff390a" }
	else if(pri == MEDIUM) { color = "#ecff09" }
	else if(pri == LOW) { color = "#1ae53e" }
	else if(pri == VERY_LOW) { color = "#009dff" }

	box(
		inset: (x: 2pt, y: 2pt),
		outset: (x: 2pt , y: 2pt),
		fill: rgb(str(color)),
		[P] + str(pri)
	)
};

#let req(text, necessity, priority, usecase: "") = {
	let metadata = [#priority_box(priority) #necessity]
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
