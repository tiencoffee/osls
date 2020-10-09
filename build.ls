require! {
	"fs-extra": fs
	pug
}
process.chdir __dirname

do !->>
	Paths = {}
	paths = <[
		comps/both
		comps/main
	]>
	for path in paths
		Paths[path] = fs.readdirSync path .map ~> "#path/#it"
	fs.outputJsonSync \Paths.json Paths, spaces: \\t

	html = fs.readFileSync \main.pug \utf8
	html = pug.render html, doctype: \html
	fs.outputFileSync \index.html html
