#comments-start
chèn các thư viện và khai báo các biến
controlclick trong windown bị lỗi
	trừ 30 và trừ đi 57 để có toạ độ chính xác
#comments-end

#include "HandleImgSearch.au3"
#include "Function.au3"
#include <Array.au3>

Global $tittle = "GOGUN.VN"
WinSetTitle($tittle,"","accchinh")
$tittle = "accchinh"

Global $hWndgunny = WinWait("accchinh")
Global $hWndtool = WinWait("[CLASS:SunAwtDialog]")

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

Global Const $quaytrai = "{LEFT}"
Global Const $quayphai = "{RIGHT}"

Global $xanhminimap = Null
Global $dominimap = Null
; màu xanh0 0x0033CC
; màu đỏ0 0xFF0000

; màu xanh định vị nhân vật màu xanh trong tool 0x00D32C
; màu đỏ định vị nhân vật màu xanh trong tool 0x37C800

Global $quay_huongdich = Null
Global $quaynguoc_huongdich = Null
Global $check_suthaydoihuong = Null

Global $thoat15turn = 1
Global $turn = 0
