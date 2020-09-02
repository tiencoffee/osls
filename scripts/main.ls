App = m.component class
	->
		@colors = <[black white dark gray light blue green yellow red]>
		@val = "Chào :3"
		@val2 = "Meme"
		@list = m.menu [
			* text: "Chọn"
				color: \blue
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
						submenu:
							* text: "Liên Minh Huyền Thoại"
			* text: "Sắp xếp theo"
				icon: \sort-size-down-alt
				submenu:
					* text: "Tên"
					* text: "Kích thước"
					* text: "Ngày"
			* text: "Trang chủ"
				icon: \home
			* text: "Xóa"
				icon: \trash
				color: \red
				label: \Del
			* text: "Thông tin"
				label: \Alt+Enter
			* text: "Tìm kiếm trên Google..."
				icon: \https://image.flaticon.com/icons/svg/2702/2702602.svg
			* text: "Chia sẻ"
				submenu:
					* text: "Facebook"
						icon: \https://www.flaticon.com/premium-icon/icons/svg/2504/2504903.svg
					* text: "Twitter"
						icon: \https://www.flaticon.com/premium-icon/icons/svg/2504/2504947.svg
					* text: "LINE"
						icon: \https://image.flaticon.com/icons/png/512/2504/2504922.png
					* text: "Pinterest"
						icon: \https://image.flaticon.com/icons/png/512/2504/2504932.png
					* text: "Tiktok"
						icon: \https://image.flaticon.com/icons/png/512/2504/2504942.png
		]

	view: ->
		m \.p-3,
			# @colors.map (color) ~>
			# 	m Button,
			# 		color: color
			# 		color
			m TextInput,
				value: @val
				onInput: (@val) !~>
			m TextInput,
				value: @val2
				onInput: (@val2) !~>
			m \p @val
			m \p @val2
			# m Button, "xinchao"
			# m Button,
			# 	onClick: !~>
			# 		@val = ""
			# 	"Reset val"
			# m Menu,
			# 	list: @list
			# m Icon, name: \home
			# m Icon, name: \fad:beer
			# m Icon, name: \https://image.flaticon.com/icons/svg/3352/3352375.svg
			# m \span \oks
			# m Popover,
			# 	m Button, "Click me!"
