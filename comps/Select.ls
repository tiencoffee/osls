Select = m.component do
	oninit: !->
		@isOpen = no

	ondefault: ->
		items: []
		item: null

	view: ->
		m Popover,
			isOpen: @isOpen
			portalClass: \Select-portal
			placement: \bottom-start
			flips: [\top-start]
			allowedFlips: [\bottom-start \top-start]
			offsets: [0 -1]
			sameWidth: yes
			onchange: (@isOpen) !~>
			targetTag: Button
			targetAttrs:
				class: \Select
				fill: yes
				alignText: \left
				rightIcon: \caret-down
				onclick: !~>
					not= @isOpen
			contentAttrs:
				class: \Select-content
			content: (popover) ~>
				m Menu,
					fill: yes
					item: @attrs.item
					items: @attrs.items
					onitemchange: (item, event) !~>
						@attrs.onitemchange? item, event
					onitemclick: popover.close
			m.resultObj @attrs.item, \text
