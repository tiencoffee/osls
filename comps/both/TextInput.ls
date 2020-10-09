TextInput = m.component do
	oninit: !->
		@isFocus = no
		@inputRef = null

	ondefault: ->
		type: \text
		size: 180

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
				"TextInput-hasLeftElement": @attrs.element
				"TextInput-hasRightElement": @attrs.rightElement
				@attrs.class
			style: m.style do
				width: @attrs.size
			onfocusout: (event) !~>
				if event.relatedTarget?closest \.ContextMenu
					event.target.focus!
			if @attrs.element
				m \.TextInput-element that
			@inputRef =
				m \input.TextInput-input,
					class: @attrs.inputClass
					type: @attrs.type
					autofocus: @attrs.autofocus
					minlength: @attrs.minlength
					maxlength: @attrs.maxlength
					min: @attrs.min
					max: @attrs.max
					step: @attrs.step
					required: @attrs.required
					value: @attrs.value
					oninput: !~>
						@attrs.onchange? it.target.value, it
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
