MouseExtras(HoldSub, HoldTime="*", DoubleSub="*", DClickTime="*", Button=""){
	ListLines, Off
	DClickTime2 := Round( DllCall("GetDoubleClickTime")/5000, 2 )
	If Button =
		 Button := A_ThisHotkey
	Button := LTrim(Button, "~*$")
	If InStr(Button, "&")
		Button := RegExReplace(Button, "^.*&( +)?")
	MouseGetPos, xpos
	if !WinActive("Firefox")
	Loop
	{
		MouseGetPos, xposn
		If (A_TimeSinceThisHotkey > HoldTime)
		{
			If IsLabel(HoldSub)
			{
				ListLines, On
				GoSub, %HoldSub%
			}
			Else
			{
				Send {%Button% Down}
				KeyWait, %Button%
				Send {%Button% Up}
			}

			return
		}
		Else If !GetKeyState(Button, "P")
		{
			If !IsLabel(DoubleSub)
			{
				Send {%Button%}
				return
			}
			KeyWait, %Button%, T%DClickTime%, D
				If (ErrorLevel = 1) AND (A_PriorKey = "RButton")
					Send {%Button%}
			Else
			{
			If IsLabel(DoubleSub) AND (A_PriorKey = "RButton")
				GoSub, %DoubleSub%
			Else
				continue
				;~ Send {%Button%}
			}
			return
		}
		
	}  
Send {%Button% Down}
KeyWait, %Button%
Send {%Button% Up}
ListLines, On	
return
}

isOver_mouse(WinTitle:="A"){ ;If ahk_id is passed, dont use ahk_id prefix or any other options
    Listlines, Off
    MouseGetPos, , , Win
    if WinTitle is number
        return (win==WinTitle)
    else return WinExist(WinTitle " ahk_id " Win)
    ListLines, On
}

isOver_coord(win,pos){
    CoordMode, Mouse, Screen        ;Mouse co-ords are specified in global co-ords
    WinGetPos, x, y, w, h, % win
    msgbox, %x%, %y%, %w%, %h%
    msgbox, % mpos[1] "|" mpos[2]
    if ((pos[1]>=x) and (pos[1]<=x+w) and (pos[2]>=y) and (pos[2]<=y+h))
        return True
    return false
}

;~ ; Create the Hotkeys with the function and select labels and wait times.

;~ *RButton::
;~ MouseExtras("RHoldMsg", "400", "RDoubleMsg", "0.1")
;~ return

;~ *MButton::
;~ MouseExtras("MHoldMsg", "500", "MDoubleMsg", "0.1")
;~ return

;~ ~LButton & RButton::
;~ MouseExtras("LRHoldMsg", "500", "LRDoubleMsg", "0.5")
;~ return


;~ ; You can create your own labels and put the functions you want.
;~ return
;~ RHoldMsg:
;~ ToolTip,  Right Button Hold!
;~ return

;~ RDoubleMsg:
;~ ToolTip, Right Button Double Click!
;~ return

;~ MHoldMsg:
;~ ToolTip, Middle Button Hold!
;~ return

;~ MDoubleMsg:
;~ ToolTip, Middle Button Double Click!
;~ return

;~ LRHoldMsg:
;~ ToolTip, Left & Right Hold!
;~ return

;~ LRDoubleMsg:
;~ ToolTip, Left & Right Double Click!
;~ return


; MouseExtras
; Author: Pulover [Rodolfo U. Batista]
; rodolfoub@gmail.com

/*
- Allows to use subroutines for Holding and Double Clicking a Mouse Button.
- Keeps One-Click and Drag functions.
- Works with combinations, i.e. LButton & RButton.

Usage:
Assign the function to the Mouse Hotkey and input the Labels to
trigger with GoSub and wait times in the parameters:

MouseExtras("HoldSub", "DoubleSub", "HoldTime", "DClickTime", "Button")
  HoldSub: Button Hold Label.
  HoldTime: Wait Time to Hold Button (miliseconds - optional).
  DoubleSub: Double Click Label.
  DClickTime: Wait Time for Double Click (seconds - optional).
  Button: Choose a different Button (optional - may be useful for combinations).

- If you don't want to use a certain function put "" in the label.
- I recommend using the "*" prefix to allow them to work with modifiers.
- Note: Althought it's designed for MouseButtons it will work with Keyboard as well.
*/
