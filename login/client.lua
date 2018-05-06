local guiEnabled = false
IsLoggedIn = false
CharID = 1

AddEventHandler('playerSpawned', function(spawn)
    if IsLoggedIn then
        FirstSpawn = false
    else
        TriggerEvent('login:SpawnFreeze')
        TriggerServerEvent('login:getCharacterData')
    end
end)

RegisterNetEvent('login:SpawnFreeze')
AddEventHandler('login:SpawnFreeze', function()
  Citizen.CreateThread(function()
    local ped = GetPlayerPed(PlayerId())
    if IsEntityVisible(ped) then
    SetEntityVisible(ped, false)
    end
    SetPlayerInvincible(PlayerId(), true)
    FreezeEntityPosition(ped, true) 
    SetEntityCoords(ped, -1400.11,-1530.36, 81.1)
  end)
end)

RegisterNetEvent('login:UnFreeze')
AddEventHandler('login:UnFreeze', function(coords)
  IsLoggedIn = true
  Citizen.CreateThread(function()
    local ped = GetPlayerPed(PlayerId())
    SetEntityVisible(ped, true)
    SetPlayerInvincible(PlayerId(), false)
    FreezeEntityPosition(ped, false)
    if coords == nil then
        DisplayNotification("For some reason your coordinates were NIL, report this to an admin!")
        SetEntityCoords(ped, -1858.91, -348.509, 49.8377)
    else
        SetEntityCoords(ped, coords.x, coords.y, coords.z)
    end
  end)
end)

function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end

function EnableGui(enable)
    SetNuiFocus(enable,enable)
    guiEnabled = enable

    SendNUIMessage({
        type = "enableui",
        enable = enable
    })
end


function EnableCreateGui(enable)
    SetNuiFocus(enable,enable)
    guiEnabled = enable

    SendNUIMessage({
        type = "enablecreateui",
        enable = enable
    })
end



function DisableUI()
    SetNuiFocus(false,false)
    guiEnabled = false

    SendNUIMessage({
        type = "disableui",
        enable = false
    })
end

function OpenGUI()
    SetNuiFocus(true,true)
    SendNUIMessage({OpenGUI = true})
end

function EnableCCGui(enable, name1, dob1, gen1, height1, name2, dob2, gen2, height2, name3, dob3, gen3, height3)
    SetNuiFocus(enable,enable)
    guiEnabled = enable

    if name1 == 1 or name1 == "" or name1 == " " or name1 == "N/A" then
        name1 = "N/A"
        dob1 = "N/A"
        gen1 = "N/A"
        height1 = "N/A"
    end

    if name2 == 1 or name2 == "" or name2 == " " or name2 == "N/A" then
        name2 = "N/A"
        dob2 = "N/A"
        gen2 = "N/A"
        height2 = "N/A"
    end

    if name3 == 1 or name3 == "" or name3 == " " or name3 == "N/A" then
        name3 = "N/A"
        dob3 = "N/A"
        gen3 = "N/A"
        height3 = "N/A"
    end

    SendNUIMessage({
        type = "enableccui",
        enable = enable,
        name1 = name1,
        dob1 = dob1,
        gen1 = gen1,
        height1 = height1,
        name2 = name2,
        dob2 = dob2,
        gen2 = gen2,
        height2 = height2,
        name3 = name3,
        dob3 = dob3,
        gen3 = gen3,
        height3 = height3
    })
end


RegisterNetEvent("login:LoginGUIOn")
AddEventHandler("login:LoginGUIOn", function()
    EnableGui(true)
end)

RegisterNetEvent("login:OpenChooseCharMenu")
AddEventHandler("login:OpenChooseCharMenu", function(name1, dob1, gen1, height1, name2, dob2, gen2, height2, name3, dob3, gen3, height3)
    EnableCCGui(true, name1, dob1, gen1, height1, name2, dob2, gen2, height2, name3, dob3, gen3, height3)
end)

RegisterNetEvent("login:RemoveCCNUI")
AddEventHandler("login:RemoveCCNUI", function()
    EnableCCGui(false)
end)


RegisterNetEvent("login:RemoveNUI")
AddEventHandler("login:RemoveNUI", function()
    DisableUI()
end)

RegisterNetEvent("login:IncorrectPW")
AddEventHandler("login:IncorrectPW", function()
    SendNUIMessage({
        type = "IncorrectPW"
    })
end)

RegisterNUICallback('escape', function(data, cb)
    Citizen.Trace("3")
    DisableUI()

    cb('ok')
end)

RegisterNUICallback('login', function(data, cb)
    Citizen.Trace("2")
    TriggerServerEvent("GetPassword", data.password)
    cb('ok')
end)

RegisterNUICallback('char', function(data, cb)
    Citizen.Trace("1")
    TriggerServerEvent("login:ChooseCharacter", data.id)
    DisableUI()
    cb('ok')
end)

RegisterNUICallback('editcharacter', function(data, cb)
    DisableUI()
    TriggerEvent("OpenCCMenu", data.id)
end)

RegisterNUICallback('wipecharacter', function(data, cb)
    DisableUI()
    TriggerServerEvent("login:wipeCharacter", data.id)
end)

RegisterNetEvent("OpenCCMenu")
AddEventHandler("OpenCCMenu", function(id)
    EnableCreateGui(true)
    CharID = id
end)

RegisterNUICallback('create', function(data, cb)
    TriggerServerEvent("login:CreateCharacter", data, CharID)
    DisableUI()
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown

            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate

            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
end)