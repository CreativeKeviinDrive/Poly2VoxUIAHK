REC        =App\import\                                ;---- <<< place for copied file 3D Model ZIP
run,%COMSPEC% /C if not exist \%REC%\NUL MD %REC%,,hide



Gui, Show, W800 H440 X250 Y125, Poly2VOX (GUI Interface)
Gui, Color, 15202b, 0b1621,
Gui +ToolWindow -Theme
Gui, Add, Picture, x0 y80, app\data\menu.png
Gui,  Add, Text, x300 y0, STEP 1 - POLY2VOX | ZIP PARAMETER VV
Gui,  Add, Text, x200 y40, STEP 2- SELECT AN EXTENSION YOU WANT TO CONVERT THE VOXEL TO! (Only Pick One!)
Gui, Add, Button,x595 y420 w80 h20 gTriggerOpenCmd, show CMD
Gui, Add, Button,gTrigger0 x0 y20 w300 h20 v1,  Open ZIP File (With *.3DS and *.PNG Textures) (Required)*
Gui, Add, Edit,x320 y20 w200 h20 vselect1,  Select a Model
Gui, Add, Button,x000 y60 w200 h20 gTrigger2, KV6 (recommended)
Gui, Add, Button,x200 y60 w200 h20 gTrigger3, KVX (For Small things)
Gui, Add, Button,x400 y60 w200 h20 gTrigger4, VXL (Huge, No "/v" required)
Gui, Add, Button,x600 y60 w200 h20 gTrigger5, VOX (No Compression)
Gui, Add, Button,x0 y420 w400 h20 gTrigger6, Voxel Size (Be sure to change 128 to your number)
Gui, Add, Button,x400 y420 w80 h20 gTrigger7, Convert
Gui, Add, Button,x675 y420 w50 h20 gTrigger9, Help
Gui, Add, Button,x725 y420 w75 h20 gTrigger10, Copyright
Gui, Show



Run cmd.exe,
WinGetPos, cmdX, cmdY, wideness, highness, ButtonWindow1
cmdY += 42
WinWait, ahk_class ConsoleWindowClass
WinMove, ahk_class ConsoleWindowClass,, %cmdX%, %cmdY%


;==============================================================
;==============================================================
; This must go after the "auto-execute" section, but 
; before hotkeys and labels, otherwise it won't work right

;WM_MOVE = 0x03
;WM_EXITSIZEMOVE = 0x232
;WM_MOVING = 0x216

OnMessage(0x232, "WM_EXITSIZEMOVE")
return

WM_EXITSIZEMOVE()
{
IfWinExist, ahk_class ConsoleWindowClass
{
WinGetPos, cmdX, cmdY, wideness, highness, ButtonWindow1
cmdY += 42
WinWait, ahk_class ConsoleWindowClass
WinMove, ahk_class ConsoleWindowClass,, %cmdX%, %cmdY%
return
}
}
;==============================================================
;==============================================================


!x::ExitApp

TriggerOpenCmd:
IfWinExist, ahk_class ConsoleWindowClass
{
WinClose, ahk_class ConsoleWindowClass
return
}
else
{
Run cmd.exe, 
WinGetPos, cmdX, cmdY, wideness, highness, ButtonWindow1
cmdY +=42
WinWait, ahk_class ConsoleWindowClass
WinMove, ahk_class ConsoleWindowClass,, %cmdX%, %cmdY%
return
}

Trigger0:
Gui,3:submit,nohide

FileSelectFile,SFL,3,, %A_scriptdir%, Open a file (*.*)
GuiControl,,Select%A_GuiControl%,%A_scriptdir%
If ErrorLevel<>0
  return

SplitPath,SFL,name, dir, ext, name_no_ext, drive
FileCopy, %SFL%,%REC%\model.zip
IfWinExist, ahk_class ConsoleWindowClass
WinActivate
Send, app\Poly2vox.exe app\import\model.zip
return

Trigger1:


Trigger2:
IfWinExist, ahk_class ConsoleWindowClass
WinActivate
Send, {space}.\app\Export\kv6_voxel.kv6
return

Trigger3:
IfWinExist, ahk_class ConsoleWindowClass
WinActivate
Send,  {space}.\app\Export\kvx_voxel.kvx
return

Trigger4:
IfWinExist, ahk_class ConsoleWindowClass
WinActivate
Send,  {space}.\app\Export\vxl_map.vxl
return

Trigger5:
IfWinExist, ahk_class ConsoleWindowClass
WinActivate
Send,  {space}.\app\Export\Vox_voxel.vox
return

Trigger6:
IfWinExist, ahk_class ConsoleWindowClass
WinActivate
Send, {space}/v128
return

Trigger7:
IfWinExist, ahk_class ConsoleWindowClass
WinActivate
Send, {Enter}
return

Trigger8:
IfWinExist, ahk_class ConsoleWindowClass
WinActivate
Send, ipconfig{Enter}
return

Trigger9:
Run, App\Data\Help.txt
return

Trigger10:
Run, App\Data\Copyright.txt
return




GuiContextMenu:
IfWinNotExist, ahk_class ConsoleWindowClass
{
Run cmd.exe, c:\
}
WinGetPos, cmdX, cmdY, wideness, highness, ButtonWindow1
cmdY += 42
WinWait, ahk_class ConsoleWindowClass
WinMove, ahk_class ConsoleWindowClass,, %cmdX%, %cmdY%
return

GuiClose:
WinClose, ahk_class ConsoleWindowClass
ExitApp
return

KillIt:
WinClose, ahk_class ConsoleWindowClass
ExitApp
return