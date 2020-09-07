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

		menu: (items) ->
			items = _.castArray items
			for item, id in items
				item.id = id
				item.color ?= \light
				if item.submenu
					item.submenu = m.menu that
			items

		component: (opts) ->
			->
				old = null
				comp = {
					...opts
					attrs: {}
					children: []
					__oninit: opts.oninit or ->
					__oncreate: opts.oncreate or ->
					__onbeforeupdate: opts.onbeforeupdate or ->
					__onupdate: opts.onupdate or ->
					oninit: (v) !->
						m.onvnode @, v
						@__oninit v
						old :=
							attrs: {...@attrs}
							children: [...@children]
					oncreate: (v) !->
						@{dom} = v
						@__oncreate v
					onbeforeupdate: (v) ->
						m.onvnode @, v
						@__onbeforeupdate old, v
					onupdate: (v) !->
						@{dom} = v
						@__onupdate old, v
						old :=
							attrs: {...@attrs}
							children: [...@children]
				}
				m.bind comp
				comp

		onvnode: (inst, v) !->
			{modelAttr} = inst
			if isUncontrolModel = modelAttr and modelAttr of inst.attrs
				modelVal = inst.attrs[modelAttr]
			inst.attrs = v.attrs or {}
			inst.children = v.children or []
			if attrs = inst.ondefault? v
				for k, val of attrs
					v.attrs[k] ?= val
			inst.onassign? v
			if isUncontrolModel
				inst.attrs[modelAttr] = modelVal
