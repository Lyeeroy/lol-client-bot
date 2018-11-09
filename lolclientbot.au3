#RequireAdmin

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\Pictures\Icon\220.png.ico
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$Form1 = GUICreate("lolClientBot", 330, 221, 374, 213)
$Tab1 = GUICtrlCreateTab(0, 0, 305, 193)
$TabSheet1 = GUICtrlCreateTabItem("General")
GUICtrlSetState(-1, $GUI_SHOW)
$Group1 = GUICtrlCreateGroup("", 24, 48, 129, 113)
$autoCheck = GUICtrlCreateCheckbox("Auto Accept", 40, 64, 97, 17)
$sayCheck = GUICtrlCreateCheckbox("Say Role", 40, 96, 97, 17)
$pickCheck = GUICtrlCreateCheckbox("Pick Champ", 40, 128, 97, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Stop = GUICtrlCreateButton("Stop", 168, 112, 115, 25)
$Start = GUICtrlCreateButton("Start", 168, 72, 115, 25)
$TabSheet3 = GUICtrlCreateTabItem("Say Role")
$Label1 = GUICtrlCreateLabel("Delay :", 28, 138, 37, 17)
$SE = GUICtrlCreateInput("500", 68, 138, 49, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
$co = GUICtrlCreateCombo("", 36, 66, 233, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
$comb = GUICtrlSetData(-1, "top|mid|jungle|adc|supp")
$amoun = GUICtrlCreateInput("2", 212, 138, 25, 21)
$Label8 = GUICtrlCreateLabel("Amount :", 164, 138, 46, 17)
$Group3 = GUICtrlCreateGroup("Options", 12, 122, 273, 57)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("Role", 12, 34, 273, 81)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TabSheet4 = GUICtrlCreateTabItem("Pick Champ")
$cham1 = GUICtrlCreateInput("", 136, 56, 121, 21)
$cham2 = GUICtrlCreateInput("", 136, 88, 121, 21)
$Label2 = GUICtrlCreateLabel("Pick champs:", 16, 56, 68, 17)
$cham3 = GUICtrlCreateInput("", 136, 120, 121, 21)
$Label3 = GUICtrlCreateLabel("1.", 112, 56, 13, 17)
$Label6 = GUICtrlCreateLabel("2.", 112, 88, 13, 17)
$Label7 = GUICtrlCreateLabel("3.", 112, 120, 13, 17)
$Group2 = GUICtrlCreateGroup("", 96, 32, 193, 129)
GUICtrlCreateTabItem("")
$Label1 = GUICtrlCreateLabel("Status :", 152, 200, 40, 17)
$stat = GUICtrlCreateLabel("Loading...", 220, 200, 90, 17)
GUISetState(@SW_SHOW)

Global $comb
Global $amount
Global $SEC
Global $combo
Global $i = 0
Global $x = 0
Global $dot = 0
Global $LoopEx = 0

_main()

Func _main()
	While 1
		While 1
			$nMsg = GUIGetMsg()
			Switch $nMsg
				Case $GUI_EVENT_CLOSE
					Exit
				Case $Start
					If $LoopEx = 0 Then
						Global $combo = GUICtrlRead($comb)
						Global $SEC = GUICtrlRead($SE)
						Global $amount = GUICtrlRead($amoun)
						Global $comb = GUICtrlRead($co)
						Global $champ1 = GUICtrlRead($cham1)
						Global $champ2 = GUICtrlRead($cham2)
						Global $champ3 = GUICtrlRead($cham3)
						If _IsChecked($sayCheck) Then
							If $comb = '' Then
								MsgBox(0, 'Error:' & @ScriptName, 'Choose role')
							ElseIf $amount > 15 Or $amount = 0 Then
								MsgBox(0, 'Error' & @ScriptName, 'Amount > 15 Or 0')
							ElseIf $SEC > 10000 Or $SEC = 0 Then
								MsgBox(0, 'Error:' & @ScriptName, 'Delay > 10 or 0 sec')
							Else
								$LoopEx += 1
								$say = 1
							EndIf
						EndIf
						If _IsChecked($pickCheck) Then
							If $champ1 = '' Then
								MsgBox(0, 'Error:' & @ScriptName, 'Choose at least first champion')
							Else
								$LoopEx += 1
								$pick = 1
							EndIf
						EndIf
						If _IsChecked($autoCheck) Then
							$LoopEx += 1
							$auto = 1
						EndIf
					EndIf
				Case $Stop
					$LoopEx = 0
			EndSwitch
			$i += 1
			$dot += 1
			If $i >= 100 Then
				If $LoopEx >= 1 Then
					If $dot <= 120 Then
						GUICtrlSetData($stat, 'Processing.')
					ElseIf $dot <= 220 Then
						GUICtrlSetData($stat, 'Processing..')
					ElseIf $dot <= 320 Then
						GUICtrlSetData($stat, 'Processing...')
					EndIf
					If $dot >= 300 Then
						$dot = 0
					EndIf
					$dot += 1
				ElseIf $LoopEx = 0 Then
					If ProcessExists('LeagueClient.exe') Then
						If WinActive('League of Legends') Then
							GUICtrlSetData($stat, 'Client active.')
						Else
							GUICtrlSetData($stat, 'Client found.')
						EndIf
					Else
						GUICtrlSetData($stat, 'LoL.Exe 404')
					EndIf
				EndIf
				$i = 0
			EndIf
			If $LoopEx >= 1 Then
				ExitLoop
			EndIf
			ConsoleWrite($LoopEx & ' ---- ')
		WEnd
		ConsoleWrite($LoopEx & ' ---- ')
		If _IsChecked($autoCheck) And $auto = 1 Then
			If ProcessExists('LeagueClient.exe') And WinActive('League of Legends') Then
				Local $GP = WinGetPos('League of Legends')
				$Accept = PixelGetColor($GP[0] + 635, $GP[1] + 536) ;accept 0x09C2B5
				If $Accept = 0x09C2B5 Then ;ifAccept
					$LoopEx -= 1
					$auto = 0
					$LOL = WinGetPos('League of Legends')
					MouseClick('left', $LOL[0] + 643, $LOL[1] + 556, 1, 10)
					GUICtrlSetData($stat, 'Wait for lobby...')
					$loop = 0
					Do
						$loop += 1
						Sleep(100)
						$lobby = PixelGetColor($GP[0] + 676, $GP[1] + 92) ;Lobby 0xC3A15D
					Until $loop = 120 Or $lobby = 0xC3A15D ;Lobby
					If $loop = 120 Then
						$auto = 1
						$LoopEx += 1
					EndIf
				EndIf
			EndIf
		ElseIf _IsChecked($sayCheck) And $say = 1 Then
			If ProcessExists('LeagueClient.exe') And WinActive('League of Legends') Then
				$GP = WinGetPos('League of Legends')
				$pixez2 = PixelGetColor($GP[0] + 624, $GP[1] + 105)
				If $pixez2 = 0x151B1E Then
					Local $LOL = WinGetPos('League of Legends')
					$pos = MouseGetPos()
					$say = 0
					$LoopEx -= 1
					MouseClick('left', $LOL[0] + 160, $LOL[1] + 680, 1, 0)
					MouseMove($pos[0], $pos[1], 0)
					Do
						$x += 1
						Send($comb & '{ENTER}')
						Sleep($SEC)
					Until $x = $amount
				EndIf
				Global $x = 0
			EndIf
		ElseIf _IsChecked($pickCheck) And $pick = 1 Then
			$GP = WinGetPos('League of Legends')
			$lobby = PixelGetColor($GP[0] + 676, $GP[1] + 92) ;Lobby 0xC3A15D
			If $lobby = 0xC3A15D Then ;Lobby
				Local $LOL = WinGetPos('League of Legends')
				$pick = 0
				$LoopEx -= 1
				MouseClick('left', $LOL[0] + 913, $LOL[1] + 103, 2, 0)
				Sleep(200)
				Send($champ1)
				Sleep(200)
				MouseClick('left', $LOL[0] + 382, $LOL[1] + 164, 1, 0)
				If $champ2 <> '' Then
					If $lobby = 0xC3A15D Then ;Lobby
						Local $LOL = WinGetPos('League of Legends')
						MouseClick('left', $LOL[0] + 913, $LOL[1] + 103, 2, 0)
						Sleep(200)
						Send($champ2)
						Sleep(200)
						MouseClick('left', $LOL[0] + 382, $LOL[1] + 164, 1, 0)
					EndIf
				EndIf

				If $champ3 <> '' Then
					If $lobby = 0xC3A15D Then ;Lobby
						Local $LOL = WinGetPos('League of Legends')
						MouseClick('left', $LOL[0] + 913, $LOL[1] + 103, 2, 0)
						Sleep(200)
						Send($champ3)
						Sleep(200)
						MouseClick('left', $LOL[0] + 382, $LOL[1] + 164, 1, 0)
					EndIf
				EndIf
			EndIf
		EndIf
	WEnd
EndFunc   ;==>_main

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked
