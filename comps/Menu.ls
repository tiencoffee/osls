Menu = m.component class
	->
		@item = null

	ondefault: ->
		color: \light

	view: ->
		m \.Menu,
			class: @attrs.class
			@attrs.list.map (item) ~>
				m \.Menu-item,
					class: m.class do
						"Menu-item-#{item.color}"
						"Menu-item-noSubmenu": not item.submenu
						"active": @attrs.active
					m \.Menu-itemIcon,
						if item.icon
							m Icon, name: item.icon
					m \.Menu-itemText item.text
					if item.label or item.submenu
						m \.Menu-itemLabel,
							if item.submenu
								m Icon, name: \angle-right
							else
								item.label
					if item.submenu and @item is item
						m Menu,
							class: "Menu-submenu"
							list: item.submenu
