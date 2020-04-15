trayMenu(){
    ListLines, Off
    ifexist %A_ScriptDir%\AutoHotKey\resources\%SCR_Name%_Clear.ico                     
        Menu, Tray, Icon, %A_ScriptDir%\AutoHotKey\resources\%SCR_Name%_Clear.ico 
        Menu, Tray, Add
    Menu, Tray, Tip, % " "                         
    Menu, Tray, NoStandard                        
    ;~ Menu, Tray, Add, &Active, SCR_Pause
    ;~ Menu, Tray, Check, &Active
    Menu, Tray, Add, &Reload This Script, SCR_Reload
    Menu, Tray, Add, Open &Folder, SCR_OpenFolder
    LoopTray()
        Menu, SubEdit, Add, Lib, :lib
        Sleep, 40
        Menu, Tray, Add, &Edit, :SubEdit
    Menu, ScriptInfo, Add, KeyHistory, SCR_KeyHistory
    Menu, ScriptInfo, Add, ListHotkeys, SCR_ListHotkeys
    Menu, ScriptInfo, Add, ListVars, SCR_ListVars
    Menu, ScriptInfo, Add, ListLines, SCR_ListLines   
    Menu, ScriptInfo, Add, ListLines On, SCR_ListLinesOn
    Menu, ScriptInfo, Add, ListLines Off, SCR_ListLinesOff   
        Menu, Tray, Add, Script Info, :ScriptInfo
        Menu, ScriptInfo, check, ListLines Off
    Menu, Tray, Add
    Menu, Tray, NoMainWindow
    Menu, Tray, Standard
    trayListen()
    setTimer, trayListen, 1000  ;for better Stability
}
ListLines, Off
LoopTray(){
Loop, Files, %A_ScriptDir%\AutoHotkey\*.ahk
{       
    Menu, SubEdit, Add, %A_LoopFileName%, SCR_Edit4
    Loop, Files, %A_ScriptDir%\AutoHotkey\lib\*.ahk
    {  
        Menu, Lib, Add, %A_LoopFileName%, SCR_Edit3
}
}
}

SCR_OpenFolder(){
    Run, %A_ScriptDir%/AutoHotkey
    return
}
SCR_Edit3(){
    Run, edit %A_ScriptDir%\AutoHotkey\lib\%A_ThisMenuItem%
    return
}
SCR_Edit4(){
    Run, edit %A_ScriptDir%\AutoHotkey\%A_ThisMenuItem%
    return
}
SCR_Reload(){
    Reload
    return
}
SCR_Pause(){
    Suspend
    Menu, Tray, ToggleCheck, &Active
    Pause, Toggle, 1
    return
}

SCR_KeyHistory(){
    KeyHistory
    Return
}
SCR_ListHotkeys(){
    ListHotkeys
    Return
}
SCR_ListVars(){
    ListVars
Return
}

SCR_ListLines(){
    ListLines, Off 
    ListLines
    Return
}
SCR_ListLinesOn(){
    Menu, ScriptInfo, Check, ListLines On
    Menu, ScriptInfo, Uncheck, ListLines Off
    Toast.show( {life:2000, title:{text:(InStr(KeepRunning, false)? "ListLines Stopped: Press Win+" Clean_ThisHotKey " to Restart":"ListLines Started: Press Win+" strRemove(A_ThisHotkey,["~","+","#"]) " to End")}, sound:True})
    ListLines, Off
    ListLines
    KeepRunning := tray
    SetTimer, SCR_ListLines, 500
    return
}
SCR_ListLinesOff(){
    Menu, ScriptInfo, Uncheck, ListLines On
    Menu, ScriptInfo, check, ListLines Off
    Toast.show( {life:2000, title:{text:(InStr(KeepRunning, false)? "ListLines Stopped: Press Win+" Clean_ThisHotKey " to Restart":"ListLines Started: Press Win+" strRemove(A_ThisHotkey,["~","+","#"]) " to End")}, sound:True})    
    SetTimer, SCR_ListLines, Delete
} 

