#include <MsgBoxConstants.au3>
#include <Array.au3>
#include "HandleImgSearch.au3"

; Press Esc to terminate script, Pause/Break to "pause"

Global $g_bPaused = False

HotKeySet("{PAUSE}", "TogglePause")
HotKeySet("{ESC}", "Terminate")
HotKeySet("+!d", "ShowMessage") ; Shift-Alt-d



Func TogglePause()
    $g_bPaused = Not $g_bPaused
    While $g_bPaused

        ToolTip('Script is "Paused"', 0, 0)
    WEnd
    ToolTip("")
EndFunc   ;==>TogglePause

Func Terminate()
    Exit
EndFunc   ;==>Terminate

Func ShowMessage()
    MsgBox($MB_SYSTEMMODAL, "", "This is a message.")
EndFunc   ;==>ShowMessage

Func _sleep ($hWndgunny , $time , $ketthuc0 , $ketthuc1)
	$t1 = TimerInit()
	While TimerDiff($t1) <= $time
		_HandleImgSearch($hWndgunny,$ketthuc0, 566-30 , 148-57 ,965-30 , 637-57) ; nhiều khi nó cứ loay hoay mã mà không thấy được kết thúc thì toang
		$error3 = @error
		_HandleImgSearch($hWndgunny,$ketthuc1, 566-30 , 148-57 ,965-30 , 637-57)
		$error4 = @error
		If $error3*$error4 <> 1 Then ; kết thúc 1 trận game
			Return 1 ; trả về báo hiệu kết thúc
		EndIf
	WEnd
	Return 0
EndFunc


Func _Check_goc($hWndgunny,$hWndtool, $quay_huongdich , $quaynguoc_huongdich , $ketthuc0 , $ketthuc1)
	$solantanggoc = 1
	$bolenkiemgoc = True

	While $solantanggoc <= 3

		$matgoc = PixelGetColor(70, 85, $hWndtool)
		If $matgoc == 0xFF0000 Then ; nếu là màu đỏ chứng tỏ bị mất góc

			_HandleImgSearch($hWndgunny,$ketthuc0, 566-30 , 148-57 ,965-30 , 637-57) ; nhiều khi nó cứ loay hoay mã mà không thấy được kết thúc thì toang
			$error33 = @error
			_HandleImgSearch($hWndgunny,$ketthuc1, 566-30 , 148-57 ,965-30 , 637-57)
			$error44 = @error

			If $error33*$error44 ==0 Then ; kết thúc 1 trận game
				Return 1 ; return1 ketthuc tran roi
			EndIf

			If $bolenkiemgoc == True Then ; lần đầu bị bắn sẽ mất góc nên bò lên xíu để kiếm góc
				$bolech = 0
				While $bolech <15
					ControlSend($hWndgunny,"","",$quay_huongdich) ; KẾT THÚC TÌM KIẾM vẫn không có thì bò ngược lại
					$bolech+=1
				WEnd
				$bolenkiemgoc = False ; bò đi xíu xìu xiu cho lần đầu tiên bắn địch nè !!!
			EndIf

			If $solantanggoc ==3  Then ;lần tăng góc cuối cùng thất bại thì quay lại chiến
				$tanggoc = 0
				$bolech = 0
				While $tanggoc <40 ; tăng max số góc  nè
					ControlSend($hWndgunny,"","","{UP}")
					$tanggoc+=1
				WEnd
				While $bolech <70 ; bắt đầu bò ngược lại nè
					ControlSend($hWndgunny,"","",$quaynguoc_huongdich) ; KẾT THÚC TÌM KIẾM vẫn không có thì bò ngược lại
					$bolech+=1
				WEnd
				$solantanggoc+=1
				Return -1 ; trả về -1 khi thất bại tìm kiếm
			EndIf

			$hagoc = 0 ; bắt đầu hạ góc
			While $hagoc < 15
				ControlSend($hWndgunny,"","","{DOWN}")
				$hagoc+=1
			WEnd

			If _sleep($hWndgunny , 1000 , $ketthuc0 , $ketthuc1) == 1 Then ; build time là 1000s
				Return 1
			EndIf
			$solantanggoc+=1
		Else
			Return 0 ; trả về không khi không thấy mã màu
		EndIf
	WEnd
EndFunc

