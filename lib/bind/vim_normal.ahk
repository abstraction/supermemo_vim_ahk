﻿#if (Vim.IsVimGroup() && Vim.State.IsCurrentVimMode("Vim_Normal") && !Vim.State.g)
; Undo/Redo
u::Send,^z
^r::Send,^y

; Combine lines
+j:: send {End}{Space}{Delete}
+k:: send {up}{End}{Space}{Delete}

; Change case
~::
  send +{right}
  selection := Copy()
  if selection is lower
    StringUpper, selection, selection
  else if selection is upper
    StringLower, selection, selection
  send % "{text}" . selection
return

+z::Vim.State.SetMode("Z")
#if (Vim.IsVimGroup() && Vim.State.IsCurrentVimMode("Z"))
+z::
  send ^s
  send !{F4}
  Vim.State.SetMode("Vim_Normal")
Return

+q::
  send !{F4}
  Vim.State.SetMode("Vim_Normal")
Return

; #if Vim.IsVimGroup() and (Vim.State.IsCurrentVimMode("Vim_Normal"))
; Space::send {Right}

; period
; .::send +^{Right}{BS}^v

#if Vim.IsVimGroup() and (Vim.State.IsCurrentVimMode("Vim_Normal") || Vim.State.StrIsInCurrentVimMode("Visual"))
^e::Vim.Move.Repeat("^e")
^y::Vim.Move.Repeat("^y")

; Q-dir
#if Vim.IsVimGroup() and WinActive("ahk_group VimQdir") and (Vim.State.Mode == "Vim_Normal")
; For Q-dir, ^X mapping does not work, use !X instead.
; ^X does not work to be sent, too, use Down/Up
; switch to left top (1), right top (2), left bottom (3), right bottom (4)
!u::send {LControl Down}{1 Down}{1 Up}{LControl Up}
!i::send {LControl Down}{2 Down}{2 Up}{LControl Up}
!j::send {LControl Down}{3 Down}{3 Up}{LControl Up}
!k::send {LControl Down}{4 Down}{4 Up}{LControl Up}
; Ctrl+q, menu Quick-links
'::send {LControl Down}{q Down}{q Up}{LControl Up}
; Keep the e key in Normal mode, use the right button and then press the refresh (e) function, do nothing, return to the e key directly
~e::
Return

#if
