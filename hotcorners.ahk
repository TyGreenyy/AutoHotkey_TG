hotcorners(){
	ListLines, Off 
	CoordMode, Mouse, Screen
	static counter:=0, trigger:=False 
	counterTemp:=0
	hotcornersdelay:=1      		;Hotcorners Delay setting 
	toprightdelay:=8       		 	;Hotcorners TopRight Delay setting
	topcenterdelay:=6   			;Hotcorners TopCenter Delay setting
	bottomleftdelay:=6				;Hotcorners TopCenter Delay setting
	rightsidedelay:=3				;Hotcorners TopCenter Delay setting
	MouseGetPos, xpos, ypos
	buttonsPressed:= GetKeyState("LButton") OR GetKeyState("RButton")
	 ; tooltip, % "X:" xpos "+" A_ScreenWidth-xpos "=" A_ScreenWidth "`nY:"  ypos "+" A_ScreenHeight-ypos "=" A_ScreenHeight "`nTrigger=" trigger "`nCounter=" counter "`n" SCR_UserDir
	 ;~ tooltip, % ClipContent - InputTempValue - OutputTemp - 
	
	; Edges not containing trigger:=True will fire contineously. Counter can be used to controll the frequency of firing. Corners must always contain trigger:=True. Otherwise, edge to corner transitions will fire the corresponding edge.
	
	/* How to use counter:
		counterTemp:=counter+1
		if (counterTemp>hotcornersdelay){
			DO THIS
			counterTemp:=0
		}
	*/

	
	;~ if DllCall("User32\OpenInputDesktop","int",0*0,"int",0*0,"int",0x0001L*1){
	if (xpos<2) {
		if (ypos<2){
			if (!trigger){
				;~ trigger:=True
				if(!buttonsPressed){
					; 										Top Left
					counterTemp:=counter+1
					
					;---------------------------------------------------------
				}
				;---------------------------------------------------------
			}
		}
		else if (ypos+2>=A_ScreenHeight){
			if (!trigger){
				;~ trigger:=True
				if(!buttonsPressed){
					; 										Bottom Left
					counterTemp:=counter+1
					if (counterTemp>=bottomleftdelay){
						Send, #x
						counterTemp:=0
					}
					;---------------------------------------------------------
				}
			}
		}
		else {
			if (!trigger){
				;~ trigger:=True
				if(!buttonsPressed){
					;											Left
					counterTemp:=counter+1
					if (counterTemp>=hotcornersdelay){
						Send, #^{Left}
						counterTemp:=0
						trigger:=True
					}
					;---------------------------------------------------------
				}
			}
		}
	}
	else if (xpos+2>=A_ScreenWidth) {
		if (1970>xpos && xpos>1850 || xpos>3790){
			if (ypos<2) {
				if (!trigger){
					;~  trigger:=True
					if(!buttonsPressed){
					; 										Top Right
					counterTemp:=counter+1
					if !(A_UserName = "TG-PC")
					Return
					if (counterTemp>=toprightdelay){
						if !WinExist("A_UserName"){
							hcusername := A_UserName
							Run, %SCR_UserDir%
							WinWait, ahk_class CabinetWClass, %hcusername%, 1,,
							WinMove, ahk_class CabinetWClass, %hcusername%, 55, 110, 850, 840
							if !WinExist("Downloads"){
								Run, %SCR_UserDir%\Downloads
								WinWait, ahk_class CabinetWClass, Downloads, 1,,
								WinMove, ahk_class CabinetWClass, Downloads,  1005, 110, 850, 840
							}
						}
					}
					;---------------------------------------------------------
				}
				}
				lastYedge:="Top"
			}
		}
		else if (ypos+2>=A_ScreenHeight){
			if (!trigger){
				trigger:=True
				if(!buttonsPressed){
					; 										Bottom Right
					send, #a
					}
					;---------------------------------------------------------
			}
		}
		else {
			lastcorner:="None"
			if (!trigger){
				;~ trigger:=True
				if(!buttonsPressed){
					; 											Right
					counterTemp:=counter+1
					if (counterTemp>rightsidedelay){
						Send, #^{Right}
						counterTemp:=0
						trigger:=True
					}
					;---------------------------------------------------------
				}
			}
		}
		lastXedge:="Right"
	}
	else if (ypos<2){  
		if (1820>xpos && xpos>100){
			;~ ListLines, on
			if (!trigger){
				;~ trigger:=True
				if(!buttonsPressed){
					;												Top
					counterTemp:=counter+1
					if !(A_UserName = "TG-PC")
						Return
					if (counterTemp>topcenterdelay){
						if !WinActive("Firefox"){
							if !WinActive("Chrome"){
							Send, #d
							counterTemp:=0
							trigger:=True
							}
						}
					}
					;-------------------------------------------------------------
				}
			}
		}
	}
	else if (ypos+2>=A_ScreenHeight){
		if (!trigger){
			; trigger:=True
			if(!buttonsPressed){
				; 												Bottom
				counterTemp:=counter+1
				if (counterTemp>hotcornersdelay){
				 		;~ send, #{Tab}
					trigger:=True
					counterTemp:=0
				}
				;-------------------------------------------------------------
			}
		}
	}
	else trigger:=False
		counter:=counterTemp
;~ }
}
ListLines, On
