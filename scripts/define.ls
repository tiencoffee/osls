Object.assign m,
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

	fetch: (url, dataType = \text) ->
		(await fetch url)[dataType]!

	menu: (items) ->
		items = _.castArray items
		for item in items
			item.color ?= \light
			if item.submenu
				item.submenu = m.menu that
		items

	component: (comp) ->
		ctor = comp::?@@?bind comp or !->
		oncreate = comp::?oncreate?bind comp or !->
		onbeforeupdate = comp::?onbeforeupdate?bind comp or !->
		comp::@@ = (vnode) !->
			console.log vnode
			m.onvnode.call @, vnode
			ctor vnode
		comp::oncreate = (vnode) !->
			m.onvnode.call @, vnode
			oncreate vnode
		comp::onbeforeupdate = (vnode) ->
			old =
				attrs: {...@attrs}
				children: [...@children]
			m.onvnode.call @, vnode
			onbeforeupdate old, vnode
		m.bind comp
		comp

	onvnode: (vnode) !->
		{@attrs = {}, @children = [], @dom} = vnode
		if @ondefault
			defls = @ondefault vnode or {}
			@attrs = Object.assign defls, @attrs
		@onassign? vnode
