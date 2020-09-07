Icon = m.component do
	onassign: !->
		{name} = @attrs
		name = "fas:#name" unless name.includes \:
		[, @attrs.type, @attrs.name] = name is /(.+):(.+)/

	view: ->
		{type, name} = @attrs
		switch type
		| \http \https
			m \img.Icon.Icon-img, src: "#type:#name"
		else
			m \i.Icon, class: "#type fa-#name"