Func _Xacdinhvitri( ByRef $quay_huongdich , ByRef $quaynguoc_huongdich , ByRef $xanhminimap, ByRef $dominimap , ByRef $turn , $quaytrai , $quayphai,  $hWndtool , $hWndgunny,$ketthuc0,$ketthuc1); hàm xác định vị trí màu nào sẽ gần với xanh dương hơn
	While 1
		_HandleImgSearch($hWndgunny,$ketthuc0, 566-30 , 148-57 ,965-30 , 637-57) ; nhiều khi nó cứ loay hoay mã mà không thấy được kết thúc thì toang
		$error33 = @error
		_HandleImgSearch($hWndgunny,$ketthuc1, 566-30 , 148-57 ,965-30 , 637-57)
		$error44 = @error

		If $error33*$error44 ==0 Then ; kết thúc 1 trận game
			Return 1 ; return1 ketthuc tran roi
		EndIf

		$Xanhduong = PixelSearch(769, 82,1008, 172, 0x0033CC, 0, 1, $hWndgunny )
		$error11 = @error
		If @error == 0 Then
			$xanhminimap = $Xanhduong
		EndIf

		$Do = PixelSearch(769, 82, 1008, 172, 0xFF0000, 0, 1, $hWndgunny )
		$error22 = @error
		If @error == 0 Then
			$dominimap = $Do
		EndIf

		If $turn ==1 Then
			If $error11==1 Or $error22 == 1 Then ; bo di neu bi trung , neu 1 trong 2 tim ko co
				If $error11 == 1 Then ;va cai nay cung v
					If Random(0,1,1) == 0 Then ; neu trung ngay turn 1
						$bolech = 0
						While $bolech <70 ; bắt đầu bò ngược lại nè
							ControlSend($hWndgunny,"","","{RIGHT}") ; nhan vat bi trung
							$bolech+=1
						WEnd
						$turn =1
						ContinueLoop ; lap lai
					Else
						While $bolech <70 ; bắt đầu bò ngược lại nè
							ControlSend($hWndgunny,"","","{RIGHT}") ; nhan vat bi trung
							$bolech+=1
						WEnd
						$turn =1
						ContinueLoop
					EndIf
				EndIf
				If $error22 == 1 Then ; eu ero 2 ko co
					If Random(0,1,1) == 0 Then ; neu trung ngay turn 1
						$bolech = 0
						While $bolech <70 ; bắt đầu bò ngược lại nè
							ControlSend($hWndgunny,"","","{RIGHT}") ; nhan vat bi trung
							$bolech+=1
						WEnd
						$turn =1
						ContinueLoop ; lap lai
					Else
						While $bolech <70 ; bắt đầu bò ngược lại nè
							ControlSend($hWndgunny,"","","{RIGHT}") ; nhan vat bi trung
							$bolech+=1
						WEnd
						$turn =1
						ContinueLoop
					EndIf
				EndIf
			EndIf
		EndIf

		PixelSearch(106, 76,361, 211, 0x00D32C, 0, 1, $hWndgunny ) ; của thằng xanh
		$errorxlc1 = @error
		;0x37C800
		PixelSearch(106, 76,361, 211, 0x37C800, 0, 1, $hWndgunny ) ; của thằng đỏ
		$errorxlc2 = @error

		If $errorxlc1 == 0 Or $errorxlc2 == 0 Then
			If $errorxlc1 == 0 Then ; màu này là của ông thần danh rồi , thì xanh chính là của mình
				If $xanhminimap[0] > $dominimap[0] Then ; nếu màu xanh trong minimap có toạ độ x lớn hơn màu đỏ
					$quay_huongdich = $quaytrai
					$quaynguoc_huongdich = $quayphai
					ControlSend($hWndgunny,"","",$quay_huongdich) ; quay trái về hướng phía đỏ
					If _sleep ($hWndgunny , 500 , $ketthuc0 , $ketthuc1) == 1 Then
						Return 1
					EndIf
				Else
					$quay_huongdich = $quayphai
					$quaynguoc_huongdich = $quaytrai
					ControlSend($hWndgunny,"","",$quay_huongdich) ; quay phải về hướng phía đỏ
					If _sleep ($hWndgunny , 500 , $ketthuc0 , $ketthuc1) == 1 Then
						Return 1
					EndIf
				EndIf
			Else ; ngược lại thì đỏ chính là nhân vật
				If $dominimap[0] > $xanhminimap[0] Then
					$quay_huongdich = $quaytrai
					$quaynguoc_huongdich = $quayphai
					ControlSend($hWndgunny,"","",$quay_huongdich) ; quay trái về hướng phía xanh
					If _sleep ($hWndgunny , 500 , $ketthuc0 , $ketthuc1) == 1 Then
						Return 1
					EndIf
				Else
					$quay_huongdich = $quayphai
					$quaynguoc_huongdich = $quaytrai
					ControlSend($hWndgunny,"","",$quay_huongdich) ; quay phải về hướng phía xah
					If _sleep ($hWndgunny , 500 , $ketthuc0 , $ketthuc1) == 1 Then
						Return 1
					EndIf
				EndIf
			EndIf
		Else
			ContinueLoop
		EndIf



		$kt = _Check_goc($hWndgunny,$hWndtool, $quay_huongdich , $quaynguoc_huongdich , $ketthuc0 , $ketthuc1)
		If $kt == -1 Then
			ContinueLoop
		ElseIf $kt == 1 Then ; nếu phát hiện trong sleep có sự kết thúc va trong luc check goc
			Return 1
		ElseIf $kt == 0 Then
			Return 0 ; ddax tim thay vi tri roi,
		EndIf

	WEnd
EndFunc

Func _Vuotqua15turn (ByRef $quay_huongdich , ByRef $quaynguoc_huongdich , ByRef $xanhminimap, ByRef $dominimap, ByRef $turn , ByRef $thoat15turn , ByRef $hWndgunny )
	If $turn >=20 Then
		MouseClick("left",994, 65,1,10)
		Sleep(2000)
		ControlSend($hWndgunny,"","","{ENTER}")
		$turn = 0
		$quay_huongdich = Null
		$quaynguoc_huongdich= Null
		$xanhminimap = Null
		$dominimap = Null
		$thoat15turn = 999
		Return 999
	EndIf
	Return 1
EndFunc