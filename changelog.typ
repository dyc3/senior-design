= Changelog

This table is automatically generated from the current git history.

#import "lib/misc.typ": github

#let changelog = csv("changelog.csv").map(row => {

	// auto link to issues

	let new_row = ();
	for item in row {
		let matches = item.matches(regex("\#\d+"))
		let processed = [];
		let index = 0;
		for match in matches {
			let head = item.slice(index, match.start);
			index = match.end;
			processed += head;
			processed += [#github("dyc3/senior-design", match.text.slice(1, match.text.len()))];
		}
		processed += item.slice(index, item.len());
		new_row += (processed,);
	}
	new_row
})

#figure(
	table(
		columns: 3,
		[Date], [Author], [Description],
		..changelog.rev().flatten()
	),
	caption: "Document Changelog"
) <changelog>
