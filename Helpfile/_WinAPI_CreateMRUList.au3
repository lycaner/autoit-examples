#include <WinAPIReg.au3>
#include <APIRegConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>

Local $hMRU = _WinAPI_CreateMRUList($HKEY_CURRENT_USER, 'Software\MyProg\MRU', 5)

; Create MRU list in the registry (only at first start example)
RegRead('HKCU\Software\MyProg\MRU', 'MRUList')
If @error Then
	For $i = 5 To 1 Step -1
		_WinAPI_AddMRUString($hMRU, 'String' & $i)
	Next
EndIf

GUICreate('Test ' & StringReplace(@ScriptName, '.au3', '()'), 320, 92)
Local $Combo = GUICtrlCreateCombo(_WinAPI_EnumMRUList($hMRU, 0), 10, 20, 300, 21, $CBS_DROPDOWNLIST)
Local $Count = _WinAPI_EnumMRUList($hMRU, -1)
Local $Data = ''
For $i = 1 To $Count - 1
	$Data &= _WinAPI_EnumMRUList($hMRU, $i) & '|'
Next
GUICtrlSetData(-1, $Data)
Local $Button = GUICtrlCreateButton('OK', 125, 58, 70, 23)
GUISetState(@SW_SHOW)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Button
			_WinAPI_AddMRUString($hMRU, GUICtrlRead($Combo))
			ExitLoop
	EndSwitch
WEnd

_WinAPI_FreeMRUList($hMRU)
