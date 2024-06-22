#Requires AutoHotkey v2.0

#Include "base_feature.ahk"
#Include "..\helpers\scene_util.ahk"

class AlternateVision extends BaseFeature {
    _Disable() {
        Hotkey "~*``", ToggleVision.Bind(this.GameProcessName), "Off"
    }

    _Enable() {
        Hotkey "~*``", ToggleVision.Bind(this.GameProcessName), "On"
    }
}

VisionModeTick := 0

ToggleVision(GameProcessName, *) {
    Global
    If (not WinActive(GameProcessName)) {
        Return
    }
    If (VisionModeTick > 0 or IsFullScreenMenu()) {
        SetTimer TimeVisionMode, 0
        VisionModeTick := 0
        Send "{MButton Up}"
    } Else {
        VisionModeTick := 1
        Send "{MButton Down}"
        SetTimer TimeVisionMode, 250
    }
}

TimeVisionMode() {
    Global
    If (IsFullScreenMenu()) {
        SetTimer TimeVisionMode, 0
        VisionModeTick := 0
        Send "{MButton Up}"
    } Else {
        VisionModeTick := VisionModeTick + 1
        If (VisionModeTick == 10) {
            VisionModeTick := 1
            Send "{MButton Up}"
            RandSleep(20)
        }
        Send "{MButton Down}"
        RandSleep(50)
    }
}