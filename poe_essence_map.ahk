global stopHoldAKey := false
global stopHoldWKey := False
global stopHoldTimerKey := False

keyarray := [ {key: "{l}", time: 4600}, {key: "^e", time: 11000} ]

timerarray := []

for index, value in keyarray {
    t := new mytimer(value.time, value.key, "sendKey")
    timerarray.push(t)
}



sendKey(key) {
    if (ST()) {
        
    }
    Send %key%
    
}

class mytimer {
    time_off := 1000
    key := ""
    funct := {}

    start() {
        f := this.funct
        SetTimer, % f, % this.time_off
    }
    
    stop() {
        f := this.funct
        SetTimer, % f, Off
    }
    
    __New(p1, p2, fn) {
        this.time_off := p1
        this.key := p2
        this.funct := Func(fn).bind(p2)
    }
}

f::
;PixelGetColor, OutputVar, 1869, 799
;MsgBox % "color is " . OutputVarl
;ToolTip, Multiline`nTooltip, 100, 150
return

F3::
    Suspend
    if (stopHoldTimerKey) {
        for index, value in timerarray {
            value.stop()
        }
        stopHoldTimerKey := False
        ToolTip, Close Timer
        SetTimer, RemoveToolTip, -2000
    }
    
    
return

$o::
    if (!ST()) {
        Send {o}
        return
    }
    if (!stopHoldTimerKey) {

        for index, value in timerarray {
            value.start()
        }
        ;SetTimer, sendLKey, 4650
        ToolTip, Open Timer
        SetTimer, RemoveToolTip, -2000
    } else {
        ;SetTimer, sendLKey, Off
        for index, value in timerarray {
            value.stop()
        }
        ToolTip, Close Timer
        SetTimer, RemoveToolTip, -2000
    }
    stopHoldTimerKey := !stopHoldTimerKey
return



$w::
if ST()
{
    if(!stopHoldWKey)
    {
        Send {w down}
    } else {
        Send {w up}
    }
    stopHoldWKey := !stopHoldWKey
} else {
    Send {w}
}
return

;自动连点鼠标
~a::
if (ST())
{
    
    if (stopHoldWKey)
    {
        Send {w up}
        stopHoldWKey := False
    }
    
    Loop
    {
        Random, rand, 45, 55
        if (!GetKeyState("a", "P"))
            break
        Send {Click}
        Sleep rand
    }
}
return

;瓦精华
d::
if ST()
{
    currentX := 0
    currentY := 0
    corruptEssX = 1300
    corruptEssY = 620
    MouseGetPos, currentX, currentY
    Send {F2}
    Sleep 10
    MouseMove, %corruptEssX%, %corruptEssY%, 3
    Sleep 10
    Send {RButton}
    Sleep 10
    Send {F2}
    MouseMove, %currentX%, %currentY%, 3
    Sleep 10
    Send {Click}
    Sleep 10
    Send {Click}
    Sleep 10
    Send {Click}
    Sleep 10
    Send {Click}
    Sleep 10
    if(!stopHoldWKey)
    {
        stopHoldWKey := true
        Send {w down}
    }
}
return

RemoveToolTip:
ToolTip
return

ST()
{
    return GetKeyState("ScrollLock", "T") and WinActive("Path of Exile")
}
