Checkbox = m.component do
	onbeforeupdate: !->
		@isCheckList = Array.isArray @attrs.checked
		@checked =
			if @isCheckList => @attrs.checked?includes @attrs.value
			else @attrs.checked

	view: ->
		m \label.Checkbox,
			m Button,
				class: \Checkbox-input
				color: @checked and \blue or \gray
				icon: @checked and \check
				onclick: !~>
					if @isCheckList
						index = @attrs.checked.indexOf @attrs.value
						if index < 0
							@attrs.checked.push @attrs.value
						else
							@attrs.checked.splice index, 1
					@attrs.onchange? not @checked
			if @attrs.label?
				m \.Checkbox-label,
					@attrs.label
