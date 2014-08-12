#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\Unbenannt.ico
#AutoIt3Wrapper_Outfile=Kodi Texture.exe
#AutoIt3Wrapper_Res_Description=for Kodi.
#AutoIt3Wrapper_Res_Fileversion=1.2
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

FileInstall("C:\Users\blank\Downloads\neu\base.exe",@tempdir & "\base.exe")
FileInstall("C:\Users\blank\Downloads\neu\D3DX9_43.dll",@tempdir & "\D3DX9_43.dll")
FileInstall("C:\Users\blank\Downloads\neu\glew32.dll",@tempdir & "\glew32.dll")
FileInstall("C:\Users\blank\Downloads\neu\jpeg.dll",@tempdir & "\jpeg.dll")
FileInstall("C:\Users\blank\Downloads\neu\libjpeg-8.dll",@tempdir & "\libjpeg-8.dll")
FileInstall("C:\Users\blank\Downloads\neu\libpng12.dll",@tempdir & "\libpng12.dll")
FileInstall("C:\Users\blank\Downloads\neu\libpng15-15.dll",@tempdir & "\libpng15-15.dll")
FileInstall("C:\Users\blank\Downloads\neu\libtiff.dll",@tempdir & "\libtiff.dll")
FileInstall("C:\Users\blank\Downloads\neu\libtiff-5.dll",@tempdir & "\libtiff-5.dll")
FileInstall("C:\Users\blank\Downloads\neu\libwebp-2.dll",@tempdir & "\libwebp-2.dll")
FileInstall("C:\Users\blank\Downloads\neu\SDL.dll",@tempdir & "\SDL.dll")
FileInstall("C:\Users\blank\Downloads\neu\SDL_image.dll",@tempdir & "\SDL_image.dll")
FileInstall("C:\Users\blank\Downloads\neu\TexturePacker.exe",@tempdir & "\TexturePacker.exe")
FileInstall("C:\Users\blank\Downloads\neu\zlib1.dll",@tempdir & "\zlib1.dll")

Local $hGUI = GUICreate("Kodi XBMC - Texture Tool (v.1.2)",600,190)
GuictrlcreateLabel("Decompile Mode",100,5,100,12)
Guictrlsetfont(-1,8)
Guictrlsetstate(-1,$GUI_DISABLE)
GuictrlcreateLabel("Compile Mode",410,5,100,12)
Guictrlsetfont(-1,8)
Guictrlsetstate(-1,$GUI_DISABLE)
$select = GUICtrlCreateButton("Select Input",180,30,100,25)
$output = GUICtrlCreateButton("Select Output",180,60,100,25)
Guictrlsetstate(-1,$GUI_DISABLE)
$start = GUICtrlCreateButton("Start",180,90,100,25)
Guictrlsetstate(-1,$GUI_DISABLE)
; Display the GUI.
GuictrlcreateLabel("1.Select the input File",10,35,150,25)
GuictrlcreateLabel("2.Select the output Folder",10,65,150,25)
GuictrlcreateLabel("2.Press Start to begin",10,95,150,25)
GuictrlcreateButton("",-5,120,720,5)
Guictrlsetstate(-1,$GUI_DISABLE)
$status = GuictrlcreateLabel("Information Label / Watch out / Pretty dangerous",10,165,600,25)
Guictrlsetstate(-1,$GUI_DISABLE)
$progress = GUICtrlCreateProgress(5,130,590,20)
GuictrlcreateButton("",293,-5,5,127)
Guictrlsetstate(-1,$GUI_DISABLE)
;#-------------------------------------------------------------------------


$select2 = GUICtrlCreateButton("Select Input Folder",480,30,100,25)
$output2 = GUICtrlCreateButton("Select Output File",480,60,100,25)
Guictrlsetstate(-1,$GUI_DISABLE)
$start2 = GUICtrlCreateButton("Start",480,90,100,25)
Guictrlsetstate(-1,$GUI_DISABLE)
GuictrlcreateLabel("1.Select the input Folder",310,35,150,25)
GuictrlcreateLabel("2.Select the output File",310,65,150,25)
GuictrlcreateLabel("2.Press Start to begin",310,95,150,25)

