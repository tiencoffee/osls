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
					@inputRef.dom.focus!
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

	view: ->
		m TextInput,
			class: m.class do
				"PasswordInput-showPassword": @isShowPassword
				"PasswordInput"
				@attrs.class
			autofocus: @attrs.autofocus
			icon: @attrs.icon
			value: @attrs.value
			oninput: @attrs.oninput
			oncopy: (.preventDefault!)
			oncut: (.preventDefault!)
			oncontextmenu: @oncontextmenu
			inputRef: (@inputRef) ~>
			rightElement:
				m Button,
					minimal: yes
					icon: @isShowPassword and \eye-slash or \eye
					onclick: !~>
						not= @isShowPassword
