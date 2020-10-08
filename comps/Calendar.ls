Calendar = m.component do
	oninit: !->
		@momentLunarPkgLoaded = void

	ondefault: ->
		value: null
		showLunarDate: no

	setMom: (opts) !->
		oldMom = @mom.clone!
		@mom.set opts if opts
		unless @mom.isSame oldMom
			@attrs.onchange? @mom.format \YYYY-MM-DDTHH:mm
		@momData =
			year: @mom.year!
			month: @mom.month!
			date: @mom.date!
			daysInMonth: @mom.daysInMonth!

	onbeforeupdate: !->
		@mom = moment @attrs.value
		@setMom!
		@months = moment.months!map (month, i) ~>
			text: month
			value: i
		@years = [@momData.year - 20 to @momData.year + 20]
		@weekdays = moment.weekdaysMin yes
		@start = @mom.clone!startOf \month
		@start.date 1 - @start.weekday!
		@end = @mom.clone!endOf \month
		@end.date @end.date! + 6 - @end.weekday!
		@dates = []
		while @start < @end
			date =
				year: @start.year!
				month: @start.month!
				date: @start.date!
			if @attrs.showLunarDate and @momentLunarPkgLoaded
				lunar = @start.clone!lunar!
				date.lunar =
					year: lunar.year!
					month: lunar.month!
					date: lunar.date!
			@dates.push date
			@start.add 864e5
		if @attrs.showLunarDate
			if @momentLunarPkgLoaded is void
				@momentLunarPkgLoaded = no
				m.require \moment-lunar@0.0.4 .then !~>
					@momentLunarPkgLoaded = yes
					m.redraw!

	view: ->
		m \.Calendar,
			class: m.class do
				"Calendar-hasLunarDate": @attrs.showLunarDate and @momentLunarPkgLoaded
			m \.Calendar-caption,
				m Button,
					class: \Calendar-prev
					minimal: yes
					icon: \angle-left
					onclick: !~>
						@setMom month: @momData.month - 1
				m Select,
					minimal: yes
					size: 120
					items: @months
					value: @momData.month
					onchange: (month) !~>
						@setMom {month}
				m Select,
					minimal: yes
					size: 80
					items: @years
					value: @momData.year
					onchange: (year) !~>
						@setMom {year}
				m Button,
					class: \Calendar-next
					minimal: yes
					icon: \angle-right
					onclick: !~>
						@setMom month: @momData.month + 1
			m \.Calendar-weekdays,
				@weekdays.map (weekday) ~>
					m \.Calendar-weekday weekday
			m \.Calendar-dates,
				@dates.map (date) ~>
					m Button,
						class:
							"Calendar-outdate": date.month isnt @momData.month
							"Calendar-date"
						minimal: yes
						onclick: !~>
							@setMom date
						m \.Calendar-solarDate,
							date.date
						if @attrs.showLunarDate and @momentLunarPkgLoaded
							m \.Calendar-lunarDate,
								if date.lunar.date is 1 or date.date in [1 @momData.daysInMonth]
									"#{date.lunar.date}/#{date.lunar.month + 1}"
								else date.lunar.date