GUISetState(@SW_SHOW, $hGUI)

; Loop until the user exits.
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
		case $select
			$selected = FileOpenDialog("Please select the .xbt File to extract",@DesktopDir,"XBMC Texture File (*.xbt)")
			Guictrlsetdata($status,"             Good Guy ! You enabled Step 2")
			if $selected <> "" Then
				Guictrlsetstate($output,$GUI_ENABLE)
			Endif
		case $output
			$outputed = FileSelectFolder("Please select destination directory",@DesktopDir)
			Guictrlsetdata($status,"               Awesome ! You enabled Step 3")
			Guictrlsetstate($start,$GUI_ENABLE)

		case $start
			Traytip("Watch out","Extract is in progress",2,1)
			ProcessClose("base.exe")
			$command = "base.exe " & '"' & $selected & '"' & ' "' &  $outputed & '"'
			;msgbox(0,"",$command)
			Run(@ComSpec & " /c " & $command ,@tempdir, @SW_HIDE)
			Guictrlsetdata($status,"By the Way, its not taking that long / give a fu** at the Progressbar - #justanimationthings  | WAIT DUDE ... WAIT !")
			Traytip("XBMC Texture Extraction","Wait dude...just wait..",2,1)
			bar()
			ProcessWaitClose("cmd.exe")
			Guictrlsetdata($progress,100)

			Guictrlsetdata($status,"                  Holyshit !   We are done (: ")
			ShellExecute($outputed)
		case $select2
			$outputedd = FileSelectFolder("Please select Directory to compile to .xbt File",@DesktopDir)
			Guictrlsetdata($status,"               Awesome ! You enabled Step 2")
			Guictrlsetstate($output2,$GUI_ENABLE)
		case $output2
			$selected2 = FileSaveDialog("Please define a name for .xbt",@DesktopDir,"XBMC Texture File (*.xbt)",0,"Textures.xbt")
			Guictrlsetdata($status,"             Good Guy ! You enabled Step 2")
			if $selected2 <> "" Then
				Guictrlsetstate($start2,$GUI_ENABLE)
			Endif
		case $start2
			Traytip("Watch out","Extract is in progress",2,1)
			ProcessClose("TexturePacker.exe")
			$command = "START /B /WAIT TexturePacker -dupcheck -input "  & $outputedd & " -output " & $selected2
			;msgbox(0,"",$command)
			Run(@ComSpec & " /c " & $command ,@tempdir, @SW_HIDE)
			Guictrlsetdata($status,"By the Way, its not taking that long / give a fu** at the Progressbar - #justanimationthings | WAIT DUDE ... WAIT ! ")
			Traytip("XBMC Texture Extraction","Wait dude...just wait..",2,1)
			bar()
			ProcessWaitClose("cmd.exe")
			Guictrlsetdata($progress,100)

			Guictrlsetdata($status,"                  Holyshit !   We are done (: ")
		EndSwitch
WEnd

Func hide()
			Winsetstate("Dummy Window! (Keine Rückmeldung)","",@SW_HIDE)
			WinSetTrans ( "Dummy Window! (Keine Rückmeldung)","",0 )
			Winsetstate("Dummy Window!","",@SW_HIDE)
			WinSetTrans ( "Dummy Window!","",0 )
			WinClose("Dummy Window!")
			WinKill("Dummy Window!")
			WinKill("Dummy Window! (Keine Rückmeldung)")

Endfunc

func bar()
	for $i = 0 to 100 Step 3
	GUICtrlSetData($progress,$i)
	sleep(200)
	if $i = 99 then
	$i = 0
	Endif
	if not ProcessExists("cmd.exe") Then
		$i = 100
	Endif
Next

Endfunc
