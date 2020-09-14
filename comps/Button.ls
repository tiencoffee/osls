Button = m.component do
	ondefault: ->
		color: \gray

	view: ->
		m \button.Button,
			class: m.class do
				"Button-#{@attrs.color}"
				"Button-minimal": @attrs.minimal
				"active": @attrs.active
				@attrs.class
			onclick: @attrs.onclick
			onmouseenter: @attrs.onmouseenter
			onmouseleave: @attrs.onmouseleave
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
