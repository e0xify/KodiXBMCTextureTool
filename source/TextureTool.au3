#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=fav.ico
#AutoIt3Wrapper_Outfile=Kodi Texture.exe
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

FileInstall("C:\Users\rkopplin\Desktop\Kodi\source\base.exe", @TempDir & "\base.exe")
FileInstall("C:\Users\rkopplin\Desktop\Kodi\source\D3DX9_43.dll", @TempDir & "\D3DX9_43.dll")
FileInstall("C:\Users\rkopplin\Desktop\Kodi\source\TexturePacker.exe", @TempDir & "\TexturePacker.exe")

Local $hGUI = GUICreate("Kodi XBMC - Texture Tool (v. 2.0)", 600, 190)
GUICtrlCreateLabel("Decompile Mode", 100, 5, 100, 12)
GUICtrlSetFont(-1, 8)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel("Compile Mode", 410, 5, 100, 12)
GUICtrlSetFont(-1, 8)
GUICtrlSetState(-1, $GUI_DISABLE)
$select = GUICtrlCreateButton("Select input", 180, 30, 100, 25)
$output = GUICtrlCreateButton("Select output", 180, 60, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$start = GUICtrlCreateButton("Start", 180, 90, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
; Display the GUI.
GUICtrlCreateLabel("1.Select the input file", 10, 35, 150, 25)
GUICtrlCreateLabel("2.Select the output folder", 10, 65, 150, 25)
GUICtrlCreateLabel("2.Press start to begin", 10, 95, 150, 25)
GUICtrlCreateButton("", -5, 120, 720, 5)
GUICtrlSetState(-1, $GUI_DISABLE)
$status = GUICtrlCreateLabel("Created by e0xify // TexturePacker by uNiversal // Decompiler by tiben20", 10, 165, 600, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$progress = GUICtrlCreateProgress(5, 130, 590, 20)
GUICtrlCreateButton("", 293, -5, 5, 127)
GUICtrlSetState(-1, $GUI_DISABLE)
;#-------------------------------------------------------------------------


$select2 = GUICtrlCreateButton("Select input folder", 480, 30, 100, 25)
$output2 = GUICtrlCreateButton("Select output file", 480, 60, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
$start2 = GUICtrlCreateButton("Start", 480, 90, 100, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateLabel("1.Select the input folder", 310, 35, 150, 25)
GUICtrlCreateLabel("2.Select the output file", 310, 65, 150, 25)
GUICtrlCreateLabel("2.Press start to begin", 310, 95, 150, 25)

GUISetState(@SW_SHOW, $hGUI)

; Loop until the user exits.
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $select
			$selected = FileOpenDialog("Please select the .xbt File to extract", @DesktopDir, "XBMC Texture File (*.xbt)")
			If StringInStr($selected, " ") Then
				MsgBox(0, "Error", "TexturePacker isn't supporting Spaces in Directory")
				$selected = FileOpenDialog("Please select the .xbt File to extract", @DesktopDir, "XBMC Texture File (*.xbt)")
			Else
				GUICtrlSetData($status, "             Step 2 is enabled, please go ahead.")
				If $selected <> "" Then
					GUICtrlSetState($output, $GUI_ENABLE)
				EndIf
			EndIf
		Case $output
			$outputed = FileSelectFolder("Please select destination directory", @DesktopDir)
			If StringInStr($outputed, " ") Then
				MsgBox(0, "Error", "TexturePacker isn't supporting Spaces in Directory")
				$outputed = FileSelectFolder("Please select destination directory", @DesktopDir)
			Else
				GUICtrlSetData($status, "               Awesome ! You enabled Step 3")
				GUICtrlSetState($start, $GUI_ENABLE)
			EndIf

		Case $start
			TrayTip("Watch out", "Extract is in progress", 2, 1)
			ProcessClose("base.exe")
			$command = "base.exe " & '"' & $selected & '"' & ' "' & $outputed & '"'
			;msgbox(0,"",$command)
			Run(@ComSpec & " /c " & $command, @TempDir, @SW_HIDE)
			GUICtrlSetData($status, "Please wait until it's done. Get yourself a coffee or something...")
			TrayTip("XBMC Texture Extraction", "Please wait until its done...", 2, 1)
			bar()
			ProcessWaitClose("cmd.exe")
			GUICtrlSetData($progress, 100)

			GUICtrlSetData($status, "                  We are done (: ")
			ShellExecute($outputed)
		Case $select2
			$outputedd = FileSelectFolder("Please select Directory to compile to .xbt File", @DesktopDir)
			if StringinStr($outputedd, " ") Then
				MsgBox(0, "Error", "TexturePacker isn't supporting Spaces in Directory")
				$outputedd = FileSelectFolder("Please select Directory to compile to .xbt File", @DesktopDir)
			else
			GUICtrlSetData($status, "               Step 2 is enabled, please go ahead.")
			GUICtrlSetState($output2, $GUI_ENABLE)
			Endif
		Case $output2
			$selected2 = FileSaveDialog("Please define a name for .xbt", @DesktopDir, "XBMC Texture File (*.xbt)", 0, "Textures.xbt")
			if StringinStr($selected2, " ") then
				MsgBox(0, "Error", "TexturePacker isn't supporting Spaces in Directory")
				$selected2 = FileSaveDialog("Please define a name for .xbt", @DesktopDir, "XBMC Texture File (*.xbt)", 0, "Textures.xbt")
			Else
			GUICtrlSetData($status, "             Step 2 is enabled, please go ahead.")
			If $selected2 <> "" Then
				GUICtrlSetState($start2, $GUI_ENABLE)
			EndIf
			Endif
		Case $start2
			TrayTip("Watch out", "Extract is in progress", 2, 1)
			ProcessClose("TexturePacker.exe")
			$command = "TexturePacker -dupecheck -input " & $outputedd & " -output " & $selected2
			;msgbox(0,"",$command)
			Run(@ComSpec & " /c " & $command, @TempDir, @SW_HIDE)
			GUICtrlSetData($status, "Please wait until it's done. Get yourself a coffee or something...")
			TrayTip("XBMC Texture Extraction", "Wait dude...just wait..", 2, 1)
			bar()
			ProcessWaitClose("cmd.exe")
			GUICtrlSetData($progress, 100)

			GUICtrlSetData($status, "                  We are done (: ")
	EndSwitch
WEnd

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
