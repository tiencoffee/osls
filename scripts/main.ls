App = m.component do
	oninit: (v) !->
		@colors = <[black white dark gray light blue green yellow red]>
		@val = "Chào :3"
		@val2 = "Meme"
		@isShow = yes
		@popperPlacement = \auto
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
				label: \Alt+Home
			* text: "Xóa"
				icon: \trash
				color: \red
				label: \Del
			* text: "Văn bản này dài khá dài đó, không biết nó dài đến đâu nữa, à dài đến đây thôi"
				label: \Shift+PgUp
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
			@colors.map (color) ~>
				m Button,
					color: color
					color
			m TextInput,
				defaultValue: "haha"
				oninput: (@val) !~>
			m TextInput,
				value: @val2
				oninput: (@val2) !~>
			m \p @val
			m \p @val2
			m Button,
				onclick: !~>
					@val = ""
				"Reset val"
			m Button,
				onclick: !~>
					not= @isShow
				"Toggle isShow: #{@isShow}"
			m Menu,
				list: @list
			m Icon, name: \home
			m Icon, name: \fad:beer
			m Icon, name: \https://image.flaticon.com/icons/svg/3352/3352375.svg
			m \span \oks
			m Button,
				onclick: !~>
					@popperPlacement = @popperPlacement is \auto and \bottom-end or \auto
				"popperPlacement: #{@popperPlacement}"
			m Popover,
				placement: @popperPlacement
				content:
					m \.p-3,
						m \h3 "Đây là một cái Popover xịn xò!"
						m \small.text-gray Date.now!
						m \br
						m ButtonGroup,
							m Button,
								\OK
							m Button,
								color: \red
								\Đóng
				if @isShow
					m Button, "Click me!"
