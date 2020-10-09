m <<<
	uniqIdVal: 0
	requiredPkgs: []
	cssUnitless:
		animationIterationCount: yes
		borderImageOutset: yes
		borderImageSlice: yes
		borderImageWidth: yes
		boxFlex: yes
		boxFlexGroup: yes
		boxOrdinalGroup: yes
		columnCount: yes
		columns: yes
		flex: yes
		flexGrow: yes
		flexPositive: yes
		flexShrink: yes
		flexNegative: yes
		flexOrder: yes
		gridArea: yes
		gridRow: yes
		gridRowEnd: yes
		gridRowSpan: yes
		gridRowStart: yes
		gridColumn: yes
		gridColumnEnd: yes
		gridColumnSpan: yes
		gridColumnStart: yes
		fontWeight: yes
		lineClamp: yes
		lineHeight: yes
		opacity: yes
		order: yes
		orphans: yes
		tabSize: yes
		widows: yes
		zIndex: yes
		zoom: yes
		fillOpacity: yes
		floodOpacity: yes
		stopOpacity: yes
		strokeDasharray: yes
		strokeDashoffset: yes
		strokeMiterlimit: yes
		strokeOpacity: yes
		strokeWidth: yes

	class: (...vals) ->
		res = []
		for val in vals
			if Array.isArray val
				res.push m.class ...val
			else if val instanceof Object
				for k, v of val
					res.push k if v
			else if val?
				res.push val
		res * " "

	style: (props) ->
		if props
			for k, val of props
				if not m.cssUnitless[k] and +val
					props[k] += \px
		props

	bind: (obj) !->
		for k, val of obj
			if typeof val is \function and val.name isnt /(bound|class) /
				obj[k] = val.bind obj

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
		++m.uniqIdVal

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

	require: (...pkgs) !->
		code = ""
		for pkg in pkgs
			unless m.requiredPkgs[pkg]
				code += await (await fetch "//cdn.jsdelivr.net/npm/#pkg")text!
				m.requiredPkgs[pkg]
		window.eval code if code

	createPopper: (refEl, popperEl, attrs = {}, isSelect) ->
		modifiers =
			* name: \offset
				options:
					offset: attrs.offsets
			* name: \preventOverflow
				options:
					padding: attrs.padding
			* name: \flip
				options:
					fallbackPlacements: attrs.flips
					allowedAutoPlacements: attrs.allowedFlips
		if attrs.sameWidth or isSelect
			modifiers.push do
				name: \sameWidth
				enabled: yes
				phase: \beforeWrite
				fn: ({state}) !~>
					state.styles.popper ?= {}
					widthPx = state.rects.reference.width + \px
					if attrs.sameWidth
						state.styles.popper.width = widthPx
					if isSelect
						state.styles.popper.minWidth = widthPx
		Popper.createPopper refEl, popperEl,
			placement: attrs.placement ? \auto
			strategy: \fixed
			modifiers: modifiers
