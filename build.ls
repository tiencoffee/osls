require! {
	"fs-extra": fs
	\glob-concat
	pug
}
process.chdir __dirname

do !->>
	paths = []
	paths ++= globConcat.sync \comps/*
	fs.outputJsonSync \paths.json paths

	html = fs.readFileSync \main.pug \utf8
	html = pug.render html, doctype: \html
	fs.outputFileSync \index.html html
