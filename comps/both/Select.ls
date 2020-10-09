Select = m.component do
	oninit: !->
		@isOpen = no
		@popover = null
		@item = null

	ondefault: ->
		value: null
		items: []
		minimal: no
		size: 180
		maxHeight: innerHeight
		sameWidth: no

	onmousedownWindow: (event) !->
		unless event.which is 1 and (@dom.contains event.target or @popover.portalEl.contains event.target)
			@popover.close!

	onresizeWindow: !->
		m.redraw!

	removeEventWindow: !->
		removeEventListener \mousedown @onmousedownWindow, yes
		removeEventListener \resize @onresizeWindow, yes

	onbeforeupdate: !->
		@item = @attrs.items.find ~>
			@attrs.value in [it, it?value]
		if @isOpen
			@maxHeight = Math.floor innerHeight / 2 - @dom.offsetHeight
			@maxHeight <?= @attrs.maxHeight

	onupdate: (old) !->
		unless @isOpen is old.isOpen
			@removeEventWindow!
			if @isOpen
				addEventListener \mousedown @onmousedownWindow, yes
				addEventListener \resize @onresizeWindow, yes

	onbeforeremove: !->
		@removeEventWindow!

	view: ->
		m Popover,
			isOpen: @isOpen
			portalClass: \Select-portal
			popoverClass: \Select-content
			popoverStyle:
				maxHeight: @maxHeight
			placement: \auto
			allowedFlips: <[bottom top]>
			offsets: [0 -1]
			sameWidth: @attrs.sameWidth
			onopen: @onopen
			popoverRef: (@popover) !~>
			onchange: (@isOpen) !~>
			content: (popover) ~>
				m Menu,
					fill: yes
					minWidth: 0
					scrollIntoView: yes
					items: @attrs.items
					activeItem: @item
					onchange: (item, event) !~>
						@attrs.onchange? m.resultObj(item, \value), item, event
					onitemclick: popover.close
			m Button,
				class: \Select
				style: m.style do
					width: @attrs.size
				active: @isOpen
				minimal: @attrs.minimal
				alignText: \left
				rightIcon: \sort
				m.resultObj @item, \text
