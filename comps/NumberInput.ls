NumberInput = m.component do
	oninit: !->
		@inputRef = null
		@buttonTimeoutId = 0
		@buttonIntervalId = 0

	spin: (stepDir) !->
		@inputRef.dom[stepDir]!
		inputEvent = new CustomEvent \input
		@inputRef.dom.dispatchEvent inputEvent

	onmousedownButton: (stepDir, event) !->
		if event.which is 1
			@spin stepDir
			@buttonTimeoutId = setTimeout !~>
				@spin stepDir
				@buttonIntervalId = setInterval !~>
					@spin stepDir
				, 100
			, 300
			addEventListener \mouseup @onmouseupWindow

	onmouseupWindow: (event) !->
		clearTimeout @buttonTimeoutId
		clearInterval @buttonIntervalId

	view: ->
		m ControlGroup,
			class: \NumberInput
			m TextInput,
				class: \NumberInput-input
				type: \number
				autofocus: @attrs.autofocus
				min: @attrs.min
				max: @attrs.max
				step: @attrs.step
				required: @attrs.required
				value: @attrs.value
				inputRef: (@inputRef) ~>
				oninput: @attrs.oninput
				onwheel: !~>
					@attrs.onwheel? it
			m \.NumberInput-buttons,
				m Button,
					class: "NumberInput-button NumberInput-button-up"
					icon: \angle-up
					onmousedown: !~>
						@onmousedownButton \stepUp it
				m Button,
					class: "NumberInput-button NumberInput-button-down"
					icon: \angle-down
					onmousedown: !~>
						@onmousedownButton \stepDown it
