NumberInput = m.component do
	oninit: !->
		@inputRef = null
		@buttonTimeoutId = 0
		@buttonIntervalId = 0

	ondefault: ->
		size: 180

	spin: (delta) !->
		dir = delta < 0 and \stepDown or \stepUp
		for i til Math.abs delta
			@inputRef.dom[dir]!
		inputEvent = new CustomEvent \input
		@inputRef.dom.dispatchEvent inputEvent

	oncontextmenu: (event) !->
		@attrs.oncontextmenu? event
		ContextMenu.open [
			* text: "Tăng lên"
				icon: "chevron-up"
				label: \ArrowUp
				onclick: !~>
					@spin 1
			* text: "Giảm xuống"
				icon: "chevron-down"
				label: \ArrowDown
				onclick: !~>
					@spin -1
			,,
			* text: "Hoàn tác"
				icon: \undo
				label: \Ctrl+Z
				onclick: !~>
					document.execCommand \undo
			* text: "Làm lại"
				icon: \redo
				label: \Ctrl+Y
				onclick: !~>
					document.execCommand \redo
			,,
			* text: "Chọn tất cả"
				label: \Ctrl+A
				onclick: !~>
					@inputRef.dom.select!
		] event

	onmousedownButton: (delta, event) !->
		if event.which is 1
			@spin delta
			@buttonTimeoutId = setTimeout !~>
				@spin delta
				@buttonIntervalId = setInterval !~>
					@spin delta
				, 50
			, 300
			addEventListener \mouseup @onmouseupWindow

	onmouseupWindow: (event) !->
		clearTimeout @buttonTimeoutId
		clearInterval @buttonIntervalId

	view: ->
		m ControlGroup,
			class: \NumberInput
			style: m.style do
				width: @attrs.size
			m TextInput,
				type: \number
				autofocus: @attrs.autofocus
				min: @attrs.min
				max: @attrs.max
				step: @attrs.step
				required: @attrs.required
				value: @attrs.value
				inputRef: (@inputRef) !~>
				onchange: (val, event) !~>
					@attrs.onchange? val, event
				oncontextmenu: @oncontextmenu
				onwheel: !~>
					@attrs.onwheel? it
			m \.NumberInput-buttons,
				m Button,
					class: "NumberInput-button NumberInput-button-up"
					icon: \angle-up
					onmousedown: !~>
						@onmousedownButton 1 it
				m Button,
					class: "NumberInput-button NumberInput-button-down"
					icon: \angle-down
					onmousedown: !~>
						@onmousedownButton -1 it
