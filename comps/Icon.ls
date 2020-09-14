Icon = m.component do
	oninit: !->
		@type = void
		@name = void

	onbeforeupdate: !->
		{name} = @attrs
		name = "fas:#name" unless name.includes \:
		[, @type, @name] = name is /(.+):(.+)/

	view: ->
		switch @type
		| \https \http
			m \img.Icon.Icon-img,
				class: @attrs.class
				src: "#{@type}:#{@name}"
				onload: m.redraw
		else
			m \i.Icon,
				class: m.class do
					"#{@type} fa-#{@name}"
					@attrs.class
