local IsJailed = false
local removeSentence = false
 
 
RegisterNetEvent("js:jail")
AddEventHandler("js:jail", function(JailTime)
    if IsJailed == true then
        return
    end

    if exports.policejob:getIsCuffed() == true then
        TriggerEvent('police:uncuff')
    end
    if DoesEntityExist(GetPlayerPed(-1)) then
       
        Citizen.CreateThread(function()
            local playerOldLoc = GetEntityCoords(GetPlayerPed(-1), true)
            SetEntityCoords(GetPlayerPed(-1), 1677.233, 2658.618, 45.216)
            IsJailed = true
            removeSentence = false
            while JailTime > 0 and not removeSentence do
                RemoveAllPedWeapons(GetPlayerPed(-1), true)
                SetEntityInvincible(GetPlayerPed(-1), true)
                TriggerEvent("fm:eat", 100)
                TriggerEvent("fm:drink", 100)
                if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                end
                if JailTime % 30 == 0 then
                    exports.pNotify:SendNotification({text = JailTime .." more seconds until release.",type = "error",timeout = 3000,layout = "centerRight",queue = "left"})
                    TriggerServerEvent("js:updatetime", JailTime)
                end
                Citizen.Wait(500)
                local coords = GetEntityCoords(GetPlayerPed(-1), true)
                local Distance = Vdist(1677.233, 2658.618, 45.216, coords['x'], coords['y'], coords['z'])
                if Distance > 90 then
                    SetEntityCoords(GetPlayerPed(-1), 1677.233, 2658.618, 45.216)
                    if Distance > 100 then
                        JailTime = JailTime + 60
                        if JailTime > 1500 then
                            JailTime = 1500
                        end
                        exports.pNotify:SendNotification({text = "Your jail time was extended for an unlawful escape attempt.",type = "error",timeout = 5000,layout = "centerRight",queue = "left"})
                    end
                end
                JailTime = JailTime - 0.5
            end
            SetEntityCoords(GetPlayerPed(-1), 1839.099, 2608.195, 45.562)
            IsJailed = false
            SetEntityInvincible(GetPlayerPed(-1), false)
            if not removeSentence then
                TriggerServerEvent("js:setjailtimeOnExit", 0)
            end
        end)
    end
end)

RegisterNetEvent("js:unjail")
AddEventHandler("js:unjail", function()
    removeSentence = true
end)