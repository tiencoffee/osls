App = m.component do
	load:
		loaded: no

	crypto:
		textEncoder: new TextEncoder

	taskbar:
		location: \bottom
		combine: \whenFull

	display:
		light: no
		nightLight: no

	appl:
		list: []

	task:
		list: []

	file:
		entry: (path) ~>
			fs.getEntry path

		exists: (path) ~>
			fs.exists path

		copy: (path, newPath, create = no) ~>
			fs.copy path, newPath, {create}

		move: (path, newPath, create = no) ~>
			fs.rename path, newPath, {create}

		stats: (path) ~>
			fs.stat path

		createDir: (path) ~>
			fs.mkdir path

		readDir: (path, deep = no) ~>
			fs.readdir path, {deep}

		removeDir: (path) ~>
			fs.rmdir path

		readFile: (path, type = \text) ~>
			fs.readFile path,
				type: type.0.toUpperCase! + type.substring 1

		writeFile: (path, data, method = \writeFile) ~>
			unless _.isArrayBuffer data
				data = @crypto.textEncoder.encode data .buffer
			fs[method] path, data

		appendFile: (path, data) ~>
			fs.writeFile path, data, \appendFile

		removeFile: (path) ~>
			fs.unlink path

		usage: ~>
			fs.usage!

	oncreate: ->
		await fs.init do
			type: window.PERSISTENT
			bytes: 268435456
		@load.loaded = yes
		m.redraw!

	view: ->
		if @load.loaded
			m \.column.full,
				m \.col \Desktop
				m \.col-0.px-3.py-2 \Taskbar
