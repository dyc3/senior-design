#import "@preview/in-dexter:0.0.5": *

#set document(
	title: "OpenTogetherTube Load Balancer",
	author: ("Carson McManus", "Christopher Roddy"),
)
#set heading(numbering: "1.")

#import "lib/glossary.typ": glossary, glossaryWords, glossaryShow
#show glossaryWords("glossary.yaml"): word => glossaryShow("glossary.yaml", word)

#align(center, text(size: 24pt)[Load Balancer for OpenTogetherTube Horizontal Scaling])
#align(center, "by")
#align(center, "Carson McManus, Christopher Roddy")
#align(center, text(size: 8pt)[With additional contributions from: Evan Ciok, Sophia DiCuffa, Cindy Lee])
#pagebreak()

#outline()
#pagebreak()

#outline(title: "List of Figures", target: figure.where(kind: image))
#pagebreak()

#outline(title: "List of Tables", target: figure.where(kind: table))
#pagebreak()

#include "changelog.typ"
#pagebreak()
#include "introduction.typ"
#include "team-declaration.typ"
#include "motivation.typ"
#include "weekly-reports.typ"
#include "user-interviews.typ"
#include "use-cases.typ"
#include "constraints-justification.typ"
#include "solution-overview.typ"
#include "join-process.typ"
#include "protocol.typ"
#include "api-proxy.typ"
#include "room-states.typ"
#include "elicitation-validation.typ"
#include "harness-requirements.typ"
#pagebreak()

#glossary("glossary.yaml")
#include "index.typ"