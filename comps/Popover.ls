Popover = m.component do
	model:
		attr: \isOpen
		default: -> @attrs.defaultIsOpen

	attrs:
		defaultIsOpen: Boolean
		placement:
			type: String
			default: \auto
		offsets:
			type: Array
			default: -> [0 0]
		padding:
			type: Number
			default: 8
		flip

	state: ->
		portal = m \.Popover,
			@attrs.content!
		m.render portalsEl, portal
		popper: null
		portal: portal

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

	view: ->
		m @attrs.targetTag, {
			...@attrs.targetAttrs
			class: m.class do
				\Popover-target
				@attrs.targetAttrs.class
		}, @children
