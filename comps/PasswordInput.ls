PasswordInput = m.component do
	oninit: !->
		@isShowPassword = no
		@inputRef = null

	oncontextmenu: (event) !->
		@attrs.oncontextmenu? event
		ContextMenu.open [
			* text: @isShowPassword and "Ẩn mật khẩu" or "Hiện mật khẩu"
				icon: @isShowPassword and \eye-slash or \eye
				onclick: !~>
					not= @isShowPassword
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

	view: ->
		m TextInput,
			class: m.class do
				"PasswordInput-showPassword": @isShowPassword
				"PasswordInput"
				@attrs.class
			autofocus: @attrs.autofocus
			icon: @attrs.icon
			value: @attrs.value
			inputRef: (@inputRef) !~>
			onchange: (val, event) !~>
				@attrs.onchange val, event
			oncopy: (.preventDefault!)
			oncut: (.preventDefault!)
			oncontextmenu: @oncontextmenu
			rightElement:
				m Button,
					minimal: yes
					icon: @isShowPassword and \eye-slash or \eye
					onclick: !~>
						not= @isShowPassword
