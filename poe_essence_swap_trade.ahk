#Warn All

Global Array := ["Essence of Delirium", "Essence of Horror", "Deafening Essence of Misery", "Deafening Essence of Envy"
, "Deafening Essence of Scorn", "Deafening Essence of Spite", "Deafening Essence of Zeal", "Deafening Essence of Loathing"
, "Deafening Essence of Wrath", "Deafening Essence of Rage", "Deafening Essence of Anger", "Deafening Essence of Woe", "Deafening Essence of Contempt"]
global target_mods_num := 1
;global mods := [ ["Athlete's"], ["Frozen"], ["Scorching"], ["Honed"], ["Mirage's"], ["Vaporous"], ["Fawn's"], ["of Nullification"]
;    ,["Arcing"], ["of Tzteosh"], ["of Haast"], ["of Ephij"] ]

; gloves
global mods := [ ["Athlete's"], ["Mirage's"], ["of Tzteosh"], ["of Haast"], ["of Ephij"], ["of Nullification"]]

; body armour
;global mods := [ ["Rapturous"], ["Mirage's"], ["of Abjuration"], ["of Tzteosh"], ["of Haast"], ["of Ephij"] ]

; helmet 
;global mods := [ ["Fecund"], ["Mirage's"], ["of the Polymath"], ["of the Genius"], ["of Bameth"], ["of Nullification"] ]

; mageblood flask
;global mods := [ ["reg123Abecedarian's|Dabbler's|Alchemist's", "reg123of the Impala|of the Cheetah|of the Rainbow|of Incision"]
;    ,["reg123Abecedarian's|Dabbler's|Alchemist's", "reg123flask$"]
;    ,["reg123of the Impala|of the Cheetah|of the Rainbow|of Incision", "reg123^Jade|^diamond|^quartz|^silver|^quicksilver"]]

global craftCentX := 966
global craftCentY := 450
global craftBtnX := 966
global craftBtnY := 610

global stopHoldKey := False

global wantX := 535
global wantY := 240
global haveX := 715
global haveY := 240

class point {
    ; 屏幕坐标
    x := 0
    y := 0

    ; table索引
    i := 0
    j := 0
    __New(p1, p2) {
        this.x := p1
        this.y := p2
    }
}

class rectangle {
    static rec_pixel = 52
    x_pixel := 2 * 52
    y_pixel := 2 * 52

    startP := new point(18, 134)
    endP := new point(436, 342)

    i := 1
    j := 1

