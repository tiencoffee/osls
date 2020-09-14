Popover = m.component do
	options:
		model: \isOpen

	oninit: !->
		@popper = null
		@portalEl = null
		@portalsEl = null

	ondefault: ->
		isOpen: @attrs.defaultIsOpen ? no
		placement: \auto
		offsets: [0 0]
		padding: 6
		flips: void
		allowedFlips: void
		interactKind: \click
		targetTag: \div
		targetAttrs: {}
		usePortal: yes
		groupId: void

	createPopper: (refEl, popperEl) ->
		Popper.createPopper refEl, popperEl,
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

	close: ->
		if @attrs.isOpen
			@attrs.isOpen = no
			@attrs.onchange? no
			m.redraw!

	onupdate: (old) !->
		@portalsEl = @attrs.usePortal and portalsEl or @dom
		unless @attrs.isOpen is old.attrs.isOpen
			if @attrs.isOpen
				if @attrs.groupId
					for groupId, inst of Popover.groups
						if groupId.startsWith @attrs.groupId
							inst.close!
				unless @popper
					@portalEl = document.createElement \div
					@portalsEl.appendChild @portalEl
					popover =
						view: ~>
							m \.Popover,
								@attrs.content @
					m.mount @portalEl, popover
					@popper = @createPopper @dom, @portalEl
				if @attrs.groupId
					Popover.groups[that] = @
			else
				if @popper
					@popper.destroy!
					@popper = null
					m.mount @portalEl, null
					@portalEl.remove!
					delete Popover.groups[@attrs.groupId]
		if @attrs.isOpen
			unless @attrs.placement is old.attrs.placement
				@popper?setOptions placement: @attrs.placement
			unless @attrs.usePortal is old.attrs.usePortal
				@portalsEl.appendChild @portalEl
				@popper.update!

	view: ->
		m @attrs.targetTag, {
			...@attrs.targetAttrs
			class: m.class do
				\Popover-target
				@attrs.targetAttrs.class
			onclick: !~>
				@attrs.targetAttrs.onclick? it
				if @attrs.interactKind is \click
					unless @attrs.isOpen and @portalEl.contains it.target
						not= @attrs.isOpen
						@attrs.onchange? @attrs.isOpen
			onmouseenter: !~>
				@attrs.targetAttrs.onmouseenter? it
				if @attrs.interactKind is \hover
					unless @attrs.isOpen
						@attrs.isOpen = yes
						@attrs.onchange? yes
		},
			@children

Popover <<<<
	groups: {}
