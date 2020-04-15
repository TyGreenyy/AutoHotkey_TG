QuickPrompt(){
	do = n
	ControlGetFocus, ctl, A
	IfWinActive, ahk_class CabinetWClass,, IfEqual, ctl, Edit1, setenv, do, y
	IfWinActive, ahk_class ExploreWClass,, IfEqual, ctl, Edit1, setenv, do, y
	IfEqual, do, n, return
	
	WinGetActiveTitle, pth
    Hotkey, Enter, Prompt
	Hotkey, Enter, On
}

Prompt(){
	Hotkey, Enter, Off
	do = n
	ControlGetFocus, ctl, A
	IfWinActive, ahk_class CabinetWClass,, IfEqual, ctl, Edit1, setenv, do, y
	IfWinActive, ahk_class ExploreWClass,, IfEqual, ctl, Edit1, setenv, do, y
	IfEqual, do, n
	{
		Send, {Enter}
		return
	}
	ControlGetText, cmd, Edit1, A
	StringLeft, check, cmd, 2
	IfEqual, check, //
	{
		StringTrimLeft, cmd, cmd, 2
		run, %comspec% /k %cmd%, %pth%
	}
	
	IfNotEqual, check, //
	{
		StringTrimLeft, cmd, cmd, 1
		run, %comspec% /c %cmd%, %pth%, hide
	}
	ControlSetText, Edit1, %pth%, %pth%
}