; =====================================================================================

; AHK Version ...: AHK 1.1.32.00 (Unicode 64-bit) - September 13, 2015
; Platform ......: Windows 10
; Language ......: English (en-US)
; Author ........: TyGreeny
; =====================================================================================

IfNotExist, %SCR_UserDir%\QuickLinks\
FileCreateDir, %SCR_UserDir%\QuickLinks\

;~ Loop, C:\Users\%A_UserName%\QuickLinks\*.*, 1 , 0 
Loop, Files, %SCR_UserDir%\QuickLinks\*.*, D
{
	SplitPath, A_LoopFileName,, , ,Shortcut_Name,
	Shortcut_Name:=Shortcut_Name

	Menu, Tray, Add, %Shortcut_Name%, MenuHandler

	MainMenu := Shortcut_Name
	CountLoop := 0
	Loop, Files, %A_LoopFileFullPath%\*.*, D F
	{
		if A_LoopFileAttrib contains H,R,S  ;Skip any file that is 
		continue        ; H, R, or S (System).

		SplitPath, A_LoopFileName,, , ,Shortcut_Name,
		Shortcut_Name:=Shortcut_Name

		Menu, %MainMenu%, Add, %Shortcut_Name%, MenuHandler
		CountLoop := 1


	}
	If (CountLoop = 1)
	{
		;      Msgbox, Index %a_index% Error Level %ErrorLevel%
		Menu, Tray, Add, %MainMenu%, :%MainMenu%
	}
	Else
	{
		;     Msgbox, Index %a_index% Error Level %ErrorLevel%
		Menu, Tray, Add, %MainMenu%, ProgramHandler
	}
}


Loop, Files, %SCR_UserDir%\QuickLinks\*.*, F
{

	SplitPath, A_LoopFileName,, , ,Shortcut_Name,
	Shortcut_Name:=Shortcut_Name

	Menu, Tray, Add, %Shortcut_Name%, MenuHandler

	MainMenu := Shortcut_Name
	CountLoop := 0
	Loop, Files, %A_LoopFileFullPath%\*.*, 
	{
		if A_LoopFileAttrib contains H,R,S  ;Skip any file that is 
		continue        ; H, R, or S (System).

		SplitPath, A_LoopFileName,, , ,Shortcut_Name,
		Shortcut_Name:=Shortcut_Name

		Menu, %MainMenu%, Add, %Shortcut_Name%, MenuHandler
		CountLoop := 1


	}
	If (CountLoop = 1)
	{
		;      Msgbox, Index %a_index% Error Level %ErrorLevel%
		Menu, Tray, Add, %MainMenu%, :%MainMenu%
	}
	Else
	{
		;     Msgbox, Index %a_index% Error Level %ErrorLevel%
		Menu, Tray, Add, %MainMenu%, ProgramHandler
	}
}
ListLines, ON
quicklinksDINI := SCR_UserDir "\QuickLinks\desktop.ini"
if FileExist(quicklinksDINI)
	Menu, Tray, Delete, desktop 
Menu, Tray, NoStandard
Menu, Tray, Standard
