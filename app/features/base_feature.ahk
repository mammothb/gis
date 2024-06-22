#Requires AutoHotkey v2.0

class BaseFeature {
    __New(Enabled, GameProcessName) {
        this.Enabled := Enabled
        this.GameProcessName := GameProcessName
        this.SetEnabled(this.Enabled)
    }

    SetEnabled(Value) {
        this.Enabled := Value
        If (this.Enabled) {
            this._Enable()
        } Else {
            this._Disable()
        }
    }

    _Disable() {
        throw UnsetError("Derived class should implement this")
    }

    _Enable() {
        throw UnsetError("Derived class should implement this")
    }
}