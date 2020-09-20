let
	uniqId = 0

	m <<<
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

		resultFn: (fn) ->
			if typeof fn is \function => fn! else fn

		resultObj: (obj, prop) ->
			if typeof! obj is \Object => obj[prop] else obj

		fetch: (url, dataType = \text) ->
			(await fetch url)[dataType]!

		component: (opts) ->
			->
				old = null
				vnode = {
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
				m.bind vnode
				vnode

		static: (comp, opts) !->
			comp <<< opts
			m.bind comp

		onvnode: (inst, vnode) !->
			inst.attrs = vnode.attrs or {}
			inst.children = vnode.children or []
			if attrs = inst.ondefault?!
				for k, val of attrs
					inst.attrs[k] ?= val

		createPopper: (refEl, popperEl, attrs = {}) ->
			modifiers =
				* name: \offset
					options:
						offset: attrs.offsets ? [0 0]
				* name: \preventOverflow
					options:
						padding: attrs.padding ? 5
				* name: \flip
					options:
						fallbackPlacements: attrs.flips
						allowedAutoPlacements: attrs.allowedFlips
			if attrs.sameWidth
				modifiers.push do
					name: \sameWidth
					enabled: yes
					phase: \main
					fn: ({state}) !~>
						state.styles{}popper.width = "#{state.rects.reference.width}px"
			Popper.createPopper refEl, popperEl,
				placement: attrs.placement ? \auto
				modifiers: modifiers
