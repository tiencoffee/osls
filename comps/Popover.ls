Popover = m.component do
	oninit: !->
		@popper = null
		@portalEl = null
		@portalsEl = null

	ondefault: ->
		isOpen: void
		usePortal: yes
		portalClass: ""
		placement: \auto
		offsets: [0 0]
		padding: 5
		flips: void
		allowedFlips: void
		sameWidth: no
		targetTag: \div
		targetAttrs: {}

	close: !->
		if @attrs.isOpen
			@attrs.onchange? no
			m.redraw!

	onupdate: (old) !->
		@portalsEl = @attrs.usePortal and portalsEl or @dom
		if @attrs.isOpen
			unless @popper
				@portalEl = document.createElement \div
				@portalEl.className = "Portal #{@attrs.portalClass}"
				@portalsEl.appendChild @portalEl
				popover =
					view: ~>
						m \.Popover,
							@attrs.contentAttrs
							@attrs.content @
				m.mount @portalEl, popover
				@popper = m.createPopper @dom, @portalEl, @attrs
			unless @attrs.placement is old.attrs.placement
				@popper?setOptions placement: @attrs.placement
			unless @attrs.usePortal is old.attrs.usePortal
				@portalsEl.appendChild @portalEl
			@popper.forceUpdate!
		else
			if @popper
				@popper.destroy!
				@popper = null
				m.mount @portalEl, null
				@portalEl.remove!

	view: ->
		m @attrs.targetTag, {
			...@attrs.targetAttrs
			class: m.class do
				\Popover-target
				@attrs.targetAttrs.class
			onclick: !~>
				@attrs.targetAttrs.onclick? it
				unless @attrs.isOpen and @portalEl.contains it.target
					@attrs.onchange? not @attrs.isOpen
		},
			@children
