#Requires AutoHotkey v2.0
; this script helps switching windows by using windows' ALT TAB functionallity called from F1
; it is easy to go back to previous or pre-previous window by using single close keyboard keys: F1 and F2
; Usage:
; F1 = opens ALT-TAB window and be able to:
;       - repeat F1 to navigate forward
;       - activate a window with mouse (not in scope)
;       - choose with arrow keys (not in scope)
;       - close ALT-TAB with Esc (not in scope)
; F2 = activates selected window, available only if ALT-TAB is opened
;
; -- inspired by snippet from autohotkey v2 chm
; this variant improves on selecting windows with mouse and keyboard. it is due mainly by avoiding the previous script dependency on having "alt" key down

; settings:
; none

; keymaps:
*F1:: OpenAltTabMenuAndKeepOpened() ; Asterisk is required in this case.

#HotIf WinExist("Task Switching ahk_exe explorer.exe") ; try to not override F2 when not in the AltTab
F2::ActivateSelectedWindow()

; functions:
OpenAltTabMenuAndKeepOpened() {
    SendInput "{LCtrl Down}{LAlt Down}{Tab}{LCtrl Up}{LAlt Up}"
}
ActivateSelectedWindow() {
    Send "{Enter}"
}