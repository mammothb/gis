#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn

#Include "app\gis_controller.ahk"
#Include "app\gis_model.ahk"
#Include "app\gis_view.ahk"

If (not A_IsAdmin) {
    Try {
        Run '*RunAs "' A_ScriptFullPath '"'
    } Catch {
        MsgBox "Failed to launch as administrator"
    }
}

ScriptModel := GisModel()
ScriptController := GisController(&ScriptModel)
ScriptView := GisView(&ScriptController)
ScriptView.Show()

A_IconTip := ScriptModel.ShortTitle
TraySetIcon ScriptModel.Asset["Icon"]
