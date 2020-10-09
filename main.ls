styl = ""
code = ""

fetch2 = (path, dataType = \text) ->
	(await fetch path)[dataType]!

Paths = await fetch2 \Paths.json \json

styl += await fetch2 \both.styl

paths = <[
	scripts/define.ls
]>
paths ++= Paths"comps/both"
paths ++= Paths"comps/main"
paths ++= <[
	scripts/main.ls
	scripts/mount.ls
]>
for path in paths
	code += await fetch2 path

styl = stylus.render styl, {+compress}
stylEl.textContent = styl

livescript.run code
