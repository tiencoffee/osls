styl = ""
code = ""

fetch2 = (path) ->
	dataType = path.endsWith \.json and \json or \text
	(await fetch path)[dataType]!

styl += await fetch2 \both.styl
styl = stylus.render styl, {+compress}
stylEl.textContent = styl

paths = <[
	scripts/define
	...paths.json
	scripts/main
	scripts/mount
]>
for path in paths
	if path.startsWith \...
		path = await fetch2 path.slice 3
		for subpath in path
			code += await fetch2 subpath
	else
		path += \.ls unless path.includes \.
		code += await fetch2 path
livescript.run code
