TextInput = m.component do
	options:
		model: \value

	oninit: !->
		@isFocus = no

	ondefault: ->
		value: @attrs.defaultValue ? ""
		type: \text

	onbeforeupdate: !->
		if @attrs.icon
			@attrs.element ?= m Icon, name: that
		if @attrs.rightIcon
			@attrs.rightElement ?= m Icon, name: that

	view: ->
		m \.TextInput,
			class: m.class do
				"focus": @isFocus
			if @attrs.element
				m \.TextInput-element that
			m \input.TextInput-input,
				class: m.class do
					"TextInput-inputWithLeftElement": @attrs.element
					"TextInput-inputWithRightElement": @attrs.rightElement
					@attrs.class
				type: @attrs.type
				autofocus: @attrs.autofocus
				value: @attrs.value
				oninput: !~>
					@attrs.value = it.target.value
					@attrs.oninput? it
				onfocus: !~>
					@isFocus = yes
					@attrs.onfocus? it
				onblur: !~>
					@isFocus = no
					@attrs.onblur? it
				oncopy: @attrs.oncopy
				oncut: @attrs.oncut
			if @attrs.rightElement
				m \.TextInput-element that
