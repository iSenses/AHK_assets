#SingleInstance force
#NoEnv

; 首先是#C 开启CMD
; DirectAddress.ahk
; https://blog.csdn.net/liuyukuan/article/details/39804929
SetTitleMatchMode RegEx  
return  
  
; Stuff to do when Windows Explorer is open  
;  
#IfWinActive ahk_class ExploreWClass|CabinetWClass  
  
    ; create new text file  
    ;  
    #t::Send !fwt  
  
    ; open 'cmd' in the current directory  
    ;  
    #c::  
        OpenCmdInCurrent()  
    return  
#IfWinActive  
  
  
; Opens the command shell 'cmd' in the directory browsed in Explorer.  
; Note: expecting to be run when the active window is Explorer.  
;  
OpenCmdInCurrent()  
{  
    ; This is required to get the full path of the file from the address bar  
    WinGetText, full_path, A  
    ;StringLen, Length, full_path
    ;MsgBox The length of InputVar is %Length%.
    ;MsgBox %full_path%
    ; Split on newline (`n)
    fun := RegExMatch(full_path, "地址: (.*?)\r\n", new_path)
    full_path := new_path1
    ;MsgBox %fun%
    ;MsgBox %new_path1%
    ;StringSplit, word_array, full_path, `n  
    ; Take the first element from the array  
    ;full_path = %word_array9%     

    ;MsgBox %full_path%
    ; strip to bare address  
    ;full_path := RegExReplace(full_path, "^地址: ")  
  
    ; Just in case - remove all carriage returns (`r)  
    StringReplace, full_path, full_path, `r, , all  
  
    IfInString full_path, :\  
    {  
        Run,  cmd /K cd /D "%full_path%"  
    }  
    else  
    {  
        Run, cmd /K cd /D "C:/windows/System32 "  
    }   
}  

; 永远在前
; ontop.ahk
;

^!Left::
WinSet AlwaysOnTop, Toggle, A
return

; toggle透明
; transparent.ahk
;
^!Right::
WinGet, currentTransparency, Transparent, A
if (currentTransparency = 180)
{
    WinSet, Transparent, OFF, A
}
else
{
    WinSet, Transparent, 180, A
}
return

; 一些应用快捷键VIM chrome
; VIM_ESC.ahk
;

#ifWinActive ahk_exe gvim.exe|Oni.exe|Code.exe|chrome.exe
Ctrl::Send {Esc}
;#space::MsgBox Win+space is pressed in GVim
#ifWinActive

#ifWinActive ahk_exe Acrobat.exe
^u::Send {PgUp}
^d::Send {PgDn}
^j::Send {Down}
^k::Send {Up}
#ifWinActive


CapState = 0
$CapsLock::CapsFunc(CapState)
CapsFunc(ByRef CapState)
{
    IfWinActive ahk_class Vim 
    { 
        SetCapsLockState Off
        if (CapState == 0) {
          ;Send {Esc}:Caps{Enter}a
          Send ^o:Caps{Enter}
          ;MsgBox It's On.
          CapState = 1
        } else {
          ;Send {Esc}:Mixed{Enter}a
          Send ^o:Mixed{Enter}
          ;MsgBox It's Off.
          CapState = 0
        }
    } else {
        SetStoreCapsLockMode, Off 
        Send {CapsLock}
        SetStoreCapsLockMode, On 
        
        ;MsgBox out of Bounds
    }
}



