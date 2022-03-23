#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir, c:\ ;Set working directory under C drive
#InstallKeybdHook
topConfiguredFlg := 0
topWinNm := "" 
topWinPid := ""

;-------------------------------------
; Hotkey Config
;-------------------------------------

vk1D & f::Right
vk1D & s::Left
vk1D & e::Up
vk1D & d::Down

vk1D & j::Home
vk1D & l::End
vk1D & i::PgUp
vk1D & k::PgDn

vk1D & a::AppsKey

vk1D & vk1C::BackSpace
vk1D & F10::Delete

vk1C::Enter

F13::!F4
F1::#r

vk1D & q::Send, {vkF3}   ; input switching
+F10::Send, {Delete}

$`;::Send, -
$-::Send, `;
$^`;::Send, {^-} 

;-------------------------------------
; Call Application
;-------------------------------------

; Edit script
#z::
    EnvGet, ahkPath, AhkPath
    Run, %ahkPath%\editTxt.exe %ahkPath%\keyConf.ahk
    Sleep, 30
    Reload
    Return

; Open Explorer by specifying a path
#e::
    Send, ^c
    sleep, 100
    Run, %comspec% /c start %Clipboard%,,hide
    Return

; Search files by Everything
#f::
    EnvGet, everythingPath, EVERYTHING
    Send, ^c
    sleep, 50
    Run, %everythingPath% /s %clipboard%
    Return
 
; googling
#g::
    Send, ^c
    sleep, 100
    Run http://www.google.com/search?q=%clipboard%
    Return

; Wake command prompt
#c::
    Run, %comspec%
    Return

; Wake calculator
#k::
    Run, c:/Windows/System32/calc.exe
    Return

; Open new text file by Mery
#w::
    EnvGet, meryPath, MERY
    Run, %meryPath%
    Return

;-------------------------------------
; Macro
;-------------------------------------

; Take schreenshot(Long:design range    Else:Window)
PrintScreen::
    KeyWait, PrintScreen, U T0.2
    If (ErrorLevel = 1) {
        Send, +#s
        Return
    } Else {
        Send, !{PrintScreen}
    }
    Return

; paste with quote
F9::
    StringReplace, Clipboard, Clipboard, `n,`n>, All
    Clipboard:=>%Clipboard%
    Send, ^v
    Return

; Pin the active window to the top
Pause::
    If(topConfiguredFlg = 0){
        WinSet, AlwaysOnTop, , A
        topConfiguredFlg := 1
        WinGet, topWinPid, PID, A
        WinGetTitle, topWinNm, A
        TrayTip, , %topWinNm% is configured on top, 2
        Return
    }
    If(topConfiguredFlg = 1){
        WinSet, AlwaysOnTop, ,ahk_pid %topWinPid%
        topConfiguredFlg := 0
        TrayTip, , %topWinNm% unfastened, 2
        topWinNm := ""
        topWinPid := ""
        Return
    }


;-------------------------------------
; test
;-------------------------------------

;GUI
;F8::
;    Gui, Add, Text,, Hello world!!
;    Gui, Add, Edit
;    Gui, Add, Hotkey
;    Gui,Add,Button,,OK
;    Gui, Show
;    Return
;    ButtonOK:
;    ExitApp




