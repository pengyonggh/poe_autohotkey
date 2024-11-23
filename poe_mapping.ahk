;~a::
;if (ST())
;{
;    Loop
;    {
;        Random, rand, 45, 55
;        if (!GetKeyState("a", "P"))
;            break
;        Send {Click}
;        Sleep rand
;    }
;}
;return

stop := False
$Space::
if ST()
{
    if(!stop)
    {
        Send {Space down}
    } else {
        Send {Space up}
    }
    stop := !stop
} else {
    Send {Space}
}
return

ST()
{
    return GetKeyState("ScrollLock", "T") and WinActive("Path of Exile")
}