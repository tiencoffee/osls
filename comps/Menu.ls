Menu = m.component do
	viewMenuItemChildren: (item) ->
		m.fragment do
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
						targetAttrs:
							class: m.class do
								"hover": @item is item
						onmouseenter: !~>
							@item = item
						content: ~>
							m Menu,
								list: item.submenu
						@viewMenuItemChildren item
				else
					m \.Menu-item,
						key: item.id
						class: m.class do
							"Menu-item-#{item.color}"
							"Menu-item-noSubmenu"
						@viewMenuItemChildren item
