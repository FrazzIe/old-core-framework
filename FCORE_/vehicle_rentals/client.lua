--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                        Vehicle Rentals                                                       --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Variables                                                          --
--==============================================================================================================================--
carrental_menu = false                                                                                                          --
isCarRentalOpen = false                                                                                                         --
local vehbool = false                                                                                                           --
local currentShop = nil                                                                                                         --
local currentMarker = nil                                                                                                       --
local currentCategory = nil                                                                                                     --
local currentPreview = {model=0, entity=nil}                                                                                    --
local currentExit = nil                                                                                                         --  
DecorRegister("isRental", 2)                                                                                                    --
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Configuration                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
keys = {[0] = "ControlNextCamera", [1] = "ControlLookLeftRight", [2] = "ControlLookUpDown", [3] = "ControlLookUpOnly", [4] = "ControlLookDownOnly", [5] = "ControlLookLeftOnly", [6] = "ControlLookRightOnly", [7] = "ControlCinematicSlowMo", [8] = "ControlFlyUpDown", [9] = "ControlFlyLeftRight", [10] = "ControlScriptedFlyZUp", [11] = "ControlScriptedFlyZDown", [12] = "ControlWeaponWheelUpDown", [13] = "ControlWeaponWheelLeftRight", [14] = "ControlWeaponWheelNext", [15] = "ControlWeaponWheelPrev", [16] = "ControlSelectNextWeapon", [17] = "ControlSelectPrevWeapon", [18] = "ControlSkipCutscene", [19] = "ControlCharacterWheel", [20] = "ControlMultiplayerInfo", [21] = "ControlSprint", [22] = "ControlJump", [23] = "ControlEnter", [24] = "ControlAttack", [25] = "ControlAim", [26] = "ControlLookBehind", [27] = "ControlPhone", [28] = "ControlSpecialAbility", [29] = "ControlSpecialAbilitySecondary", [30] = "ControlMoveLeftRight", [31] = "ControlMoveUpDown", [32] = "ControlMoveUpOnly", [33] = "ControlMoveDownOnly", [34] = "ControlMoveLeftOnly", [35] = "ControlMoveRightOnly", [36] = "ControlDuck", [37] = "ControlSelectWeapon", [38] = "ControlPickup", [39] = "ControlSniperZoom", [40] = "ControlSniperZoomInOnly", [41] = "ControlSniperZoomOutOnly", [42] = "ControlSniperZoomInSecondary", [43] = "ControlSniperZoomOutSecondary", [44] = "ControlCover", [45] = "ControlReload", [46] = "ControlTalk", [47] = "ControlDetonate", [48] = "ControlHUDSpecial", [49] = "ControlArrest", [50] = "ControlAccurateAim", [51] = "ControlContext", [52] = "ControlContextSecondary", [53] = "ControlWeaponSpecial", [54] = "ControlWeaponSpecial2", [55] = "ControlDive", [56] = "ControlDropWeapon", [57] = "ControlDropAmmo", [58] = "ControlThrowGrenade", [59] = "ControlVehicleMoveLeftRight", [60] = "ControlVehicleMoveUpDown", [61] = "ControlVehicleMoveUpOnly", [62] = "ControlVehicleMoveDownOnly", [63] = "ControlVehicleMoveLeftOnly", [64] = "ControlVehicleMoveRightOnly", [65] = "ControlVehicleSpecial", [66] = "ControlVehicleGunLeftRight", [67] = "ControlVehicleGunUpDown", [68] = "ControlVehicleAim", [69] = "ControlVehicleAttack", [70] = "ControlVehicleAttack2", [71] = "ControlVehicleAccelerate", [72] = "ControlVehicleBrake", [73] = "ControlVehicleDuck", [74] = "ControlVehicleHeadlight", [75] = "ControlVehicleExit", [76] = "ControlVehicleHandbrake", [77] = "ControlVehicleHotwireLeft", [78] = "ControlVehicleHotwireRight", [79] = "ControlVehicleLookBehind", [80] = "ControlVehicleCinCam", [81] = "ControlVehicleNextRadio", [82] = "ControlVehiclePrevRadio", [83] = "ControlVehicleNextRadioTrack", [84] = "ControlVehiclePrevRadioTrack", [85] = "ControlVehicleRadioWheel", [86] = "ControlVehicleHorn", [87] = "ControlVehicleFlyThrottleUp", [88] = "ControlVehicleFlyThrottleDown", [89] = "ControlVehicleFlyYawLeft", [90] = "ControlVehicleFlyYawRight", [91] = "ControlVehiclePassengerAim", [92] = "ControlVehiclePassengerAttack", [93] = "ControlVehicleSpecialAbilityFranklin", [94] = "ControlVehicleStuntUpDown", [95] = "ControlVehicleCinematicUpDown", [96] = "ControlVehicleCinematicUpOnly", [97] = "ControlVehicleCinematicDownOnly", [98] = "ControlVehicleCinematicLeftRight", [99] = "ControlVehicleSelectNextWeapon", [100] = "ControlVehicleSelectPrevWeapon", [101] = "ControlVehicleRoof", [102] = "ControlVehicleJump", [103] = "ControlVehicleGrapplingHook", [104] = "ControlVehicleShuffle", [105] = "ControlVehicleDropProjectile", [106] = "ControlVehicleMouseControlOverride", [107] = "ControlVehicleFlyRollLeftRight", [108] = "ControlVehicleFlyRollLeftOnly", [109] = "ControlVehicleFlyRollRightOnly", [110] = "ControlVehicleFlyPitchUpDown", [111] = "ControlVehicleFlyPitchUpOnly", [112] = "ControlVehicleFlyPitchDownOnly", [113] = "ControlVehicleFlyUnderCarriage", [114] = "ControlVehicleFlyAttack", [115] = "ControlVehicleFlySelectNextWeapon", [116] = "ControlVehicleFlySelectPrevWeapon", [117] = "ControlVehicleFlySelectTargetLeft", [118] = "ControlVehicleFlySelectTargetRight", [119] = "ControlVehicleFlyVerticalFlightMode", [120] = "ControlVehicleFlyDuck", [121] = "ControlVehicleFlyAttackCamera", [122] = "ControlVehicleFlyMouseControlOverride", [123] = "ControlVehicleSubTurnLeftRight", [124] = "ControlVehicleSubTurnLeftOnly", [125] = "ControlVehicleSubTurnRightOnly", [126] = "ControlVehicleSubPitchUpDown", [127] = "ControlVehicleSubPitchUpOnly", [128] = "ControlVehicleSubPitchDownOnly", [129] = "ControlVehicleSubThrottleUp", [130] = "ControlVehicleSubThrottleDown", [131] = "ControlVehicleSubAscend", [132] = "ControlVehicleSubDescend", [133] = "ControlVehicleSubTurnHardLeft", [134] = "ControlVehicleSubTurnHardRight", [135] = "ControlVehicleSubMouseControlOverride", [136] = "ControlVehiclePushbikePedal", [137] = "ControlVehiclePushbikeSprint", [138] = "ControlVehiclePushbikeFrontBrake", [139] = "ControlVehiclePushbikeRearBrake", [140] = "ControlMeleeAttackLight", [141] = "ControlMeleeAttackHeavy", [142] = "ControlMeleeAttackAlternate", [143] = "ControlMeleeBlock", [144] = "ControlParachuteDeploy", [145] = "ControlParachuteDetach", [146] = "ControlParachuteTurnLeftRight", [147] = "ControlParachuteTurnLeftOnly", [148] = "ControlParachuteTurnRightOnly", [149] = "ControlParachutePitchUpDown", [150] = "ControlParachutePitchUpOnly", [151] = "ControlParachutePitchDownOnly", [152] = "ControlParachuteBrakeLeft", [153] = "ControlParachuteBrakeRight", [154] = "ControlParachuteSmoke", [155] = "ControlParachutePrecisionLanding", [156] = "ControlMap", [157] = "ControlSelectWeaponUnarmed", [158] = "ControlSelectWeaponMelee", [159] = "ControlSelectWeaponHandgun", [160] = "ControlSelectWeaponShotgun", [161] = "ControlSelectWeaponSmg", [162] = "ControlSelectWeaponAutoRifle", [163] = "ControlSelectWeaponSniper", [164] = "ControlSelectWeaponHeavy", [165] = "ControlSelectWeaponSpecial", [166] = "ControlSelectCharacterMichael", [167] = "ControlSelectCharacterFranklin", [168] = "ControlSelectCharacterTrevor", [169] = "ControlSelectCharacterMultiplayer", [170] = "ControlSaveReplayClip", [171] = "ControlSpecialAbilityPC", [172] = "ControlPhoneUp", [173] = "ControlPhoneDown", [174] = "ControlPhoneLeft", [175] = "ControlPhoneRight", [176] = "ControlPhoneSelect", [177] = "ControlPhoneCancel", [178] = "ControlPhoneOption", [179] = "ControlPhoneExtraOption", [180] = "ControlPhoneScrollForward", [181] = "ControlPhoneScrollBackward", [182] = "ControlPhoneCameraFocusLock", [183] = "ControlPhoneCameraGrid", [184] = "ControlPhoneCameraSelfie", [185] = "ControlPhoneCameraDOF", [186] = "ControlPhoneCameraExpression", [187] = "ControlFrontendDown", [188] = "ControlFrontendUp", [189] = "ControlFrontendLeft", [190] = "ControlFrontendRight", [191] = "ControlFrontendRdown", [192] = "ControlFrontendRup", [193] = "ControlFrontendRleft", [194] = "ControlFrontendRright", [195] = "ControlFrontendAxisX", [196] = "ControlFrontendAxisY", [197] = "ControlFrontendRightAxisX", [198] = "ControlFrontendRightAxisY", [199] = "ControlFrontendPause", [200] = "ControlFrontendPauseAlternate", [201] = "ControlFrontendAccept", [202] = "ControlFrontendCancel", [203] = "ControlFrontendX", [204] = "ControlFrontendY", [205] = "ControlFrontendLb", [206] = "ControlFrontendRb", [207] = "ControlFrontendLt", [208] = "ControlFrontendRt", [209] = "ControlFrontendLs", [210] = "ControlFrontendRs", [211] = "ControlFrontendLeaderboard", [212] = "ControlFrontendSocialClub", [213] = "ControlFrontendSocialClubSecondary", [214] = "ControlFrontendDelete", [215] = "ControlFrontendEndscreenAccept", [216] = "ControlFrontendEndscreenExpand", [217] = "ControlFrontendSelect", [218] = "ControlScriptLeftAxisX", [219] = "ControlScriptLeftAxisY", [220] = "ControlScriptRightAxisX", [221] = "ControlScriptRightAxisY", [222] = "ControlScriptRUp", [223] = "ControlScriptRDown", [224] = "ControlScriptRLeft", [225] = "ControlScriptRRight", [226] = "ControlScriptLB", [227] = "ControlScriptRB", [228] = "ControlScriptLT", [229] = "ControlScriptRT", [230] = "ControlScriptLS", [231] = "ControlScriptRS", [232] = "ControlScriptPadUp", [233] = "ControlScriptPadDown", [234] = "ControlScriptPadLeft", [235] = "ControlScriptPadRight", [236] = "ControlScriptSelect", [237] = "ControlCursorAccept", [238] = "ControlCursorCancel", [239] = "ControlCursorX", [240] = "ControlCursorY", [241] = "ControlCursorScrollUp", [242] = "ControlCursorScrollDown", [243] = "ControlEnterCheatCode", [244] = "ControlInteractionMenu", [245] = "ControlMpTextChatAll", [246] = "ControlMpTextChatTeam", [247] = "ControlMpTextChatFriends", [248] = "ControlMpTextChatCrew", [249] = "ControlPushToTalk", [250] = "ControlCreatorLS", [251] = "ControlCreatorRS", [252] = "ControlCreatorLT", [253] = "ControlCreatorRT", [254] = "ControlCreatorMenuToggle", [255] = "ControlCreatorAccept", [256] = "ControlCreatorDelete", [257] = "ControlAttack2", [258] = "ControlRappelJump", [259] = "ControlRappelLongJump", [260] = "ControlRappelSmashWindow", [261] = "ControlPrevWeapon", [262] = "ControlNextWeapon", [263] = "ControlMeleeAttack1", [264] = "ControlMeleeAttack2", [265] = "ControlWhistle", [266] = "ControlMoveLeft", [267] = "ControlMoveRight", [268] = "ControlMoveUp", [269] = "ControlMoveDown", [270] = "ControlLookLeft", [271] = "ControlLookRight", [272] = "ControlLookUp", [273] = "ControlLookDown", [274] = "ControlSniperZoomIn", [275] = "ControlSniperZoomOut", [276] = "ControlSniperZoomInAlternate", [277] = "ControlSniperZoomOutAlternate", [278] = "ControlVehicleMoveLeft", [279] = "ControlVehicleMoveRight", [280] = "ControlVehicleMoveUp", [281] = "ControlVehicleMoveDown", [282] = "ControlVehicleGunLeft", [283] = "ControlVehicleGunRight", [284] = "ControlVehicleGunUp", [285] = "ControlVehicleGunDown", [286] = "ControlVehicleLookLeft", [287] = "ControlVehicleLookRight", [288] = "ControlReplayStartStopRecording", [289] = "ControlReplayStartStopRecordingSecondary", [290] = "ControlScaledLookLeftRight", [291] = "ControlScaledLookUpDown", [292] = "ControlScaledLookUpOnly", [293] = "ControlScaledLookDownOnly", [294] = "ControlScaledLookLeftOnly", [295] = "ControlScaledLookRightOnly", [296] = "ControlReplayMarkerDelete", [297] = "ControlReplayClipDelete", [298] = "ControlReplayPause", [299] = "ControlReplayRewind", [300] = "ControlReplayFfwd", [301] = "ControlReplayNewmarker", [302] = "ControlReplayRecord", [303] = "ControlReplayScreenshot", [304] = "ControlReplayHidehud", [305] = "ControlReplayStartpoint", [306] = "ControlReplayEndpoint", [307] = "ControlReplayAdvance", [308] = "ControlReplayBack", [309] = "ControlReplayTools", [310] = "ControlReplayRestart", [311] = "ControlReplayShowhotkey", [312] = "ControlReplayCycleMarkerLeft", [313] = "ControlReplayCycleMarkerRight", [314] = "ControlReplayFOVIncrease", [315] = "ControlReplayFOVDecrease", [316] = "ControlReplayCameraUp", [317] = "ControlReplayCameraDown", [318] = "ControlReplaySave", [319] = "ControlReplayToggletime", [320] = "ControlReplayToggletips", [321] = "ControlReplayPreview", [322] = "ControlReplayToggleTimeline", [323] = "ControlReplayTimelinePickupClip", [324] = "ControlReplayTimelineDuplicateClip", [325] = "ControlReplayTimelinePlaceClip", [326] = "ControlReplayCtrl", [327] = "ControlReplayTimelineSave", [328] = "ControlReplayPreviewAudio", [329] = "ControlVehicleDriveLook", [330] = "ControlVehicleDriveLook2", [331] = "ControlVehicleFlyAttack2", [332] = "ControlRadioWheelUpDown", [333] = "ControlRadioWheelLeftRight", [334] = "ControlVehicleSlowMoUpDown", [335] = "ControlVehicleSlowMoUpOnly", [336] = "ControlVehicleSlowMoDownOnly", [337] = "ControlMapPointOfInterest"}

