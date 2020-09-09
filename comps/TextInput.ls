TextInput = m.component do
	options:
		model: \value

	oninit: !->
		@attrs.value ?= @attrs.defaultValue

	ondefault: ->
		defaultValue: ""

	view: ->
		m \.TextInput,
			m \input.TextInput-input,
				value: @attrs.value
				oninput: !~>
					@attrs.value = it.target.value
					@attrs.oninput? @attrs.value
