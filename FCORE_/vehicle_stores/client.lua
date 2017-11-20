--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Carshop                                                            --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Variables                                                          --
--==============================================================================================================================--
carshop_menu = false                                                                                                            --
isCarshopOpen = false                                                                                                           --
local vehbool = false                                                                                                           --
local currentShop = nil                                                                                                         --
local currentMarker = nil                                                                                                       --
local currentCategory = nil                                                                                                     --
local currentPreview = {model=0, entity=nil}                                                                                    --
local currentExit = nil                                                                                                         --
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Configuration                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
keys = {[0] = "ControlNextCamera", [1] = "ControlLookLeftRight", [2] = "ControlLookUpDown", [3] = "ControlLookUpOnly", [4] = "ControlLookDownOnly", [5] = "ControlLookLeftOnly", [6] = "ControlLookRightOnly", [7] = "ControlCinematicSlowMo", [8] = "ControlFlyUpDown", [9] = "ControlFlyLeftRight", [10] = "ControlScriptedFlyZUp", [11] = "ControlScriptedFlyZDown", [12] = "ControlWeaponWheelUpDown", [13] = "ControlWeaponWheelLeftRight", [14] = "ControlWeaponWheelNext", [15] = "ControlWeaponWheelPrev", [16] = "ControlSelectNextWeapon", [17] = "ControlSelectPrevWeapon", [18] = "ControlSkipCutscene", [19] = "ControlCharacterWheel", [20] = "ControlMultiplayerInfo", [21] = "ControlSprint", [22] = "ControlJump", [23] = "ControlEnter", [24] = "ControlAttack", [25] = "ControlAim", [26] = "ControlLookBehind", [27] = "ControlPhone", [28] = "ControlSpecialAbility", [29] = "ControlSpecialAbilitySecondary", [30] = "ControlMoveLeftRight", [31] = "ControlMoveUpDown", [32] = "ControlMoveUpOnly", [33] = "ControlMoveDownOnly", [34] = "ControlMoveLeftOnly", [35] = "ControlMoveRightOnly", [36] = "ControlDuck", [37] = "ControlSelectWeapon", [38] = "ControlPickup", [39] = "ControlSniperZoom", [40] = "ControlSniperZoomInOnly", [41] = "ControlSniperZoomOutOnly", [42] = "ControlSniperZoomInSecondary", [43] = "ControlSniperZoomOutSecondary", [44] = "ControlCover", [45] = "ControlReload", [46] = "ControlTalk", [47] = "ControlDetonate", [48] = "ControlHUDSpecial", [49] = "ControlArrest", [50] = "ControlAccurateAim", [51] = "ControlContext", [52] = "ControlContextSecondary", [53] = "ControlWeaponSpecial", [54] = "ControlWeaponSpecial2", [55] = "ControlDive", [56] = "ControlDropWeapon", [57] = "ControlDropAmmo", [58] = "ControlThrowGrenade", [59] = "ControlVehicleMoveLeftRight", [60] = "ControlVehicleMoveUpDown", [61] = "ControlVehicleMoveUpOnly", [62] = "ControlVehicleMoveDownOnly", [63] = "ControlVehicleMoveLeftOnly", [64] = "ControlVehicleMoveRightOnly", [65] = "ControlVehicleSpecial", [66] = "ControlVehicleGunLeftRight", [67] = "ControlVehicleGunUpDown", [68] = "ControlVehicleAim", [69] = "ControlVehicleAttack", [70] = "ControlVehicleAttack2", [71] = "ControlVehicleAccelerate", [72] = "ControlVehicleBrake", [73] = "ControlVehicleDuck", [74] = "ControlVehicleHeadlight", [75] = "ControlVehicleExit", [76] = "ControlVehicleHandbrake", [77] = "ControlVehicleHotwireLeft", [78] = "ControlVehicleHotwireRight", [79] = "ControlVehicleLookBehind", [80] = "ControlVehicleCinCam", [81] = "ControlVehicleNextRadio", [82] = "ControlVehiclePrevRadio", [83] = "ControlVehicleNextRadioTrack", [84] = "ControlVehiclePrevRadioTrack", [85] = "ControlVehicleRadioWheel", [86] = "ControlVehicleHorn", [87] = "ControlVehicleFlyThrottleUp", [88] = "ControlVehicleFlyThrottleDown", [89] = "ControlVehicleFlyYawLeft", [90] = "ControlVehicleFlyYawRight", [91] = "ControlVehiclePassengerAim", [92] = "ControlVehiclePassengerAttack", [93] = "ControlVehicleSpecialAbilityFranklin", [94] = "ControlVehicleStuntUpDown", [95] = "ControlVehicleCinematicUpDown", [96] = "ControlVehicleCinematicUpOnly", [97] = "ControlVehicleCinematicDownOnly", [98] = "ControlVehicleCinematicLeftRight", [99] = "ControlVehicleSelectNextWeapon", [100] = "ControlVehicleSelectPrevWeapon", [101] = "ControlVehicleRoof", [102] = "ControlVehicleJump", [103] = "ControlVehicleGrapplingHook", [104] = "ControlVehicleShuffle", [105] = "ControlVehicleDropProjectile", [106] = "ControlVehicleMouseControlOverride", [107] = "ControlVehicleFlyRollLeftRight", [108] = "ControlVehicleFlyRollLeftOnly", [109] = "ControlVehicleFlyRollRightOnly", [110] = "ControlVehicleFlyPitchUpDown", [111] = "ControlVehicleFlyPitchUpOnly", [112] = "ControlVehicleFlyPitchDownOnly", [113] = "ControlVehicleFlyUnderCarriage", [114] = "ControlVehicleFlyAttack", [115] = "ControlVehicleFlySelectNextWeapon", [116] = "ControlVehicleFlySelectPrevWeapon", [117] = "ControlVehicleFlySelectTargetLeft", [118] = "ControlVehicleFlySelectTargetRight", [119] = "ControlVehicleFlyVerticalFlightMode", [120] = "ControlVehicleFlyDuck", [121] = "ControlVehicleFlyAttackCamera", [122] = "ControlVehicleFlyMouseControlOverride", [123] = "ControlVehicleSubTurnLeftRight", [124] = "ControlVehicleSubTurnLeftOnly", [125] = "ControlVehicleSubTurnRightOnly", [126] = "ControlVehicleSubPitchUpDown", [127] = "ControlVehicleSubPitchUpOnly", [128] = "ControlVehicleSubPitchDownOnly", [129] = "ControlVehicleSubThrottleUp", [130] = "ControlVehicleSubThrottleDown", [131] = "ControlVehicleSubAscend", [132] = "ControlVehicleSubDescend", [133] = "ControlVehicleSubTurnHardLeft", [134] = "ControlVehicleSubTurnHardRight", [135] = "ControlVehicleSubMouseControlOverride", [136] = "ControlVehiclePushbikePedal", [137] = "ControlVehiclePushbikeSprint", [138] = "ControlVehiclePushbikeFrontBrake", [139] = "ControlVehiclePushbikeRearBrake", [140] = "ControlMeleeAttackLight", [141] = "ControlMeleeAttackHeavy", [142] = "ControlMeleeAttackAlternate", [143] = "ControlMeleeBlock", [144] = "ControlParachuteDeploy", [145] = "ControlParachuteDetach", [146] = "ControlParachuteTurnLeftRight", [147] = "ControlParachuteTurnLeftOnly", [148] = "ControlParachuteTurnRightOnly", [149] = "ControlParachutePitchUpDown", [150] = "ControlParachutePitchUpOnly", [151] = "ControlParachutePitchDownOnly", [152] = "ControlParachuteBrakeLeft", [153] = "ControlParachuteBrakeRight", [154] = "ControlParachuteSmoke", [155] = "ControlParachutePrecisionLanding", [156] = "ControlMap", [157] = "ControlSelectWeaponUnarmed", [158] = "ControlSelectWeaponMelee", [159] = "ControlSelectWeaponHandgun", [160] = "ControlSelectWeaponShotgun", [161] = "ControlSelectWeaponSmg", [162] = "ControlSelectWeaponAutoRifle", [163] = "ControlSelectWeaponSniper", [164] = "ControlSelectWeaponHeavy", [165] = "ControlSelectWeaponSpecial", [166] = "ControlSelectCharacterMichael", [167] = "ControlSelectCharacterFranklin", [168] = "ControlSelectCharacterTrevor", [169] = "ControlSelectCharacterMultiplayer", [170] = "ControlSaveReplayClip", [171] = "ControlSpecialAbilityPC", [172] = "ControlPhoneUp", [173] = "ControlPhoneDown", [174] = "ControlPhoneLeft", [175] = "ControlPhoneRight", [176] = "ControlPhoneSelect", [177] = "ControlPhoneCancel", [178] = "ControlPhoneOption", [179] = "ControlPhoneExtraOption", [180] = "ControlPhoneScrollForward", [181] = "ControlPhoneScrollBackward", [182] = "ControlPhoneCameraFocusLock", [183] = "ControlPhoneCameraGrid", [184] = "ControlPhoneCameraSelfie", [185] = "ControlPhoneCameraDOF", [186] = "ControlPhoneCameraExpression", [187] = "ControlFrontendDown", [188] = "ControlFrontendUp", [189] = "ControlFrontendLeft", [190] = "ControlFrontendRight", [191] = "ControlFrontendRdown", [192] = "ControlFrontendRup", [193] = "ControlFrontendRleft", [194] = "ControlFrontendRright", [195] = "ControlFrontendAxisX", [196] = "ControlFrontendAxisY", [197] = "ControlFrontendRightAxisX", [198] = "ControlFrontendRightAxisY", [199] = "ControlFrontendPause", [200] = "ControlFrontendPauseAlternate", [201] = "ControlFrontendAccept", [202] = "ControlFrontendCancel", [203] = "ControlFrontendX", [204] = "ControlFrontendY", [205] = "ControlFrontendLb", [206] = "ControlFrontendRb", [207] = "ControlFrontendLt", [208] = "ControlFrontendRt", [209] = "ControlFrontendLs", [210] = "ControlFrontendRs", [211] = "ControlFrontendLeaderboard", [212] = "ControlFrontendSocialClub", [213] = "ControlFrontendSocialClubSecondary", [214] = "ControlFrontendDelete", [215] = "ControlFrontendEndscreenAccept", [216] = "ControlFrontendEndscreenExpand", [217] = "ControlFrontendSelect", [218] = "ControlScriptLeftAxisX", [219] = "ControlScriptLeftAxisY", [220] = "ControlScriptRightAxisX", [221] = "ControlScriptRightAxisY", [222] = "ControlScriptRUp", [223] = "ControlScriptRDown", [224] = "ControlScriptRLeft", [225] = "ControlScriptRRight", [226] = "ControlScriptLB", [227] = "ControlScriptRB", [228] = "ControlScriptLT", [229] = "ControlScriptRT", [230] = "ControlScriptLS", [231] = "ControlScriptRS", [232] = "ControlScriptPadUp", [233] = "ControlScriptPadDown", [234] = "ControlScriptPadLeft", [235] = "ControlScriptPadRight", [236] = "ControlScriptSelect", [237] = "ControlCursorAccept", [238] = "ControlCursorCancel", [239] = "ControlCursorX", [240] = "ControlCursorY", [241] = "ControlCursorScrollUp", [242] = "ControlCursorScrollDown", [243] = "ControlEnterCheatCode", [244] = "ControlInteractionMenu", [245] = "ControlMpTextChatAll", [246] = "ControlMpTextChatTeam", [247] = "ControlMpTextChatFriends", [248] = "ControlMpTextChatCrew", [249] = "ControlPushToTalk", [250] = "ControlCreatorLS", [251] = "ControlCreatorRS", [252] = "ControlCreatorLT", [253] = "ControlCreatorRT", [254] = "ControlCreatorMenuToggle", [255] = "ControlCreatorAccept", [256] = "ControlCreatorDelete", [257] = "ControlAttack2", [258] = "ControlRappelJump", [259] = "ControlRappelLongJump", [260] = "ControlRappelSmashWindow", [261] = "ControlPrevWeapon", [262] = "ControlNextWeapon", [263] = "ControlMeleeAttack1", [264] = "ControlMeleeAttack2", [265] = "ControlWhistle", [266] = "ControlMoveLeft", [267] = "ControlMoveRight", [268] = "ControlMoveUp", [269] = "ControlMoveDown", [270] = "ControlLookLeft", [271] = "ControlLookRight", [272] = "ControlLookUp", [273] = "ControlLookDown", [274] = "ControlSniperZoomIn", [275] = "ControlSniperZoomOut", [276] = "ControlSniperZoomInAlternate", [277] = "ControlSniperZoomOutAlternate", [278] = "ControlVehicleMoveLeft", [279] = "ControlVehicleMoveRight", [280] = "ControlVehicleMoveUp", [281] = "ControlVehicleMoveDown", [282] = "ControlVehicleGunLeft", [283] = "ControlVehicleGunRight", [284] = "ControlVehicleGunUp", [285] = "ControlVehicleGunDown", [286] = "ControlVehicleLookLeft", [287] = "ControlVehicleLookRight", [288] = "ControlReplayStartStopRecording", [289] = "ControlReplayStartStopRecordingSecondary", [290] = "ControlScaledLookLeftRight", [291] = "ControlScaledLookUpDown", [292] = "ControlScaledLookUpOnly", [293] = "ControlScaledLookDownOnly", [294] = "ControlScaledLookLeftOnly", [295] = "ControlScaledLookRightOnly", [296] = "ControlReplayMarkerDelete", [297] = "ControlReplayClipDelete", [298] = "ControlReplayPause", [299] = "ControlReplayRewind", [300] = "ControlReplayFfwd", [301] = "ControlReplayNewmarker", [302] = "ControlReplayRecord", [303] = "ControlReplayScreenshot", [304] = "ControlReplayHidehud", [305] = "ControlReplayStartpoint", [306] = "ControlReplayEndpoint", [307] = "ControlReplayAdvance", [308] = "ControlReplayBack", [309] = "ControlReplayTools", [310] = "ControlReplayRestart", [311] = "ControlReplayShowhotkey", [312] = "ControlReplayCycleMarkerLeft", [313] = "ControlReplayCycleMarkerRight", [314] = "ControlReplayFOVIncrease", [315] = "ControlReplayFOVDecrease", [316] = "ControlReplayCameraUp", [317] = "ControlReplayCameraDown", [318] = "ControlReplaySave", [319] = "ControlReplayToggletime", [320] = "ControlReplayToggletips", [321] = "ControlReplayPreview", [322] = "ControlReplayToggleTimeline", [323] = "ControlReplayTimelinePickupClip", [324] = "ControlReplayTimelineDuplicateClip", [325] = "ControlReplayTimelinePlaceClip", [326] = "ControlReplayCtrl", [327] = "ControlReplayTimelineSave", [328] = "ControlReplayPreviewAudio", [329] = "ControlVehicleDriveLook", [330] = "ControlVehicleDriveLook2", [331] = "ControlVehicleFlyAttack2", [332] = "ControlRadioWheelUpDown", [333] = "ControlRadioWheelLeftRight", [334] = "ControlVehicleSlowMoUpDown", [335] = "ControlVehicleSlowMoUpOnly", [336] = "ControlVehicleSlowMoDownOnly", [337] = "ControlMapPointOfInterest"}

