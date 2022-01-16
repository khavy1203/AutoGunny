#include "Variable.au3"

WinMove($hWndgunny,"",0,0)
WinMove($hWndtool,"",9, 72)

;~ While 1 ; mới vô game trang chủ
;~ 	_HandleImgSearch($hWndgunny,$phonggame0,394-30, 197-57,612-30, 345-57)
;~ 	$error1 = @error
;~ 	_HandleImgSearch($hWndgunny,$phonggame1,394-30, 197-57,612-30, 345-57)
;~ 	$error2 = @error
;~ 	If $error1*$error2 <> 1 Then
;~ 		ControlClick($hWndgunny,"","","left",1,481-30, 260-57) ; phòng game trang chính
;~ 		ExitLoop
;~ 	EndIf
;~ WEnd
While 1 ; lặp tìm phòng game nếu ở sảnh nè
	While 1
		_HandleImgSearch($hWndgunny,$batdau0)
		$error1 = @error
		_HandleImgSearch($hWndgunny,$batdau1)
		$error2 = @error
		If $error1*$error2 <> 1 Then
			Sleep(3000)
			ControlClick($hWndgunny,"","","left",1,766-30, 589-57);bắt đầu ở sảnh
			Sleep(3000)
			ControlClick($hWndgunny,"","","left",1,383-30, 528-57); click xác nhận vào phòng
			Sleep(2000)
			ControlClick($hWndgunny,"","","left",1,314-30, 185-57);
			ExitLoop
		EndIf
	WEnd

	While 1 ; bắt đầu lặp tìm game

		If $thoat15turn == 999 Then ; thoát vòng lặp bắt đầu vào lại game
			$thoat15turn = 1
			ExitLoop
		EndIf

		While 1
			_HandleImgSearch($hWndgunny,$timgame0,897-30, 539-57,1002-30, 583-57)
			$error1 = @error
			_HandleImgSearch($hWndgunny,$timgame1,897-30, 539-57,1002-30, 583-57)
			$error2 = @error
			If $error1*$error2 <> 1 Then
				Sleep(3000)
				ControlClick($hWndgunny,"","","left",1,954-30, 548-57) ; tìm game
				ExitLoop
			EndIf
		WEnd

		While 1

			_HandleImgSearch($hWndgunny,$start8s0, 350-30, 256-57 , 401-30 , 302-57)
			$error1 = @error
			_HandleImgSearch($hWndgunny,$start8s1, 350-30, 256-57,401-30 , 302-57)
			$error2 = @error
			_HandleImgSearch($hWndgunny,$ketthuc0, 566-30 , 148-57 ,965-30 , 637-57)
			$error3 = @error
			_HandleImgSearch($hWndgunny,$ketthuc1, 566-30 , 148-57 ,965-30 , 637-57)
			$error4 = @error

			If $error3*$error4 <> 1 Then ; kết thúc 1 trận game
				$turn = 0
				$quay_huongdich = Null
				$quaynguoc_huongdich= Null
				$xanhminimap = Null
				$dominimap = Null
				ExitLoop
			EndIf

			If $error1*$error2 <> 1 Then
				$turn+=1 ; xác định turn đầu tiên
				If $turn == 1 Then
					$bolech = 0
					$tanggoc = 0
					While $tanggoc < 40 ; tăng max góc đầu game cho dễ chơi nè
						ControlSend($hWndgunny,"","","{UP}")
						$tanggoc+=1
					WEnd
				EndIf

				WinActivate($tittle) ; thấy bắt đầu phát là bắn vô liền

				If _Vuotqua15turn($quay_huongdich , $quaynguoc_huongdich , $xanhminimap, $dominimap, $turn , $thoat15turn , $hWndgunny ) == 999 Then ; nếu quá 15 turn thì cho thoát vòng lặp
					$thoat15turn = 999
					ExitLoop
				EndIf

				$flagKT = _Xacdinhvitri(  $quay_huongdich , $quaynguoc_huongdich , $xanhminimap, $dominimap ,$turn , $quaytrai , $quayphai,  $hWndtool , $hWndgunny,$ketthuc0,$ketthuc1)
				If $flagKT == 1 Then
					$turn = 0
					$quay_huongdich = Null
					$quaynguoc_huongdich= Null
					$xanhminimap = Null
					$dominimap = Null
					ExitLoop ; n ếu tìm thấy được sự kết thúc bên kia thì bên này cũng kết thúc luôn rồi chứ để làm gì nữa
				EndIf

				If $turn > 1 And $turn <=3 Then ; turn thứ 2 sẽ bị dính, bò lên tý kiếm miếng cơm ..v..v
					$bolech = 0
					While $bolech < 7
						ControlSend($hWndgunny,"","",$quay_huongdich) ; thao tác đầu game tăng góc nè , bò ngược lại nè, vượt chướng ngại vật nè
						$bolech+=1
					WEnd
				EndIf

				ControlSend($hWndgunny,"","","1478b")

				Sleep(1000) ; cho nó nghỉ xíu xìu xiu chứ nó chạy nhanh quá bên tool ko cập nhật kịp được nè

				Send("{DEL}") ; sút nó thôi!!!
			EndIf

		WEnd



	WEnd ;=> kết thúc lặp tìm game

WEnd
