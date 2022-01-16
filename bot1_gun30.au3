#include "HandleImgSearch.au3"
Global $phonggame1 = @ScriptDir & "\Images\gogun\gogun_pgame1.bmp"
Global $phonggame0 = @ScriptDir & "\Images\gogun\gogun_pgame0.bmp"

Global $batdau0 = @ScriptDir & "\Images\gogun\gogun_batdau0.bmp"
Global $batdau1 = @ScriptDir & "\Images\gogun\gogun_batdau1.bmp"

Global $timgame0 = @ScriptDir & "\Images\gogun\gogun_timgame0.bmp"
Global $timgame1 = @ScriptDir & "\Images\gogun\gogun_timgame1.bmp"

Global $start8s0 = @ScriptDir & "\Images\gogun\gogun_start8s0.bmp"
Global $start8s1 = @ScriptDir & "\Images\gogun\gogun_start8s1.bmp"

Global $ketthuc0 = @ScriptDir & "\Images\gogun\gogun_ketthuc0.bmp"
Global $ketthuc1 = @ScriptDir & "\Images\gogun\gogun_ketthuc1.bmp"

WinActivate("Adobe Flash Player 11")

$cl1= WinWait("Adobe Flash Player 11")
WinSetTitle($cl1,"","clone1")
WinActive("clone1")
Local $hWndgunnyclone =WinWait("clone1")

WinMove($hWndgunnyclone,"",0,0)


While 1 ; lặp tìm phòng game nếu ở sảnh nè

		While 1
			_HandleImgSearch($hWndgunnyclone,$timgame0,897-30, 539-57,1002-30, 583-57)
			$error1 = @error
			_HandleImgSearch($hWndgunnyclone,$timgame1,897-30, 539-57,1002-30, 583-57)
			$error2 = @error
			If $error1*$error2 <> 1 Then
				Sleep(3000)
				ControlClick($hWndgunnyclone,"","","left",1,954-30, 548-57) ; tìm game
				ExitLoop
			EndIf
		WEnd

		While 1
			_HandleImgSearch($hWndgunnyclone,$start8s0, 350-30, 256-57 , 401-30 , 302-57)
			$error1 = @error
			_HandleImgSearch($hWndgunnyclone,$start8s1, 350-30, 256-57,401-30 , 302-57)
			$error2 = @error
			_HandleImgSearch($hWndgunnyclone,$ketthuc0, 566-30 , 148-57 ,965-30 , 637-57)
			$error3 = @error
			_HandleImgSearch($hWndgunnyclone,$ketthuc1, 566-30 , 148-57 ,965-30 , 637-57)
			$error4 = @error
			If $error1*$error2 <> 1 Then
				ControlSend($hWndgunnyclone,"","","{P}")
			EndIf
			If $error3*$error4 <> 1 Then ; kết thúc 1 trận game
				ExitLoop
			EndIf
		WEnd

WEnd
