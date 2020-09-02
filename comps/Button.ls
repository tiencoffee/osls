Button =
	oninit: (v) !->
		v.attrs.color ?= \light

	view: (v) ->
		m \button.Button,
			class: m.class do
				"Button-#{v.attrs.color}"
				"active": v.attrs.active
			onclick: v.attrs.onClick
			m \.Button-text,
				v.children