rental_cars = {
    {title = "Cars", vehicles = {
        {name = "Punto", price = 900, model = GetHashKey("panto")},
        {name = "2017 Subaru BRZ t-S", price = 2500, model = GetHashKey("brz")},
        {name = "2014 Lexus LX570", price = 5000, model = GetHashKey("LX570")},
        {name = "2002 Honda NSX", price = 2500, model = GetHashKey("nsx")},   
        {name = "2015 Mitsubishi Evo X", price = 2500, model = GetHashKey("evo10")},
        {name = "1990 MB 600SEL", price = 4500, model = GetHashKey("sel600")},
        {name = "1999 BMW 750iL E38", price = 4900, model = GetHashKey("750il")},
        {name = "2016 VW Golf GTI", price = 3000, model = GetHashKey("mk7")},
        {name = "2003 BMW M5 E39", price = 4200, model = GetHashKey("m5")},
        {name = "Alpha", price = 2000, model = GetHashKey("alpha")},
        {name = "Banshee", price = 3500, model = GetHashKey("banshee")},
        {name = "Buffalo", price = 4500, model = GetHashKey("buffalo")},
        {name = "Buffalo S", price = 4700, model = GetHashKey("buffalo2")},
        {name = "Baller", price = 4000, model = GetHashKey("baller")},
        {name = "Cavalcade", price = 3000, model = GetHashKey("cavalcade")},
        {name = "Grabger", price = 3500, model = GetHashKey("granger")},
        {name = "Huntley S", price = 1450, model = GetHashKey("huntley")},
        {name = "Landstalker", price = 3800, model = GetHashKey("landstalker")},
        {name = "Radius", price = 3200, model = GetHashKey("radi")},
        {name = "Rocoto", price = 4500, model = GetHashKey("rocoto")},
        {name = "Seminole", price = 3000, model = GetHashKey("seminole")},
        {name = "XLS", price = 5300, model = GetHashKey("xls")},
        {name = "16 Porsche 911 TurboS", price = 25000, model = GetHashKey("911turbos")},
        {name = "2004 Nissan GT-R R34", price = 20000, model = GetHashKey("skyline")},
        {name = "1998 Toyota Supra", price = 20000, model = GetHashKey("supra")},
        {name = "2015 Nissan GTR R35", price = 30000, model = GetHashKey("gtr")}, 
    }},
    {title = "Motorcycles", vehicles = {
        {name = "Faggio", price = 550, model = GetHashKey("faggio2")},
        {name = "Enduro", price = 700, model = GetHashKey("enduro")},
        {name = "ATV", price = 600, model = GetHashKey("blazer")},
    }},
}
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                            Events                                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterNetEvent("carRental:bought")
AddEventHandler("carRental:bought",function(data)
	isCarRentalOpen = false
	carrental_menu = false
	if DoesEntityExist(currentPreview.entity) then
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
	end
	currentPreview = {model=0, entity=nil}
	FreezeEntityPosition(GetPlayerPed(-1),false)
	SetEntityVisible(GetPlayerPed(-1),true)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        RequestModel(data.m)
        while not HasModelLoaded(data.m) do
            Citizen.Wait(0)
        end
        local veh = CreateVehicle(data.m, currentExit[1], currentExit[2], currentExit[3], currentExit[4], true, false)
        SetVehicleNumberPlateText(veh, data.p)
        SetVehicleOnGroundProperly(veh)
        SetVehicleHasBeenOwnedByPlayer(veh,true)
        local id = NetworkGetNetworkIdFromEntity(veh)
        SetNetworkIdCanMigrate(id, true)
        SetVehicleColours(veh, data.cp, data.cs)
        SetVehicleExtraColours(veh, tonumber(data.pc), tonumber(data.wc))
        SetVehicleNumberPlateTextIndex(veh,plateindex)
        SetVehicleNeonLightsColour(veh,tonumber(data.nc[1]),tonumber(data.nc[2]),tonumber(data.nc[3]))
        SetVehicleTyreSmokeColor(veh,tonumber(data.sc[1]),tonumber(data.sc[2]),tonumber(data.sc[3]))
        SetVehicleModKit(veh,0)
        SetVehicleMod(veh, 0, tonumber(data.m0))
        SetVehicleMod(veh, 1, tonumber(data.m1))
        SetVehicleMod(veh, 2, tonumber(data.m2))
        SetVehicleMod(veh, 3, tonumber(data.m3))
        SetVehicleMod(veh, 4, tonumber(data.m4))
        SetVehicleMod(veh, 5, tonumber(data.m5))
        SetVehicleMod(veh, 6, tonumber(data.m6))
        SetVehicleMod(veh, 7, tonumber(data.m7))
        SetVehicleMod(veh, 8, tonumber(data.m8))
        SetVehicleMod(veh, 9, tonumber(data.m9))
        SetVehicleMod(veh, 10, tonumber(data.m10))
        SetVehicleMod(veh, 11, tonumber(data.m11))
        SetVehicleMod(veh, 12, tonumber(data.m12))
        SetVehicleMod(veh, 13, tonumber(data.m13))
        SetVehicleMod(veh, 14, tonumber(data.m14))
        SetVehicleMod(veh, 15, tonumber(data.m15))
        SetVehicleMod(veh, 16, tonumber(data.m16))
        if data.t == "on" then
            ToggleVehicleMod(veh, 18, true)
        else
            ToggleVehicleMod(veh, 18, false)
        end
        if data.ts == "on" then
            ToggleVehicleMod(veh, 20, true)
        else
            ToggleVehicleMod(veh, 20, false)
        end
        if data.xl == "on" then
            ToggleVehicleMod(veh, 22, true)
        else
            ToggleVehicleMod(veh, 22, false)
        end
        SetVehicleWheelType(veh, tonumber(data.wht))
        SetVehicleMod(veh, 23, tonumber(data.m23))
        SetVehicleMod(veh, 24, tonumber(data.m24))
        if data.cw == "on" then
            SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), true)-- Vehicle Mod 23
            SetVehicleMod(veh, 24, GetVehicleMod(veh, 24), true)-- Vehicle Mod 24
        end
        if data.n0 == "on" then
            SetVehicleNeonLightEnabled(veh,0, true)
        else
            SetVehicleNeonLightEnabled(veh,0, false)
        end
        if data.n1 == "on" then
            SetVehicleNeonLightEnabled(veh,1, true)
        else
            SetVehicleNeonLightEnabled(veh,1, false)
        end
        if data.n2 == "on" then
            SetVehicleNeonLightEnabled(veh,2, true)
        else
            SetVehicleNeonLightEnabled(veh,2, false)
        end
        if data.n3 == "on" then
            SetVehicleNeonLightEnabled(veh,3, true)
        else
            SetVehicleNeonLightEnabled(veh,3, false)
        end
        if data.bp == "on" then
            SetVehicleTyresCanBurst(veh, false)
        else
            SetVehicleTyresCanBurst(veh, true)
        end
        SetVehicleWindowTint(veh,tonumber(data.wt))
        TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
        SetEntityInvincible(veh, false)
        DecorSetBool(veh, "isRental", true)        
    end)
