#let github(repo, number) = {
	link("https://github.com/" + repo + "/issues/" + str(number))[#repo\##number]
}

= Testing

#show link: underline
#github("rust-lang/rust", 1234)
