; i want to have keys 1-10 mapped to opened windows, like in RTS games
; press CTRL+number: registers shortcut to active window
; press the number: switch to the regiestered window
; toggle on/off the hotkeys
; optional: mouse in the middle, not stable

; backlog:
;


; settings:
; this flag enables hotkey to show windows mapped
isDebugMapped := true
isPosionMouseInMiddleWindow := false

;
; This dictionary<int, int> holds key = keyboard numbers 0-9, value = Hwnd of an opened application
windowsToNumbers := Map()
; this flag is toggled when the user requests active/inactive toggle. i didn't find a way to pool the current state of the hotkey after "Toggle" is used
isScriptActive := true

; OPIS
/*
1. debug:
CTRL+ALT+SHIFT+\

2. mark application:
CTRL+1, CTRL+2, CTRL+3, CTRL+4, CTRL+5, CTRL+6, CTRL+7, CTRL+8, CTRL+9, CTRL+0

3. show application:
1,2,3,4,5,6,7,8,9,0

4. enable/disable hotkeys:
CTRL+\

 */ 


; DEBUG: reset stuff =========
/*
^!\::{ ; CTRL+ALT+\-
    ToolTip()
    windowsToNumbers.Clear()
}
*/

; DEBUG: show list ==========
#HotIf isDebugMapped
    ^!+\:: { ; CTRL+ALT+SHIFT+\
        list := ""
        for key, value in windowsToNumbers {
            list .= key . ': ' . WinGetTitle(value) . '`n'
        }

        MsgBox list
    }
#HotIf

;
; register keys ==============================
^1:: ; CTRL+1
{
    currentWindow := RegisterActiveWindowTo(1)
    ShowTimedTooltipForMapping("CTRL+1", currentWindow)
}
^2:: ; CTRL+2
{
    currentWindow := RegisterActiveWindowTo(2)
    ShowTimedTooltipForMapping(ThisHotkey, currentWindow)
}
^3:: ; CTRL+3
{
    currentWindow := RegisterActiveWindowTo(3)
    ShowTimedTooltipForMapping(ThisHotkey, currentWindow)
}
^4:: ; CTRL+4
{
    currentWindow := RegisterActiveWindowTo(4)
    ShowTimedTooltipForMapping(ThisHotkey, currentWindow)
}
^5:: ; CTRL+5
{
    currentWindow := RegisterActiveWindowTo(5)
    ShowTimedTooltipForMapping(ThisHotkey, currentWindow)
}
^6:: ; CTRL+6
{
    currentWindow := RegisterActiveWindowTo(6)
    ShowTimedTooltipForMapping(ThisHotkey, currentWindow)
}
^7:: ; CTRL+7
{
    currentWindow := RegisterActiveWindowTo(7)
    ShowTimedTooltipForMapping(ThisHotkey, currentWindow)
}
^8:: ; CTRL+8
{
    currentWindow := RegisterActiveWindowTo(8)
    ShowTimedTooltipForMapping(ThisHotkey, currentWindow)
}
^9:: ; CTRL+9
{
    currentWindow := RegisterActiveWindowTo(9)
    ShowTimedTooltipForMapping(ThisHotkey, currentWindow)
}
^0:: ; CTRL+0
{
    currentWindow := RegisterActiveWindowTo(0)
    ShowTimedTooltipForMapping(ThisHotkey, currentWindow)
}

1:: ; 1
{
    ActivateWindowForKey(1)
    PositionMouseInTheMiddle()
}
2:: ; 2
{
    ActivateWindowForKey(2)
    PositionMouseInTheMiddle()
}
3:: ; 3
{
    ActivateWindowForKey(3)
    PositionMouseInTheMiddle()
}
4:: ; 4
{
    ActivateWindowForKey(4)
    PositionMouseInTheMiddle()
}
5:: ; 5
{
    ActivateWindowForKey(5)
    PositionMouseInTheMiddle()
}
6:: ; 6
{
    ActivateWindowForKey(6)
    PositionMouseInTheMiddle()
}
7:: ; 7
{
    ActivateWindowForKey(7)
    PositionMouseInTheMiddle()
}
8:: ; 8
{
    ActivateWindowForKey(8)
    PositionMouseInTheMiddle()
}
9:: ; 9
{
    ActivateWindowForKey(9)
    PositionMouseInTheMiddle()
}
0:: ; 0
{
    ActivateWindowForKey(0)
    PositionMouseInTheMiddle()
}

^\:: { ; CTRL+\
    ToggleKeys()
    global isScriptActive := !isScriptActive
    ShowTimedTooltip("RTS mode is now " . (isScriptActive ? "ON" : "OFF"))
}

;
; functions ====================
RegisterActiveWindowTo(nKey) {
    windowsToNumbers[nKey] := WinExist("A")
    return WinGetTitle("A")
}

ActivateWindowForKey(nKey) {
    if ( NOT windowsToNumbers.Has(nKey)) {
        return
    }
    if ( NOT WinExist({ Hwnd: windowsToNumbers[nKey] })) {
        windowsToNumbers.Delete(nKey)
        return
    }

    WinActivate { Hwnd: windowsToNumbers[nKey] }
}

PositionMouseInTheMiddle() {
    if (isPosionMouseInMiddleWindow) {

        ; Get the active window's position and size
        WinGetClientPos &x, &y, &width, &height, "A"
        
        ; Calculate the center position
        centerX := x + (width // 2)
        centerY := y + (height // 2)
        
        ; Move the mouse to the center position
        MouseMove centerX, centerY
    }
}

ToggleKeys() {
    Hotkey "^1", "Toggle"
    Hotkey "^2", "Toggle"
    Hotkey "^3", "Toggle"
    Hotkey "^4", "Toggle"
    Hotkey "^5", "Toggle"
    Hotkey "^6", "Toggle"
    Hotkey "^7", "Toggle"
    Hotkey "^8", "Toggle"
    Hotkey "^9", "Toggle"
    Hotkey "^0", "Toggle"

    Hotkey 1, "Toggle"
    Hotkey 2, "Toggle"
    Hotkey 3, "Toggle"
    Hotkey 4, "Toggle"
    Hotkey 5, "Toggle"
    Hotkey 6, "Toggle"
    Hotkey 7, "Toggle"
    Hotkey 8, "Toggle"
    Hotkey 9, "Toggle"
    Hotkey 0, "Toggle"
}

ShowTimedTooltipForMapping(wKey, wWindow) {
    ShowTimedTooltip(wKey . " mapped to this window:`n" . wWindow)
}
ShowTimedTooltip(wText) {
    ToolTip wText
    SetTimer () => ToolTip(), -1000
}
