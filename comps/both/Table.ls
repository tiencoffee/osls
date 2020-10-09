Table = m.component do
	ondefault: ->
		bordered: no
		striped: no
		interactive: no
		maxHeight: void

	view: ->
		m \.Table,
			class: m.class do
				"Table-bordered": @attrs.bordered
				"Table-striped": @attrs.striped
				"Table-interactive": @attrs.interactive
				"Table-hasHeader": @attrs.header
			m \.Table-content,
				style: m.style do
					maxHeight: @attrs.maxHeight
				if @attrs.header
					@attrs.header
				@children
