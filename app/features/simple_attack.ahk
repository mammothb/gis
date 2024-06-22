#Requires AutoHotkey v2.0

#Include "base_feature.ahk"
#Include "..\helpers\general_util.ahk"
#Include "..\helpers\scene_util.ahk"

class SimpleAttack extends BaseFeature {
    _Disable() {
        Hotkey "~*LButton", PressLButton.Bind(this.GameProcessName), "Off"
        Hotkey "~*LButton Up", ReleaseLButton, "Off"
    }

    _Enable() {
        Hotkey "~*LButton", PressLButton.Bind(this.GameProcessName), "On"
        Hotkey "~*LButton Up", ReleaseLButton, "On"
    }
}

Global PressingLButton := False

PressLButton(GameProcessName, *) {
    Global
    If (not WinActive(GameProcessName)) {
        Return
    }
    If (not IsFishing() and not PressingLButton) {
        SetTimer Attack, 140
    }
    PressingLButton := True
}

ReleaseLButton(*) {
    Global
    SetTimer Attack, 0
    PressingLButton := False
}

Attack() {
    Click
}