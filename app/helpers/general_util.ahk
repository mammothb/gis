#Requires AutoHotkey v2.0

IsColor(X, Y, Color, Variation := 0) {
    If (Variation != 0) {
        Return PixelSearch(&_, &_, X, Y, X, Y, Color, Variation)
    }
    Return PixelGetColor(X, Y) == Color
}

RandSleep(Start, Stop) {
    RandDelay := Random(Start, Stop)
    Sleep RandDelay
}