cars = {
    {title = "Asian Cars", vehicles = {
        {name="2007 Toyota Camry V6", price=40000, model=GetHashKey("camry")},
        {name="2017 Honda Accord V6", price=50000, model=GetHashKey("accord")},
        {name="2017 Subaru BRZ t-S", price=125000, model=GetHashKey("brz")},
        {name="2014 Lexus LX570", price=150000, model=GetHashKey("lx570")},
        {name="2015 Lexus GS350F", price=200000, model=GetHashKey("gs350")},
        {name="2002 Honda NSX", price=225000, model=GetHashKey("nsx")},
        {name="2015 Mitsubishi Evo X", price=225000, model=GetHashKey("evo10")},
        {name="2006 Mitsubishi Evo IX", price=240000, model=GetHashKey("evo9")},
        --{name="2004 Subaru WRX STi", price=250000, model=GetHashkey("subwrx")},
        {name="2006 Subaru WRX STi", price=265000, model=GetHashKey("sti05")},
        {name="2004 Nissan GT-R R34", price=270000, model=GetHashKey("skyline")},
        {name="1998 Toyota Supra", price=350000, model=GetHashKey("supra")},
        {name="2015 Nissan GTR R35", price=750000, model=GetHashKey("gtr")},
    }},
    {title = "European Cars", vehicles = {
        {name="1986 MB 560SEL", price=50000, model=GetHashKey("560sel")},
        {name="1995 BMW M3 E36T", price=80000, model=GetHashKey("e36t")},
        {name="1995 BMW M5 E34", price=80000, model=GetHashKey("m5e34")},
        {name="1990 MB 600SEL", price=85000, model=GetHashKey("sel600")},
        {name="1999 BMW 750iL E38", price=89000, model=GetHashKey("750il")},
        {name="2016 VW Golf GTI", price=90000, model=GetHashKey("mk7")},
        {name="2006 VW Beetle Turbo", price=90000, model=GetHashKey("beetle")},
        {name="2016 Mini CooperWorks", price=90000, model=GetHashKey("cooperworks")},
        {name="2001 Audi S4", price=92000, model=GetHashKey("b5s4")},
        {name="2002 MB C32 AMG", price=92000, model=GetHashKey("benzc32")},
        {name="2003 BMW M5 E39", price=92000, model=GetHashKey("m5")},
        {name="2012 Range Rover SC", price=100000, model=GetHashKey("rover")},
        {name="2013 Audi RS4 Avant", price=120000, model=GetHashKey("rs4")},
    }}, 
    {title = "European Cars 2", vehicles = {
        {name="15 Range Rover Vouge", price=130000, model=GetHashKey("vogue")},
        {name="2012 Audi Q7 V12", price=160000, model=GetHashKey("q7")},
        {name="1982 Porsche 911 Turbo", price=175000, model=GetHashKey("turbo33")},
        {name="2009 Audi RS6 Avant", price=200000, model=GetHashKey("rs6om")},
        {name="2013 Audi S8 FSI", price=225000, model=GetHashKey("s8")},
        {name="2012 MB C63 AMG", price=245000, model=GetHashKey("c63")},
        {name="1960 AustinHealey", price=250000, model=GetHashKey("aust")},
        {name="2016 Maserati GhibliS", price=275000, model=GetHashKey("ghibli")},
        {name="13 AM Vanquish", price=350000, model=GetHashKey("amv12")},
        {name="16 Porsche 911 TurboS", price=850000, model=GetHashKey("911turbos")},
        {name="2013 Lambo LP570-4", price=1500000, model=GetHashKey("gallardo")},        
        {name="16 Audi R8 V10", price=2000000, model=GetHashKey("r8ppi")},
        {name="2015 Ferrari 488GTB", price=2350000, model=GetHashKey("488gtb")},
        {name="2010 Lambo LP650-4", price=2500000, model=GetHashKey("lp6504")},
    }},
    {title = "American Cars", vehicles = {
        {name="1991 Lincoln TownCar", price=25000, model=GetHashKey("towncar")},
        {name="2003 Ford CrownVic LX", price=50000, model=GetHashKey("crownvic")},
        {name="2003 GMC Yukon XL", price=75000, model=GetHashKey("yukonxl")},
        {name="12 Chevy Silverado LTZ", price=85000, model=GetHashKey("silverado")},
        {name="2013 Ford Explorer V6", price=100000, model=GetHashKey("explorer")},
        {name="1968 Ford Mustang FB", price=100000, model=GetHashKey("68mustang")},
        {name="1969 Chevy Camaro SS", price=110000, model=GetHashKey("ss350")},
        {name="1970 Dodge Challenger", price=110000, model=GetHashKey("rt440")},
        {name="1970 Plymouth HemiCuda", price=110000, model=GetHashKey("cuda")},
        {name="1970 Chevy Chevelle SS", price=110000, model=GetHashKey("chevelle1970")},
        {name="1967 Ford GT500", price=115000, model=GetHashKey("gt500")},
        {name="69 Ford MustangBOSS302", price=120000, model=GetHashKey("boss302")},
    }},
    {title = "American Cars 2", vehicles = {
        {name="Jeep TrailCat", price=125000, model=GetHashKey("trailcat")},
        {name="1954 Ford Thunderbird", price=135000, model=GetHashKey("tbird")},
        {name="70 Dodge ChargerMagnum", price=150000, model=GetHashKey("magnum")},
        {name="2014 Cadillac Escalade", price=150000, model=GetHashKey("escalade")},
        {name="66 Shelby Cobra 427 SC", price=175000, model=GetHashKey("cobra")},
        {name="15 Chrysler 300CSRT8", price=200000, model=GetHashKey("300c")},
        {name="16 Dodge Charger RT", price=225000, model=GetHashKey("charger")},
        {name="2015 Jaguar F-Type", price=240000, model=GetHashKey("ftypec")},
        {name="2013 Ford F150 Raptor", price=250000, model=GetHashKey("fraptor")},
        {name="2016 Ford Mustang GT", price=255000, model=GetHashKey("musty5")},
        {name="2015 Corvette C7-Z06", price=295000, model=GetHashKey("vc7")},
        {name="15 Challenger Hellcat", price=1250000, model=GetHashKey("hellcat")},
    }},
    {title = "GTA DLC", vehicles = {
        {name="Coquette3", price=115000, model=GetHashKey("coquette3")},
        {name="Feltzer3", price=155000, model=GetHashKey("feltzer3")},
        {name="Guardian", price=180000, model=GetHashKey("guardian")},
        {name="Contender", price=185000, model=GetHashKey("contender")},
        {name="TrophyTruck2", price=185000, model=GetHashKey("trophytruck2")},
        {name="Lurcher", price=190000, model=GetHashKey("lurcher")},
        {name="Btype", price=225000, model=GetHashKey("btype")},
        {name="Slamvan", price=225000, model=GetHashKey("slamvan")},
        {name="Slamvan2", price=225000, model=GetHashKey("slamvan2")},
        {name="Slamvan3", price=225000, model=GetHashKey("slamvan3")},
        {name="Minivan2", price=235000, model=GetHashKey("minivan2")},
        {name="Sabre GT2", price=245000, model=GetHashKey("sabregt2")},
        {name="Tornado5", price=245000, model=GetHashKey("tornado5")},
        {name="Virgo2", price=245000, model=GetHashKey("virgo2")},
        {name="Comet3", price=290000, model=GetHashKey("comet3")},
        {name="Torero", price=295000, model=GetHashKey("torero")},
        {name="Osiris", price=600000, model=GetHashKey("osiris")},
        {name="Elegy1", price=650000, model=GetHashKey("elegy")},
        {name="SultanRS", price=685000, model=GetHashKey("sultanrs")},
        {name="Specter", price=750000, model=GetHashKey("specter2")},
        {name="Tempesta", price=820000, model=GetHashKey("tempesta")},
        {name="ItaliGTB2", price=1000000, model=GetHashKey("italigtb2")},
        {name="Cheetah2", price=1300000, model=GetHashKey("cheetah2")},
        {name="XA21", price=1500000, model=GetHashKey("xa21")},
        {name="Nero", price=2000000, model=GetHashKey("nero2")},
    }},
    {title = "GTA Compacts", vehicles = {
        {name="Blista", price=15000, model=GetHashKey("blista")},
        {name="Brioso R/A", price=15500, model=GetHashKey("brioso")},
        {name="Dilettante", price=20000, model=GetHashKey("dilettante")},
        {name="Issi", price=20000, model=GetHashKey("issi2")},
        {name="Panto", price=25000, model=GetHashKey("panto")},
        {name="Prairie", price=25000, model=GetHashKey("prairie")},
        {name="Rhapsody", price=25000, model=GetHashKey("rhapsody")},
    }},
    {title = "GTA Coupes", vehicles = {
        {name="Cognoscenti Cabrio", price=125000, model=GetHashKey("cogcabrio")},
        {name="Exemplar", price=125000, model=GetHashKey("exemplar")},
        {name="F620", price=130000, model=GetHashKey("f620")},
        {name="Felon", price=130000, model=GetHashKey("felon")},
        {name="Felon GT", price=135000, model=GetHashKey("felon2")},
        {name="Jackal", price=105000, model=GetHashKey("jackal")},
        {name="Oracle", price=110000, model=GetHashKey("oracle")},
        {name="Oracle XS", price=115000, model=GetHashKey("oracle2")},
        {name="Sentinel", price=110000, model=GetHashKey("sentinel")},
        {name="Sentinel XS", price=115000, model=GetHashKey("sentinel2")},
        {name="Windsor", price=135000, model=GetHashKey("windsor")},
        {name="Windsor Drop", price=145000, model=GetHashKey("windsor2")},
        {name="Zion", price=110000, model=GetHashKey("zion")},
        {name="Zion Cabrio", price=125000, model=GetHashKey("zion2")},
    }},
    {title = "GTA Sports", vehicles = {
        {name="9F", price=120000, model=GetHashKey("ninef")},
        {name="9F Cabrio", price=130000, model=GetHashKey("ninef2")},
        {name="Alpha", price=120000, model=GetHashKey("alpha")},
        {name="Banshee", price=130000, model=GetHashKey("banshee")},
        {name="Bestia GTS", price=135000, model=GetHashKey("bestiagts")},
        {name="Buffalo", price=95000, model=GetHashKey("buffalo")},
        {name="Buffalo2", price=99000, model=GetHashKey("buffalo2")},
        {name="Futo Sport", price=125000, model=GetHashKey("futo")},
        {name="Carbonizzare", price=135000, model=GetHashKey("carbonizzare")},
        {name="Comet", price=145000, model=GetHashKey("comet2")},
        {name="Coquette", price=150000, model=GetHashKey("coquette")},
        {name="Feltzer", price=150000, model=GetHashKey("feltzer2")},
        {name="Furore GT", price=185000, model=GetHashKey("furoregt")},
        {name="Fusilade", price=175000, model=GetHashKey("fusilade")},
        {name="Jester", price=185000, model=GetHashKey("jester")},
        {name="Jester Race", price=200000, model=GetHashKey("jester2")},
        {name="Lynx", price=200000, model=GetHashKey("lynx")},
        {name="Massacro", price=205000, model=GetHashKey("massacro")},
        {name="Massacro Race", price=225000, model=GetHashKey("massacro2")},
        {name="Omnis", price=245000, model=GetHashKey("omnis")},
        {name="Penumbra", price=215000, model=GetHashKey("penumbra")},
        {name="Drift Tampa", price=265000, model=GetHashKey("tampa2")},
        {name="Rapid GT", price=290000, model=GetHashKey("rapidgt")},
        {name="Rapid GT Convertible", price=295000, model=GetHashKey("rapidgt2")},
        {name="Schafter V12", price=300000, model=GetHashKey("schafter3")},
        {name="Sultan", price=200000, model=GetHashKey("sultan")},
        {name="Surano", price=190000, model=GetHashKey("surano")},
        {name="Tropos", price=195000, model=GetHashKey("tropos")},
        {name="Verkierer", price=220000, model=GetHashKey("verlierer2")},
        {name="Kuruma", price=300000, model=GetHashKey("kuruma")},
    }},
    {title = "GTA Sports Classics", vehicles = {
        {name="Casco", price=145000, model=GetHashKey("casco")},
        {name="Coquette Classic", price=155000, model=GetHashKey("coquette2")},
        {name="JB 700", price=160000, model=GetHashKey("jb700")},
        {name="Pigalle", price=150000, model=GetHashKey("pigalle")},
        {name="Stinger", price=145000, model=GetHashKey("stinger")},
        {name="Stinger GT", price=165000, model=GetHashKey("stingergt")},
        {name="Stirling GT", price=140000, model=GetHashKey("feltzer3")},
        {name="Ztype", price=195000, model=GetHashKey("ztype")},
    }},
    {title = "GTA Super", vehicles = {
        {name="Adder", price=320000, model=GetHashKey("adder")},
        {name="Banshee 900R", price=290000, model=GetHashKey("banshee2")},
        {name="Bullet", price=290000, model=GetHashKey("bullet")},
        {name="Cheetah", price=320000, model=GetHashKey("cheetah")},
        {name="Entity XF", price=335000, model=GetHashKey("entityxf")},
        {name="ETR1", price=295000, model=GetHashKey("sheava")},
        {name="FMJ", price=289000, model=GetHashKey("fmj")},
        {name="Infernus", price=325000, model=GetHashKey("infernus")},
        {name="Osiris", price=350000, model=GetHashKey("osiris")},
        {name="RE-7B", price=360000, model=GetHashKey("le7b")},
        {name="Reaper", price=350000, model=GetHashKey("reaper")},
        {name="T20", price=365000, model=GetHashKey("t20")},
        {name="Turismo R", price=385000, model=GetHashKey("turismor")},
        {name="Tyrus", price=275000, model=GetHashKey("tyrus")},
        {name="Vacca", price=285000, model=GetHashKey("vacca")},
        {name="Voltic", price=310000, model=GetHashKey("Voltic")},
        {name="X80 Proto", price=410000, model=GetHashKey("prototipo")},
        {name="Zentorno", price=450000, model=GetHashKey("zentorno")},
    }},
    {title = "GTA Muscle", vehicles = {
        {name="Blade", price=18000, model=GetHashKey("blade")},
        {name="Buccaneer", price=19000, model=GetHashKey("buccaneer")},
        {name="Chino", price=20000, model=GetHashKey("chino")},
        {name="Coquette BlackFin", price=90000, model=GetHashKey("coquette3")},
        {name="Dominator", price=95000, model=GetHashKey("dominator")},
        {name="Dukes", price=95000, model=GetHashKey("dukes")},
        {name="Gauntlet", price=89000, model=GetHashKey("gauntlet")},
        {name="Hotknife", price=105000, model=GetHashKey("hotknife")},
        {name="Faction", price=100000, model=GetHashKey("faction")},
        {name="Nightshade", price=120000, model=GetHashKey("nightshade")},
        {name="Picador", price=120000, model=GetHashKey("picador")},
        {name="Sabre Turbo", price=85000, model=GetHashKey("sabregt")},
        {name="Tampa", price=85000, model=GetHashKey("tampa")},
        {name="Virgo", price=105000, model=GetHashKey("virgo")},
        {name="Vigero", price=110000, model=GetHashKey("vigero")},
    }},
    {title = "GTA Offroad", vehicles = {
        {name="Bifta", price=28000, model=GetHashKey("bifta")},
        {name="Blazer", price=29000, model=GetHashKey("blazer")},
        {name="Brawler", price=25000, model=GetHashKey("brawler")},
        {name="Sadler", price=39000, model=GetHashKey("sadler")},
        {name="Dubsta 6x6", price=90000, model=GetHashKey("dubsta3")},
        {name="Rebel", price=75000, model=GetHashKey("rebel")},
        {name="Sandking", price=95000, model=GetHashKey("sandking2")},
        {name="Sandking XL", price=125000, model=GetHashKey("sandking")},
        {name="Trophy Truck", price=145000, model=GetHashKey("trophytruck")},
    }}, 
    {title = "GTA SUV", vehicles = {
        {name="Baller", price=38000, model=GetHashKey("baller")},
        {name="Cavalcade", price=40000, model=GetHashKey("cavalcade")},
        {name="Grabger", price=45000, model=GetHashKey("granger")},
        {name="Huntley S", price=48000, model=GetHashKey("huntley")},
        {name="Landstalker", price=55000, model=GetHashKey("landstalker")},
        {name="Radius", price=65000, model=GetHashKey("radi")},
        {name="Rocoto", price=75000, model=GetHashKey("rocoto")},
        {name="Seminole", price=85000, model=GetHashKey("seminole")},
        {name="XLS", price=100000, model=GetHashKey("xls")},
    }}, 
    {title = "GTA Vans", vehicles = {
        {name="Bison", price=28000, model=GetHashKey("bison")},
        {name="Bobcat XL", price=30000, model=GetHashKey("bobcatxl")},
        {name="Gang Burrito", price=35000, model=GetHashKey("gburrito")},
        {name="Journey", price=15000, model=GetHashKey("journey")},
        {name="Minivan", price=35000, model=GetHashKey("minivan")},
        {name="Paradise", price=45000, model=GetHashKey("paradise")},
        {name="Rumpo", price=35000, model=GetHashKey("rumpo")},
        {name="Surfer", price=42000, model=GetHashKey("surfer")},
        {name="Youga", price=38000, model=GetHashKey("youga")},
    }},
    {title = "GTA Sedans", vehicles = {
        {name="Asea", price=18000, model=GetHashKey("asea")},
        {name="Fugitive", price=29000, model=GetHashKey("fugitive")},
        {name="Asterope", price=34300, model=GetHashKey("asterope")},
        {name="Glendale", price=40000, model=GetHashKey("glendale")},
        {name="Ingot", price=35000, model=GetHashKey("ingot")},
        {name="Intruder", price=42000, model=GetHashKey("intruder")},
        {name="Premier", price=39000, model=GetHashKey("premier")},
        {name="Primo", price=25000, model=GetHashKey("primo")},
        {name="Primo Custom", price=30000, model=GetHashKey("primo2")},
        {name="Schafter", price=65000, model=GetHashKey("schafter2")},
        {name="Tailgater", price=62000, model=GetHashKey("tailgater")},
        {name="Warrener", price=85000, model=GetHashKey("warrener")},
        {name="Washington", price=95000, model=GetHashKey("washington")},
        {name="Surge", price=99000, model=GetHashKey("surge")},
        {name="Super Diamond", price=125000, model=GetHashKey("superd")},
        {name="Stretch", price=150000, model=GetHashKey("stretch")},
    }}, 
    {title = "Motorcycles", vehicles = {
        {name="ATV", price=3900, model=GetHashKey("blazer")},
        {name="Faggio", price=3900, model=GetHashKey("faggio2")},
        {name="Sanchez", price=4500, model=GetHashKey("sanchez")},
        {name="Enduro", price=6000, model=GetHashKey("enduro")},
        {name="Akuma", price=9900, model=GetHashKey("akuma")},
        {name="Bagger", price=11500, model=GetHashKey("bagger")},
        {name="Bati 801", price=12500, model=GetHashKey("bati")},
        {name="Bati 801RR", price=14000, model=GetHashKey("bati2")},
        {name="BF400", price=25000, model=GetHashKey("bf400")},
        {name="Carbon RS", price=35000, model=GetHashKey("carbonrs")},
        {name="Cliffhanger", price=38000, model=GetHashKey("cliffhanger")},
        {name="Daemon", price=40000, model=GetHashKey("daemon")},
        {name="Double T", price=40000, model=GetHashKey("double")},
        {name="Gargoyle", price=42000, model=GetHashKey("gargoyle")},
        {name="Hakuchou", price=45000, model=GetHashKey("hakuchou")},
        {name="Hexer", price=45000, model=GetHashKey("hexer")},
        {name="Harley Fatboy", price=49000, model=GetHashKey("fatboy")},
        {name="Innovation", price=50000, model=GetHashKey("innovation")},
        {name="Lectro", price=60000, model=GetHashKey("lectro")},
        {name="Nemesis", price=45000, model=GetHashKey("nemesis")},
        {name="PCJ-600", price=46000, model=GetHashKey("pcj")},
        {name="Ruffian", price=50000, model=GetHashKey("ruffian")},
        {name="Harley KnuckleHead", price=60000, model=GetHashKey("knucklehead")},
        {name="Vindicator", price=65000, model=GetHashKey("vindicator")},
        {name="Diablous", price=75000, model=GetHashKey("diablous2")},
        {name="Street ATV", price=85000, model=GetHashKey("blazer4")},  
    }},
}
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                            Events                                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterNetEvent("carshop:bought")
AddEventHandler("carshop:bought",function(data)
	isCarshopOpen = false
	carshop_menu = false
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
        table.insert(out, veh)
        SetVehicleOnGroundProperly(veh)
        SetVehicleHasBeenOwnedByPlayer(veh,true)
        local id = NetworkGetNetworkIdFromEntity(veh)
        SetNetworkIdCanMigrate(id, true)
        SetVehicleColours(veh, data.cp, data.cs)
        SetVehicleExtraColours(veh, tonumber(data.pc), tonumber(data.wc))
        SetVehicleNumberPlateTextIndex(veh,plateindex)
        SetVehicleNumberPlateText(veh, data.p)
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
    end)
