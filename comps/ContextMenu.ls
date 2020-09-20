ContextMenu =
	popper: null
	portalEl: null

	open: (items, opts) !->
		if items?length
			unless @popper
				@portalEl = document.createElement \div
				@portalEl.classList.add \Portal
				portalsEl.appendChild @portalEl
				contextMenu =
					view: ~>
						m Menu,
							class: \ContextMenu
							items: items
							onitemclick: (item) !~>
								unless item.submenu
									@close!
				m.mount @portalEl, contextMenu
				refEl =
					getBoundingClientRect: ~>
						left: opts.x
						top: opts.y
						right: opts.x
						bottom: opts.y
						width: 0
						height: 0
				@popper = m.createPopper refEl, @portalEl,
					placement: \bottom-start
					flips: [\top-start]
					offsets: [-3 -3]
				addEventListener \mousedown @onmousedownWindow, yes

	close: !->
		if @popper
			@popper.destroy!
			@popper = null
			m.mount @portalEl, null
			@portalEl.remove!
			removeEventListener \mousedown @onmousedownWindow, yes

	onmousedownWindow: (event) !->
		unless event.target.closest \.ContextMenu
			@close!

m.bind ContextMenu
