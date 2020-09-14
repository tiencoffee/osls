PasswordInput = m.component do
	options:
		model: \value

	oninit: !->
		@isShowPassword = no

	ondefault: ->
		value: @attrs.defaultValue ? ""

	view: ->
		m TextInput,
			class: m.class do
				"PasswordInput-showPassword": @isShowPassword
				"PasswordInput"
				@attrs.class
			autofocus: @attrs.autofocus
			icon: @attrs.icon
			rightIcon: @attrs.rightIcon
			rightElement:
				m Button,
					minimal: yes
					icon: @isShowPassword and \eye-slash or \eye
					onclick: !~>
						not= @isShowPassword
			value: @attrs.value
			oninput: !~>
				@attrs.value = it.target.value
				@attrs.oninput? it
			oncopy: !~>
				it.preventDefault!
			oncut: !~>
				it.preventDefault!
