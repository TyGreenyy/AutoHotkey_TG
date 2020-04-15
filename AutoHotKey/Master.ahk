; =====================================================================================
; AHK Version ...: AHK 1.1.32.00 (Unicode 64-bit) - September 13, 2015
; Platform ......: Windows 10
; Language ......: English (en-US)
; Author ........: TyGreeny
; =====================================================================================
SetWorkingDir %A_ScriptDir%\AutoHotkey\
Suspend On
#include %A_MyDocuments%\AutoHotkey\						;Sets dir for includes
#include Directives.ahk

#include <Toast>
#include <DelayedTimer>
#include <MouseExtras>
#include <QuickLinks>
#include <URI_Encode>
; #include <VA>
;~ #include windowInfos.ahk
;~ #include <Acc>
;~ #include <Anchor>
;~ #include <iWB2>
;~ #include <JEE>
;~ #include <numpad>

#include hotcorners.ahk 									; Refactor as a class
delayedTimer.set("hotcorners", 100)

delayedTimer.set("SCR_lockedDesktopOn", 500)

delayedTimer.set(Func("formatDriveClose").bind(100), 100)

delayedTimer.set(Func("numpadFunctions").bind(100), 100)

#include Togglekeys.ahk
DelayedTimer.set(Func("CapsLockOffTimer").bind(30000), 1000)
caseMenu.__new()

;~ delayedTimer.set("googlewtfClose", 100)

#include Tray.ahk
trayMenu()

;{ ============================== TextEditGroup =======================================
GroupAdd, TextEditGroup, ahk_exe WINWORD.EXEord.exe
GroupAdd, TextEditGroup, ahk_exe notepad.exe
GroupAdd, TextEditGroup, ahk_exe SciTE.exe
GroupAdd, TextEditGroup, ahk_exe soffice.bin
GroupAdd, TextEditGroup, ahk_exe hh.exe
GroupAdd, TextEditGroup, ahk_exe firefox.exe
GroupAdd, TextEditGroup, ahk_exe sublime_text.exe
GroupAdd, TextEditGroup, ahk_exe WinSCP.exe
;}
;{ ============================== TriviaGroup =========================================
GroupAdd, TriviaGroup, #tg-gambling - Discord
GroupAdd, TriviaGroup, #trivia - Discord
;}
;{=============================== PIPWindowGroup ======================================
GroupAdd, PIPWindowGroup, ahk_class MozillaWindowClass
GroupAdd, PIPWindowGroup, ahk_class MozillaDialogClass
GroupAdd, PIPWindowGroup, ahk_class MozillaDialogClass
;}
;{=============================== ResizeWindowGroup ===================================
GroupAdd, ResizeWindowGroup, ahk_exe AutoHotkey.exe
;}
;=============================== End Groups ===========================================

delayedTimer.start()
delayedTimer.firstRun()

Toast.show("Script Loaded")
suspend Off

;============================== End of auto-execute ===================================
#include keyRemap.ahk 
#include hotKeys.ahk

return

return

