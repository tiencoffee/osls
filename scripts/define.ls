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
			opts.hooks ?= {}
			->
				old = null
				scope =
					attrs: {}
					children: []
					dom: null
				scope <<<< that if opts.methods
				comp =
					oninit: !->
						m.onvnode @, it
						scope <<<< that! if opts.state
						opts.hooks.init?call scope
						old :=
							attrs: {...scope.attrs}
							children: [...scope.children]
					oncreate: !->
						scope.dom = it.dom
						opts.hooks.create?call scope
					onbeforeupdate: ->
						m.onvnode @, it
						opts.hooks.onbeforeupdate?call scope, old
					onupdate: !->
						scope.dom = it.dom
						opts.hooks.onupdate?call scope, old
						old :=
							attrs: {...scope.attrs}
							children: [...scope.children]
				m.bind scope
				comp

		onvnode: (inst, v) !->
			{model} = inst.options
			if isUncontrolModel = model and model of inst.attrs
				modelVal = inst.attrs[model]
			inst.attrs = v.attrs or {}
			inst.children = v.children or []
			if attrs = inst.ondefault? v
				for k, val of attrs
					v.attrs[k] ?= val
			if isUncontrolModel
				inst.attrs[model] = modelVal
