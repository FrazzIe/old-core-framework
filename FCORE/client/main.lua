local kick = true
local oldpos
local reason = ""
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if NetworkIsSessionStarted() then
            TriggerServerEvent("f:irstjoin")
            TriggerServerEvent('hardcap:playerActivated')
            return
        end
    end
end)

AddEventHandler("playerSpawned", function()
    if not kick then
        TriggerServerEvent("f:kick", reason)
    else
        TriggerServerEvent("f:spawn")
    end
end)

RegisterNetEvent("f:kick")
AddEventHandler("f:kick", function(r)
    reason = r
    kick = false
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local pos = GetEntityCoords(GetPlayerPed(-1))

        if(oldpos ~= pos)then
            TriggerServerEvent('f:updatepos', pos.x, pos.y, pos.z)
            oldpos = pos
        end
    end
end)

RegisterNetEvent('f:disMoney')
AddEventHandler('f:disMoney', function(d)
    SendNUIMessage({
        setmoney = true,
        money = d
    })
end)

RegisterNetEvent('f:disBank')
AddEventHandler('f:disBank', function(d)
    SendNUIMessage({
        setbank = true,
        bank = d
    })
end)

RegisterNetEvent('f:disDirty')
AddEventHandler('f:disDirty', function(d)
    SendNUIMessage({
        setDirty_money = true,
        dirty_money = d
    })
end)

RegisterNetEvent('f:addBank')
AddEventHandler('f:addBank', function(a)
    SendNUIMessage({
        addbank = true,
        bank = a
    })
end)

RegisterNetEvent("f:addMoney")
AddEventHandler("f:addMoney", function(a)
    SendNUIMessage({
        addcash = true,
        money = a
    })
end)

RegisterNetEvent("f:addDirty")
AddEventHandler("f:addDirty", function(a)
    SendNUIMessage({
        addDirty_cash = true,
        dirty_money = a
    })
end)

RegisterNetEvent("f:remMoney")
AddEventHandler("f:remMoney", function(r)
    SendNUIMessage({
        removecash = true,
        money = r
    })
end)

RegisterNetEvent('f:remBank')
AddEventHandler('f:remBank', function(r)
    SendNUIMessage({
        removebank = true,
        bank = r
    })
end)

RegisterNetEvent("f:remDirty")
AddEventHandler("f:remDirty", function(r)
    SendNUIMessage({
        removeDirty_cash = true,
        dirty_money = r
    })
end)

local pauseMenu = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsPauseMenuActive() and not pauseMenu then
            pauseMenu = true
            TriggerEvent('js:pause', true)
            SendNUIMessage({
                setDisplay = true,
                display = 0.0,
            })
        elseif not IsPauseMenuActive() and pauseMenu then
            pauseMenu = false
            TriggerEvent('js:pause', false)
            SendNUIMessage({
                setDisplay = true,
                display = 1.0,
            })
        end
    end
end)

RegisterNetEvent("f:pvp")
AddEventHandler("f:pvp", function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            for i = 0,32 do
                if NetworkIsPlayerActive(i) then
                    SetCanAttackFriendly(GetPlayerPed(i), true, true)
                    NetworkSetFriendlyFireOption(true)
                end
            end
        end
    end)
end)