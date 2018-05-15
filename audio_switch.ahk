; From
; https://autohotkey.com/boards/viewtopic.php?t=21229

#Include <VA>

OnExit("ExitFunc")

bool := False
device := VA_GetDevice("playback")

#h::PlaybackDeviceState(device, bool := !bool)
 
PlaybackDeviceState(device_desc, bool := False){
	; CPolicyConfigClient
	Static CLSID := "{870af99c-171d-4f9e-af0d-e63df40c2bc9}"
	; IPolicyConfig
	Static IID   := "{f8679f50-850a-41cf-9c72-430f290290c8}" ; "{00632a31-4d49-4167-8ae1-27f82ce135b1}"
	if(PolConfig := ComObjCreate(CLSID, IID)) {
		if(defPlaybackDevice := VA_GetDevice(device_desc)) { ; get default playback device
			if(VA_IMMDevice_GetId(defPlaybackDevice, id) == 0){ ; get the device id
				DllCall(NumGet(NumGet(PolConfig+0)+14*A_PtrSize), "Ptr", PolConfig, "WStr", id, "Int", bool) ; ::SetEndpointVisibility - disable the device
			}
			ObjRelease(defPlaybackDevice) ; cleanup
		}
		ObjRelease(PolConfig)
	}
}

ExitFunc(ExitReason, ExitCode){
	Global device
	PlaybackDeviceState(device, True)
	ObjRelease(device)
}