SCR_lockedDesktopOn(){
    ListLines, Off 
    if !DllCall("User32\OpenInputDesktop","int",0*0,"int",0*0,"int",0x0001L*1){
        SCR_lockedDesktopOff()
        return
	}
} 
SCR_lockedDesktopOff(){
    SetTimer, SCR_lockedDesktopLocked, 500
    SetTimer, SCR_lockedDesktopOn, Delete
    return 
}
SCR_lockedDesktopLocked(){
    if DllCall("User32\OpenInputDesktop","int",0*0,"int",0*0,"int",0x0001L*1){
        SCR_lockedDesktopOnStart()
        return
    }
}
SCR_lockedDesktopOnStart(){
    SetTimer, SCR_lockedDesktopOn, 500
    SetTimer, SCR_lockedDesktopLocked, Delete
    return
}
googlewtfClose(){
    ListLines, off
    IfWinNotExist, C:\Users\TG-PC\Google_Drive
        SetTimer, googlewtfClose, -100
    else
        SetTimer, googlewtfClose, Off
    WinClose, C:\Users\TG-PC\Google_Drive, , 0
    ;~ exit
    return
}
formatDriveClose(){
	ListLines, Off
	IfWinNotExist, Microsoft Windows ahk_class #32770 ahk_exe Explorer.EXE
		return True
	Else
	ControlClick, Button2, Microsoft Windows ahk_class #32770 ahk_exe Explorer.EXE
	;~ Send, {Esc}  ; Otherwise
	return False
}
lastpassActivate(){
	ListLines, Off
	If !WinExist("Swipe finger")
		return
	Else
        WinActivate, Swipe finger
	return 
}
numpadFunctions(){
    ListLines, Off
    Key:=SubStr(A_Index,0) ; so it grabs zero not 10
    HotKey, #NumPad%key%, #NumPad%key%
    Return
}

micToggle(){
	SoundSet, +1, MASTER, mute,5
	SoundGet, master_mute, , mute,5
	MouseGetPos, mx, my
	tip:= % master_mute
    
    obj:=func("showTrayTipMic").bind(tip,mx,my)
    setTimer, % obj, -200
    return
}
micListenToggle(){
SetControlDelay, 30
isExist:=WinExist("ahk_exe rundll32.exe ahk_class #32770")
Run, % "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,recording",,, uPID
WinWait, % "ahk_pid"uPID,, 1
WinWait,Sound
Send {CTRL DOWN}{Down}{CTRL UP}
ControlGet, List, List,, SysListView321, % "ahk_pid"uPID
FileRead, OutputVar, toggle.ini
Loop, Parse, List, `n
{
    IfInString, A_LoopField, %OutputVar%
    {
        ControlClick,&Properties
        Send {CTRL DOWN}{Tab}{CTRL UP}
        Send {Space}
        Send {Enter}
        break
    }
    else 
    {
        ControlSend,SysListView321,{Down}
    }
}
WinWait,Sound
Send {Esc}
return
}
showTrayTipMic(tip,mx,my){
    MouseGetPos, mx, my
    ToolTip(tip, {x:mx+50,y:my+50,no:19,life:2000}) 
    exit
}
fireFoxOpen(openLink){
    RegRead,defBrowser,HKCR,.html                               ; Get default browswer
    RegRead,defBrowser,HKCR,%defBrowser%\shell\open\command     ; Get path to default browser + options
    defBrowser := StrReplace(defBrowser, "`%1", openLink)
    Run % defBrowser 
}

;==========================================
trayListen(){
    ListLines, Off
    OnMessage(0x404, "mouseOverTray")  ;Mouse over tray icon
    return
}
mouseOverTray(wParam,lParam){
    ListLines, Off
    if (lParam=0x205) {        ; Single click
    } else if (lParam=0x205) {    ; Double click
    } else if (lParam=0x205) {    ; Right click
    } else updateTray()
    return
}
updateTray(){
    ListLines, Off
    MouseGetPos, mx, my
    
    if (A_UserName = "TG-PC"){
    ;~ for INetwork in ComObjCreate("{DCB00C01-570F-4A9B-8D69-199FDBA5723B}").GetNetworks(1)
    ;~ tip:=INetwork.GetName() "`n"
    }
    
    tip.=SCR_Name " Script`n" 

    obj:=Togglekeys_check()
    tip.="ToggleKeys: " (obj.n?"N":"") (obj.c?"C":"") (obj.s?"S":"") (obj.i?"I":"") "`n"
    
    ;~ tip.=SCR_Path "`n"
    ;~ tip.="ErrorLevel "ErrorLevel
    ;~ tip.=", Suspended "A_IsSuspended
    ;~ tip.=", Paused "A_IsPaused
    ;~ tip.=" | This Hot Key: "A_ThisHotkey
    ;~ tip.=" Prior Hot Key: "A_PriorHotkey

    obj:=func("showTrayTip").bind(tip,mx,my)
    setTimer, % obj, -200
    return
}
showTrayTip(tip,mx,my){
    ListLines, Off
    MouseGetPos, mx, my
    ToolTip(tip, {x:mx,y:980,no:20,life:750})
    return
}


