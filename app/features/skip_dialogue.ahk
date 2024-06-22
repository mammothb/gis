#Requires AutoHotkey v2.0

#Include "base_feature.ahk"
#Include "..\helpers\scene_util.ahk"

class SkipDialogue extends BaseFeature {
    _Disable() {
        Hotkey "~*f", PressF.Bind(this.GameProcessName), "Off"
        Hotkey "~*f Up", ReleaseF, "Off"
    }

    _Enable() {
        Hotkey "~*f", PressF.Bind(this.GameProcessName), "On"
        Hotkey "~*f Up", ReleaseF, "On"
    }
}

; ===============
; Dialog skipping
; ===============
Global PressingF := False
Global ClickDelay := 25

PressF(GameProcessName, *) {
    Global
    If (not WinActive(GameProcessName)) {
        Return
    }
    if (not PressingF) {
        SetTimer SkipAndClick, 50
    }
    PressingF := True
}

ReleaseF(*) {
    Global
    SetTimer SkipAndClick, 0
    PressingF := False
}

SkipAndClick() {
    Send "{f}"
    If (SearchDialogue(&FoundX, &FoundY, "Quest")) {
        LockedClick(FoundX, FoundY)
    } Else If (SearchDialogue(&FoundX, &FoundY, "Normal")) {
        LockedClick(FoundX, FoundY)
    }
    RandSleep(0, 100)
}

LockedClick(X, Y) {
    Global
    BlockInput "MouseMove"
    Click X, Y, "Down"
    Sleep ClickDelay
    Click "Up"
    BlockInput "MouseMoveOff"
}