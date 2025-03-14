#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn

If (not A_IsAdmin) {
    Try {
        Run '*RunAs "' A_ScriptFullPath '"'
    } Catch {
        MsgBox "Failed to launch as administrator"
    }
}

Global GameProcessName := "ahk_exe StarRail.exe"
Global ColorIDs := Map("Normal", 0xFFFFFF, "Quest", 0xE6CF88)

LockedClick(X, Y) {
    Global
    BlockInput "MouseMove"
    Click X, Y, "Down"
    Sleep ClickDelay
    Click "Up"
    BlockInput "MouseMoveOff"
}

RandSleep(Start, Stop?) {
    If (IsSet(Stop)) {
        RandDelay := Random(Start, Stop)
    } Else {
        Offset := Start * 0.1
        RandDelay := Random(Start - Offset, Start + Offset)
    }
    Sleep RandDelay
}

SearchDialogue(&FoundX, &FoundY, DialogueType) {
    Global
    X := 1327
    Y1 := 770
    Y2 := 490
    Return PixelSearch(
        &FoundX, &FoundY, X, Y1, X, Y2, ColorIDs[DialogueType]
    )
}

SkipAndClick() {
    Send "{Space}"
    RandSleep(100)
    Send "1"
    ; If (SearchDialogue(&FoundX, &FoundY, "Quest")) {
    ;     LockedClick(FoundX, FoundY)
    ; } Else If (SearchDialogue(&FoundX, &FoundY, "Normal")) {
    ;     LockedClick(FoundX, FoundY)
    ; }
}

Hotkey "~*``", HoldSpace

Global HoldingSpace := False

HoldSpace(*) {
    Global
    If (not WinActive(GameProcessName)) {
        Return
    }
    If (HoldingSpace) {
        SendInput "{Space Up}"
        HoldingSpace := False
    } Else {
        SendInput "{Space Down}"
        HoldingSpace := True
    }
}

Hotkey "~*Space",    PressSpace,   "On"
Hotkey "~*Space Up", ReleaseSpace, "On"

Global PressingSpace := False
Global ClickDelay := 25

PressSpace(*) {
    Global
    If (not WinActive(GameProcessName)) {
        Return
    }
    If (not PressingSpace) {
        SetTimer SkipAndClick, 50
    }
    PressingSpace := True
}

ReleaseSpace(*) {
    Global
    SetTimer SkipAndClick, 0
    PressingSpace := False
}

Hotkey "$F12", ReloadSelf, "On"
Hotkey "$Pause", CloseSelf, "On"

CloseSelf(*) {
    ExitApp
}

ReloadSelf(*) {
    TrayTip "Reloading"
    Sleep 100
    Reload
}
