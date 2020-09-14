let
	uniqId = 0

	m <<<<
		class: (...vals) ->
			res = []
			for val in vals
				if Array.isArray val
					res.push m.class ...val
				else if val instanceof Object
					for k, v of val
						res.push k if v
				else res.push val
			res * " "

		bind: (comp) !->
			for k, val of comp
				if typeof val is \function and val.name isnt /(bound|class) /
					comp[k] = val.bind comp

		rand: (min, max) ->
			switch &length
			| 0 =>
				max = 1
				min = 0
			| 1 =>
				max = min
				min = 0
			Math.floor min + Math.random! * (1 + Math.abs max - min)

		uuid: ->
			"$#{m.rand 9e9}#{m.uniqId!}#{Date.now!}"

		uniqId: ->
			++uniqId

		fetch: (url, dataType = \text) ->
			(await fetch url)[dataType]!

		menu: (items, groupId = \0-) ->
			items = _.castArray items
			for item, id in items
				item.id = groupId + id + \-
				item.groupId = groupId
				item.color ?= \gray
				if item.submenu
					item.submenu = m.menu that, item.id
			items

		component: (opts) ->
			->
				old = null
				comp = {
					options: {}
					...opts
					attrs: {}
					children: []
					__oninit: opts.oninit or ->
					__oncreate: opts.oncreate or ->
					__onbeforeupdate: opts.onbeforeupdate or ->
					__onupdate: opts.onupdate or ->
					oninit: !->
						m.onvnode @, it
						@__oninit!
						old :=
							attrs: {...@attrs}
							children: [...@children]
						@__onbeforeupdate old
					oncreate: !->
						@{dom} = it
						@__oncreate!
						@__onupdate old
					onbeforeupdate: ->
						m.onvnode @, it
						@__onbeforeupdate old
					onupdate: !->
						@{dom} = it
						@__onupdate old
						old :=
							attrs: {...@attrs}
							children: [...@children]
				}
				m.bind comp
				comp

		onvnode: (inst, v) !->
			{model} = inst.options
			if isModelOfAttr = model and model of inst.attrs
				modelVal = inst.attrs[model]
			inst.attrs = v.attrs or {}
			inst.children = v.children or []
			if attrs = inst.ondefault?!
				for k, val of attrs
					unless k is model and k of inst.attrs
						inst.attrs[k] ?= val
			if isModelOfAttr
				inst.attrs[model] = modelVal
