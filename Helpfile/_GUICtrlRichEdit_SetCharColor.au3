#include <GuiRichEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Color.au3>

Global $lblMsg, $hRichEdit

Example()

Func Example()
	Local $hGui, $iMsg, $btnNext, $iStep = 0
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, 4) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$lblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$btnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState(@SW_SHOW)

	_GUICtrlRichEdit_SetText($hRichEdit, "Paragraph 1")
	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($hRichEdit) ; needed unless script crashes
				; GUIDelete() 	; is OK too
				Exit
			Case $iMsg = $btnNext
				$iStep += 1
				Switch $iStep
					Case 1
						Report("1. Initial setting")
					Case 2
						_GUICtrlRichEdit_SetCharColor($hRichEdit, "304050")
						Report("2. Setting is now")
					Case 3
						_GUICtrlRichEdit_SetSel($hRichEdit, 1, 5)
						_GUICtrlRichEdit_SetCharColor($hRichEdit)
						Report("3. Background of a few characters changed")
					Case 4
						_GUICtrlRichEdit_SetSel($hRichEdit, 6, -1)
						; Stream all text to the Desktop so you can look at settings in Word
						_GUICtrlRichEdit_Deselect($hRichEdit)
						_GUICtrlRichEdit_StreamToFile($hRichEdit, @DesktopDir & "\gcre.rtf")
						Report("4. Saved to File")
						GUICtrlSetState($btnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Example

Func Report($sMsg)
	Local $iColor = _GUICtrlRichEdit_GetCharColor($hRichEdit)
	Local $sMixed = _Iif(@extended, "+", "~")
	Local $aRet = _ColorGetRGB($iColor)
	$sMsg = $sMsg & @CRLF & @CRLF & $aRet[0] & ";" & $aRet[1] & ";" & $aRet[2] & " Color=0x" & Hex($iColor) & ":" & $sMixed
	GUICtrlSetData($lblMsg, $sMsg)
EndFunc   ;==>Report
