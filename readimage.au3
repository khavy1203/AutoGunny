#Include <File.au3>
#include <WindowsConstants.au3>

Local $img_filename = FileOpenDialog("Image file", @DesktopDir & "\", "Images (*.tif;*.png;*.jpg)", $FD_FILEMUSTEXIST)
$ocr_filename = StringLeft($img_filename, StringLen($img_filename) - 4)
$ocr_filename_and_ext = $ocr_filename & ".txt"

;~ ;Double quotation marks are for paths containing spaces (tested on Tesseract V3.02)
;~ Local $iPID = Run(@ComSpec & " /C " & "tesseract.exe """ & $img_filename & """ """ & $ocr_filename & """", @ProgramFilesDir & "\Tesseract-OCR", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
;~ ProcessWaitClose($iPID)
;~ ;This also works:
ShellExecuteWait(@ProgramFilesDir & "\Tesseract-OCR\tesseract.exe", " """ & $img_filename & """ """ & $ocr_filename & """")

;Display text in SciTe editor
Run(@ProgramFilesDir & "\AutoIt3\SciTE\SciTE.exe """ & $ocr_filename_and_ext & """", "", @SW_SHOWMAXIMIZED)