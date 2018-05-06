--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--Dragging
drag = false
officerDrag = -1

RegisterNetEvent('paramedic:toggleDrag')
AddEventHandler('paramedic:toggleDrag', function(t)
	drag = not drag
	officerDrag = t
end)

--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if drag then
			local ped = GetPlayerPed(GetPlayerFromServerId(officerDrag))
			local myped = GetPlayerPed(-1)
			FreezeEntityPosition(ped, true)
			AttachEntityToEntity(myped, ped, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
			DetachEntity(GetPlayerPed(-1), true, false)
			FreezeEntityPosition(ped, false)	
		end
	end
end)--]]

local dragging = false
Citizen.CreateThread(function()
	while true do
		if drag then
			local ped = GetPlayerPed(GetPlayerFromServerId(officerDrag))
			local myped = GetPlayerPed(-1)
			AttachEntityToEntity(myped, ped, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			dragging = true
		else
			DetachEntity(GetPlayerPed(-1), true, false)		
			if dragging then
				local pos = GetEntityCoords(GetPlayerPed(-1), true)
				SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
				dragging = false
			end
		end
		Citizen.Wait(0)
	end
end)


-- reset player position every few seconds, just to refresh surroundings incase of the door glitch.
Citizen.CreateThread(function()
	while true do
		if drag then
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
		end
		Citizen.Wait(1000)
	end
end)
--==============================================================================================================================--
--Forced entry of a vehicle
RegisterNetEvent('paramedic:forcedEnteringVeh')
AddEventHandler('paramedic:forcedEnteringVeh', function(veh)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

	if vehicleHandle ~= nil then
		SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
	end
end)
--==============================================================================================================================--
--Forced exit of a vehicle
RegisterNetEvent('paramedic:unseatme')
AddEventHandler('paramedic:unseatme', function(t)
	local ped = GetPlayerPed(t)        
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local xnew = plyPos.x+2
	local ynew = plyPos.y+2
   
	SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)
--==============================================================================================================================--

--==============================================================================================================================--
--Heal
RegisterNetEvent('paramedic:heal')
AddEventHandler('paramedic:heal', function()
    SetEntityHealth(GetPlayerPed(-1), GetPedMaxHealth(GetPlayerPed(-1)))
    SetEntityInvincible(GetPlayerPed(-1), false)
    DisablePlayerFiring(PlayerId(), false)
    ClearPedBloodDamage(GetPlayerPed(-1))
    local coord = GetEntityCoords(GetPlayerPed(-1), true)
    local head = GetEntityHeading(GetPlayerPed(-1), true)
    NetworkResurrectLocalPlayer(coord.x, coord.y, coord.z, head, true, false)
    local bars = exports.FCORE_:getBars()
    if bars[1] < 21 or bars[2] < 21 then
    	TriggerEvent('fm:drink', 21)
    	TriggerEvent('fm:eat', 21)
    end
    secondsRemaining = -1
end)
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
