Popover = m.component do
	modelAttr: \isOpen

	oninit: ->
		@attrs.isOpen ?= @attrs.defaultIsOpen
		@popper = null
		@portal = m \.Popover,
			@attrs.content!
		m.render portalsEl, @portal

	ondom: !->
		@popper = Popper.createPopper @dom, @portal.dom,
			placement: @attrs.placement
			modifiers:
				* name: \offset
					options:
						offset: @attrs.offsets
				* name: \preventOverflow
					options:
						padding: @attrs.padding
				* name: \flip
					options:
						fallbackPlacements: @attrs.flips
						allowedAutoPlacements: @attrs.allowedFlips

	ondefault: ->
		defaultIsOpen: no
		placement: \auto
		offsets: [0 0]
		padding: 8
		flips: void
		allowedFlips: void
		interactKind: \click
		targetTag: \div
		targetAttrs: {}

	view: ->
		m @attrs.targetTag, {
			...@attrs.targetAttrs
			class: m.class do
				\Popover-target
				@attrs.targetAttrs.class
		}, @children
