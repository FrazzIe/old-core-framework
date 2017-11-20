--==--==--==--==--==--==--==--==--==--
--==================================--
--              F.A.C               --
--==================================--
--   A Shitty AntiCheat for FiveM   --
--==================================--
--            By Frazzle.           --
--==================================--
--==--==--==--==--==--==--==--==--==--
--==================================--
--             Variables            --
--==================================--
--==--==--==--==--==--==--==--==--==--
local bannedWeapons = {
"WEAPON_RAILGUN",
"WEAPON_GRENADELAUNCHER",
"WEAPON_GRENADELAUNCHER_SMOKE",
"WEAPON_RPG",
"WEAPON_PASSENGER_ROCKET",
"WEAPON_AIRSTRIKE_ROCKET",
"WEAPON_STINGER",
"WEAPON_MINIGUN",
"WEAPON_STICKYBOMB",
"WEAPON_VEHICLE_ROCKET"
}
local BannedVehicles = {
    "rhino",
    "apc",
    "oppressor",
    "tampa3",
    "insurgent3",
    "technical3",
    "halftrack",
    "nightshark",
    "blazer5",
    "boxville5",
    "dune4",
    "dune5",
    "phantom2",
    "ruiner2",
    "technical2",
    "voltic2",
    "hydra",
    "jet",
    "blimp",
    "cargoplane",
    "titan",
    "buzzard",
    "valkyrie",
    "savage",
    "dune3",
    "insurgent",
    "insurgent2"
}

local BannedEntitys = {
    "jet",
    "blimp",
    "cargoplane"    
}

local banned = false
isAdmin = false
--DecorRegister("player_Invisible", 2)
--DecorSetBool(GetPlayerPed(-1), "Invisible_player", true)
--DecorRegister("player_Invincible", 2)
--DecorSetBool(GetPlayerPed(-1), "player_Invincible", true)
--==--==--==--==--==--==--==--==--==--
--==================================--
--              Events              --
--==================================--
--==--==--==--==--==--==--==--==--==--

RegisterNetEvent('Anticheat:isAdmin')
AddEventHandler('Anticheat:isAdmin', function()
    isAdmin = true
end)

--==--==--==--==--==--==--==--==--==--
--==================================--
--              Loops               --
--==================================--
--==--==--==--==--==--==--==--==--==--
--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not isAdmin then
            for i = 1, #bannedWeapons do
                local weapon_t = bannedWeapons[i]
                local weapon = GetHashKey(weapon_t)
                if HasPedGotWeapon(GetPlayerPed(-1), weapon, false) then
                    if not banned then
                        banned = true
                        TriggerServerEvent("FAC:BanCheater", "[ANTI-CHEAT] (Illegal gun) ["..weapon_t.."]")
                    end
                end
            end
        end
    end
end)
--]]
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not isAdmin then
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                local cVeh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                for i = 1, #BannedVehicles do
                    local vehicle_name = BannedVehicles[i]
                    local vehicle = GetHashKey(vehicle_name)
                    if GetEntityModel(cVeh) == vehicle then
                        if not banned then
                            banned = true
                            SetEntityAsMissionEntity(cVeh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(cVeh))
                            TriggerServerEvent("FAC:BanCheater", "[ANTI-CHEAT] (Illegal vehicle) ["..vehicle_name.."]")
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not isAdmin then
            if GetEntityHealth(GetPlayerPed(-1)) > 200 then
                if not banned then
                    banned = true
                    TriggerServerEvent("FAC:BanCheater", "[ANTI-CHEAT] (Health > Normal)")
                end
            end
        end
    end
end)

--[[
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if not isAdmin then
            for i = 1, #BannedEntitys do
                local vehicle_name = BannedEntitys[i]
                local vehicle = GetHashKey(vehicle_name)
                Citizen.Trace(vehicle_name)
                Citizen.Trace(vehicle)
                local pos = GetEntityCoords(GetPlayerPed(-1),true)
                Citizen.Trace(pos.x.." "..pos.y.." "..pos.z)
                local closestbannedVeh = GetClosestObjectOfType(pos.x, pos.y, pos.z, 200, vehicle, false, 0, 0)
                if DoesEntityExist(closestbannedVeh) then
                    Citizen.Trace("IT EXISTS")
                    SetEntityAsMissionEntity(closestbannedVeh, true, true)
                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(closestbannedVeh))
                end
            end
        end
    end
end)
--]]
--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if fullyLoaded then
            local isPedLegallyInvisible = DecorGetBool(GetPlayerPed(-1), "player_Invisible")
            --local isPedLegallyInvincible = DecorGetBool(GetPlayerPed(-1), "player_Invincible")
            if not IsEntityVisible(GetPlayerPed(-1)) then
                if isPedLegallyInvisible == false then
                    TriggerServerEvent("FAC:BanCheater", "[ANTI-CHEAT] (Illegally Invisible)")
                end
            end
            --if GetPlayerInvincible(GetPlayerPed(-1)) then
                --if isPedLegallyInvincible == false then
                    --TriggerServerEvent("FAC:BanCheater", "[ANTI-CHEAT] (Illegally Invincible)")
                --end
            --end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(0)
        local isDead = DecorGetBool(GetPlayerPed(-1), "isDead")
        if GetEntityHealth(GetPlayerPed(-1)) < GetPedMaxHealth(GetPlayerPed(-1)) then
            Wait(500)
            if GetEntityHealth(GetPlayerPed(-1)) == GetPedMaxHealth(GetPlayerPed(-1)) and not isDead then
                TriggerServerEvent("FAC:BanCheater", "[ANTI-CHEAT] Unlimited Health")
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local isDead = DecorGetBool(GetPlayerPed(-1), "isDead")
        if GetPedArmour(GetPlayerPed(-1)) < 200 then
            Wait(500)
            if GetPedArmour(GetPlayerPed(-1)) == 200 and not isDead then
                TriggerServerEvent("FAC:BanCheater", "[ANTI-CHEAT] Unlimited Armour")
            end
        end
    end
end)
--]]

--[[
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local hasWeapon, currentWeapon = GetCurrentPedWeapon(GetPlayerPed(-1), 1)
        if hasWeapon then
            drawThisTxt(0.635, 1.42, 1.0,1.0,0.64 , "~w~" .. GetAmmoInPedWeapon(GetPlayerPed(-1), currentWeapon), 255, 255, 255, 255, 6)  -- INT: kmh
            local ammoCount = GetAmmoInPedWeapon(GetPlayerPed(-1), currentWeapon)
            if IsPedShooting(GetPlayerPed(-1)) then
                Wait(1000)
                print(ammoCount.." == ".. GetAmmoInPedWeapon(GetPlayerPed(-1), currentWeapon))
                if ammoCount == GetAmmoInPedWeapon(GetPlayerPed(-1), currentWeapon) then
                    TriggerEvent("customNotification", "ban")
                end
            end
        end
    end
end)
--]]