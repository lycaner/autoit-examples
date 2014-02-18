#include <WinAPIGdi.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173

Local $Pic[2], $hPic[2], $hBitmap[2]

; Create GUI
Local $hForm = GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 260, 140)
$Pic[0] = GUICtrlCreatePic('', 20, 20, 100, 100)
$Pic[1] = GUICtrlCreatePic('', 140, 20, 100, 100)
For $i = 0 To 1
	$hPic[$i] = GUICtrlGetHandle($Pic[$i])
Next

; Create bitmap1
Local $hDC = _WinAPI_GetDC($hPic[0])
Local $hDestDC = _WinAPI_CreateCompatibleDC($hDC)
$hBitmap[0] = _WinAPI_CreateCompatibleBitmapEx($hDC, 100, 100, 0xFF00FF)
Local $hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap[0])
Local $hObj = _WinAPI_CreateCompatibleBitmapEx($hDC, 70, 70, 0x00A060)
_WinAPI_DrawBitmap($hDestDC, 15, 15, $hObj)
_WinAPI_DeleteObject($hObj)
$hObj = _WinAPI_CreateCompatibleBitmapEx($hDC, 40, 40, 0xFF00FF)
_WinAPI_DrawBitmap($hDestDC, 30, 30, $hObj)
_WinAPI_DeleteObject($hObj)

_WinAPI_ReleaseDC($hPic[0], $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_DeleteDC($hDestDC)

; Create bitmap2
$hDC = _WinAPI_GetDC($hPic[1])
$hDestDC = _WinAPI_CreateCompatibleDC($hDC)
$hBitmap[1] = _WinAPI_CreateCompatibleBitmapEx($hDC, 100, 100, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_3DFACE)))
$hDestSv = _WinAPI_SelectObject($hDestDC, $hBitmap[1])
Local $hSrcDC = _WinAPI_CreateCompatibleDC($hDC)
Local $hSrcSv = _WinAPI_SelectObject($hSrcDC, $hBitmap[0])
_WinAPI_TransparentBlt($hDestDC, 0, 0, 100, 100, $hSrcDC, 0, 0, 100, 100, 0xFF00FF)

_WinAPI_ReleaseDC($hPic[1], $hDC)
_WinAPI_SelectObject($hDestDC, $hDestSv)
_WinAPI_SelectObject($hSrcDC, $hSrcSv)
_WinAPI_DeleteDC($hDestDC)
_WinAPI_DeleteDC($hSrcDC)

; Set both bitmaps to controls
For $i = 0 To 1
	_SendMessage($hPic[$i], $STM_SETIMAGE, 0, $hBitmap[$i])
	$hObj = _SendMessage($hPic[$i], $STM_GETIMAGE)
	If $hObj <> $hBitmap[$i] Then
		_WinAPI_DeleteObject($hBitmap[$i])
	EndIf
Next

GUISetState(@SW_SHOW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE