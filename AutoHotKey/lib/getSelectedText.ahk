Clip(Text="", Reselect="")
{
	Static BackUpClip, Stored, LastClip
	If (A_ThisLabel = A_ThisFunc) {
		If (Clipboard == LastClip)
			Clipboard := BackUpClip
		BackUpClip := LastClip := Stored := ""
	} Else {
		If !Stored {
			Stored := True
			BackUpClip := ClipboardAll ; ClipboardAll must be on its own line
		} Else
			SetTimer, %A_ThisFunc%, Off
		LongCopy := A_TickCount, Clipboard := "", LongCopy -= A_TickCount ; LongCopy gauges the amount of time it takes to empty the clipboard which can predict how long the subsequent clipwait will need
		If (Text = "") {
			SendInput, ^c
			ClipWait, LongCopy ? 0.6 : 0.2, True
		} Else {
			Clipboard := LastClip := Text
			ClipWait, 10
			SendInput, ^v
		}
		SetTimer, %A_ThisFunc%, -700
		Sleep 20 ; Short sleep in case Clip() is followed by more keystrokes such as {Enter}
		If (Text = "")
			Return LastClip := Clipboard
		Else If ReSelect and ((ReSelect = True) or (StrLen(Text) < 3000))
			SendInput, % "{Shift Down}{Left " StrLen(StrReplace(Text, "`r")) "}{Shift Up}"
	}
	return
	Clip:
	return Clip()
}

getSelectedText()
{
 /* Returns selected text without disrupting the clipboard. However, if the clipboard contains a large amount of data, some of it may be lost
 */
    clipOld:=ClipboardAll
    Clipboard:=""
    Send, ^c
    ClipWait, 0.1, 1
    clipNew:=Clipboard
    Clipboard:=clipOld

    ;Special for explorer
    WinGet, w, ID, A
    WinGetClass, c, ahk_id %w%
    if c in Progman,WorkerW,Explorer,CabinetWClass
        SplitPath, clipNew,,,, clipNew2

    return clipNew2?clipNew2:clipNew
}

