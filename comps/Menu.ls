Menu = m.component do
	oninit: !->
		@item = null
		@popper = null
		@submenuTimeoutId = 0

	ondefault: ->
		fill: no
		minimal: no
		minWidth: 160
		showEmptyIcons: no
		scrollIntoView: no
		items: []
		activeItem: null
		submenuDelay: 200
		root: @

	onmousedownWindow: (event) !->
		unless event.target.closest \.Menu
			@item = null
			m.redraw!

	oncreate: !->
		if @attrs.scrollIntoView
			if el = @dom.querySelector \.Menu-item.active
				el.scrollIntoView do
					block: \center

	onbeforeupdate: !->
		@showEmptyIcons = @attrs.showEmptyIcons or @attrs.items.some (?icon)

	onbeforeremove: !->
		clearTimeout @submenuTimeoutId
		removeEventListener \mousedown @onmousedownWindow, yes

	view: ->
		m \.Menu,
			class: m.class do
				"Menu-fill": @attrs.fill
				"Menu-minimal": @attrs.minimal
				@attrs.class
			style: m.style do
				minWidth: @attrs.minWidth
				@attrs.style
			tabindex: @attrs.tabindex
			@attrs.items.map (item) ~>
				if item?
					m \.Menu-item,
						class: m.class do
							"hover": item is @item
							"active": item is @attrs.activeItem
							"Menu-item-#{item.color or \gray}"
							"Menu-item-#{item.submenu and \has or \no}Submenu"
						tabindex: 0
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
											offsets: [-5 -4]
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
								unless item is @attrs.activeItem
									item.onclick? event
									@attrs.root.attrs.onchange? item, event
								@attrs.root.attrs.onitemclick? item, event
						if @showEmptyIcons
							m \.Menu-itemIcon,
								if item.icon
									m Icon, name: item.icon
						m \.Menu-itemText,
							m.resultObj item, \text
						if item.label or item.submenu
							m \.Menu-itemLabel,
								if item.submenu
									m Icon, name: \caret-right
								else
									item.label
						if @item is item and item.submenu
							m Menu,
								class: \Menu-submenu
								showEmptyIcons: @attrs.showEmptyIcons
								items: item.submenu
								root: @attrs.root
								onremove: !~>
									@popper.destroy!
									@popper = null
				else
					m \.Menu-divider