end)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Functions                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function carRental()
    Menu.SetupMenu("carrental_main","Escalera Rentals")
    Menu.Switch(nil,"carrental_main")
    Menu.PageCounter()
    for i, v in pairs(rental_cars) do
	    Menu.addOption("carrental_main", function()
	        if(Menu.Option(rental_cars[i].title))then
	           subRentals(rental_cars[i].title, rental_cars[i].vehicles)
	        end
	    end)
	end
end

function subRentals(title,cvehicles)
	currentCategory = cvehicles
    Menu.SetupMenu("carrental_submenu","Escalera Rentals")
    Menu.Switch("carrental_main","carrental_submenu")
    Menu.PageCounter()
    for i, v in pairs(cvehicles) do
        Menu.addOption("carrental_submenu", function()
            if(Menu.CarBool(tostring(v.name), vehbool,"~g~$~w~"..v.price,"~g~$~w~"..v.price,function(cb)   vehbool = cb end))then
                local count = 0
                for i = 1,#user_vehicles do
                    if user_vehicles[i].cg == 1 then
                        count = count + 1
                    end
                end
    	        local car = v
    	        local veh = currentPreview.entity
    	        local turbo
    	        local tiresmoke
    	        local xenon
    	        local neon0
    	        local neon1
    	        local neon2
    	        local neon3
    	        local bulletproof
    	        local variation
    		    local colors = table.pack(GetVehicleColours(veh))
    		    local extra_colors = table.pack(GetVehicleExtraColours(veh))
    		    local neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
    		    local smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
    		    if IsToggleModOn(veh,18) then
    		        turbo = "on"
    		    else
    		        turbo = "off"
    		    end
    		    if IsToggleModOn(veh,20) then
    		        tiresmoke = "on"
    		    else
    		        tiresmoke = "off"
    		    end
    		    if IsToggleModOn(veh,22) then
                    xenon = "on"
    		    else
    		        xenon = "off"
    		    end
    		    if IsVehicleNeonLightEnabled(veh,0) then
    		        neon0 = "on"
    		    else
    		        neon0 = "off"
    		    end
    		    if IsVehicleNeonLightEnabled(veh,1) then
    		        neon1 = "on"
    		    else
    		        neon1 = "off"
    		    end
    		    if IsVehicleNeonLightEnabled(veh,2) then
    		        neon2 = "on"
    		    else
    		        neon2 = "off"
    		    end
    		    if IsVehicleNeonLightEnabled(veh,3) then
    		        neon3 = "on"
    		    else
    		        neon3 = "off"
    		    end
    		    if GetVehicleTyresCanBurst(veh) then
                    bulletproof = "off"
    		    else
    		        bulletproof = "on"
    		    end
    		    if GetVehicleModVariation(veh,23) then
    		        variation = "on"
    		    else
    		        variation = "off"
    		    end
    	        local data = {
    	            n=v.name, -- Name
    	            c=v.price/2,
    	            m=GetEntityModel(veh), -- Model
                    instance=veh, -- Current Instance
                    cg = 1,
    	            p=GetVehicleNumberPlateText(veh), -- Plate
    	            s="~r~Missing", -- State
    	            cp=colors[1], -- Colour Primary
    	            cs=colors[2], -- Colour Secondary
    	            pc=extra_colors[1], -- Pearlescent Colour
    	            wc=extra_colors[2], -- Wheel Colour
    	            pi=GetVehicleNumberPlateTextIndex(veh), -- Colour of license plate
    	            nc={neoncolor[1],neoncolor[2],neoncolor[3]}, -- Neon Colours
    	            wt=GetVehicleWindowTint(veh), -- Window Tint
    	            wht=GetVehicleWheelType(veh), -- Wheel type
    	            m0=GetVehicleMod(veh, 0), -- Vehicle Mod 0
    	            m1=GetVehicleMod(veh, 1), -- Vehicle Mod 1
                    m2=GetVehicleMod(veh, 2), -- Vehicle Mod 2
                    m3=GetVehicleMod(veh, 3), -- Vehicle Mod 3
    	            m4=GetVehicleMod(veh, 4), -- Vehicle Mod 4
    	            m5=GetVehicleMod(veh, 5), -- Vehicle Mod 5
    	            m6=GetVehicleMod(veh, 6), -- Vehicle Mod 6
    	            m7=GetVehicleMod(veh, 7), -- Vehicle Mod 7
    	            m8=GetVehicleMod(veh, 8), -- Vehicle Mod 8
    	            m9=GetVehicleMod(veh, 9), -- Vehicle Mod 9
    	            m10=GetVehicleMod(veh, 10), -- Vehicle Mod 10
    	            m11=GetVehicleMod(veh, 11), -- Vehicle Mod 11
    	            m12=GetVehicleMod(veh, 12), -- Vehicle Mod 12
    	            m13=GetVehicleMod(veh, 13), -- Vehicle Mod 13
    	            m14=GetVehicleMod(veh, 14), -- Vehicle Mod 14
    	            m15=GetVehicleMod(veh, 15), -- Vehicle Mod 15
    	            m16=GetVehicleMod(veh, 16), -- Vehicle Mod 16
    	            t=turbo, -- Turbo
    	            xl=xenon, -- Xenon Lights
    	            ts=tiresmoke, -- Tyre Smoke
    	            m23=GetVehicleMod(veh, 23), -- Vehicle Mod 23
    	            m24=GetVehicleMod(veh, 24), -- Vehicle Mod 24
                    n0=neon0, -- Neon 0
    	            n1=neon1, -- Neon 1
    	            n2=neon2, -- Neon 2
    	            n3=neon3, -- Neon 3
    	            bp=bulletproof, -- Bulletproof tyres
    	            sc={smokecolor[1],smokecolor[2],smokecolor[3]}, -- Tyre smoke colour
    	            cw=variation, -- Custom Wheels
    	            ins="false", -- Insurance
    	        }
    	       TriggerServerEvent("carRental:buy", title,car,data)
            end
        end)
    end
