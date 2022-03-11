﻿#If Vim.IsVimGroup() && !WinActive("ahk_class TPlanDlg") && WinActive("ahk_class TElWind") && !IsSMEditingText()
; in Plan window pressing enter simply goes to the next field; no need to go back to normal
; in element window pressing enter to learn goes to normal
~enter::
#If Vim.IsVimGroup() && WinActive("ahk_class TElWind") && !IsSMEditingText()
~space:: ; for Learn button
#If Vim.IsVimGroup() and WinActive("ahk_class TElWind") ; SuperMemo element window
~^p:: ; open Plan window
~f4:: ; open tasklist
#If Vim.IsVimGroup() and WinActive("ahk_class TPlanDlg") ; SuperMemo Plan window
~^s:: ; save
~^+a:: ; archive current plan
	Vim.State.SetNormal()
return