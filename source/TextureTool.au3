#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=fav.ico
#AutoIt3Wrapper_Outfile=update.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=for Kodi.
#AutoIt3Wrapper_Res_Fileversion=2.6.1.0
#AutoIt3Wrapper_Res_LegalCopyright=by supelele
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
#include <TrayConstants.au3>
#include <Inet.au3>

HotKeySet("+!d","enable_dev")
Global $version = "2.6.1"

Opt("TrayMenuMode", 3)

FileInstall("C:\Users\rkopplin\Documents\KodiXBMCTextureTool-master\source\base.exe", @TempDir & "\base.exe")
FileInstall("C:\Users\rkopplin\Documents\KodiXBMCTextureTool-master\source\D3DX9_43.dll", @TempDir & "\D3DX9_43.dll")
FileInstall("C:\Users\rkopplin\Documents\KodiXBMCTextureTool-master\source\TexturePacker.exe", @TempDir & "\TexturePacker.exe")
FileInstall("C:\Users\rkopplin\Documents\KodiXBMCTextureTool-master\source\kodi.png", @TempDir & "\kodi.png")
update()
Global $g_hGUI = GUICreate("Kodi - Texture Tool", 285, 520)
_GDIPlus_Startup()
Global $g_hImage = _GDIPlus_ImageLoadFromFile(@TempDir & "\kodi.png")
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
GUICtrlCreateLabel("2.Select the output directory", 10, 245, 150, 25)
GUICtrlCreateLabel("3.Press start to begin", 10, 275, 150, 25)
GUICtrlCreateButton("", -5, 300, 720, 5)
GUICtrlSetState(-1, $GUI_DISABLE)
$info = GUICtrlCreateButton("?", 260, 5, 20, 20)
$status = GUICtrlCreateLabel("Welcome !                               ", 10, 490, 290, 20)
GUICtrlSetFont(-1, 7)
GUICtrlSetState(-1, $GUI_DISABLE)
$lz0 = GUICtrlCreateCheckbox("enable lz0",20,435,100,25)
Guictrlsetstate(-1,$GUI_CHECKED)
$dupeheck = GUICtrlCreateCheckbox("enable dupecheck",150,435,130,25)
Guictrlsetstate(-1,$GUI_CHECKED)
$dev = GUICtrlCreateCheckbox("dev mode",20,455,130,25)
Guictrlsetstate(-1,$GUI_DISABLE)
$progress = GUICtrlCreateProgress(5, 505, 275, 10)
GUICtrlCreateButton("", 293, -5, 5, 127)
GUICtrlSetState(-1, $GUI_DISABLE)
;#-------------------------------------------------------------------------


