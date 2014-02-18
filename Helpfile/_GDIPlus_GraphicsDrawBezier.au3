#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>

Example()

Func Example()
	Local $hGUI, $hGraphic

	; Create GUI
	$hGUI = GUICreate("GDI+", 400, 300)
	GUISetState(@SW_SHOW)

	; Draw a Bezier curve
	_GDIPlus_Startup()
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)

	_GDIPlus_GraphicsDrawBezier($hGraphic, 50, 50, 100, 5, 125, 25, 250, 50)

	; Loop until the user exits.
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

	; Clean up resources
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_Shutdown()
EndFunc   ;==>Example
