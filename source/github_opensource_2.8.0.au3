#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=fav.ico
#AutoIt3Wrapper_Outfile=update.exe
#AutoIt3Wrapper_Res_Description=Kodi - Texture Tool
#AutoIt3Wrapper_Res_Fileversion=2.7.3.0
#AutoIt3Wrapper_Res_LegalCopyright=by supp
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=fav.ico
#AutoIt3Wrapper_Outfile=kodi.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=Kodi - Texture Tool
#AutoIt3Wrapper_Res_Fileversion=2.7.3.0
#AutoIt3Wrapper_Res_LegalCopyright=by supp
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=fav.ico
#AutoIt3Wrapper_Outfile=update.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=Kodi - Texture Tool
#AutoIt3Wrapper_Res_Fileversion=2.7.3.0
#AutoIt3Wrapper_Res_LegalCopyright=by supp
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=fav.ico
#AutoIt3Wrapper_Outfile=update.exe
#AutoIt3Wrapper_Res_Description=Kodi - Texture Tool
#AutoIt3Wrapper_Res_Fileversion=2.7.3
#AutoIt3Wrapper_Res_LegalCopyright=by supp
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

Global $time, $short, $Button
Global $File, $Download = False, $check = "not checked"
gettime()
FileDelete(@ScriptDir & "\TextureTool_Log.txt")

Global $hLog = @ScriptDir & "\TextureTool_Log.txt"
FileWrite($hLog, '******************Program start*****************' & @CRLF)
FileWrite($hLog, 'Current Time: ' & $time & @CRLF)
Global $version = "2.8.0"
FileWrite($hLog, 'Running Version: ' & $version & @CRLF)
$reg = Regread("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\10.0\VC\VCRedist\x86","Installed")
FileWrite($hLog, 'RegRead: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\VisualStudio\10.0\VC\VCRedist\x86: ' & $reg & @CRLF)

if @OSArch = "x64" then
$checkdll = FileExists(@SystemDir & "\msvcp140.dll")
$checkdll2 = FileExists(@WindowsDir & "\system32\msvcp140.dll")
$checkdll3 = FileExists(@SystemDir & "\VCRUNTIME140.dll")
$checkdll4 = FileExists(@WindowsDir & "\system32\VCRUNTIME140.dll")
FileWrite($hLog, @SystemDir & "\msvcp140.dll: " & $checkdll & @CRLF)
FileWrite($hLog, @WindowsDir & "\system32\msvcp140.dll: " & $checkdll2 & @CRLF)
FileWrite($hLog, @SystemDir & "\VCRUNTIME140.dll: " & $checkdll3 & @CRLF)
FileWrite($hLog, @WindowsDir & "\system32\VCRUNTIME140.dll: " & $checkdll4 & @CRLF)
if $checkdll = 0 or $checkdll2 = 0 or $checkdll3 = 0 or $checkdll4 = 0 then
$check = "not installed"
Endif
Else
$checkdll2 = FileExists(@WindowsDir & "\system32\msvcp140.dll")
$checkdll4 = FileExists(@WindowsDir & "\system32\VCRUNTIME140.dll")
if $checkdll2 = 0 or $checkdll4 = 0 then
$check = "not installed"
Endif
FileWrite($hLog, @WindowsDir & "\system32\msvcp140.dll: " & $checkdll2 & @CRLF)
FileWrite($hLog, @WindowsDir & "\system32\VCRUNTIME140.dll: " & $checkdll4 & @CRLF)
Endif

HotKeySet("+!d", "enable_dev")


If Not FileExists(@TempDir & "\1.dat") Then
	FileWrite(@TempDir & "\1.dat", "kodi texture tool message handler")
	$lol = MsgBox($MB_YESNO, "Kodi - Texture Tool", "TextureTool is using the latest TexturePacker, if its not working in your case, please install the latest Visual C++ Redistributable for Visual Studio")
	If $lol = 6 Then
		ShellExecute("https://www.microsoft.com/de-DE/download/details.aspx?id=48145")
	EndIf
	gettime()
	FileWrite($hLog, $short & ": " & 'Displayed vcredist hint once' & @CRLF)
EndIf

Opt("TrayMenuMode", 3)

