#Requires AutoHotkey v2.0

#Include "helpers\gis_config.ahk"

; Features
#Include "features\alternate_vision.ahk"
#Include "features\simple_attack.ahk"
#Include "features\simple_jump.ahk"
#Include "features\skip_dialogue.ahk"

class GisModel {
    EnabledFeatures := [
        "AlternateVision",
        "SimpleAttack",
        "SimpleJump",
        "SkipDialogue",
    ]
    GuiTitle := "Genshin Impact Script"
    ShortTitle := "GIS"

    DataDir := A_ScriptDir . "\data"
    GameProcessName := "ahk_exe GenshinImpact.exe"

    __New() {
        this._InitAsset()
        this._InitConfig()
    }

    IsEnabled(FeatureName) {
        Return this.Feature[FeatureName].Enabled
    }

    Set(FeatureName, Value) {
        this.Feature[FeatureName].SetEnabled(Value)
        this.Config.Set(FeatureName, Value)
    }

    _InitAsset() {
        this.Asset := Map()
        this.Asset["Icon"] := A_ScriptDir . "\app\assets\icon.ico"
    }

    _InitConfig() {
        ; Creates the "data" folder if it does not exist. Initializes the
        ; config.ini with the enabled features and create their corresponding
        ; feature class.
        DirCreate this.DataDir
        this.Config := GisConfig(this.DataDir)
        this.Feature := Map()
        For FeatureName in this.EnabledFeatures {
            this.Config.Init(Featurename, 0)
            ; %StrClassName% lets call the class from a string value
            this.Feature[FeatureName] := %FeatureName%(
                this.Config.Get(FeatureName) == 1,
                this.GameProcessName,
            )
        }
    }
}