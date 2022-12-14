#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
#Persistent
#SingleInstance, force
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
; Ensures CapsLock is alwaysoff, this means its just a hotkey
SetCapsLockState, AlwaysOff
DetectHiddenWindows, On
toggle:=0

SwitchToWindowsTerminal() {
  windowHandleId := WinExist("ahk_exe WindowsTerminal.exe")
  windowExistsAlready := windowHandleId > 0

  ; If the Windows Terminal is already open, determine if we should put it in focus or minimize it.
  if (windowExistsAlready) {
    activeWindowHandleId := WinExist("A")
    windowIsAlreadyActive := activeWindowHandleId == windowHandleId

    if (windowIsAlreadyActive) {
      WinMinimize, "ahk_id %windowHandleId%"
    }
    else {
      WinShow, "ahk_id %windowHandleId%"
      ; Put the window in focus.
      WinActivate, "ahk_id %windowHandleId%"
    }
  }
  ; Else it's not already open, so launch it.
  else {
    Run, "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.15.3466.0_x64__8wekyb3d8bbwe\wt.exe"
  }
}

#IfWinActive ahk_class Photoshop
  MButton::
    Send {Space Down}{LButton Down}
    Keywait, MButton
    Send {LButton Up}{Space Up}
  Return
#IfWinActive

#IfWinActive, ahk_exe msedge.exe
  ^+p::^+Space
  RShift & s::Send ^e
  ; Search in top of window
  RShift & t::^a ; Open tabs dropdown
  SC15D & Right::^PgDn
  SC15D & Left::^PgUp
#IfWinActive

; Cool shortcut to get back to vim from
; SumatraPDF :)
#IfWinActive, ahk_exe SumatraPDF.exe
b::SwitchToWindowsTerminal()
Space::SwitchToWindowsTerminal()
#IfWinActive

; Cool shortcut for j k when alt-tabbing
LWin & j::ShiftAltTab
LWin & k::AltTab

; Maximize windows, AutoHotkeyism A is the active window
LWin & Up::WinMaximize, A

; Cool windows shortcuts
#]::#t
#[::#+t
#s::Send #+s
CapsLock::Send #{vkC0sc029}
; Hotkey to use windows key + w to launch/restore the Windows Terminal.
#w::SwitchToWindowsTerminal()
F5::KeyHistory

^+c::
  Send, ^c
  Sleep, 10
  run www.duckduckgo.com/?q=%Clipboard%
return

RShift & e::
Send {RShift up}
Send {Esc}
Send {RShift up}
return

; Shorcut to close a window
RShift & c::!F4

; Shortcut for autocomplete powershell
RShift & a::
Send {RShift up}
Send {Right}
Send {RShift up}
return

; Shortcut for clearing the terminal
RShift & l::
Send {RShift up}
Send ^l
Send {RShift up}
return

; Shortcut to minimize and restore active window
#Down::
  if (toggle:=!toggle)
    WinMinimize, % "ahk_id " _hwnd := WinExist("A")
  else
    WinRestore, % "ahk_id " _hwnd
return

RAlt::^Space
SC15D::^Space
;corresponds to the key next to left arrow *shrug*
;Cool ideas #H for voice to text
#NoTrayIcon
