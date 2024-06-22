#Requires AutoHotkey v2.0

class GisController {
    __New(&Model) {
        this.Model := Model
        Hotkey "$F12", ObjBindMethod(this, "ReloadGis"), "On"
        Hotkey "$Pause", ObjBindMethod(this, "CloseGis"), "On"
    }

    CloseGis(*) {
        ExitApp
    }

    ReloadGis(*) {
        TrayTip "Reloading GIS"
        Sleep 100
        Reload
    }

    ToggleFeature(FeatureName, GuiCtrl, *) {
        this.Model.Set(FeatureName, GuiCtrl.Value)
    }
}