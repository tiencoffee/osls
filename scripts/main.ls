App = m.component do
	oninit: (v) !->
		@pkmStarter = \charmander
		@pokemons = <[farfetchd eiscue]>
		@checkboxChecked = yes
		@sliderVal = 15
		@isShowLunarDate = no
		@colors = <[gray blue green yellow red]>
		@val = "Meme"
		@val2 = "C:/programs/paint.exe"
		@num = 32
		@dat = new Date
		@isShowPopover = yes
		@isShowPopoverTarget = yes
		@isOpenPopover = no
		@placementPopover = \auto
		@usePortalPopover = yes
		@items =
			* text: "Chọn"
				color: \blue
			,,
			* text: "Mở"
			* text: "Ứng dụng"
				icon: \window-restore
				submenu:
					* text: "Trình duyệt"
						submenu:
							* text: "Chrome"
								icon: \fab:chrome
							* text: "Firefox"
								icon: \fab:firefox
							* text: "Edge"
								icon: \fab:edge
								submenu:
									* text: "Edge"
										icon: \fab:edge
									* text: "Edge (legacy)"
					* text: "Trò chơi"
						icon: \gamepad-alt
						submenu:
							* text: "Liên Minh Huyền Thoại"
							...
					* text: "Văn bản này dài khá dài đó, không biết nó dài đến đâu nữa, à dài đến đây thôi"
						label: \Shift+PgUp
			* text: "Sắp xếp theo"
				submenu:
					* text: "Tên"
					* text: "Kích thước"
					* text: "Ngày"
					,,
					* text: "Tùy chọn..."
			* text: "Trang chủ"
				icon: \home
				label: \Alt+Home
			,,
			* text: "Xóa"
				icon: \trash-alt
				color: \red
				label: \Del
			,,
			* text: "Chia sẻ"
				icon: \share
				color: \yellow
				submenu:
					* text: "Facebook"
						icon: \https://www.flaticon.com/svg/static/icons/svg/733/733547.svg
						submenu:
							* text: "Facebook"
								icon: \https://www.flaticon.com/svg/static/icons/svg/733/733547.svg
							* text: "Messenger"
								icon: \https://www.flaticon.com/svg/static/icons/svg/733/733548.svg
					* text: "Twitter"
						icon: \https://www.flaticon.com/svg/static/icons/svg/733/733579.svg
						color: \blue
					* text: "LINE"
						icon: \https://www.flaticon.com/svg/static/icons/svg/2111/2111498.svg
						color: \green
					* text: "Pinterest"
						icon: \https://www.flaticon.com/svg/static/icons/svg/220/220214.svg
						color: \red
					* text: "Tiktok"
						icon: \https://www.flaticon.com/svg/static/icons/svg/3046/3046121.svg
			* text: "Tìm kiếm trên Google..."
				icon: \https://image.flaticon.com/icons/svg/2702/2702602.svg
		@selectItems =
			* text: "Rết"
				value: \ret
			* text: "Vượn đen má trắng"
				value: yes
			* text: "Rồng đất"
				value: no
			* text: "Khủng long bạo chúa"
				value: null
			,,
			* text: "Sao biển"
				value: p: 2
			* text: "Rái cá"
				value: "rai ca"
			* text: "Chim cánh cụt hoàng đế"
				value: 1
			"Khỉ đầu chó"
			-493.1024
			,,
			* text: "Gà 🐔"
				value: [4 \chicken]
			,,
			* text: 123
				value: 456
			* text: "<empty>"
				value: ""
			* text: "Đại bàng"
				value: \dai-bang
			# "Nếu con thuyền phải ra khơi giữa mùa bão nổi, những người đi biển sẽ không bao giờ về. Nếu hành trang vào đời không được chuẩn bị chu đáo, người ta sẽ vấp phạm từ lầm lỡ này sang lầm lỡ khác. Nếu tình yêu không bị thử thách, sao có thể biết ai là người hết lòng vì ta."
		@table =
			* text: "Samurott"
				icon: \https://www.serebii.net/pokedex-swsh/icon/503.png
				type: "Water"
			* text: "Beedrill (Mega)"
				icon: \https://www.serebii.net/pokedex-swsh/icon/015-m.png
				type: "Bug / Poison"
			* text: "Stonjourner"
				icon: \https://www.serebii.net/pokedex-swsh/icon/874.png
				type: "Rock"
			* text: "Darmanitan (Galarian Form Zen Mode)"
				icon: \https://www.serebii.net/pokedex-swsh/icon/555-gz.png
				type: "Ice / Fire"
			* text: "Exeggutor (Galarian Form)"
				icon: \https://www.serebii.net/pokedex-swsh/icon/103-a.png
				type: "Grass / Dragon"
			* text: "Gyarados"
				icon: \https://www.serebii.net/pokedex-swsh/icon/130.png
				type: "Water / Flying"
			* text: "Sawsbuck (Autumn Form)"
				icon: \https://www.serebii.net/pokedex-swsh/icon/586-a.png
				type: "Normal / Grass"
			* text: "Shellos (East Sea)"
				icon: \https://www.serebii.net/pokedex-swsh/icon/422-e.png
				type: "Water"
			* text: "Kyurem"
				icon: \https://www.serebii.net/pokedex-swsh/icon/646.png
				type: "Dragon / Ice"
		@selectVal = "rai ca"

	oncreate: !->
		addEventListener \contextmenu (event) !~>
			event.preventDefault!
			ContextMenu.open @items, event

	view: ->
		m \.p-3.full.scroll-y,
			m \pre """
				Radio = m.component do
				\tonbeforeupdate: !->
				\t\t@checked = @attrs.checked is @attrs.value

				\tview: ->
				\t\tm \\label.Radio,
				\t\t\tm Button,
				\t\t\t\tclass: \\Radio-input
				\t\t\t\tcolor: @checked and \\blue or \\gray
				\t\t\t\ticon: @checked and \\circle
				\t\t\t\tonclick: !~>
				\t\t\t\t\tunless @checked
				\t\t\t\t\t\t@attrs.onchange? @attrs.value
				\t\t\tif @attrs.label?
				\t\t\t\tm \\.Radio-label,
				\t\t\t\t\t@attrs.label
			"""
			m \p m.trust """<u>Khủng long</u> là những con vật khổng lồ dài đến 50m và trọng lượng lên tới 77 tấn. Cổ chúng cũng dài, như, các con siêu khủng long <b>Supersaurus</b> (một chi khủng long thuộc cận bộ Sauropod) cổ dài 15m với tổng chiều dài cơ thể khoảng 33m. Trong nhiều năm, các nhà khoa học đã ghi nhận một số sự biến đổi mang tính thích nghi trong bộ xương của loài bò sát Sauropod, nhằm đỡ cho thân thể khổng lồ. Cũng như các loài vật có xương sống khác, các đốt sống bao gồm 2 phần chính: thân đốt sống hình trụ (<i>corpus vertebrae</i>) và vòng cung (<i>arcus vertebrae</i>) có dạng vòm. Các lỗ kéo dài giữa thân đốt sống và vòng cung chứa tủy sống. Chúng được sắp xếp riêng biệt, sau đó dần dần kết nối và phát triển liền vào nhau. Nhưng trước khi kết nối liền nhau, thân đốt sống kết nối với vòng cung bằng mô sụn đàn hồi."""
			m \code \html
			m \kbd \P
			m \kbd \Alt+F4
			for i from 1 to 6
				m "h#i" "Tiêu đề h#i"
			m Table,
				bordered: yes
				striped: yes
				interactive: yes
				maxHeight: 200
				header:
					m \tr,
						m \th \Icon
						m \th \Tên
						m \th \Hệ
				@table.map (item) ~>
					m \tr,
						m \td,
							m Icon,
								name: item.icon
								size: \auto
						m \td item.text
						m \td item.type
			m Radio,
				checked: @pkmStarter
				value: \bulbasaur
				label: \Bulbasaur
				onchange: (@pkmStarter) !~>
			m Radio,
				checked: @pkmStarter
				value: \charmander
				label: \Charmander
				onchange: (@pkmStarter) !~>
			m Radio,
				checked: @pkmStarter
				value: \squirtle
				label: \Squirtle
				onchange: (@pkmStarter) !~>
			m \p "@pkmStarter: #{@pkmStarter}"
			m Checkbox,
				checked: @pokemons
				value: \stonjourner
				label: \Stonjourner
			m Checkbox,
				checked: @pokemons
				value: \eiscue
				label: \Eiscue
			m Checkbox,
				checked: @pokemons
				value: \farfetchd
				label: \Farfetch'd
			m Checkbox,
				checked: @pokemons
				value: \hoOh
				label: \Ho-Oh
			m Checkbox,
				checked: @pokemons
				value: \porygon2
				label: \Porygon2
			m Checkbox,
				checked: @pokemons
				value: \nidoranF
				label: \Nidoran♀
			m Checkbox,
				checked: @pokemons
				value: \typeNull
				label: "Type: Null"
			m \p "@pokemons: #{@pokemons * ", "}"
			m Checkbox,
				checked: @checkboxChecked
				label: "checkboxChecked: #{@checkboxChecked}"
				onchange: (@checkboxChecked) !~>
			m Slider,
				min: 7.1
				max: 19.5
				step: 2.3
				value: @sliderVal
				onchange: (@sliderVal) !~>
			m Calendar,
				showLunarDate: @isShowLunarDate
				value: @dat
				onchange: (@dat) !~>
			m \span,
				style: m.style do
					fontSize: @sliderVal
				@dat + ""
			m Button,
				onclick: !~>
					not= @isShowLunarDate
				"isShowLunarDate: #{@isShowLunarDate}"
			m NumberInput,
				value: @num
				onchange: (@num) !~>
			m \div "num: #{@num}"
			m ControlGroup,
				m TextInput
				m Button,
					icon: \sort-alpha-down
				m Button, "Quay lại"
				if @isShowPopover
					m Popover,
						isOpen: @isOpenPopover
						placement: @placementPopover
						usePortal: @usePortalPopover
						onchange: (@isOpenPopover) !~>
						content: (popover) ~>
							m \.p-3,
								m \h3 "Đây là một cái Popover xịn xò"
								m \small.text-gray Date.now!
								m \br
								m ControlGroup,
									m Button,
										\OK
									m Button,
										color: \red
										onclick: popover.close
										\Đóng
						if @isShowPopoverTarget
							m Button, "Click me!"
			m Select,
				items: @selectItems
				value: @selectVal
				onchange: (@selectVal) !~>
			m \.text-prewrap """
				value: #{@selectVal}
				typeof!: #{typeof! @selectVal}
			"""
			m Button,
				onclick: !~>
					@placementPopover = @placementPopover is \auto and \bottom-end or \auto
				"placementPopover: #{@placementPopover}"
			m Button,
				color: @usePortalPopover and \blue or \gray
				onclick: !~>
					not= @usePortalPopover
				"usePortalPopover: #{@usePortalPopover}"
			m Button,
				onclick: !~>
					not= @isShowPopover
				"Toggle isShowPopover: #{@isShowPopover}"
			m Button,
				onclick: !~>
					not= @isShowPopoverTarget
				"Toggle isShowPopoverTarget: #{@isShowPopoverTarget}"
			m Button,
				onclick: !~>
					not= @isOpenPopover
				"isOpenPopover: #{@isOpenPopover}"
			@colors.map (color) ~>
				m Button,
					color: color
					color
			@colors.map (color) ~>
				m Button,
					minimal: yes
					color: color
					color
			m ControlGroup,
				m Button,
					color: \blue
					"Nokia"
				m Button, "Samsung"
				m Button, "Iphone"
				m Button,
					color: \red
					"Huawei"
				m Button,
					color: \green
					"Xiaomi"
			m Button,
				color: \blue
				icon: \star
				"Dấu trang"
			m Button,
				color: \green
				icon: \key
			m Button,
				icon: \key
			m TextInput,
				rightElement:
					m Button,
						minimal: yes
						color: \blue
						icon: \atom
						"Nguyên tử"
			m PasswordInput,
				icon: \key
				value: @val
				onchange: (@val) !~>
			m TextInput,
				value: @val2
				onchange: (@val2) !~>
			m \p @val
			m \p @val2
			m Menu,
				items: @items
			m Icon, name: \home
			m Icon, name: \fad:beer
			m Icon, name: \https://image.flaticon.com/icons/svg/3352/3352375.svg
			m Button,
				onclick: !~>
					@val = ""
				"Reset val"
			m \span \oks
