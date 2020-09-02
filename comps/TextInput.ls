TextInput =
	oninit: (v) !->
		# @isModel = \value of @attrs
		# @value = @attrs.defaultValue

	view: (v) ->
		aa = v.attrs
		m \.TextInput,
			m \input.TextInput-input,
				value: if @isModel => @attrs.value else @value
				oninput: !~>
					console.log aa is v.attrs
					@value = it.target.value
					# @attrs.onInput? @value
