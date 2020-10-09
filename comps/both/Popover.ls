Popover = m.component do
	oninit: !->
		@popper = null
		@portalEl = null
		@portalsEl = null
		@attrs.popoverRef? @

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

	close: !->
		if @popper
			@attrs.onchange? no
			@attrs.onclose?!
			@removePortal!
			m.redraw!

	removePortal: !->
		if @popper
			@popper.destroy!
			@popper = null
			m.mount @portalEl, null
			@portalEl.remove!
			@portalEl = null

	onupdate: (old) !->
		@portalsEl = @attrs.usePortal and portalsEl or @dom
		if @attrs.isOpen
			unless @popper
				@portalEl = document.createElement \div
				@portalEl.className = "Portal #{@attrs.portalClass}"
				@portalsEl.appendChild @portalEl
				popover =
					view: ~>
						m \.Popover {
							class: m.class @attrs.popoverClass
							style: m.style @attrs.popoverStyle
							...@attrs.popoverAttrs
						} @attrs.content @
				m.mount @portalEl, popover
				@popper = m.createPopper @dom, @portalEl, @attrs, yes
				@popper.forceUpdate!
				@attrs.onopen? @
			unless @attrs.placement is old.attrs.placement
				@popper?setOptions placement: @attrs.placement
			unless @attrs.usePortal is old.attrs.usePortal
				@portalsEl.appendChild @portalEl
				@popper.forceUpdate!
		else
			if @popper
				@removePortal!

	onbeforeremove: !->
		@attrs.popoverRef? null
		@close!

	view: ->
		m \div,
			class: m.class do
				\Popover-target
				@attrs.class
			style: @attrs.style
			onclick: (event) !~>
				unless @attrs.isOpen and @portalEl.contains event.target
					isOpen = not @attrs.isOpen
					@attrs.onchange? isOpen
					@attrs.onclose?! unless isOpen
			@children
