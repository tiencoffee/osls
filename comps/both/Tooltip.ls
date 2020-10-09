Tooltip = m.component do
	oninit: !->
		@popper = null
		@portalEl = null

	onmouseenterChildren: (event) !->
		@attrs.onmouseenter? event
		unless @popper
			@portalEl = document.createElement \div
			@portalEl.className = \Portal
			portalsEl.appendChild @portalEl
			tooltip =
				view: ~>
					m \.Tooltip,
						@attrs.content @
			m.mount @portalEl, tooltip
			@popper = m.createPopper @dom, @portalEl

	onmouseleaveChildren: (event) !->
		@attrs.onmouseleave? event
		if @popper
			@popper.destroy!
			@popper = null
			m.mount @portalEl, null
			@portalEl.remove!
			@portalEl = null

	onbeforeupdate: !->
		if @children.0
			@children.0.attrs <<<
				onmouseenter: @onmouseenterChildren
				onmouseleave: @onmouseleaveChildren

	view: ->
		@children
