#SingleInstance Force
#include VA.ahk
#Persistent

scrn := 1670624
lapt := 44068592

Menu, Tray, Icon, %A_WorkingDir%\Icons8-Ios7-Music-Headset.ico,,1
VA_SetDefaultEndpoint(%lapt%, 0)
VA_SetDefaultEndpoint(%lapt%, 1)
VA_SetDefaultEndpoint(%lapt%, 2)

Menu, Tray, NoStandard
Menu, Tray, Add, &Switch Playback Device, #h
Menu, Tray, Add, 
Menu, Tray, Standard
Menu, Tray, Default, &Switch Playback Device
Return

#h::     ; Win+h toggles headphones / speakers
msgbox "Switching"
Toggle := !Toggle
VA_SetDefaultEndpoint((Toggle ? %scrn% : %lapt% ), 0)
VA_SetDefaultEndpoint((Toggle ? %scrn% : %lapt% ), 1)
VA_SetDefaultEndpoint((Toggle ? %scrn% : %lapt% ), 2)
setIcon((Toggle ? %scrn% : %lapt% ))
return

setIcon(Toggle) {
	if (Toggle == %lapt%) {
		Menu, Tray, Icon, %A_WorkingDir%\Icons8-Ios7-Music-Headset.ico,,1
	} else if (Toggle == %scrn%) {
		Menu, Tray, Icon, %A_WorkingDir%\Iconsmind-Outline-Speaker-2.ico,,1
	}
}