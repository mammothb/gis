#Requires AutoHotkey v2.0

IsColor(X, Y, Color, Variation := 0) {
    If (Variation != 0) {
        Return PixelSearch(&_, &_, X, Y, X, Y, Color, Variation)
    }
    Return PixelGetColor(X, Y) == Color
}

RandSleep(Start, Stop?) {
    If (IsSet(Stop)) {
        RandDelay := Random(Start, Stop)
    } Else {
        Offset := Start * 0.1
        RandDelay := Random(Start - Offset, Start + Offset)
    }
    Sleep RandDelay
}