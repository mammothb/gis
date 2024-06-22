#Requires AutoHotkey v2.0

#Include "base_feature.ahk"
#Include "..\helpers\general_util.ahk"

class SimpleJump extends BaseFeature {
    _Disable() {
        Hotkey "~*Space", PressSpace.Bind(this.GameProcessName), "Off"
        Hotkey "~*Space Up", ReleaseSpace, "Off"
    }

    _Enable() {
        Hotkey "~*Space", PressSpace.Bind(this.GameProcessName), "On"
        Hotkey "~*Space Up", ReleaseSpace, "On"
    }
}

Global PressingSpace := False

PressSpace(GameProcessName, *) {
    Global
    If (not WinActive(GameProcessName)) {
        Return
    }
    If (not PressingSpace) {
        SetTimer PreBHop, -200
    }
    PressingSpace := True
}

ReleaseSpace(*) {
    Global
    PressingSpace := False
}

PreBHop() {
    SetTimer BHop, 45
}

BHop() {
    Global
    If (not PressingSpace) {
        SetTimer BHop, 0
        Return
    }
    ; if (IsDiving()) {
    ;     Return
    ; }
    Jump()
}

Jump() {
    Global
    if (IsInBoat()) {
        Send "{Space Down}"
        RandSleep(700, 750)
        Send "{Space Up}"
    } Else {
        ; if (IsDiving()) {
        ;     Send "{Space Down}"
        ;     Return
        ; }
        Send "{Space}"
        RandSleep(0, 5)
    }
}