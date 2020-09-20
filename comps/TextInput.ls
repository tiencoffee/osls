TextInput = m.component do
	oninit: !->
		@isFocus = no
		@inputRef = null

	ondefault: ->
		type: \text

	oncontextmenu: !->
		ContextMenu.open [
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
			* text: "Xóa"
				icon: \trash-alt
				label: \Backspace
				onclick: !~>
					document.execCommand \delete
			,,
			* text: "Chọn tất cả"
				label: \Ctrl+A
				onclick: !~>
					@inputRef.dom.select!
		] event

	onbeforeupdate: !->
		if @attrs.icon
			@attrs.element ?= m Icon, name: that
		if @attrs.rightIcon
			@attrs.rightElement ?= m Icon, name: that

	onupdate: !->
		@attrs.inputRef? @inputRef

	view: ->
		m \.TextInput,
			class: m.class do
				"focus": @isFocus
			if @attrs.element
				m \.TextInput-element that
			@inputRef =
				m \input.TextInput-input,
					class: m.class do
						"TextInput-inputWithLeftElement": @attrs.element
						"TextInput-inputWithRightElement": @attrs.rightElement
						@attrs.class
					type: @attrs.type
					autofocus: @attrs.autofocus
					minlength: @attrs.min
					maxlength: @attrs.max
					min: @attrs.min
					max: @attrs.max
					step: @attrs.step
					required: @attrs.required
					value: @attrs.value
					oninput: @attrs.oninput
					onfocus: (event) !~>
						@isFocus = yes
						@attrs.onfocus? event
					onblur: (event) !~>
						@isFocus = no
						@attrs.onblur? event
					oncopy: @attrs.oncopy
					oncut: @attrs.oncut
					oncontextmenu: (event) !~>
						@attrs.oncontextmenu? event
						@oncontextmenu event
					onwheel: @attrs.onwheel
			if @attrs.rightElement
				m \.TextInput-element that