    currentP := new point(this.x_pixel // 2 + this.startP.x, this.y_pixel // 2 + this.startP.y)

    max_i := (this.endP.x - this.startP.x) // this.x_pixel
    max_j := (this.endP.y - this.startP.y) // this.y_pixel

    table := []

    initRec() {
        this.max_i := (this.endP.x - this.startP.x) // this.x_pixel
        this.max_j := (this.endP.y - this.startP.y) // this.y_pixel
    }

    isInRec(x, y) {
        return x > this.startP.x && x < this.endP.x 
                && y > this.startP.y && y < this.endP.y
    }

    getCurrent() {
        local rand
        While (this.j <= this.max_j) {
            
            While (this.i <= this.max_i) {
                
                if (!hasTwoKey(this.table, this.i, this.j) || !this.table[this.i, this.j]) {

                    ;MsgBox % "max_i is " . this.max_i . " max_j is " . this.max_j
                    ; result := new point(0, 0)
                    
                    Random, rand, 1, 2
                    result := new point(0, 0)
                    result.i := this.i
                    result.j := this.j
                    result.x := (this.i - 1) * this.x_pixel + this.x_pixel // 2 + this.startP.x + rand
                    result.y := (this.j - 1) * this.y_pixel + this.y_pixel // 2 + this.startP.y + rand
                    ; result.x := this.currentP.x
                    ; result.y := this.currentP.y
                    this.i++
                    if (this.i > this.max_i)
                    {
                        this.i := 1
                        this.j++
                    }
                    return result
                }
                this.i++
            }
            this.i := 1
            this.j++
        }

        this.j := 1
        this.i := 1
        ; this.currentP.x := this.x_pixel // 2 + this.startP.x
        ; this.currentP.y := this.y_pixel // 2 + this.startP.y
        While (this.j <= this.max_j) {
            
            While (this.i <= this.max_i) {
                
                if (!hasTwoKey(this.table, this.i, this.j) || !this.table[this.i, this.j]) {

                    ;MsgBox % "max_i is " . this.max_i . " max_j is " . this.max_j
                    ; result := new point(0, 0)
                    Random, rand, 1, 2
                    result := new point(0, 0)
                    result.i := this.i
                    result.j := this.j
                    result.x := (this.i - 1) * this.x_pixel + this.x_pixel // 2 + this.startP.x + rand
                    result.y := (this.j - 1) * this.y_pixel + this.y_pixel // 2 + this.startP.y + rand
                    ; result.x := this.currentP.x
                    ; result.y := this.currentP.y
                    this.i++
                    if (this.i > this.max_i)
                    {
                        this.i := 1
                        this.j++
                    }
                    return result
                }
                this.i++
            }
            this.i := 1
            this.j++
        }

        result := new point(0, 0)
        return result
    }
    
    setTable(i, j, flag) {
        this.table[i, j] := flag    
    }

    ; 如果剪贴板没有读取到，说明这一行后面都没有物品了，将这一行后面都设置为完成
    setThisLine(flag) {
        if (this.i = 1) 
            return
        ; 如果是第一行的第一个为空，说明下一行也没有物品了，直接设置全部完成
        if (this.i = 2) {
            ;MsgBox % "setThisLine this.i is " . this.i . " this.j is " . this.j
            while (this.j <= this.max_j) {
                while (this.i <= this.max_i) {
                    this.table[this.i, this.j] := flag
                    this.i++
                }
                this.j++
                this.i := 1
            }
            return
        }
        while (this.i <= this.max_i) {
            this.table[this.i, this.j] := flag
            this.i++
        }
        this.i := 1
        this.j++
    }
}

hasTwoKey(obj, key1, key2) {
    if(obj.HasKey(key1) && obj[key1].HasKey(key2))
        return true
    return false
}

; func 多个物品洗词缀
a::
Send {Shift Down}
;MouseGetPos, x, y
;MsgBox x is %x%, y is %y%
rec1 := new rectangle
rec1.startP := new point(18, 134)
rec1.endP := new point(12 * 52 + 18, 12 * 52 + 134)
rec1.x_pixel := 2 * rectangle.rec_pixel
rec1.y_pixel := 2 * rectangle.rec_pixel
rec1.initRec()
poOld := new point(0, 0)
Loop {
    po := rec1.getCurrent()
    if (po.x = 0) 
        break
    ;MsgBox % "currentX is " . po.x . " currentY is " . po.y . " old po x is " . poOld.x . " old po y is " . poOld.y
    if (Abs(po.x - poOld.x) < 5 and Abs(po.y - poOld.y) < 5) {
        ;MsgBox % "currentX is " . po.x . " currentY is " . po.y . " old x is " . poOld.x . " old y is " . poOld.y
        Sleep 200
    } else {
        MouseMove, po.x, po.y, 4
    }

    poOld := po

    clipboard := ""
    Send ^c
    ClipWait, 1  ; 等待剪贴板中出现文本.
    if (ErrorLevel) {
        rec1.setTable(po.i, po.j, true)
        rec1.setThisLine(true)
        continue
    }
    clipboardStr := clipboard
    if (checkMods(clipboardStr)) {
        rec1.setTable(po.i, po.j, true)
    } else {
        Send {Click}
    } 
    Sleep 30
    
}
Send {Shift Up}
MsgBox % "have done"
return

; func 单个物品洗词缀
z::
Send {Shift Down}
Loop {
    clipboard := ""
    Send ^c
    ClipWait, 1
    clipboardStr := clipboard
    if (checkMods(clipboardStr))
        break
    else 
        Send {Click}
    Sleep 300
}

return

F3::
    ExitApp
return

+F3::
    Send {Shift Up}
    ExitApp
return

; 浮士德上架补充价格信息
s::
if (!ST())
{
    Send {s}
    return
}
total_and_rate := ""
InputBox, total_and_rate
if (!ErrorLevel)
{
    split_off := InStr(total_and_rate, ",")
    total := SubStr(total_and_rate, 1, split_off - 1)
    rate := SubStr(total_and_rate, split_off + 1, 20)
    want := total // rate
    have := want * rate
    MouseMove, wantX, wantY
    Send {Click}
    Sleep 10
    Send %want%
    MouseMove, haveX, haveY, 2
    Send {Click}
    Sleep 10
    Send %have%
    ;MsgBox want is %want%, have is %have%
}
return

; func 花园工艺转换精华
~d::
if !ST()
    return

rec1 := new rectangle
rec1.startP := new point(1270, 590)
rec1.endP := new point(1894, 850)
rec1.x_pixel := 1 * rectangle.rec_pixel
rec1.y_pixel := 1 * rectangle.rec_pixel
rec1.initRec()

po := rec1.getCurrent()
rec1.setTable(po.i, po.j, true)
MouseMove, po.x, po.y, 4

Loop {
    ; 背包位置
    Send ^{Click}
    inventoryX := 0
    inventoryY := 0
    MouseGetPos, inventoryX, inventoryY
    ;清空剪贴板
    clipboard := ""
    Loop
    {   
        Random, rand, 1, 2
        stop := false
        MouseMove, craftCentX + rand, craftCentY + rand, 4
        clipboardOldStr := clipboard ;比较前后内容是否相同
        
        clipboard := ""
        Send ^c
        ClipWait, 1  ; 等待剪贴板中出现文本.
        clipboardStr := clipboard
        if (ErrorLevel) {
            rec1.setTable(po.i, po.j, true)
            rec1.setThisLine(true)
            break
        }

        ;MsgBox clipboardOldStr is %clipboardOldStr%, clipboardStr is %clipboardStr%
        if (clipboardOldStr = clipboardStr)
        {
            MsgBox no have lifeforce
            break ;没有命能了
        }
        For index, value in Array
        {
            ;MsgBox % "Item " index " is '" value "'"
            if InStr(clipboardStr, value)
            {
                stop := true
                ;MsgBox found essen %value%
                break
            }
        }
        
        if (stop || !ST())
            break
        
        MouseMove, craftBtnX + rand, craftBtnY + rand, 3
        
        Send {Click}
    }
    Send ^{Click}
    po := rec1.getCurrent()
    if (po.x = 0 and po.y = 0) {
        break
    } else {
        rec1.setTable(po.i, po.j, true)
        MouseMove, po.x, po.y, 2
    }
    ;MouseMove, inventoryX, inventoryY, 2
}
MsgBox % "have done"
return

; func 花园洗星团
x::
clipboardOldStr := ""
clipboardStr := ""
Loop {

    Random, rand, 1, 2

    clipboardOldStr := clipboardStr

    MouseMove, craftCentX + rand, craftCentY + rand, 3
    clipboard := ""
    Send ^!c
    ClipWait
    clipboardStr := clipboard

    if (clipboardOldStr = clipboardStr) {
        MsgBox % "no lifeforce"
        break
    }

    if (checkMods(clipboardStr)) {
        break
    }
    MouseMove, craftBtnX + rand, craftBtnY + rand, 3
    Send {Click}
    Sleep 100
}
return


ST()
{
    return GetKeyState("ScrollLock", "T") and WinActive("Path of Exile")
}

checkMods(str, target_num:=1) {
    num := 0
    For index1, value1 in mods
    {
        match := true
        For index2, value2 in value1
        {
            ;MsgBox % "Item " index2 " is '" value2 "'"
            if (InStr(value2, "reg123") = 1)
            {
                reg_str := "im)" . SubStr(value2, 7)
                if(!RegExMatch(str, reg_str)) {
                    match := false
                    break
                }
            } else {
                if (!InStr(str, value2)) {
                    match := false
                    break
                }
                    
            }
            ; if InStr(clipboardStr, value)
            ; {
            ;     stop := true
            ;     ;MsgBox found essen %value%
            ;     break
            ; }
        }
        if (match) {
            num++
        }
        if (match and num >= target_num) {
            ;MsgBox % "found target regx is " . value1[1]
            return true
        }
    }
    return false
}

f::
op := "or"

flag := (true %op% false)
MsgBox % "flag is " . flag
return
