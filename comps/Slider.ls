Slider = m.component do
	oninit: !->
		@hasPointerCapture = no
		@percent = 0
		@tooltipPopper = null
		@buttonRef = null

	ondefault: ->
		min: 0
		max: 10
		step: 1
		size: 180
		labelStep: void
		labelPrecision: void
		labelViewer: null

	generateRanges: (step, precision, viewer) ->
		{min, max} = @attrs
		ranges = []
		el = document.createElement \input
		el.type = \range
		el.min = min
		el.max = max
		el.step = step
		el.value = min
		loop
			{value} = el
			ranges.push +value
			el.stepUp!
			break if value is el.value
		percent = 0
		range = max - min
		for val, i in ranges
			value = switch
				| viewer => viewer val, i
				| precision? => +val.toFixed precision
				else val
			ranges[i] =
				value: value
				percent: percent
			percent += ((ranges[i + 1] ? max) - val) / range * 100
		ranges

	onpointerdownThumb: (event) !->
		event.target.setPointerCapture event.pointerId
		@hasPointerCapture = yes

	onpointerupThumb: (event) !->
		event.target.releasePointerCapture event.pointerId
		@hasPointerCapture = no

	onpointermoveThumb: (event) !->
		event.redraw = no
		if @hasPointerCapture
			percent = (event.x - @dom.offsetLeft - 10) / (@dom.offsetWidth - 20) * 100
			label = @values.reduce (a, b) ~>
				if Math.abs(a.percent - percent) < Math.abs(b.percent - percent) => a else b
			unless label.value is @attrs.value
				@attrs.onchange? label.value
				m.redraw.sync!
				@tooltipPopper.update!

	oncreateTooltip: (vnode) !->
		unless @tooltipPopper
			@tooltipPopper = m.createPopper @buttonRef.dom, vnode.dom,
				placement: \top
				offsets: [0 2]

	onbeforeRemoveTooltip: (vnode) !->
		if @tooltipPopper
			@tooltipPopper.destroy!
			@tooltipPopper = null

	onbeforeupdate: !->
		@attrs.labelStep ?= @attrs.step
		@values = @generateRanges @attrs.step
		@labels = @generateRanges @attrs.labelStep, @attrs.labelPrecision, @attrs.labelViewer
		@percent = (@attrs.value - @attrs.min) / (@attrs.max - @attrs.min) * 100

	view: ->
		m \.Slider,
			style: m.style do
				width: @attrs.size
			m \.Slider-body,
				m \.Slider-track,
					style: m.style do
						background: "linear-gradient(90deg,\#007ef6 #{@percent}%,\#ced9e0 #{@percent}%)"
				m \.Slider-labels,
					@labels.map (label) ~>
						m \.Slider-label,
							style: m.style do
								left: label.percent + \%
							label.value
				@buttonRef =
					m Button,
						class: \Slider-thumb
						style:
							left: @percent + \%
						color: \blue
						onpointerdown: @onpointerdownThumb
						onpointerup: @onpointerupThumb
						onpointermove: @onpointermoveThumb
			if @hasPointerCapture
				m \.Slider-tooltip,
					oncreate: @oncreateTooltip
					onbeforeremove: @onbeforeRemoveTooltip
					@attrs.value
