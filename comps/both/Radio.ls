Radio = m.component do
	onbeforeupdate: !->
		@checked = @attrs.checked is @attrs.value

	view: ->
		m \label.Radio,
			m Button,
				class: \Radio-input
				color: @checked and \blue or \gray
				icon: @checked and \circle
				onclick: !~>
					unless @checked
						@attrs.onchange? @attrs.value
			if @attrs.label?
				m \.Radio-label,
					@attrs.label
