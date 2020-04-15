
numpadFunctions(){
Loop, 10
  {
   Key:=SubStr(A_Index,0) ; so it grabs zero not 10
   HotKey, NumPad%key%, MyLabel
  }
Return
}

MyLabel:
MsgBox % A_ThisHotkey
Return