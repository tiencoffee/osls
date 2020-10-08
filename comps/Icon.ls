Icon = m.component do
	oninit: !->
		@type = void
		@name = void

	ondefault: ->
		size: void

	onbeforeupdate: !->
		{name} = @attrs
		switch
		| name.startsWith \//
			name = \https: + name
		| not name.includes \:
			name = \fas: + name
		[, @type, @name] = name is /(.+?):(.+)/

	view: ->
		switch @type
		| \https \http
			m \img.Icon.Icon-img,
				class: @attrs.class
				style: m.style do
					fontSize: @attrs.size
					width: \auto if @attrs.size is \auto
					height: \auto if @attrs.size is \auto
				src: "#{@type}:#{@name}"
				onload: m.redraw
		else
			m \i.Icon,
				class: m.class do
					"#{@type} fa-#{@name}"
					@attrs.class
				style: m.style do
					fontSize: @attrs.size
