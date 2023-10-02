= Changelog

This table is automatically generated from the current git history.

#let changelog = csv("changelog.csv")

#figure(
	table(
		columns: 3,
		[Date], [Author], [Description],
		..changelog.rev().flatten()
	),
	caption: "Document Changelog"
) <changelog>
