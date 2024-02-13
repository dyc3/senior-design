#import "@preview/in-dexter:0.0.5": *

#set document(
	title: "OpenTogetherTube Load Balancer",
	author: ("Carson McManus", "Christopher Roddy"),
)
#set heading(numbering: "1.")
#set page(
	numbering: "1",
	margin: 1cm,
)
#show link: underline
#show ref: underline

// hack: https://github.com/typst/typst/issues/2497
#show figure.where(kind: table): set block(breakable: true)
#show figure.where(kind: "usecase"): set block(breakable: true)

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
#include "monolith-discovery.typ"
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

#metadata("!glossary:disable")
#glossary("glossary.yaml")
#pagebreak()
#include "index.typ"
#pagebreak()
#bibliography("bibfile.bib")

