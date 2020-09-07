Menu = m.component do
	viewMenuItem: (item) ->
		m \.Menu-item,
			key: item.id
			class: m.class do
				"Menu-item-#{item.color}"
				"Menu-item-noSubmenu": not item.submenu
				"hover": @item is item
			onmouseenter: !~>
				@item = item.submenu and item
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

	view: ->
		m \.Menu,
			class: @attrs.class
			@attrs.list.map (item) ~>
				if item.submenu
					m Popover,
						key: item.id
						interactKind: \hover
						placement: \right-start
						offsets: [-6 0]
						flips: [\left-start]
						content:
							m Menu,
								list: item.submenu
						@viewMenuItem item
				else
					@viewMenuItem item
