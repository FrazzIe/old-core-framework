local notificationParam = 3 -- 1 = LockSystem notification | 2 = chatMessage notification | 3 = nothing
local soundEnable = true -- Set to false for disable sounds
local disableCar_NPC = false -- Set to false for enable NPC's car
local soundDistance = 10 -- Distance of sounds lock / unlock (default: 10m)

--[[
		######### -- READ BELOW -- #########

		- Engine System:

		The vehicle's engine turns off and turns on solo correctly but if someone rides in a vehicle the engine will not turn off. 
		This is due to the synchronization of fivem and after 4 hours of research we can't do anything at the moment.
]]
local lockcar = false
-- BELOW : ONLY FOR PROGRAMMER --
RegisterNetEvent("ls:altlock")
AddEventHandler("ls:altlock",function()
	lockcar = true
end)
local player = GetPlayerPed(-1)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		vehicle = GetVehiclePedIsIn(player, false)
		isPlayerInside = IsPedInAnyVehicle(player, true)

		if lockcar then
			lockcar = false
			player = GetPlayerPed(-1)
			lastVehicle = GetPlayersLastVehicle()
			px, py, pz = table.unpack(GetEntityCoords(player, true))
			coordA = GetEntityCoords(player, true)

			for i = 1, 32 do
				coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, (6.281)/i, 0.0)
				targetVehicle = GetVehicleInDirection(coordA, coordB)
				if targetVehicle ~= nil and targetVehicle ~= 0 then
					vx, vy, vz = table.unpack(GetEntityCoords(targetVehicle, false))
						if GetDistanceBetweenCoords(px, py, pz, vx, vy, vz, false) then
							distance = GetDistanceBetweenCoords(px, py, pz, vx, vy, vz, false)
							break
						end
				end
			end

			if distance ~= nil and distance <= 5 and targetVehicle ~= 0 or vehicle ~= 0 then

				if vehicle ~= 0 then
					plate = GetVehicleNumberPlateText(vehicle)
				else
					vehicle = targetVehicle
					plate = GetVehicleNumberPlateText(vehicle)
				end

				TriggerServerEvent("ls:check", plate, vehicle, isPlayerInside, notificationParam)

			end
		end
	end
end)
carlockstatus = "~b~Unknown"
RegisterNetEvent("ls:lock")
AddEventHandler("ls:lock", function(lockStatus, vehicle)

	if lockStatus == 1 or lockStatus == 0 then -- Si le véhicule est déverrouillé (on le verrouille):
		carlockstatus = "~r~Locked"
		SetVehicleDoorsLocked(vehicle, 2) 
		SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), true)
		TriggerServerEvent("ls:updateLockStatus", 2, plate)

		-- ## Notifications
			if soundEnable then TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "lock", 1.0) end
			TriggerEvent("ls:sendNotification", notificationParam, "Vehicle locked.", 0.080)
		-- ## Notifications

	elseif lockStatus == 2 then -- Si le véhicule est verrouillé

		carlockstatus = "~g~Unlocked"

		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
		TriggerServerEvent("ls:updateLockStatus", 1, plate) 

		-- ## Notifications
			if soundEnable then	TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "unlock", 1.0) end
			TriggerEvent("ls:sendNotification", notificationParam, "Vehicle unlocked.", 0.080)
		-- ## Notifications

	end
end)

if not enableCar_NPC then
	Citizen.CreateThread(function()
    	while true do
			Wait(0)

			local player = GetPlayerPed(-1)

	        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(player))) then

	            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(player))
	            local lock = GetVehicleDoorLockStatus(veh)

	            if lock == 7 then
	                SetVehicleDoorsLocked(veh, 2)
	            end

	            local pedd = GetPedInVehicleSeat(veh, -1)

	            if pedd then
	                SetPedCanBeDraggedOut(pedd, false)
	            end
	        end
	    end
	end)
end

RegisterNetEvent("ls:createMissionEntity")
AddEventHandler("ls:createMissionEntity", function(vehicleId)

	SetEntityAsMissionEntity(vehicleId, true, true)
end)

RegisterNetEvent("ls:notify")
AddEventHandler("ls:notify", function(text, time)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_LIFEINVADER", "CHAR_LIFEINVADER", true, 1, "LockSystem", "Version 2.0.3", time)
	DrawNotification_4(false, true)
end)

RegisterNetEvent("ls:sendNotification")
AddEventHandler("ls:sendNotification", function(param, message, duration)
	if param == 1 then
		TriggerEvent("ls:notify", message, duration)
	elseif param == 2 then
		TriggerEvent('chatMessage', 'LockSystem', { 255, 128, 0 }, message)
	elseif param == 3 then
		exports.pNotify:SendNotification({text = message,type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
	end
end)

function GetVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end