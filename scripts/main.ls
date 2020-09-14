App = m.component do
	oninit: (v) !->
		@colors = <[gray blue green yellow red]>
		@val = "Meme"
		@val2 = "C:/programs/paint.exe"
		@isShow = yes
		@isOpenPopover = no
		@placementPopover = \auto
		@usePortalPopover = yes
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
			@colors.map (color) ~>
				m Button,
					minimal: yes
					color: color
					color
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
				defaultValue: "\#h"
				oninput: !~>
					@val = it.target.value
			m TextInput,
				value: @val2
				oninput: !~>
					@val2 = it.target.value
			m \p @val
			m \p @val2
			m \p """Chúng ta vẫn biết rằng, làm việc với một đoạn văn bản dễ đọc và rõ nghĩa dễ gây rối trí và cản trở việc tập trung vào yếu tố trình bày văn bản. Lorem Ipsum có ưu điểm hơn so với đoạn văn bản chỉ gồm nội dung kiểu "Nội dung, nội dung, nội dung" là nó khiến văn bản giống thật hơn, bình thường hơn. Nhiều phần mềm thiết kế giao diện web và dàn trang ngày nay đã sử dụng Lorem Ipsum làm đoạn văn bản giả, và nếu bạn thử tìm các đoạn "Lorem ipsum" trên mạng thì sẽ khám phá ra nhiều trang web hiện vẫn đang trong quá trình xây dựng. Có nhiều phiên bản khác nhau đã xuất hiện, đôi khi do vô tình, nhiều khi do cố ý (xen thêm vào những câu hài hước hay thông tục)."""
			m Button,
				onclick: !~>
					not= @isShow
				"Toggle isShow: #{@isShow}"
			m Menu,
				list: @list
			m Button,
				onclick: !~>
					@placementPopover = @placementPopover is \auto and \bottom-end or \auto
				"placementPopover: #{@placementPopover}"
			m Button,
				color: @usePortalPopover and \blue or \gray
				onclick: !~>
					not= @usePortalPopover
				"usePortalPopover: #{@usePortalPopover}"
			m Icon, name: \home
			m Icon, name: \fad:beer
			m Icon, name: \https://image.flaticon.com/icons/svg/3352/3352375.svg
			m Button,
				onclick: !~>
					@val = ""
				"Reset val"
			m \span \oks
			m Button,
				onclick: !~>
					not= @isOpenPopover
				"isOpenPopover: #{@isOpenPopover}"
			m Popover,
				isOpen: @isOpenPopover
				placement: @placementPopover
				usePortal: @usePortalPopover
				content: ~>
					m \.p-3,
						m \h3 "Đây là một cái Popover xịn xò"
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
