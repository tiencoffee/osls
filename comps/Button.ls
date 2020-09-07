Button = m.component do
	ondefault: ->
		color: \light

	view: ->
		m \button.Button,
			class: m.class do
				"active": @attrs.active
				"Button-#{@attrs.color}"
				@attrs.class
			onclick: @attrs.onclick
			onmouseenter: @attrs.onmouseenter
			onmouseleave: @attrs.onmouseleave
			m \.Button-text,
				@children
