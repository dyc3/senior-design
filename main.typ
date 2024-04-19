#import "@preview/in-dexter:0.0.5": *

#set document(
	title: "OpenTogetherTube Load Balancer",
	author: ("Carson McManus", "Christopher Roddy"),
)
#set heading(numbering: "1.")
#set page(
	"us-letter",
	numbering: "1",
	margin: 1in,
	binding: left,
)
#show link: underline
#show ref: underline

// hack: https://github.com/typst/typst/issues/2497
#show figure.where(kind: table): set block(breakable: true)
#show figure.where(kind: "usecase"): set block(breakable: true)

// render file names for images in the document
#show figure.where(kind: image): it => {
	let regex_image_calls = regex("image\\(([^)]+)\\)")
	let image_reprs = repr(it.body).matches(regex_image_calls).map(m => m.at("text"))
	assert(image_reprs.len() > 0)
	let regex_in_quotes = regex("\"([^\"]+)\"")
	let file_paths = image_reprs.map((im) => im.find(regex_in_quotes).trim(regex("(figures|svg|[./\"])")))

	show figure.caption: it => {
		it
		"\n"
		set text(size: 8pt, fill: luma(100))
		metadata("!glossary:disable")
		for file_path in file_paths {
			raw("file: [ " + file_path + " ]") + "\n"
		}
		metadata("!glossary:enable")
	}
	it
}

#import "lib/glossary.typ": glossary, glossaryWords, glossaryShow
#show glossaryWords("glossary.yaml"): word => glossaryShow("glossary.yaml", word)
// Index-Entry hiding : this rule makes the index entries in the document invisible.
#show figure.where(kind: "jkrb_index"): it => {}
#metadata("!glossary:disable")

#set align(center)
#text(size: 24pt)[Load Balancer for OpenTogetherTube Horizontal Scaling]

by

Carson McManus, Christopher Roddy, Victor Giraldo, Michael Moreno

#text(size: 8pt)[With additional contributions from: Evan Ciok, Sophia DiCuffa, Cindy Lee]

Document rendered on #datetime.today().display()

#image("expo/icons/ott-logo.svg", width: 100pt)

#set align(left)
#pagebreak()

#outline(indent: auto)
#pagebreak()

#outline(title: "List of Figures", target: figure.where(kind: image))
#pagebreak()

#outline(title: "List of Tables", target: figure.where(kind: table))
#pagebreak()
#metadata("!glossary:enable")

#include "changelog.typ"
#pagebreak()
#include "introduction.typ"
#pagebreak()
#include "team-declaration.typ"
#pagebreak()
#include "motivation.typ"
#pagebreak()
#include "dev-plan/dev-plan.typ"
#pagebreak()
#include "weekly-reports.typ"
#pagebreak()
#include "user-interviews.typ"
#pagebreak()
#include "user-personas.typ"
#pagebreak()
#include "use-cases.typ"
#pagebreak()
#include "user-stories.typ"
#pagebreak()
#include "constraints-justification.typ"
#pagebreak()
#include "balancer-requirements.typ"
#pagebreak()
#include "solution-overview.typ"
#pagebreak()
#include "balancer-design.typ"
#pagebreak()
#include "service-discovery.typ"
#pagebreak()
#include "join-process.typ"
#pagebreak()
#include "protocol.typ"
#pagebreak()
#include "api-proxy.typ"
#pagebreak()
#include "room-states.typ"
#pagebreak()
#include "elicitation-validation.typ"
#pagebreak()
#include "harness-requirements.typ"
#pagebreak()
#include "harness-design.typ"
#pagebreak()
#include "harness-tests.typ"
#pagebreak()
#include "visualization-requirements.typ"
#pagebreak()
#include "visualization-design.typ"
#pagebreak()
#include "testing.typ"
#pagebreak()

#metadata("!glossary:disable")
#glossary("glossary.yaml")
#pagebreak()
#include "index.typ"
#pagebreak()
#bibliography("bibfile.bib")
