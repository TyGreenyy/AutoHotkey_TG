
; =====================================================================================
; AHK Version ...: AHK 1.1.32.00 (Unicode 64-bit) - September 13, 2015
; Platform ......: Windows 10
; Language ......: English (en-US)
; Author ........: TyGreeny
; =====================================================================================




;{ ============================== Temp Testing =========================================

;~ ; Hard exit that just closes the script
^Esc::ExitApp
return

!o::
isExist:=WinExist("ahk_exe rundll32.exe ahk_class #32770")
Run, % "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,recording",,, uPID
WinWait, % "ahk_pid"uPID,, 1
WinWait, Sound
        Sleep, 100
        Send {Down}
        Sleep, 100
        ControlClick, &Properties
        Sleep, 100
        Send {CTRL DOWN}{Tab}{CTRL UP}
        Sleep, 100
        Send {Space}  
        Sleep, 100
        Send {Enter}
        Send, {Esc}
return
return


;{ ============================== Main Script =========================================

;~; Right Apps Key as Windows Key. Allows use of modifiers. 
*AppsKey::    
Send {Blind}{RWin down}
return 

AppsKey up::
    if (A_Priorkey != "AppsKey" && !(GetKeyState("Shift") || GetKeyState("Ctrl") || GetKeyState("Alt")))
        Send {Blind}{Ctrl}
    Send {Blind}{RWin Up}
    return

;~ ; Ctrl + Apps Key for Apps Key
^AppsKey::
Send, {AppsKey}
return

; ========================  Empty Recycle Bin Win+Del  ========================
;~; Windows key + Delete to empty Recycle Bin
#Del::FileRecycleEmpty
return

~MButton::Send, {Enter}
return
;~ ;}
;{ ============================  Windows Explorer  =============================

#IfWinActive ahk_class CabinetWClass ahk_exe Explorer.EXE
#z::
    Send, {F2}
    fileRename()
    Send, {Tab}
return

; Ctrl+h to Toggle Windows Hidden Folders On/Off
^h::GoSub,CheckActiveWindow
return

; Type '/' in the address bar of explorer window followed by command line command

~/::QuickPrompt()                        ;~ Type '/' in the address bar of explorer
return

;~ XButton1::Send, !{Left}
;~ return

XButton2::
if (XButton2_presses > 0) ; SetTimer already started, so we log the keypress instead.
{
    XButton2_presses += 1
    return
}
XButton2_presses := 1
SetTimer, XButton2Options, -200 ; Wait for more presses within a 400 millisecond window.
return
#if
;}

;~ ; Hold right mouse botton, click left to switch to previous window
#if getKeyState("RButton","P") 
Loop {
  WinWait, Microsoft Windows ahk_class #32770
  WinClose
}
    
LButton::                                   ;- Switch to next window                         
    if (!GetKeyState("ScrollLock", "T"))
        GoSub, CtrlClickSub                      ; ScrollLock On
    else if (GetKeyState("ScrollLock", "T"))
        GoSub, SendToWindowBackSub          ; ScrollLock Off   
return
#if

;}
;{ ============================== Bria =======================================
#if WinExist("Bria")
Insert::
    if (insertPresses > 0){
        insertPresses += 1
        return
    }
    insertPresses := 1
    SetTimer, insertPresskey, -200 ; Wait for more presses within a 200 millisecond window.
return
#if

; Mouse Wheel Right for Pause
Pause::
    if (pausePresses > 0){
        pausePresses += 1
        return
    }
    pausePresses := 1
    SetTimer, pausePresskey, -180 ; Wait for more presses within a 180 millisecond window.
return


;}
;{ ============================== Communicator =======================================
#if isOver_mouse("ahk_exe firefox.exe")
XButton1 up::
    hwndtmp := "ahk_id " isOver_mouse("ahk_exe firefox.exe")
    WinActivate, %hwndtmp%,
    Send, ^{Click} 
    ;~ WinWaitNotActive, %hwndtmp%, , 0.5
        ;~ if (errorlevel)
            ;~ return
        ;~ Else
            ;~ GoSub, WinMoveSecondMon    
    return
#if    


;}
;{ ============================== Windows Explorer (Over Taskbar) =====================

#if isOver_mouse("ahk_class Shell_TrayWnd ahk_exe Explorer.exe") or isOver_mouse("ahk_exe DisplayFusion.exe")
WheelUp::
WheelDown::
    ListLines, Off
    Send % A_ThisHotKey="WheelUp" ? "^+!{Tab}" : "^!{Tab}"
return

MButton Up::Send +^{Esc}    ; Task manager
return
#if
;}
;{=============================== Mouse ===============================================

; Create the Hotkeys with the function and select labels and wait times.
RButton::
MouseExtras("RHoldMsg", "500", "RDoubleMsg", "0.1")
return

; Ctrl + Right Click to Open Tray Menu
^RButton::Menu, Tray, Show
return

; Mouse Side Button for Ditto Clipboard - Check End of Document for Extras
Xbutton2::GoSub, DittoMenu
return

; Mouse WheelLeft for Copy
WheelLeft::
    if (wheelLeftPresses > 0){
        wheelLeftPresses += 1
        return
    }
    wheelLeftPresses := 1
    SetTimer, WheelLeftKey, -200 ; Wait for more presses within a 200 millisecond window.
return

; Mouse Wheel Right for Paste
WheelRight::
    if (wheelRightPresses > 0){
        wheelRightPresses += 1
        return
    }
    wheelRightPresses := 1
    SetTimer, WheelRightKey, -300 ; Wait for more presses within a 300 millisecond window.
return

;}
;{=============================== Kensington Keyboard =================================

#if WinActive("ahk_exe Firefox.exe")
F2::
    GoSub, truePeopleSearch
return
#if

Volume_Down::
    searchTerm := Clip()
    hwndtmp := "ahk_id " isOver_mouse("A")
    WinActivate, %hwndtmp%, 
    Sleep, 100
    searchTerm := RegExReplace(searchTerm, "[^A-Za-z]", "")
    searchTerm = %searchTerm%
    openLink = https://client.debtpaypro.com/index.php?module=contacts&page=dedup&sfield=lastname&search_filter=%searchTerm%
    fireFoxOpen(openLink)
return

~Media_Stop::
~Media_Prev::
~Media_Next::
return

Launch_Media::
        Run, %A_AppData%\Spotify\Spotify.exe, , UseErrorLevel
    if ErrorLevel = ERROR
        Run, wmplayer.exe
return

Launch_App2::Run, calculator:
return

Launch_App1::Run, ms-settings:
return

Launch_Mail::
outlookWeb = https://outlook.office.com/mail/inbox
if (A_UserName = "TG-PC")
    WinActivate, FireFox
else
    fireFoxOpen(outlookWeb)
Send, !m
return

Volume_Mute::
    micToggle()
return

;}
;{ ============================== SciTE4AutoHotkey ===================================

#if WinActive("ahk_class SciTEWindow") OR WinActive("ahk_exe sublime_text.exe") 
~^s::
if (A_PriorHotkey != "~^s" or A_TimeSincePriorHotkey > 400)
{
    KeyWait, s 
    return
}  
GoSub, SaveReload
return
    Toast.show( {title:{text:strRemove(A_ThisHotkey,["~","+"]) (GetKeyState(strRemove(A_ThisHotkey,["~","+"]),"T")? " On":" Off")}, sound:True})

#if

;{ ============================== Infos Tools  ===================================
#MaxThreadsPerHotkey 3 
#F1::
#MaxThreadsPerHotkey 1
if KeepRunning1 {  			    ; This means an underlying thread is already running the loop below.
    KeepRunning1 := false
    SCR_ListLinesOff()
    return  				    ; End this thread so the one underneath will resume and see the change made by line above.
}
else
{
KeepRunning1 := true 
ListLines, Off
SCR_ListLinesOn()
}
return

#MaxThreadsPerHotkey 3 
#F2::
#MaxThreadsPerHotkey 1
if KeepRunning2 {                ; This means an underlying thread is already running the loop below.
    KeepRunning2 := false         ; Signal that thread's    loop to stop.
    SetTimer, ToolTipInfos, Delete
    Toast.show( {life:2000, title:{text:(InStr(KeepRunning2, false)? "ToolTip Info Stopped: Press Win+" strRemove(A_ThisHotkey,["~","+","#"]) " to Restart":"ToolTip Info: Press Win+" Clean_ThisHotKey " to End")}, sound:True})
    return                      ; End this thread so the one underneath will resume and see the change made by line above.
}
else
{
KeepRunning2 := true 
    Toast.show( {life:2000, title:{text:(InStr(KeepRunning2, false)? "ToolTip Info: Press Win+" Clean_ThisHotKey " to Restart":"ToolTip Info: Press Win+" strRemove(A_ThisHotkey,["~","+","#"]) " to End")}, sound:True})
ListLines, Off
SetTimer, ToolTipInfos, 500 
}
return

#MaxThreadsPerHotkey 3 
#F3::
#MaxThreadsPerHotkey 1
if KeepRunning3 {                ; This means an underlying thread is already running the loop below.
    KeepRunning3 := false         ; Signal that thread's    loop to stop.
    SetTimer, SCR_Mouse, Delete
    Toast.show( {life:2000, title:{text:(InStr(KeepRunning3, false)? "Mouse Info Stopped: Press Win+" strRemove(A_ThisHotkey,["~","+","#"]) " to Restart":"Mouse Info: Press Win+" Clean_ThisHotKey " to End")}, sound:True})
    return                      ; End this thread so the one underneath will resume and see the change made by line above.
}
else
{
KeepRunning3 := true 
Toast.show( {life:2000, title:{text:(InStr(KeepRunning3, false)? "Mouse Info: Press Win+" strRemove(A_ThisHotkey,["~","+","#"]) " to Restart":"Mouse Info: Press Win+" Clean_ThisHotKey " to End")}, sound:True})
SetTimer, SCR_Mouse, 50
}
return

#MaxThreadsPerHotkey 3 
#F4::
#MaxThreadsPerHotkey 1
if KeepRunning5 {                ; This means an underlying thread is already running the loop below.
    KeepRunning5 := false         ; Signal that thread's    loop to stop.
    SetTimer, DiscordInfos, Delete
    Toast.show( {life:2000, title:{text:(InStr(KeepRunning2, false)? "Discord Info Stopped: Press Win+" strRemove(A_ThisHotkey,["~","+","#"]) " to Restart":"Discord Info: Press Win+" Clean_ThisHotKey " to End")}, sound:True})
    return                      ; End this thread so the one underneath will resume and see the change made by line above.
}
else
{
KeepRunning5 := true 
    Toast.show( {life:2000, title:{text:(InStr(KeepRunning2, false)? "Discord Info: Press Win+" Clean_ThisHotKey " to Restart":"Discord Info: Press Win+" strRemove(A_ThisHotkey,["~","+","#"]) " to End")}, sound:True})
ListLines, Off
SetTimer, DiscordInfos, 200 
}
return

F9::
GoSub, CommunicatorReTitle
return

!F9::
    Send, +!p
return

;}
;{ ================================== Discord =============================================

#if WinActive("ahk_exe Discord.exe")
XButton1::Send, ^k
return

; Alt + p
!p::Send, .pick
return
#if
;}
;{ ================================== Outlook =============================================

;~ #if (WinActive("ahk_exe OUTLOOK.exe"))
;~ WheelRight::   
    ;~ outlookSearch := Clip()
    ;~ sleep, 100
    ;~ Run, https://www.facebook.com/search/top/?q=%outlookSearch%
;~ return
;~ #if
;}
;{ ============================== Sublime Text 3 ======================================

#if WinActive("ahk_exe sublime_text.exe")
NumpadSub::Send, ^/
return 
#if
;}
;{ ============================== TextEditGroup =======================================
;~ TextEditGroup: WINWORD.EXEord.exe, notepad.exe, SciTE.exe, soffice.bin, hh.exe, firefox.exe, sublime_text.exe, WinSCP.exe

;~ #if WinActive("ahk_group TextEditGroup")
;~ XButton1:: Send, {Delete}
;~ return
;~ #if
;}
;{ ============================== TriviaGroup =========================================
;~ Trivia Group: #tg-gambling - Discord, #trivia - Discord

#if (GetKeyState("ScrollLock", "T")) AND (WinActive("ahk_group TriviaGroup"))
WheelRight::GoSub, SearchAuieo
return
#If

#if (GetKeyState("ScrollLock", "T")) AND (WinExist("ahk_group TriviaGroup")) AND (WinActive("Knowledge Base"))
WheelRight::GoSub, SendToDiscord
return
#if
;}
;{=============================== PIPWindowGroup ======================================
;~ PIPWindowGroup: MozillaDialogClass, 

#if isOver_mouse("ahk_group PIPWindowGroup")
^#Space::Winset, AlwaysOnTop, Toggle, A
return
#if

;}
;{=============================== SubRoutines =========================================
return

RemoveToolTip:
    ToolTip
return

ToolTipInfos:
    MouseGetPos, xpos, ypos
    halfscreenheight := Round((A_ScreenHeight/2))
    halfscreenwidth := Round((A_ScreenWidth/2))
    MouseGetPos, mx, my
    ;~ tip:= % "ScriptDir: "A_ScriptDir "`nWorkingDir: "A_WorkingDir "`nWidth: "halfscreenwidth " | Height: "halfscreenheight "`nMouse X=" xpos "+" A_ScreenWidth-xpos "=" A_ScreenWidth " | Y="  ypos "+" A_ScreenHeight-ypos "=" A_ScreenHeight "`nCaret: X="  A_CaretX " | Y=" A_CaretY "`nPriorKey: " A_Priorkey " | PriorHotKey: " A_PriorHotkey " | LastError: " A_LastError " | Time Idle: " A_TimeIdle
    
    WinGetPos, FoundX, FoundY, WinRight, WinBottom, A
        MouseX := (FoundX + WinRight - mx)
        MouseY := (FoundY + WinBottom - my)
    tip2:= % mx " - " my "`n" "FoundX: " FoundX "FoundY: " FoundY "`nFrom Right: " MouseX " - From Bottom: " MouseY 
    ToolTip(tip2, {x:xpos-5,y:ypos+100,no:17,life:7500}) 
    ToolTip(tip, {x:xpos,y:20,no:18,life:7500})  
Return

DiscordInfos:
    WinActivate, ahk_exe discord.exe, , 
        Sleep, 10
        Send, {SPACE}
        Sleep, 200
        SetKeyDelay, 25, 25
        SendEvent {Text} After sitting through hours of New Age rhetoric, 
        ;~ SendEvent {Text} I decided to have a crack at writing code to generate it automatically and speed things up a bit. 
        ;~ SendEvent {Text} I cobbled together a list of New Age buzzwords and cliché sentence patterns and this is the result. 
        ;~ SendEvent {Text} The inspiration for this idea came from watching philosophy debates involving Deepak Chopra.
        Send, ^a
        Sleep 200
        Send, {Delete}
        Sleep, 100
        Send, {PgDn}
        sleep, 300
Return

SaveReload:                 ; Use Control+S to save and reload script
    Progress, m2 b X1550 Y975 zh10,, Reloading %SCR_Name%
    Progress, 100
    Sleep, 1500
    Reload
return

CheckActiveWindow:
    ID := WinExist("A")
    WinGetClass,Class, ahk_id %ID%
    WClasses := "CabinetWClass ExploreWClass"
    IfInString, WClasses, %Class%
        GoSub, Toggle_HiddenFiles_Display
return

Toggle_HiddenFiles_Display:
    RegRead, ShowHidden_Status, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
        if ShowHidden_Status = 2 
            RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
        Else
            RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
    WinGetClass, CabinetWClass
    PostMessage, 0x111, 41504,,, ahk_id %ID%
    return

SendToWindowBackSub:        ;Alt Tab is not used since it shows the TaskSwitcher Window
    winget ids, list
    winget activeID, id, A
    loop % ids {
        if (activeID!=ids%A_Index%)
            continue
        i:=A_Index+1
        ;Use next two lines to send active window one step back without activating the window behind
        ;~ winset AlwaysOntop, On, % "ahk_id " ids%i%
        ;~ winset AlwaysOntop, Off, % "ahk_id " ids%i%
        winActivate % "ahk_id " ids%i%
        break
    }
    return
    
CtrlClickSub:
    hwndtmp := "ahk_id " isOver_mouse("ahk_exe firefox.exe")
        WinActivate, %hwndtmp%,
        Send, ^{Click}  
return
    
WinMoveSecondMon:
    active_id_winkey := "ahk_id " WinActive("A")
        if SysGet, MonitorCount, 80
            WinMove, %active_id_winkey%, , 0, 0, A_ScreenWidth, A_ScreenHeight
        Else
            WinMove, %active_id_winkey%, , A_ScreenWidth, 0, A_ScreenWidth, A_ScreenHeight
        hwndtmp := ""            
    return
    
SearchGoogle:
    searchTerm := Clip()
        Sleep, 100
        searchTerm := StrReplace(searchTerm, "&", "%26")
        searchTerm := StrReplace(searchTerm, """", "%22")
        Run, http://www.google.com/search?q=%URI%
        Sleep, 200
    return

SearchAuieo:
    searchTerm := Clip()
        Sleep, 100
        searchTerm := StrReplace(searchTerm, "&", "%26")
        searchTerm := StrReplace(searchTerm, """", "%22")
        Run, https://auieo.com/knowledge/?s=%searchTerm%
        Sleep, 200
    return

SendToDiscord:       
    searchTerm := Clip() 
        Send, ^w
        WinActivate, ahk_exe Discord.exe
        Sleep, 10
        Send, {SPACE}
        Sleep, 10    
        Send % searchTerm
        Sleep, 50
        Send, {Enter}
        Sleep, 10
    return

DittoMenu:
        Send, {Ctrl down}
        Send, {`` down}{`` up}
        Sleep, 500
        Send, {Ctrl Up}
    return

DittoMenuFirstSticky:
        Send, {Ctrl down}{`` down}{`` up}{Ctrl Up} ; Ctrl+` for Ditto
        Sleep, 200
        Send, {Ctrl down}1{Ctrl up} ; Selects Ditto Quickpaste Menu
        Sleep, 200
        Send, {Enter} ; Sends Message in Discord
    return

MenuHandler:
    run, %SCR_UserDir%\QuickLinks\%A_ThisMenu%\%A_ThisMenuItem%
return

QuickLinksHandler:
    run, %SCR_UserDir%\QuickLinks\
return

ProgramHandler:
    run, %SCR_UserDir%\QuickLinks\%A_ThisMenuItem%
return

WheelLeftKey:
    if (wheelLeftPresses = 1)
        Send, ^c
    else if (wheelLeftPresses = 2)
        Send, ^x
    wheelLeftPresses := 0
return

WheelRightKey:
    if (wheelRightPresses = 1)
        Send, ^v
    else if (wheelRightPresses = 2)
        Send, {Space}
    wheelRightPresses := 0
return

XButton2Options:
    if (XButton2_presses = 1) ; The key was pressed once.
        GoSub, DittoMenu 
    else if (XButton2_presses = 2) ; The key was pressed twice.
        Send, !{Right} 
    XButton2_presses := 0
return

RHoldMsg:
    #MaxThreadsPerHotkey, 2
    Toggle = 0
    KeyWait, Rbutton, U
    if  (A_PriorKey = "RButton")
        Menu, Tray, Show    
    else
        GoSub, RightDoubleLeft
return
    
RightDoubleLeft:
    #if getKeyState("RButton","P")
        Toggle = !Toggle
    If (Toggle) AND if (A_Priorkey = A_PriorHotkey)
        Click, Down
    else
        Click, Up
return
#If

RDoubleMsg:
    if (WinActive("ahk_exe webstorm64.exe"))
        Send, ^{F4}
    ;~ else if (WinActive("ahk_exe firefox.exe"))
        ;~ Send, ^{F4}
    else if (WinActive("ahk_exe EXPLORER.exe"))
        Send, {LButton}{Enter}
    else if (GetKeyState("ScrollLock", "T"))
        Send, {LButton}{LButton}{LButton}
return

insertPresskey:
    MouseGetPos, xpos, ypos 
    if (insertPresses = 1){
        Send, ^#a
        WinActivate, Bria, 
        WinGetPos, FoundX, FoundY, WinRight, WinBottom, Bria
        briaNumpadX := (FoundX+WinRight-300)
        briaNumpadY := (FoundY+WinBottom-50)
        MouseClick, L, briaNumpadX, briaNumpadY
        Sleep, 50
        ;~ briaPhoneNumX := (FoundX+WinRight-300)
        ;~ briaPhoneNumY := (FoundY+WinBottom-462)
        ;~ MouseClick, L, briaPhoneNumX, briaPhoneNumY
        ;~ Sleep, 50
        MouseMove, xpos, ypos         
    }
    else if (insertPresses = 2){
        Send, ^#k   
        briaHistoryX := (FoundX+WinRight-242)
        briaHistoryY := (FoundY+WinBottom-50)
        MouseClick, L, BriaHistoryX, briaHistoryY
        Sleep, 50
        MouseMove, xpos, ypos
    } 
    insertPresses := 0
return

pausePresskey:
    MouseGetPos, xpos, ypos 
    if (pausePresses = 1){
        WinActivate, Communicator - Mozilla Firefox, ,
        Sleep, 50
        Send, ^+u
        WinGetPos, FoundA, FoundB, WinRight, WinBottom, Communicator - Mozilla Firefox        
        communicatorX := (FoundA+WinRight-80)
        communicatorY := (FoundB+220)
        MouseClick, L, communicatorX, communicatorY, 1, , ,
        ;~ MouseClick, L, 1832, 238, 1, , , 
        Send, ^#k
        Sleep, 50
        MouseClick, L, communicatorX, communicatorY, 1, , ,
        Sleep, 50
        MouseMove, xpos, ypos 
        ;~ MouseClick, L, 1832, 238, 1, , , 
    }
    else if (pausePresses = 2){
        WinActivate, Communicator, , , 
        ;~ WinMove,  Communicator, , 1912, -8, 1936, 1045
        Sleep, 25
        Send, ^+u
        WinGetPos, FoundX, FoundY, WinRight, WinBottom, Communicator - Mozilla Firefox        
        communicatorX := (FoundX+WinRight-180)
        communicatorY := (FoundY+135)
        MouseMove, communicatorX, communicatorY
        Sleep, 50
        MouseClick, L, communicatorX, communicatorY, 1, , , 
        ;~ MouseClick, L, 3630, 140, 1, , , 
        Sleep, 50
        MouseClick, L, (communicatorX+50), (communicatorY+85), 1, ,  , 
        MouseMove, xpos, ypos         
        ;~ MouseClick, L, 3730, 240, 1, ,  ,  
    }
    pausePresses := 0
return

truePeopleSearch:
    searchTerm := Clip()
    Sleep, 100
    searchTerm := RegExReplace(searchTerm, "[^0-9]", "")
    searchTerm = %searchTerm%
    phoneNumber1 := SubStr(searchTerm, 1, 3)
    phoneNumber2 := SubStr(searchTerm, 4, 3)
    phoneNumber3 := SubStr(searchTerm, 7, 4)
    pns5436 = file:///%SCR_UserDir%/Documents/AutoHotkey/Lib/TruePeople.html
    openLink = %pns5436% https://www.truepeoplesearch.com/results?phoneno=(%phoneNumber1%)%phoneNumber2%-%phoneNumber3%
    openLinkTab = https://www.truepeoplesearch.com/results?phoneno=(%phoneNumber1%)%phoneNumber2%-%phoneNumber3%
	pnstitle = Phone Number Search 5436
    ;~ if WinExist("TruePeopleSearch"){
        ;~ WinClose, "TruePeopleSearch"
    ;~ }
    fireFoxOpen(openLink)
    WinWait, %pnstitle%, , 2
        if (errorlevel)
			return
	WinActivate
	SysGet, MonitorCount, 80
        if (MonitorCount = 2)
            WinMove, %pnstitle%, , Mon2MidX, 0, Mon2Half_W, Mon2Height
		Else
			WinMove, %pnstitle%, , Mon2MidX, 0, Mon2Half_W, Mon2Height
        Send, ^w
return

SCR_Mouse:
   ;// http://msdn.microsoft.com/en-us/library/windows/desktop/ms646270(v=vs.85).aspx
   VarSetCapacity(MOUSEINPUT, 28, 0)
   NumPut(0, MOUSEINPUT, 0) ;// type = 0 (INPUT_MOUSE)
   
   ;// http://msdn.microsoft.com/en-us/library/windows/desktop/ms646273(v=vs.85).aspx
   NumPut(0, MOUSEINPUT, 4) ;// x = 0
   NumPut(0, MOUSEINPUT, 8) ;// y = 0
   NumPut(0, MOUSEINPUT, 12) ;// mouseData = 0
   NumPut(1, MOUSEINPUT, 16) ;// dwFlags = 1 (MOUSEEVENTF_MOVE)
   NumPut(0, MOUSEINPUT, 20) ;// time = 0
   NumPut(0, MOUSEINPUT, 24) ;// dwExtraInfo = 0
   
   ;// http://msdn.microsoft.com/en-us/library/windows/desktop/ms646310(v=vs.85).aspx
   DllCall("SendInput", "UInt", 1, "UInt", &MOUSEINPUT, "Int", 28 )
return

CommunicatorReTitle:
if (WinExist("Communicator - Mozilla Firefox") OR WinExist("Comm - Mozilla Firefox")){        
    WinActivate
Toggle := !Toggle
WinGetPos, FoundX, FoundY, WinRight, WinBottom, A
    commRenameX := (FoundX + WinRight - 80)
    commRenameY := (FoundY + WinBottom - 995)
MouseClick, L, commRenameX, commRenameY
Sleep, 500
Send, {Delete}
Sleep, 500
SetKeyDelay, 25, 25
    if Toggle
        SendEvent, {Text}Comm
    else
        SendEvent, {Text}Communicator
Sleep, 500
Send, {Enter}
SetKeyDelay, 0, 0 
Sleep, 500
return
}
return

;}
;{ ============================== Windows Key + NumPad ================================

#if WinActive("Bria")
NumpadDiv::
    Send, P
return

NumpadMult::
    Send, #
return
#if

;~ Numpad0 & Numpad1::MsgBox You pressed Numpad1 while holding down Numpad0.
;~ Numpad0 & Numpad2::Run Notepad
NumpadEnter::Send {NumpadEnter} 

MyLabel:
MsgBox % A_ThisHotkey
Return

#NumPad0::
   WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U 
    if (A_PriorHotKey != "#NumPad0" or A_TimeSincePriorHotkey > 200)
        Send, {Blind}^#t
    Else
        Send, {Blind}^#t
    Return
return
    
#NumPad1::
    WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U   
    ;  x: 1913	y: 527	w: 963	h: 520
    if (actWinPosX > 1900)
        WinMove, ahk_id %active_id_winkey%, , %Mon1Left%, %Mon1MidY%, %Mon1Half_W%, %Mon1Half_H%
    Else
        WinMove, ahk_id %active_id_winkey%, , %Mon2Left%, %Mon2MidY%, %Mon2Half_W%, %Mon2Half_H%

return

#NumPad2::
    WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U 
    if (A_PriorHotKey != "#NumPad2" or A_TimeSincePriorHotkey > 200){
        if (actWinPosX > 1900)
            WinMove, ahk_id %active_id_winkey%, , %Mon1Left%, %Mon1MidY%, %Mon1Width%, %Mon1Half_H%  
        Else
            WinMove, ahk_id %active_id_winkey%, , %Mon2Left%, %Mon2MidY%,  %Mon2Width%, %Mon2Half_H%
    }
    else   
        Send, {Blind}{Down}{Down}
    return

#NumPad3::
    ;~ Msgbox, %Mon2MidX% 
    ;~ MsgBox, %Mon2MidY%
    WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U 
    if (actWinPosX > 1900)
        WinMove, ahk_id %active_id_winkey%, , %Mon1MidX%, %Mon1MidY%, %Mon1Half_W%, %Mon1Half_H%
    Else
        WinMove, ahk_id %active_id_winkey%, , %Mon2MidX%, %Mon2MidY%, %Mon2Half_W%, %Mon2Half_H%
return

#NumPad4::
    WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U 
    if (actWinPosX > 1900){
        if (A_PriorHotKey != "#NumPad4" or A_TimeSincePriorHotkey > 200)
            WinMove, ahk_id %active_id_winkey%, , 1975, 110, 850, 840
        else
            Send, {Blind}{Left}
    }
    Else
    {
        if (A_PriorHotKey != "#NumPad4" or A_TimeSincePriorHotkey > 200)
            WinMove, ahk_id %active_id_winkey%, , 55, 110, 850, 840
        else
            Send, {Blind}{Left}
    }
    return

#NumPad5::
    WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U 
    if (actWinPosX > 1900){
    if (A_PriorHotKey != "#NumPad5" or A_TimeSincePriorHotkey > 200)
            WinMove, ahk_id %active_id_winkey%, , 2080, 110, 1600, 840
        Else
            Send, {Blind}{Down}{Up}
    }
    else
    {
        if (A_PriorHotKey != "#NumPad5" or A_TimeSincePriorHotkey > 200)
            WinMove, ahk_id %active_id_winkey%, , 160, 110, 1600, 840
        Else
            Send, {Blind}{left}{up}
    }
    return

#NumPad6::
     WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U 
    if (actWinPosX > 1900){
        if (A_PriorHotKey != "#NumPad6" or A_TimeSincePriorHotkey > 200)
            WinMove, ahk_id %active_id_winkey%, , 2935, 110, 850, 840
        else
            Send, {Blind}{Right}    
    }
    Else
    {
        if (A_PriorHotKey != "#NumPad6" or A_TimeSincePriorHotkey > 200)
            WinMove, ahk_id %active_id_winkey%, , 1015, 110, 850, 840
        else
           Send, {Blind}{Right}
    }
    return

#NumPad7::
    WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U 
    if (actWinPosX > 1900)
        WinMove, ahk_id %active_id_winkey%, , %Mon1Left%, %Mon1Top%, %Mon1Half_W%, %Mon1Half_H%
    Else
        WinMove, ahk_id %active_id_winkey%, , %Mon2Left%, %Mon2Top%, %Mon2Half_W%, %Mon2Half_H%
return

#NumPad8::
    WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U 
    if (A_PriorHotKey != "#NumPad8" or A_TimeSincePriorHotkey > 200){
        if (actWinPosX > 1900)
            WinMove, ahk_id %active_id_winkey%, , %Mon1Left%, %Mon1Top%, %Mon1Width%, %Mon1Half_H% 
        Else
            WinMove, ahk_id %active_id_winkey%, , %Mon2Left%, %Mon2Top%, %Mon2Width%, %Mon2Half_H%
    } 
    Else 
    {
        Send, {Blind}{up}{up}
    }
    return

#NumPad9::
    WinGet, active_id_winkey, ID, A
    WinGetActiveStats, actWinTitle, actWinWidth, actWinHeight, actWinPosX, actWinPosY
    KeyWait, %A_ThisHotkey%, U 
    if (actWinPosX > 1900)
        WinMove, ahk_id %active_id_winkey%, , %Mon1MidX%, %Mon1Top%, %Mon1Half_W%, %Mon1Half_H%
    Else
        WinMove, ahk_id %active_id_winkey%, , %Mon2MidX%, %Mon2Top%, %Mon2Half_W%, %Mon2Half_H%
return
;}
;{=============================== Toggglekeys and CaseMenu ============================

CapsLock::
keywait, Capslock, T0.3
if (ErrorLevel){
    ^CapsLock::
    caseMenu.show()
    return
    }
return

return
+~CapsLock::
~NumLock::
~ScrollLock::
;~ ~Insert::
    Toast.show( {title:{text:strRemove(A_ThisHotkey,["~","+"]) (GetKeyState(strRemove(A_ThisHotkey,["~","+"]),"T")? " On":" Off")}, sound:True})
return
;}
;{=============================== Hotstrings ==========================================
!Hotstrings:
return

;}
;{=============================== Sample Scripts ======================================


NumpadEnter & Numpad7::
    WinActivate, Bria, 
    WinGetPos, FoundX, FoundY, WinRight, WinBottom, Bria
    briaNumpadX := (FoundX+WinRight-290)
    briaNumpadY := (FoundY+WinBottom-50)
    MouseClick, L, briaNumpadX, briaNumpadY  
return

NumpadEnter & Numpad8::
    WinActivate, Bria, 
    WinGetPos, FoundX, FoundY, WinRight, WinBottom, Bria
    briaNumpadX := (FoundX+WinRight-235)
    briaNumpadY := (FoundY+WinBottom-50)
    MouseClick, L, briaNumpadX, briaNumpadY  
return

NumpadEnter & Numpad9::
    WinActivate, Bria, 
    WinGetPos, FoundX, FoundY, WinRight, WinBottom, Bria
    briaNumpadX := (FoundX+WinRight-170)
    briaNumpadY := (FoundY+WinBottom-50)
    MouseClick, L, briaNumpadX, briaNumpadY  
return

NumpadEnter & NumpadAdd::
    WinActivate, Bria, 
    WinGetPos, FoundX, FoundY, WinRight, WinBottom, Bria
    briaHistoryX := (FoundX+WinRight-110)
    briaHistoryY := (FoundY+WinBottom-50)
    MouseClick, L, briaHistoryX, briaHistoryY 
return

NumpadEnter & NumpadDiv::
    WinActivate, Bria, 
    WinGetPos, FoundX, FoundY, WinRight, WinBottom, Bria
    briaHistoryX := (FoundX+WinRight-110)
    briaHistoryY := (FoundY+WinBottom-50)
    MouseClick, L, briaHistoryX, briaHistoryY 
return

NumpadEnter & NumpadMult::
    Send, ^c
return

NumpadEnter & NumpadSub::
    Send, ^v
return

;~ NumpadEnter & NumpadAdd::
    ;~ Send, ^a
;~ return





     
