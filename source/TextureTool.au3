#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=fav.ico
#AutoIt3Wrapper_Outfile=Kodi Texture.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=for Kodi.
#AutoIt3Wrapper_Res_Fileversion=1.2.0.0
#AutoIt3Wrapper_Res_LegalCopyright=by e0xify
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.12.0
	Author:         myName

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

; Create a GUI with various controls.
#include <GUIConstantsEx.au3>
#include <String.au3>
#include <GDIPlus.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>

FileInstall("C:\Users\rkopplin\Documents\KodiXBMCTextureTool-master\KodiXBMCTextureTool-master\source\base.exe", @TempDir & "\base.exe")
FileInstall("C:\Users\rkopplin\Documents\KodiXBMCTextureTool-master\KodiXBMCTextureTool-master\source\D3DX9_43.dll", @TempDir & "\D3DX9_43.dll")
FileInstall("C:\Users\rkopplin\Documents\KodiXBMCTextureTool-master\KodiXBMCTextureTool-master\source\TexturePacker.exe", @TempDir & "\TexturePacker.exe")
FileInstall("C:\Users\rkopplin\Documents\KodiXBMCTextureTool-master\KodiXBMCTextureTool-master\source\kodi.png", @TempDir & "\kodi.png")

Global $g_hGUI = GUICreate("Kodi - Texture Tool", 285, 490)
_GDIPlus_Startup()
Global $g_hImage = _GDIPlus_ImageLoadFromFile(@TempDir &"\kodi.png")
Global $g_hGraphic = _GDIPlus_GraphicsCreateFromHWND($g_hGUI)
GUICtrlCreateLabel("Decompile Mode", 100, 180, 100, 12)
GUICtrlSetFont(-1, 8)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel("Compile Mode", 100, 320, 330, 12)
GUICtrlSetFont(-1, 8)
GUICtrlSetState(-1, $GUI_DISABLE)
$select = GUICtrlCreateButton("Select input", 180, 210, 100, 25)
$output = GUICtrlCreateButton("Select output", 180, 240, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$start = GUICtrlCreateButton("Start", 180, 270, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
; Display the GUI.
GUICtrlCreateLabel("1.Select the input file", 10, 215, 150, 25)
GUICtrlCreateLabel("2.Select the output folder", 10, 245, 150, 25)
GUICtrlCreateLabel("3.Press start to begin", 10, 275, 150, 25)
GUICtrlCreateButton("", -5, 300, 720, 5)
GUICtrlSetState(-1, $GUI_DISABLE)
$info = GUICtrlCreateButton("!",260,5,20,20)
$status = GUICtrlCreateLabel("Welcome !", 10, 455, 260, 20)
GUICtrlSetFont(-1,7)
GUICtrlSetState(-1, $GUI_DISABLE)
$progress = GUICtrlCreateProgress(5, 470, 275, 10)
GUICtrlCreateButton("", 293, -5, 5, 127)
GUICtrlSetState(-1, $GUI_DISABLE)
;#-------------------------------------------------------------------------


$select2 = GUICtrlCreateButton("Select input folder", 180, 340, 100, 25)
$output2 = GUICtrlCreateButton("Select output file", 180, 370, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$start2 = GUICtrlCreateButton("Start", 180, 400, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel("1.Select the input folder", 10, 345, 150, 25)
GUICtrlCreateLabel("2.Select the output file", 10, 375, 150, 25)
GUICtrlCreateLabel("3.Press start to begin", 10, 405, 150, 25)
GUIRegisterMsg($WM_PAINT, "MY_WM_PAINT")
GUISetState(@SW_SHOW)

; Loop until the user exits.
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $select
			$selected = FileOpenDialog("Please select the .xbt File to extract", @DesktopDir, "Kodi Texture File (*.xbt)")
				GUICtrlSetData($status, "             Step 2 is enabled, please go ahead.")
				If $selected <> "" Then
					GUICtrlSetState($output, $GUI_ENABLE)
				EndIf
		Case $output
			$outputed = FileSelectFolder("Please select destination directory", @DesktopDir)
				GUICtrlSetData($status, "               Awesome ! You enabled Step 3")
				GUICtrlSetState($start, $GUI_ENABLE)

		Case $start
			TrayTip("Watch out", "Extraction is in progress", 2, 1)
			ProcessClose("base.exe")
			$command = "base.exe " & '"' & $selected & '"' & ' "' & $outputed
			;msgbox(0,"",$command)
			Run(@ComSpec & " /c " & $command, @TempDir, @SW_HIDE)
			GUICtrlSetData($status, "Please wait until it's done. Get yourself a coffee...")
			TrayTip("Texture Extraction", "Please wait until its done...", 2, 1)
			bar()
			ProcessWaitClose("cmd.exe")
			GUICtrlSetData($progress, 100)

			GUICtrlSetData($status, "                  We are done (: ")
			ShellExecute($outputed)
		Case $select2
			$outputedd = FileSelectFolder("Please select directory to compile to .xbt File", @DesktopDir)
			GUICtrlSetData($status, "               Step 2 is enabled, please go ahead.")
			GUICtrlSetState($output2, $GUI_ENABLE)
		Case $output2
			$selected2 = FileSaveDialog("Please define a name for .xbt", @DesktopDir, "Kodi Texture File (*.xbt)", 0, "Textures.xbt")
			GUICtrlSetData($status, "             Step 2 is enabled, please go ahead.")
			If $selected2 <> "" Then
				GUICtrlSetState($start2, $GUI_ENABLE)
			EndIf
		Case $start2
			TrayTip("Watch out", "Extract is in progress", 2, 1)
			ProcessClose("TexturePacker.exe")
			$command = "TexturePacker -dupecheck -input " & $outputedd & " -output " & $selected2
			;msgbox(0,"",$command)
			Run(@ComSpec & " /c " & $command, @TempDir, @SW_HIDE)
			GUICtrlSetData($status, "Please wait until it's done. Get yourself a coffee..")
			TrayTip("Kodi Texture Extraction", "Please wait until it's done. Get yourself a coffee or sth...", 2, 1)
			bar()
			ProcessWaitClose("cmd.exe")
			GUICtrlSetData($progress, 100)

			GUICtrlSetData($status, "                  We are done (: ")
		case $info
			child()
	EndSwitch
WEnd

Func child()
    ; Create a GUI with various controls.
    Local $hGUI = GUICreate("Info",200,100)
    Local $idOK = GUICtrlCreateButton("OK", 310, 370, 85, 25)
	$lbl2 = GUICtrlCreateLabel("Visit official Thread! Click me",10,20,100,25)
	GUICtrlSetColor(-1,"blue")
	GUICtrlCreateLabel("Created by e0xify - v.2.3",10,70,200,25)
	GUICtrlSetState(-1,$GUI_DISABLE)
    ; Display the GUI.
    GUISetState(@SW_SHOW, $hGUI)

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE, $idOK
                ExitLoop
			case $lbl2
				ShellExecute("http://forum.kodi.tv/showthread.php?tid=201883")

        EndSwitch
    WEnd

    ; Delete the previous GUI and all controls.
    GUIDelete($hGUI)
EndFunc   ;==>Example


_GDIPlus_GraphicsDispose($g_hGraphic)
_GDIPlus_ImageDispose($g_hImage)
_GDIPlus_Shutdown()

; Draw PNG image
Func MY_WM_PAINT($hWnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg, $wParam, $lParam
    _WinAPI_RedrawWindow($g_hGUI, 0, 0, $RDW_UPDATENOW)
    _GDIPlus_GraphicsDrawImage($g_hGraphic, $g_hImage, 0, 0)
    _WinAPI_RedrawWindow($g_hGUI, 0, 0, $RDW_VALIDATE)
    Return $GUI_RUNDEFMSG
EndFunc   ;==>MY_WM_PAINT

Func hide()
	WinSetState("Dummy Window! (Keine Rückmeldung)", "", @SW_HIDE)
	WinSetTrans("Dummy Window! (Keine Rückmeldung)", "", 0)
	WinSetState("Dummy Window!", "", @SW_HIDE)
	WinSetTrans("Dummy Window!", "", 0)
	WinClose("Dummy Window!")
	WinKill("Dummy Window!")
	WinKill("Dummy Window! (Keine Rückmeldung)")
EndFunc   ;==>hide

Func bar()
	For $i = 0 To 100 Step 3
		GUICtrlSetData($progress, $i)
		Sleep(200)
		If $i = 99 Then
			$i = 0
		EndIf
		If Not ProcessExists("cmd.exe") Then
			$i = 100
		EndIf
	Next

EndFunc   ;==>bar
