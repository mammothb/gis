#Requires AutoHotkey v2.0

class GisController {
    __New(&Model) {
        this.Model := Model
        Hotkey "$End", ObjBindMethod(this, "CloseGis"), "On"
    }

    CloseGis(*) {
        ExitApp
    }

    ToggleFeature(FeatureName, GuiCtrl, *) {
        this.Model.Set(FeatureName, GuiCtrl.Value)
    }
}