$select2 = GUICtrlCreateButton("Select input folder", 180, 340, 100, 25)
$output2 = GUICtrlCreateButton("Select output file", 180, 370, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$start2 = GUICtrlCreateButton("Start", 180, 400, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel("1.Select the input directory", 10, 345, 150, 25)
GUICtrlCreateLabel("2.Select the output file", 10, 375, 150, 25)
GUICtrlCreateLabel("3.Press start to begin", 10, 405, 150, 25)
GUIRegisterMsg($WM_PAINT, "MY_WM_PAINT")
GUISetState(@SW_SHOW)

$thread = TrayCreateItem("Visit Thread", -1, -1, $TRAY_ITEM_NORMAL)
$git = TrayCreateItem("Check Github", -1, -1, $TRAY_ITEM_NORMAL)
$update = TrayCreateItem("Check for updates", -1, -1, $TRAY_ITEM_NORMAL)

TrayCreateItem("") ; Create a separator line.

Local $idAbout = TrayCreateItem("About")
TrayCreateItem("") ; Create a separator line.

Local $idExit = TrayCreateItem("Exit")

TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

; Loop until the user exits.
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ProcessClose(@ScriptName)
			ExitLoop
			Exit
		Case $select
			$selected = FileOpenDialog("Please select the .xbt File you want to extract", "C:\", "Kodi Texture File (*.xbt)")
			GUICtrlSetData($status, "             Step 2 is enabled, please go ahead.")
			If $selected <> "" Then
				GUICtrlSetState($output, $GUI_ENABLE)
			EndIf
		Case $output
			$outputed = FileSelectFolder("Please select destination directory", "C:\")
			GUICtrlSetData($status, "               Awesome ! You enabled the next step")
			GUICtrlSetState($start, $GUI_ENABLE)

		Case $start
			ProcessClose("base.exe")
			$command = "base.exe " & '"' & $selected & '"' & ' "' & $outputed
			;msgbox(0,"",$command)
			Run(@ComSpec & " /c " & $command, @TempDir, @SW_HIDE)
			GUICtrlSetData($status, "Please wait until it's done. This may takes a few seconds")
			TrayTip("Texture Extraction", "Please wait until its done...", 2, 1)
			bar()
			ProcessWaitClose("cmd.exe")
			GUICtrlSetData($progress, 100)

			GUICtrlSetData($status, "                  It's done (: ")
			ShellExecute($outputed)
		Case $select2
			$outputedd = FileSelectFolder("Please select directory to compile to .xbt File", "C:\")
			If StringInStr($outputedd, " ") Then
				MsgBox(0, "Kodi - Texture Tool", "Unfortunately TexturePacker is not supporting any spaces in directory names." & @CRLF & "Be sure that there are no names like 'new folder' or something like that." & @CRLF & @CRLF & "Please try again!")
			Else
				GUICtrlSetData($status, "               Step 2 is enabled, please go ahead.")
				GUICtrlSetState($output2, $GUI_ENABLE)
			EndIf
		Case $output2
			$selected2 = FileSaveDialog("Please define a name for .xbt", "C:\", "Kodi Texture File (*.xbt)", 0, "Textures.xbt")
			If StringInStr($selected2, " ") Then
				MsgBox(0, "Kodi - Texture Tool", "Unfortunately TexturePacker is not supporting any spaces in directory names." & @CRLF & "Be sure that there are no names like 'new folder' or something like that." & @CRLF & @CRLF & "Please try again!")
			Else
				GUICtrlSetData($status, "             Step 2 is enabled, please go ahead.")
				If $selected2 <> "" Then
					GUICtrlSetState($start2, $GUI_ENABLE)
				EndIf
			EndIf
		Case $start2
			ProcessClose("TexturePacker.exe")
			if _IsChecked($lz0) and _IsChecked($dupeheck) then
				$command = "TexturePacker -dupecheck -input " & $outputedd & " -output " & $selected2
			EndIf
			if _IsChecked($dupeheck) Then
				$command = "TexturePacker -disable_lz0 -input " & $outputedd & " -output " & $selected2
				Endif
			if _IsChecked($lz0) Then
				$command = "TexturePacker -input " & $outputedd & " -output " & $selected2
			Endif
			if _IsChecked($dev) then
				Msgbox(0,"Dev Mode","Running command: " & $command)
			EndIf
			Run(@ComSpec & " /c " & $command, @TempDir, @SW_HIDE)
			GUICtrlSetData($status, "Please wait until it's done. This may take a few seconds...")
			TrayTip("Kodi Texture Extraction", "Please wait until it's done. This may take a few seconds...", 2, 1)
			bar()
			ProcessWaitClose("cmd.exe")
			GUICtrlSetData($progress, 100)

			GUICtrlSetData($status, "                  It's done (: ")
		Case $info
			child()
EndSwitch
	Switch TrayGetMsg()
		Case $idAbout ; Display a message box about the AutoIt version and installation path of the AutoIt executable.
			child()
		Case $idExit ; Exit the loop.
			ProcessClose(@ScriptName)
			ExitLoop
			Exit
		case $update
			update()
		case $thread
			ShellExecute("http://forum.kodi.tv/showthread.php?tid=201883")
		case $git
			ShellExecute("https://github.com/e0xify/KodiXBMCTextureTool")
	EndSwitch
WEnd

Func child()

	; Create a GUI with various controls.
	Local $hGUI = GUICreate("About", 170, 150)
	Local $idOK = GUICtrlCreateButton("OK", 310, 370, 85, 25)
	$lbl2 = GUICtrlCreateButton("Release Thread", 10, 20, 150, 25)
	$lbl3 = GUICtrlCreateButton("Github", 10, 50, 150, 25)
	$lbl4 = GUICtrlCreateButton("Check for updates", 10, 80, 150, 25)

	GUICtrlCreateLabel("Created by supelele - v." & $version, 10, 130, 200, 25)
	GUICtrlSetState(-1, $GUI_DISABLE)
	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $idOK
				ExitLoop
			Case $lbl2
				ShellExecute("http://forum.kodi.tv/showthread.php?tid=201883")
			Case $lbl3
				ShellExecute("https://github.com/e0xify/KodiXBMCTextureTool")
			Case $lbl4
				update()
		EndSwitch
	WEnd

	; Delete the previous GUI and all controls.
	GUIDelete($hGUI)
EndFunc   ;==>child


_GDIPlus_GraphicsDispose($g_hGraphic)
_GDIPlus_ImageDispose($g_hImage)
_GDIPlus_Shutdown()

; Draw PNG image
Func MY_WM_PAINT($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam, $lParam
	_GDIPlus_ImageResize($g_hImage,20,20)
	_WinAPI_RedrawWindow($g_hGUI, 0, 0, $RDW_UPDATENOW)

	_GDIPlus_GraphicsDrawImage($g_hGraphic, $g_hImage, 0, 0)
	_WinAPI_RedrawWindow($g_hGUI, 0, 0, $RDW_VALIDATE)

	Return $GUI_RUNDEFMSG
EndFunc   ;==>MY_WM_PAINT

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

func enable_dev()
	Guictrlsetstate($dev,$GUI_ENABLE)
EndFunc

Func update()
	FileDelete(@TempDir & "\update.exe")
	FileDelete(@TempDir & "\update.txt")
	FileDelete(@TempDir & "\update.bat")

	$online = _INetGetSource("http://ipayforpixels.eu/scripts/update.txt")
	FileWrite(@TempDir & "\update.txt", $online)
	$latest = FileReadLine(@TempDir & "\update.txt", 1)
	If $latest <> "" Then
		If $version <> $latest Then
			TrayTip("Kodi - Texture Tool", "New update available - Tool will update itself now !", 2, 1)
			Sleep(3000)
			InetGet("http://ipayforpixels.eu/scripts/update.exe", @TempDir & "\update.exe")
			FileWrite(@TempDir & "\update.bat", "ping -n 2 127.0.0.1 > NUL" & @CRLF & "del " & '"' & @ScriptFullPath & '"' & @CRLF & "ping -n 2 127.0.0.1 > NUL" & @CRLF & "ren " & @TempDir & "\update.exe" & " " & '"' & @ScriptName & '"' & @CRLF & "move " & '"' & @TempDir & "\" & @ScriptName & '"' & " " & '"' & @ScriptFullPath & '"')
			ShellExecute(@TempDir & "\update.bat", "", "", "", @SW_HIDE)
			Exit
		Else
			TrayTip("Kodi - Texture Tool", "Texture Tool - v." & $version & " (latest)", 2, 1)
		EndIf
		FileDelete(@TempDir & "\update.txt")
		Sleep(300)
	Else
		TrayTip("Updateserver unavailable", "Cannot reach update host, check again later", 2, 1)
	EndIf
EndFunc   ;==>update

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked


