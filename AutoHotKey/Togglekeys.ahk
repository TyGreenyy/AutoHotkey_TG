CapsLockOffTimer(t:=60000){
    ListLines, Off
    if (A_TimeIdleKeyboard>t) AND GetKeyState("CapsLock","T") {
        SetCapsLockState,Off
        Toast.show("CapsLock Turned Off")
        return True
    }
    return False
}

class caseMenu{
    __new(){
        ListLines, Off
        for _, j in [["U","&UPPER CASE"],["L","&lower case"],["T","&Title Case"],["S","&Sentence case."],["I","&iNVERT cASE"]] {
            act:=ObjBindMethod(this,"caseChange",j[1])
            Menu, caseMenu, Add, % j[2], % act
        }
        ListLines, On
        Menu, caseMenu, Add

        for _, i in ["&Capslock","&Numlock","Sc&rollLock","I&nsert"] {
            act:=ObjBindMethod(this,"toggle",strReplace(i,"&"))
            Menu, caseMenu, Add, % i, % act
        }
        ListLines, On
        Menu, caseMenu, Add

        for _, j in [["ph","&Phone Format"],["php","&Phone w/ Parenth"],["fi","File &Rename"],["aq","Add Quotes"],["dq","Discord Quote"],["sms","SMS Split 160"],["tc","Temp Convert"],["rf","Remove Format"]] {
        act:=ObjBindMethod(this,"textFormat",j[1])
        Menu, caseMenu, Add, % j[2], % act
    }
        return
    }
    show(){
        for _, i in ["&Numlock","Sc&rollLock","I&nsert"]
            ;~ Toast.show("caseMenu")
        ; sleep, 500
        for _, i in ["&Numlock","Sc&rollLock","I&nsert"]
            Menu, caseMenu, % GetKeyState(strReplace(i,"&"),"T")?"Check":"Uncheck", % i
        Menu, caseMenu, show
        return
    }

    caseChange(type){ ; type: U=UPPER, L=Lower, T=Title, S=Sentence, I=Invert
        text:=caseChange(getSelectedText(), type)
        oldClip:=ClipboardAll
        clipboard:=text
        Send ^v
        sleep 100
        Clipboard:=oldClip
        return
    }

    toggle(key){
        if key=Insert
            Send, {Insert}
        else if key=Capslock
            SetCapsLockState, % GetKeyState("CapsLock","T")?"Off":"On"
        else if key=Numlock
            SetNumLockState, % GetKeyState("NumLock","T")?"Off":"On"
        else if key=Scrolllock
            SetScrollLockState, % GetKeyState("ScrollLock","T")?"Off":"On"
        return
    }

    textFormat(type){
        if type=ph
            phoneFormat() 
        else if type=php
            phoneFormatPara()   
        else if type=fi
            fileRename()
        else if type=sms 
            smsSplit()
        else if type=tc
            tempConvert()
        else if type=rf
            removeFormating()       
        else if type=aq
            addQuotes()
        else if type=dq
            discordQuote()
        
        return
    }

}

Togglekeys_check(){
    return {c:getkeyState("Capslock","T"), n:getkeyState("Numlock","T"), s:getkeyState("ScrollLock","T"), i:getkeyState("Insert","T")}
}

strRemove(parent,strlist) {
    for _,str in strlist
        parent:=strReplace(parent,str)
    return parent
}

caseChange(text,type){ ; type: U=UPPER, L=Lower, T=Title, S=Sentence, I=Invert
    static X:= ["iOS","iPhone","iPad","I","AHK","AutoHotkey","Dr","Mr","Ms","Mrs","BK","DEA","AKJ","via","v","vs","GPG","PGP","to","of","and","on","with","USB" ] 
    ;~ list of words that should not be modified for S,T
    if (type="S") { ;Sentence case.
        text := RegExReplace(RegExReplace(text, "(.*)", "$L{1}"), "(?<=[^a-zA-Z0-9_-]\s|\n).|^.", "$U{0}")
    } else if (type="I") ;iNVERSE
        text:=RegExReplace(text, "([A-Z])|([a-z])", "$L1$U2")
    else text:=RegExReplace(text, "(.*)", "$" type "{1}")

    if (type="S" OR type="T")
        for _, word in X ;Parse the exceptions
            text:= RegExReplace(text,"i)\b" word "\b", word)
    return text
}

discordQuote(){
    quoteTerm := Clip()
    Clip("> " quoteTerm)
}

; Attention:  Strips formatting from the clipboard too!
addQuotes(){
    quoteTerm := Clip()
    quoteTerm = "%quoteTerm%"
    Clip(quoteTerm)
}

 removeFormating(){
    clipUnformat:= Clip()
    clipUnformat = %clipUnformat%
    Clip(clipUnformat)
}

;~ phoneFormat(){
    ;~ formatString := Clip()
        ;~ formatString := RegExReplace(formatString, "[^0-9]", "")
        ;~ formatString = %formatString%
        ;~ phoneNumber1 := SubStr(formatString, 1, 3)
        ;~ phoneNumber2 := SubStr(formatString, 4, 3)
        ;~ phoneNumber3 := SubStr(formatString, 7, 4)
        ;~ phoneNumber4 := SubStr(formatString, 10)
        ;~ formatString = %phoneNumber1%-%phoneNumber2%-%phoneNumber3%
    ;~ Clip(formatString, true)
    ;~ return
;~ }
phoneFormat(){
    formatString := Clip()
        formatString := RegExReplace(formatString, "^.*(\d{3})[^\d]*(\d{3})[^\d]*(\d{4})$", "$1-$2-$3", 1)
    Clip(formatString, true)
    return
}

phoneFormatPara(){
    formatString := Clip()
        formatString := RegExReplace(formatString, "^.*(\d{3})[^\d]*(\d{3})[^\d]*(\d{4})$", "($1) $2-$3", 1)
    Clip(formatString, true)
    return
}

fileRename(){
    if (A_UserName = "TG-PC")
        ControlSend, DirectUIHWND3, {F2}, ahk_class CabinetWClass
    else
        Send, {F2}
    fileRenameOrg := Clip()
        fileRenameOrg := StrReplace(fileRenameOrg, "-", " ")
        fileRenameOrg := StrReplace(fileRenameOrg, "_", " ")
        fileRenameOrg := StrReplace(fileRenameOrg, "#", " ")
        fileRenameOrg := caseChange(fileRenameOrg, "T")
        fileRenameOrg := RegExReplace(fileRenameOrg, "\S\s\K\s+(?=\S)")
        fileRenameOrg := RegExReplace(fileRenameOrg, "[\?<>/\\\*""\,\?|:]", "")
        fileRenameOrg = %fileRenameOrg%
        fileRenameOrg := StrReplace(fileRenameOrg, A_Space, "_")
    Clip(fileRenameOrg, true)
    ;~ ControlSend, DirectUIHWND3, {Tab}, ahk_class CabinetWClass
    return
}

smsSplit(){
    smsSplit := Clip()
    loop { 
        if (StrLen(smsSplit) < 160)
            break  
        if ( substr(smsSplit, currChar := 160-A_Index, 1) = " " )
            break
    }
    smsSplit1 := substr(smsSplit, 1, currChar-1 )
    smsSplit2 := substr(smsSplit, currChar+1)

    loop {  
        if (StrLen(smsSplit2) < 160)
            break
        if ( substr(smsSplit2, currChar := 160-A_Index, 1) = " " )
            break
    }
    smsSplit3 := substr(smsSplit2, 1, currChar-1 )
    smsSplit4 := substr(smsSplit2, currChar+1)

    loop {   
        if (StrLen(smsSplit4) < 160)
            break
        if ( substr(smsSplit4, currChar := 160-A_Index, 1) = " " )
            break
    }
    smsSplit5 := substr(smsSplit4, 1, currChar-1 )
    smsSplit6 := substr(smsSplit4, currChar+1)

    loop { 
        if (StrLen(smsSplit6) < 160)
            break
        if ( substr(smsSplit6, currChar := 160-A_Index, 1) = " " )
            break
    }
    smsSplit7 := substr(smsSplit6, 1, currChar-1 )
    smsSplit8 := substr(smsSplit6, currChar+1)

    ;~ MsgBox % smsSplit1 "`n" smsSplit3 "`n" smsSplit5 "`n" smsSplit7
    Clip(smsSplit1 "`r`r" smsSplit3 "`r`r" smsSplit5 "`r`r" smsSplit7)
    return
}