FileInstall("C:\Users\xxx\Documents\KodiXBMCTextureTool-master\source\vcruntime140.dll", @TempDir & "\vcruntime140.dll", 1)
FileInstall("C:\Users\xxx\Documents\KodiXBMCTextureTool-master\source\msvcp140.dll", @TempDir & "\msvcp140.dll", 1)
FileInstall("C:\Users\xxx\Documents\KodiXBMCTextureTool-master\source\base.exe", @TempDir & "\base.exe", 1)
FileInstall("C:\Users\xxx\Documents\KodiXBMCTextureTool-master\source\D3DX9_43.dll", @TempDir & "\D3DX9_43.dll", 1)
FileInstall("C:\Users\xxx\Documents\KodiXBMCTextureTool-master\source\TexturePacker.exe", @TempDir & "\TexturePacker.exe", 1)
FileInstall("C:\Users\xxx\Documents\KodiXBMCTextureTool-master\source\kodi.png", @TempDir & "\kodi.png", 1)
$txtv = FileGetVersion(@TempDir & "\TexturePacker.exe")
gettime()
FileWrite($hLog, $short & ": " & 'TexturePacker Version: ' & $txtv & @CRLF)

update()

func gui()
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
$lz0 = GUICtrlCreateCheckbox("enable lz0", 20, 435, 100, 25)
GUICtrlSetState(-1, $GUI_CHECKED)
$dupeheck = GUICtrlCreateCheckbox("enable dupecheck", 150, 435, 130, 25)
$sublog = GUICtrlCreateRadio("submit log - click me", 150, 455, 130, 25)
global $dev = GUICtrlCreateCheckbox("dev mode", 20, 455, 130, 25)
GUICtrlSetState(-1, $GUI_DISABLE)
global $progress = GUICtrlCreateProgress(5, 505, 275, 10)
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
$dona = TrayCreateItem("Donate BTC", -1, -1, $TRAY_ITEM_NORMAL)

TrayCreateItem("") ; Create a separator line.

Local $idAbout = TrayCreateItem("About")
TrayCreateItem("") ; Create a separator line.

Local $idExit = TrayCreateItem("Exit")

TraySetState($TRAY_ICONSTATE_SHOW) ; Show the tray menu.

