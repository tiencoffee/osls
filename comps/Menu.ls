Menu = m.component do
	oninit: !->
		@item = @oldItem = @attrs.item
		@popper = null
		@submenuTimeoutId = 0

	ondefault: ->
		fill: no
		minimal: no
		items: []
		submenuDelay: 200
		root: @

	onmousedownWindow: (event) !->
		unless event.target.closest \.Menu
			@item = null
			m.redraw!

	view: ->
		m \.Menu,
			class: m.class do
				"Menu-fill": @attrs.fill
				"Menu-minimal": @attrs.minimal
				@attrs.class
			@attrs.items.map (item) ~>
				if item?
					m \.Menu-item,
						class: m.class do
							"hover": @item is item
							"Menu-item-#{item.color or \gray}"
							"Menu-item-#{item.submenu and \has or \no}Submenu"
						onmouseenter: (event) !~>
							unless @item is item
								@item = null
								clearTimeout @submenuTimeoutId
								removeEventListener \mousedown @onmousedownWindow, yes
								if item.submenu
									@submenuTimeoutId = setTimeout !~>
										@item = item
										m.redraw.sync!
										@popper = m.createPopper event.target, event.target.lastChild,
											placement: \right-start
											offsets: [-6 0]
											flips: [\left-start]
											allowedFlips: <[right-start left-start]>
										addEventListener \mousedown @onmousedownWindow, yes
										@submenuTimeoutId = 0
									, @attrs.submenuDelay
						onmouseleave: !~>
							if @submenuTimeoutId
								clearTimeout @submenuTimeoutId
						onclick: (event) !~>
							unless item.submenu
								unless item is @oldItem
									item.onclick? event
									@attrs.root.attrs.onitemchange? item, event
								@attrs.root.attrs.onitemclick? item, event
						m \.Menu-itemIcon,
							if item.icon
								m Icon, name: item.icon
						m \.Menu-itemText,
							m.resultObj item, \text
						if item.label or item.submenu
							m \.Menu-itemLabel,
								if item.submenu
									m Icon, name: \angle-right
								else
									item.label
						if @item is item and item.submenu
							m Menu,
								class: \Menu-submenu
								items: item.submenu
								root: @attrs.root
								onremove: !~>
									@popper.destroy!
									@popper = null
				else
					m \.Menu-divider
