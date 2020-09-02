Popover = m.component class
	->
		@isModel = \value of @attrs
		@isOpen = @attrs.defaultIsOpen

	ondefault: ->
		placement: \auto
		offset: 0
		padding: 8
		flips: void
		allowedFlips: void

	oncreate: !->
		portalsEl.appendChild @dom
		@popper = Popper.createPopper @children.0.dom, @dom,
			placement: @attrs.placement
			modifiers:
				* name: \offset
					options:
						offset: [0 @attrs.offset]
				* name: \preventOverflow
					options:
						padding: @attrs.padding
				* name: \flip
					options:
						fallbackPlacements: @attrs.flips
						allowedAutoPlacements: @attrs.allowedFlips

	onbeforeupdate: (old) !->
		if @isModel and @attrs.isOpen isnt old.attrs.isOpen
			@togglePopper!
		unless @attrs.placement is old.attrs.placement
			@popper.setOptions placement: @attrs.placement

	onremove: !->
		@popper.destroy!

	view: ->
		m.fragment do
			m \.Popover 445
			@children
