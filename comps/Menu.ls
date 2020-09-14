Menu = m.component do
	oninit: ->
		@item = null

	ondefault: ->
		list: []

	view: ->
		m \.Menu,
			class: @attrs.class
			@attrs.list.map (item) ~>
				m Popover,
					key: item.id
					groupId: item.groupId
					isOpen: @item is item
					interactKind: \hover
					placement: \right-start
					offsets: [-6 0]
					flips: [\left-start]
					targetAttrs:
						class: m.class do
							"hover": @item is item
							"Menu-item-noSubmenu": not item.submenu
							"Menu-item-#{item.color}"
							"Menu-item"
						onmouseenter: !~>
							@item = item
						onmouseleave: !~>
							@item = null
					content: ~>
						m Menu, list: that if item.submenu
					m \.Menu-itemIcon,
						if item.icon
							m Icon, name: item.icon
					m \.Menu-itemText item.groupId
					if item.label or item.submenu
						m \.Menu-itemLabel,
							if item.submenu
								m Icon, name: \angle-right
							else
								item.label
