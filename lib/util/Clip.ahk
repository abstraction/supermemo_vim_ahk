#Requires AutoHotkey v1.1.1+  ; so that the editor would recognise this script as AHK V1
; Clip() - Send and Retrieve Text Using the Clipboard
; Originally by berban - updated February 18, 2019 - modified by Winston
; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=62156
Clip(Text:="", Reselect:=false, RestoreClip:=true, HTML:=false, Method:=0, KeysToSend:="") {
  global WinClip, Vim
  if (RestoreClip)
    ClipSaved := ClipboardAll
  If (Text = "") {
    LongCopy := A_TickCount, WinClip.Clear(), LongCopy -= A_TickCount  ; LongCopy gauges the amount of time it takes to empty the clipboard which can predict how long the subsequent ClipWait will need
    ReleaseModifierKeys()
    send % KeysToSend ? KeysToSend : (Method ? "^{Ins}" : "^c")
    ClipWait, LongCopy ? 0.6 : 0.2, True
    if (!ErrorLevel) {
      if (HTML) {
        Vim.HTML.ClipboardGet_HTML(clipped)
        RegExMatch(clipped, "s)<!--StartFragment-->\K.*(?=<!--EndFragment-->)", clipped)
      } else {
        Clipped := Clipboard
      }
    }
  } Else {
    if (HTML && (HTML != "sm")) {
      Vim.HTML.SetClipboardHTML(text)
    } else {
      WinClip.Clear()
      Clipboard := Text
      ClipWait
    }
    ReleaseModifierKeys()
    send % KeysToSend ? KeysToSend : (Method ? "+{Ins}" : "^v")
    while (WinClipAPI.GetOpenClipboardWindow())
      sleep 1
    ; Sleep 20  ; Short sleep in case Clip() is followed by more keystrokes such as {Enter}
  }
  If (Text && (Reselect || (HTML = "sm"))) {
    StrLen := StrLen(Vim.ParseLineBreaks(text))
    if ((HTML = "sm") && (IfContains(text, "<p")))
      StrLen++
    send % "+{Left " . StrLen . "}"
  }
  if (text && (html = "sm"))
    send ^+1
  if (RestoreClip)  ; for scripts that restore clipboard at the end
    Clipboard := ClipSaved
  If (Text = "")
    Return Clipped
}

copy(RestoreClip:=true, HTML:=false, CopyMethod:=0, KeysToSend:="") {
  return clip(,, RestoreClip, HTML, CopyMethod, KeysToSend)
}
