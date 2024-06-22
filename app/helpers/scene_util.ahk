#Requires AutoHotkey v2.0

#Include "general_util.ahk"

Global LightMenuColor := "0xECE5D8"
Global WhiteColor := "0xFFFFFF"
Global YellowColor := "0xFFE92C"
Global ColorIDs := Map("Normal", 0xFFFFFF, "Quest", 0x806200)

IsFishing() {
    Global
    Return (
        IsGameScreen()
        and IsColor(1355, 858, YellowColor)  ; 3rd action icon is LMB
        and (
            IsColor(51, 35, WhiteColor)  ; Leave icon present
            and not IsColor(51, 16, "0xE9C38F")
        )
        and not IsColor(1420, 858, WhiteColor)  ; No "E" Skill
    )
}

IsFullScreenMenu() {
    Global
    Return (
        IsColor(1549, 39, LightMenuColor)
        or IsColor(1562, 29, LightMenuColor)
    )
}

IsGameScreen() {
    ; Check for the eye icon next to the map
    Global
    Return not IsFullScreenMenu() and IsColor(230, 50, WhiteColor)
}

IsInBoat() {
    Global
    Return IsColor(690, 813, LightMenuColor)
}

SearchDialogue(&FoundX, &FoundY, DialogueType) {
    Global
    X := 1091
    Y1 := 483
    Y2 := 700
    Return PixelSearch(
        &FoundX, &FoundY, X, Y1, X, Y2, ColorIDs[DialogueType]
    )
}