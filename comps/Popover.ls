Popover = m.component do
	modelAttr: \isOpen

	oninit: !->
		@attrs.isOpen ?= @attrs.defaultIsOpen
		@popper = null
		@globalEventFn = null

	ondefault: ->
		defaultIsOpen: no
		placement: \auto
		offsets: [0, 0]
		padding: 8
		flips: void
		allowedFlips: void
		interactKind: \click

	onassign: !->
		if target = @children.0
			classProp = typeof target.tag is \function and \class or \className
			target.attrs[classProp] ?= ""
			target.attrs[classProp] += " Popover-target"
			switch @attrs.interactKind
			| \click
				{onclick} = target.attrs
				target.attrs.onclick = !~>
					not= @attrs.isOpen
					onclick? it
			| \hover
				{onmouseenter} = target.attrs
				target.attrs.onmouseenter = !~>
					@attrs.isOpen = yes
					onmouseenter? it

	oncreate: !->
		@updateIsOpen!

	updateIsOpen: !->
		if @attrs.isOpen and @children.0
			unless @popper
				portalsEl.appendChild @dom
				@popper = Popper.createPopper @children.0.dom, @dom,
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
				if @attrs.interactKind is \click
					@globalEventFn = (event) !~>
						unless event.target.closest \.Popover-target
							@attrs.isOpen = no
							@updateIsOpen!
					window.addEventListener \mousedown @globalEventFn, yes
		else
			if @popper
				@popper.destroy!
				@popper.state.elements.popper.remove!
				@popper = null
				window.removeEventListener \mousedown @globalEventFn

	onupdate: (old) !->
		if @attrs.isOpen isnt old.attrs.isOpen or @children.0 isnt old.children.0
			@updateIsOpen!

	onremove: !->
		@updateIsOpen!

	view: ->
		m.fragment do
			if @attrs.isOpen
				m \.Popover,
					@attrs.content
			@children
