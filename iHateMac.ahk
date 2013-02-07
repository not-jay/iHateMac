;-- v0.002 (Careful reg-ex deletion)
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

log := "Files and Folders detected`n" . "-------------------------`n"
macHeader := "Files deleted`n" . "-------------------------`n"
count := 0

;Loop, ".[^.]*" ;Because this doesn't work :P
Loop, *.*, 1, 1 ;Just iterate over all files (and folders), check if it matches above and delete it!
{
	allFiles := allFiles . A_LoopFileName . "`n"
	isDotFile = RegExMatch(%A_LoopFileName%, ".[^.]*")
	if isDotFile {
		if A_LoopFileAttrib contains H
			macCrap := true
			
		if macCrap {
			if A_LoopFileAttrib contains D
				macCrapFolder := true
			
			if macCrapFolder {
				macFiles := macFiles . A_LoopFileName . " (Dir)`n"
				FileRemoveDir, %A_LoopFileName%, 1
				macCrapFolder := false
				if !ErrorLevel
					count += 1
			} else {
				macFiles := macFiles . A_LoopFileName . " (File)`n"
				FileDelete, %A_LoopFileName%
				if !ErrorLevel
					count += 1
			}
			
			macCrap := false
		}
	}
}

fileStr := (count > 1 || count == 0)? "files":"file"
MsgBox, % count . " " . fileStr . " deleted!`nLog file created as iHateMac.log" ;%

log := log . allFiles . "`n`n" . macHeader . macFiles

FileDelete, iHateMac.log
FileAppend, %log%, iHateMac.log

exitapp

;The reg-ex string ".[^.]*" should be able to match all those items below
;-- v0.001 (Manual Folder + Files deletion) --
;#SingleInstance, Force
;#Persistent
;#NoEnv

;FileRemoveDir, .Spotlight-V100, 1
;FileRemoveDir, .TemporaryItems, 1
;FileRemoveDir, .Trashes, 1
;FileRemoveDir, .fseventsd, 1
;FileDelete, ._.TemporaryItems
;FileDelete, ._.*

;;Loop, %A_ScriptDir%, 1
;;{
;;	FileDelete, 
;;}

;exitapp
