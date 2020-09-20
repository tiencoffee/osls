ControlGroup = m.component do
	view: ->
		m \.ControlGroup,
			class: @attrs.class
			@children