end

function openCarRental()
	FreezeEntityPosition(GetPlayerPed(-1),true)
	SetEntityVisible(GetPlayerPed(-1),false)
	local zcoord = Citizen.InvokeNative(0xC906A7DAB05C8D2B,currentShop[1],currentShop[2],currentShop[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(GetPlayerPed(-1),currentShop[1],currentShop[2],zcoord)
	SetEntityHeading(GetPlayerPed(-1),currentShop[4])
end

function closeCarRental()
	if DoesEntityExist(currentPreview.entity) then
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
	end
	currentPreview = {model=0, entity=nil}
	SetEntityCoords(GetPlayerPed(-1),currentMarker[1],currentMarker[2],currentMarker[3])
	FreezeEntityPosition(GetPlayerPed(-1),false)
	SetEntityVisible(GetPlayerPed(-1),true)
	carrental_menu = false
end

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Car Preview                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isCarRentalOpen then
			if curMenu == "carrental_submenu" then
				for i = 1, #currentCategory do
					if currentOption == i then
						if currentPreview.model ~= currentCategory[i].model then
							if DoesEntityExist(currentPreview.entity) then
								Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
							end
							local hash = currentCategory[i].model
							RequestModel(hash)
							while not HasModelLoaded(hash) do
								Citizen.Wait(0)
								drawLoadingTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)
								for i = 0, #keys - 1 do
									DisableControlAction(1, i, true)
								end
							end
							local veh = CreateVehicle(hash,currentShop[1],currentShop[2],currentShop[3],currentShop[4],false,false)
							while not DoesEntityExist(veh) do
								Citizen.Wait(0)
								drawLoadingTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)
								for i = 0, #keys - 1 do
									DisableControlAction(1, i, true)
								end
							end
							FreezeEntityPosition(veh,true)
							SetEntityInvincible(veh,true)
							SetVehicleDoorsLocked(veh,4)
							TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
							for i = 0,24 do
								SetVehicleModKit(veh,0)
								RemoveVehicleMod(veh,i)
							end
							currentPreview = {model=currentCategory[i].model,entity=veh}
						end					
					end
				end
			end
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press E to open/close menu in the red marker
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
emplacement_vehiclerentals = {
    {name="Vehicle rentals", colour=69, id=225, x=-904.39,y=-2337.38,z=6.71,inside={-905.96,-2333.15,6.71,62.16},exit={-905.96,-2333.15,6.71,62.16}},
}

local incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(emplacement_vehiclerentals) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, item.colour)
      SetBlipScale(item.blip, 0.7)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(emplacement_vehiclerentals) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to rent a vehicle!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                    	isCarRentalOpen = true
                    	currentMarker = {v.x,v.y,v.z}
                        currentShop = v.inside
                        currentExit = v.exit
                        GUI.maxVisOptions = 20
						titleTextSize = {0.85, 0.80} ------------ {p1, Size}                                      
						titleRectSize = {0.23, 0.085} ----------- {Width, Height}                                 
						optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      
						optionRectSize = {0.23, 0.035} ---------- {Width, Height}           
                        menuX = 0.745 ----------------------------- X position of the menu                          
                        menuXOption = 0.11 --------------------- X postiion of Menu.Option text                  
                        menuXOtherOption = 0.06 ---------------- X position of Bools, Arrays etc text            
                        menuYModify = 0.1500 -------------------- Default: 0.1174   ------ Top bar                
                        menuYOptionDiv = 4.285 ------------------ Default: 3.56   ------ Distance between buttons 
                        menuYOptionAdd = 0.21 ------------------ Default: 0.142  ------ Move buttons up and down
                        carrental_menu = not carrental_menu
                        player_menu = false
                        openCarRental()
                        carRental() -- Menu to draw
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                    incircle = false
                end
            end
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Useful functions
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
