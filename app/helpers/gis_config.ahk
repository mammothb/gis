#Requires AutoHotkey v2.0

class GisConfig {
    __New(DataDir) {
        this.File := DataDir . "\config.ini"
        this.Section := "Settings"
        If (not FileExist(this.File)) {
            FileAppend Format("[{}]", this.Section), this.File
        }
    }

    Init(Key, Value) {
        Try {
            this.Get(Key)
        } Catch {
            this.Set(Key, Value)
        } 
    }

    Get(Key) {
        Return IniRead(this.File, this.Section, Key)
    }

    Set(Key, Value) {
        IniWrite Value, this.File, this.Section, Key
    }
}