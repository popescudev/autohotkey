#Requires AutoHotkey v2.0
; this script helps switching windows by using windows ALT TAB
; -- snippet from autohotkey v2 chm

*F1::Send "{Alt down}{tab}" ; Asterisk is required in this case.
!F2::Send "{Alt up}"  ; Release the Alt key, which activates the selected window.
#HotIf WinExist("ahk_group AltTabWindow")
~*Esc::Send "{Alt up}"  ; When the menu is cancelled, release the Alt key automatically.
;*Esc::Send "{Esc}{Alt up}"  ; Without tilde (~), Escape would need to be sent.
#HotIf