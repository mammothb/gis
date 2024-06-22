#Requires AutoHotkey v2.0

class GisView extends Gui {
    __New(&Controller) {
        super.__New("+Theme", Controller.Model.GuiTitle)

        this._InitFeatures(0, 0, &Controller)
        ; Compute Features box size to place Tasks box in the next column
        this.FeatureBox.GetPos(&FeatureBoxX, &_, &FeatureBoxW, &_)
        this._InitTasks(FeatureBoxX + FeatureBoxW, 0)
    }

    _AddFeature(Name, &Controller) {
        ; Creates a togglable checkbox for the specified feature
        ; Args:
        ;     Name: Name of the feature
        ;     Controller: The Controller component responsible for providing
        ;         interaction with the Model
        Enabled := Controller.Model.IsEnabled(Name)
        Control := this.AddCheckbox(
            Format("yp+20 v{} {}", Name, Enabled ? "Checked" : ""), Name
        )
        Control.OnEvent(
            "Click", ObjBindMethod(Controller, "ToggleFeature", Name)
        )
    }

    _InitFeatures(OriginX, OriginY, &Controller) {
        ; Initializes the "Features" box and populates togglable QOL features
        ; Args:
        ;     OriginX: Left position of the box
        ;     OriginY: Top position of the box
        ;     Controller: The Controller component responsible for providing
        ;         interaction with the Model
        this.FeatureBox := this.AddGroupBox(
            Format(
                "x{} y{} w250 h260",
                OriginX + this.MarginX,
                OriginY + this.MarginY,
            ),
            "Features",
        )
        this._AddFeature("AlternateVision", &Controller)
        this._AddFeature("SimpleAttack", &Controller)
        this._AddFeature("SimpleJump", &Controller)
        this._AddFeature("SkipDialogue", &Controller)
    }

    _InitTasks(OriginX, OriginY) {
        this.FeatureBox := this.AddGroupBox(
            Format(
                "x{} y{} w250 h80",
                OriginX + this.MarginX,
                OriginY + this.MarginY,
            ),
            "Tasks",
        )
    }
}