end)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Functions                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
function Carshop()
    Menu.SetupMenu("carshop_main","LS Autos")
    Menu.Switch(nil,"carshop_main")
    Menu.PageCounter()
    for i, v in pairs(cars) do
	    Menu.addOption("carshop_main", function()
	        if(Menu.Option(cars[i].title))then
	           subCarshop(cars[i].title,cars[i].vehicles)
	        end
	    end)
	end
end

function subCarshop(title,cvehicles)
	currentCategory = cvehicles
    Menu.SetupMenu("carshop_submenu","LS Autos")
    Menu.Switch("carshop_main","carshop_submenu")
    Menu.PageCounter()
    for i, v in pairs(cvehicles) do
        Menu.addOption("carshop_submenu", function()
            if(Menu.CarBool(tostring(v.name), vehbool,"~g~$~w~"..v.price,"~g~$~w~"..v.price,function(cb)   vehbool = cb end))then
                local count = 0
                for i = 1,#user_vehicles do
                    if user_vehicles[i].cg == 1 then
                        count = count + 1
                    end
                end
                if count < user_garages[1].count then
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
    	            TriggerServerEvent("carshop:buy", title,car,data)
                else
                    exports.pNotify:SendNotification({text = "Your garage is full!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                end
            end
        end)
    end
end

function openCarshop()
	FreezeEntityPosition(GetPlayerPed(-1),true)
	SetEntityVisible(GetPlayerPed(-1),false)
	local zcoord = Citizen.InvokeNative(0xC906A7DAB05C8D2B,currentShop[1],currentShop[2],currentShop[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(GetPlayerPed(-1),currentShop[1],currentShop[2],zcoord)
	SetEntityHeading(GetPlayerPed(-1),currentShop[4])
end

function closeCarshop()
	if DoesEntityExist(currentPreview.entity) then
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(currentPreview.entity))
	end
	currentPreview = {model=0, entity=nil}
	SetEntityCoords(GetPlayerPed(-1),currentMarker[1],currentMarker[2],currentMarker[3])
	FreezeEntityPosition(GetPlayerPed(-1),false)
	SetEntityVisible(GetPlayerPed(-1),true)
	carshop_menu = false
end

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Car Preview                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isCarshopOpen then
			if curMenu == "carshop_submenu" then
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
emplacement_vehicleshop = {
    {name="Vehicle shop", colour=69, id=225, x=-33.491161346436,y=-1102.2437744141,z=26.422353744507,inside={-46.56327,-1097.382,25.99875, 120.1953},exit={-31.849,-1090.648,25.998,322.345}},
}

local incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(emplacement_vehicleshop) do
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
        for k,v in ipairs(emplacement_vehicleshop) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
                    if (incircle == false) then
                        DisplayHelpText("Press ~INPUT_CONTEXT~ to buy a vehicle!")
                    end
                    incircle = true
                    if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
                    	isCarshopOpen = true
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
                        carshop_menu = not carshop_menu
                        player_menu = false
                        openCarshop()
                        Carshop() -- Menu to draw
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
function drawLoadingTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end