; Loop until the user exits.
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			FileWrite($hLog, '******************Closed by User*****************' & @CRLF)


			Exit
			ExitLoop
			ProcessClose(@ScriptName)
		Case $select
			gettime()
			FileWrite($hLog, $short & ": " & 'Decompile Mode started.' & @CRLF)
			$selected = FileOpenDialog("Please select the .xbt File you want to extract", "C:\", "Kodi Texture File (*.xbt)")
			GUICtrlSetData($status, "Step 2 is enabled, please go ahead.")
			If $selected <> "" Then
				gettime()
				FileWrite($hLog, $short & ": " & 'Path to .xbt File: ' & $selected & @CRLF)
				GUICtrlSetState($output, $GUI_ENABLE)
			EndIf
		Case $sublog
			MsgBox(0, "Submit Log", "I can only support Kodi - Texture Tool." & @CRLF & "The software used here (TexturePacker/TextureExtraction) is not developed by me." & @CRLF & "Everytime you use the Kodi - Texture Tool a logfile is created, which gets automatically deleted when you restart the tool." & @CRLF & "Find your log here: " & @ScriptDir & "\TextureTool_log.txt" & @CRLF & "Submit your issue including the logfile AFTER you started to compile/decompile and i'll try to help you out.")
			ShellExecute("http://forum.kodi.tv/newreply.php?tid=201883")
			ShellExecute(@ScriptDir & "\TextureTool_log.txt")
		Case $output
			gettime()
			$outputed = FileSelectFolder("Please select destination directory", "C:\")
			FileWrite($hLog, $short & ": " & 'Path to output directory:' & $outputed & @CRLF)
			GUICtrlSetData($status, "Awesome ! You enabled the next step")
			GUICtrlSetState($start, $GUI_ENABLE)

		Case $start
			ProcessClose("base.exe")
			$command = "base.exe " & '"' & $selected & '"' & ' "' & $outputed
			gettime()
			FileWrite($hLog, $short & ": " & 'Running command:' & $command & @CRLF)

			;msgbox(0,"",$command)
			Run(@ComSpec & " /c " & $command, @TempDir, @SW_HIDE)
			GUICtrlSetData($status, "Please wait until it's done. This may takes a few seconds")
			TrayTip("Kodi - Texture Tool", "Decompile in progress - please wait ...", 2, 1)
			bar()
			gettime()
			FileWrite($hLog, $short & ": " & 'base.exe running.' & @CRLF)
			ProcessWaitClose("base.exe")
			gettime()
			FileWrite($hLog, $short & ": " & 'base.exe closed.' & @CRLF)
			GUICtrlSetData($progress, 100)

			GUICtrlSetData($status, "It's done (: ")
			ShellExecute($outputed)
			gettime()
			FileWrite($hLog, $short & ": " & 'Opening outputdirectory.' & @CRLF)
		Case $select2
			if $check = "not installed" Then
				$abox = msgbox(4,"Critical Error","Visual C++ Redistributable for Visual Studio seems not to be installed, TexturePacker will not work!" & @crlf & "Texture Tool will patch your system with Visual C++ package dll's." & @crlf & @crlf & "Do you want to patch those files now?")
				if $abox = 6 then
					Filecopy(@tempdir & "\msvcp140.dll",@WindowsDir & "\system32\" & "msvcp140.dll")
					Filecopy(@tempdir & "\vcruntime140.dll",@WindowsDir & "\system32\" & "vcruntime140.dll")
					Filecopy(@tempdir & "\msvcp140.dll",@SystemDir & "\msvcp140.dll")
					Filecopy(@tempdir & "\vcruntime140.dll",@SystemDir & "\vcruntime140.dll")
					FileWrite($hLog, $short & ": " & 'Systemfiles patched for VCREDIST!' & @CRLF)
				EndIf
			Endif
			gettime()
			FileWrite($hLog, $short & ": " & 'Compile Mode started.' & @CRLF)
			$outputedd = FileSelectFolder("Please select directory to compile to .xbt File", "C:\")
			If StringInStr($outputedd, " ") Then
				gettime()
				FileWrite($hLog, $short & ": " & 'Found a space in compile directory ! Displayed hint.' & @CRLF)
				MsgBox(4, "Kodi - Texture Tool", "Unfortunately TexturePacker is not supporting any spaces in directory names." & @CRLF & "Be sure that there are no names like 'new folder' or something like that." & @CRLF & @CRLF & "Please try again!")
			Else
				GUICtrlSetData($status, "Step 2 is enabled, please go ahead.")
				gettime()
				FileWrite($hLog, $short & ": " & 'Directory is fine.' & @CRLF)
				FileWrite($hLog, $short & ": " & 'Path to directory: ' & $outputedd & @CRLF)
				GUICtrlSetState($output2, $GUI_ENABLE)
			EndIf
		Case $output2
			$selected2 = FileSaveDialog("Please define a name for .xbt", "C:\", "Kodi Texture File (*.xbt)", 0, "Textures.xbt")
			If StringInStr($selected2, " ") Then
				gettime()
				FileWrite($hLog, $short & ": " & 'Found a space in target file directory ! Displayed hint.' & @CRLF)
				MsgBox(0, "Kodi - Texture Tool", "Unfortunately TexturePacker is not supporting any spaces in directory names." & @CRLF & "Be sure that there are no names like 'new folder' or something like that." & @CRLF & @CRLF & "Please try again!")
			Else
				gettime()
				FileWrite($hLog, $short & ": " & 'Directory is fine.' & @CRLF)
				FileWrite($hLog, $short & ": " & 'Path to output file: ' & $selected2 & @CRLF)
				GUICtrlSetData($status, "Step 2 is enabled, please go ahead.")
				If $selected2 <> "" Then
					GUICtrlSetState($start2, $GUI_ENABLE)
				EndIf
			EndIf
		Case $start2
			ProcessClose("TexturePacker.exe")
			gettime()
			If GUICtrlRead($lz0) = $GUI_CHECKED And GUICtrlRead($dupeheck) = $GUI_CHECKED Then
				$command = "TexturePacker -dupecheck -input " & $outputedd & " -output " & $selected2
				FileWrite($hLog, $short & ": " & 'Running command:' & $command & @CRLF)

			ElseIf GUICtrlRead($dupeheck) = $GUI_CHECKED Then
				$command = "TexturePacker -disable_lz0 -input " & $outputedd & " -output " & $selected2
				FileWrite($hLog, $short & ": " & 'Running command:' & $command & @CRLF)

			ElseIf GUICtrlRead($lz0) = $GUI_CHECKED Then
				$command = "TexturePacker -input " & $outputedd & " -output " & $selected2
				FileWrite($hLog, $short & ": " & 'Running command:' & $command & @CRLF)

			ElseIf GUICtrlRead($dev) = $GUI_CHECKED Then
				MsgBox(0, "Dev Mode", "Running command: " & $command)
				FileWrite($hLog, $short & ": " & 'Dev Mode enabled - displayed command to User' & $command & @CRLF)
			EndIf
			gettime()
			FileWrite($hLog, $short & ": " & 'TexturePacker.exe running.' & @CRLF)
			Run(@ComSpec & " /c " & $command, @TempDir, @SW_HIDE)
			GUICtrlSetData($status, "Please wait until it's done. This may take a few seconds...")
			TrayTip("Kodi - Texture Tool", "Compile in progress - please wait ...", 2, 1)
			bar()
			ProcessWaitClose("TexturePacker.exe")
			gettime()
			FileWrite($hLog, $short & ": " & 'TexturePacker.exe closed.' & @CRLF)
			GUICtrlSetData($progress, 100)

			GUICtrlSetData($status, "It's done (:")
		Case $info
			child()
	EndSwitch
	Switch TrayGetMsg()
		Case $idAbout ;
			child()
		Case $idExit ; Exit the loop.
			FileWrite($hLog, '******************Closed aboutwindow by user*****************' & @CRLF)
			ProcessClose(@ScriptName)
			ExitLoop
			Exit
		Case $update
			update()
		Case $thread
			ShellExecute("http://forum.kodi.tv/showthread.php?tid=201883")
		Case $git
			ShellExecute("https://github.com/e0xify/KodiXBMCTextureTool")
		case $dona
			Msgbox(0,"BTC Donation","Donation Adress copied to clipboard" & @crlf & "Many thanks :)")
				ClipPut("")
	EndSwitch
WEnd
Endfunc

Func child()
	gettime()
	FileWrite($hLog, $short & ": " & 'About window opened.' & @CRLF)

	; Create a GUI with various controls.
	Local $hGUI = GUICreate("About", 190, 210)
	Local $idOK = GUICtrlCreateButton("OK", 310, 370, 85, 25)
	$lbl2 = GUICtrlCreateButton("Release Thread", 10, 20, 170, 25)
	$lbl3 = GUICtrlCreateButton("Github", 10, 50, 170, 25)
	$lbl5 = GUICtrlCreateButton("Kodi Wiki", 10, 80, 170, 25)
	$lbl6 = GuictrlCreateButton("Donate BTC",10,110,170,25)
	$lbl4 = GUICtrlCreateButton("Check for updates", 10, 140, 170, 25)

	GUICtrlCreateLabel("Created by supp. - v." & $version, 30, 180, 220, 25)
	GUICtrlSetState(-1, $GUI_DISABLE)
	; Display the GUI.
	GUISetState(@SW_SHOW, $hGUI)

	; Loop until the user exits.
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE, $idOK
				gettime()
				FileWrite($hLog, $short & ": " & 'About window closed.' & @CRLF)
				ExitLoop
			Case $lbl2
				gettime()
				ShellExecute("http://forum.kodi.tv/showthread.php?tid=201883")
				FileWrite($hLog, $short & ": " & 'Kodiboard URL.' & @CRLF)
			Case $lbl3
				gettime()
				ShellExecute("https://github.com/e0xify/KodiXBMCTextureTool")
				FileWrite($hLog, $short & ": " & 'Github URL.' & @CRLF)
			Case $lbl4
				update()
			case $lbl5
				ShellExecute("http://kodi.wiki/view/TextureTool")
			case $lbl6
				Msgbox(0,"BTC Donation","Donation Adress copied to clipboard" & @crlf & "Many thanks :)")
				ClipPut("")
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
	_GDIPlus_ImageResize($g_hImage, 20, 20)
	_WinAPI_RedrawWindow($g_hGUI, 0, 0, $RDW_UPDATENOW)

	_GDIPlus_GraphicsDrawImage($g_hGraphic, $g_hImage, 40, 25)
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

Func enable_dev()
	GUICtrlSetState($dev, $GUI_ENABLE)
EndFunc   ;==>enable_dev

Func update()
	FileDelete(@TempDir & "\update.exe")
	FileDelete(@TempDir & "\update.txt")
	FileDelete(@TempDir & "\update.bat")
	gettime()
	FileWrite($hLog, $short & ": " & 'Update function started.' & @CRLF)
	$online = _INetGetSource("")
	FileWrite(@TempDir & "\update.txt", $online)
	$latest = FileReadLine(@TempDir & "\update.txt", 1)
	If $latest <> "" Then
		If $version <> $latest Then
			Traytip("Kodi - Texture Tool", "New update available !",2,1)
			FileWrite($hLog, $short & ": " & 'Update found.' & @CRLF)
			$updater = GUICreate("Kodi - Texture Tool (Updater)", 320, 65)
			$progress2 = GUICtrlCreateProgress(10, 10, 300, 15)
			$Button = GUICtrlCreateButton("Download", 60, 35, 200, 25)
			GUISetState()
			$URL = ""
			$FileName = @TempDir & "\update.exe"
		Else
			gettime()
			FileWrite($hLog, $short & ": " & "No update found!" & @CRLF)
			TrayTip("Kodi - Texture Tool", "Texture Tool - v." & $version & " (latest)", 2, 1)
			$Button = ""
			gui()

		EndIf
		FileDelete(@TempDir & "\update.txt")
		Sleep(300)
	Else
		gettime()
		FileWrite($hLog, $short & ": " & "Can't reach updatehost" & @CRLF)
		TrayTip("Updateserver unavailable", "Cannot reach update host, check again later", 2, 1)
		gui()
	EndIf

	While Sleep(10)
		$nMsg = GUIGetMsg()
		If $nMsg == $GUI_EVENT_CLOSE Then
			Exit
		ElseIf $nMsg == $Button Then
			FileWrite($hLog, $short & ": " & 'Downloading Update.' & @CRLF)
			If InetGetSize($URL) > 0 Then ;wenn die Datei existiert
				If $Download Then ;wenn die Datei gedownloaded wird
					$Download = False
					InetClose($File)
					FileDelete($FileName)
					GUICtrlSetData($progress2, 0)
					GUICtrlSetData($Button, "Download")
				Else
					$Download = True
					$File = InetGet($URL, $FileName, 1, 1)
					GUICtrlSetData($Button, "Abort")
				EndIf
			EndIf
		EndIf

		If $Download Then ;wenn die Datei gedownloaded wird
			$info = InetGetInfo($File) ;Informationen über den momentanen Download ($File)
			GUICtrlSetData($progress2, $info[0] * 100 / $info[1]) ;prozentualer Fortschritt des Downloads

			If $info[2] Then ;wenn die Datei vollständig herunter geladen wurde
				FileWrite($hLog, $short & ": " & 'Update done.' & @CRLF)
				InetClose($File)
				$Download = False
				GUICtrlSetData($Button, "Download complete !")
				sleep(2000)
				FileWrite(@TempDir & "\update.bat", "ping -n 2 127.0.0.1 > NUL" & @CRLF & "del " & '"' & @ScriptFullPath & '"' & @CRLF & "ping -n 2 127.0.0.1 > NUL" & @CRLF & "ren " & @TempDir & "\update.exe" & " " & '"' & @ScriptName & '"' & @CRLF & "ping -n 2 127.0.0.1 > NUL" & @CRLF & "move " & '"' & @TempDir & "\" & @ScriptName & '"' & " " & '"' & @ScriptFullPath & '"')
				GUICtrlSetData($Button, "Installing update !")
				ShellExecute(@TempDir & "\update.bat", "", "", "", @SW_HIDE)
				Exit
			EndIf
		EndIf
	WEnd
EndFunc   ;==>update

Func gettime()
	$time = @YEAR & "." & @MON & "." & @MDAY & "-" & @HOUR & ":" & @MIN & ":" & @SEC
	$short = @HOUR & ":" & @MIN & ":" & @SEC
EndFunc   ;==>gettime

