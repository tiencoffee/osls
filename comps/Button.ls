Button = m.component do
	ondefault: ->
		active: no
		alignText: \center
		color: \gray
		fill: no
		minimal: no

	view: ->
		m \button.Button,
			class: m.class do
				"active": @attrs.active
				"Button-fill": @attrs.fill
				"Button-minimal": @attrs.minimal
				"Button-onlyIcon": (@attrs.icon xor @attrs.rightIcon) and not @children.length
				"Button-#{@attrs.color}"
				"Button-alignText-#{@attrs.alignText}"
				@attrs.class
			style: m.style @attrs.style
			onclick: @attrs.onclick
			oncontextmenu: @attrs.oncontextmenu
			onmousedown: @attrs.onmousedown
			onmouseup: @attrs.onmouseup
			onmousemove: @attrs.onmousemove
			onmouseenter: @attrs.onmouseenter
			onmouseleave: @attrs.onmouseleave
			onmouseover: @attrs.onmouseover
			onmouseout: @attrs.onmouseout
			onpointerdown: @attrs.onpointerdown
			onpointerup: @attrs.onpointerup
			onpointermove: @attrs.onpointermove
			if @attrs.icon
				m Icon,
					class: \Button-icon
					name: @attrs.icon
			if @children.length
				m \.Button-text,
					@children
			if @attrs.rightIcon
				m Icon,
					class: \Button-icon
					name: @attrs.rightIcon
