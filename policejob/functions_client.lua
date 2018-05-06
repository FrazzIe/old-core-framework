--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--  Cuffing
handCuffed = false

RegisterNetEvent('police:uncuff')
AddEventHandler('police:uncuff', function()
	handCuffed = false
end)

RegisterNetEvent('police:getArrested')
AddEventHandler('police:getArrested', function()
	if(isInService == false and drag == false) then
		handCuffed = not handCuffed
		if(handCuffed) then
            SetPedComponentVariation(GetPlayerPed(-1), 7, 41, 0 ,0)
			exports.pNotify:SendNotification({text = "You have been handcuffed.",type = "error",timeout = 3000,layout = "centerRight",queue = "left"})
		else
			exports.pNotify:SendNotification({text = "You have been uncuffed.",type = "error",timeout = 3000,layout = "centerRight",queue = "left"})
            SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0 ,0)
		end
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "You cannot cuff a fellow officer!",type = "error",timeout = 3500,layout = "centerRight",queue = "left"})		
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if handCuffed == true then
			RequestAnimDict('mp_arresting')

			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(0)
			end

			TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 16, 0, 0, 0, 0)
		end
	end
end)

--==============================================================================================================================--
--Dragging
drag = false
officerDrag = -1

RegisterNetEvent('police:toggleDrag')
AddEventHandler('police:toggleDrag', function(t)
	if(handCuffed) then
		drag = not drag
		officerDrag = t
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if drag then
			local ped = GetPlayerPed(GetPlayerFromServerId(officerDrag))
			local myped = GetPlayerPed(-1)
			AttachEntityToEntity(myped, ped, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
			DetachEntity(GetPlayerPed(-1), true, false)		
		end
	end
end)
--==============================================================================================================================--
--Forced entry of a vehicle
RegisterNetEvent('police:forcedEnteringVeh')
AddEventHandler('police:forcedEnteringVeh', function(veh)
	if(handCuffed) then
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
		end
	end
end)
--==============================================================================================================================--
--Forced exit of a vehicle
RegisterNetEvent('police:unseatme')
AddEventHandler('police:unseatme', function(t)
	local ped = GetPlayerPed(t)        
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local xnew = plyPos.x+2
	local ynew = plyPos.y+2
   
	SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)
--==============================================================================================================================--
--Remove a targets weapons
RegisterNetEvent('police:byebyeweapons')
AddEventHandler('police:byebyeweapons', function(target)
	local playerped = GetPlayerPed(-1)
	RemoveAllPedWeapons(playerped, true)
end)
--==============================================================================================================================--
--Fines
local lockAskingFine = false
RegisterNetEvent('police:payFines')
AddEventHandler('police:payFines', function(amount, sender)
	Citizen.CreateThread(function()
		
		if(lockAskingFine ~= true) then
			lockAskingFine = true
			local notifReceivedAt = GetGameTimer()
			local msg = "Press <span style='color:lime'>Y</span> to accept the fine of <span style='color:lime'>$</span>".. amount ..", press <span style='color:red'>L</span>  to reject it!"
			exports.pNotify:SendNotification({text = msg,type = "error",timeout = 30000,layout = "centerRight",queue = "left"})
			while(true) do
				Wait(0)
				
				if (GetTimeDifference(GetGameTimer(), notifReceivedAt) > 30000) then
					TriggerServerEvent('police:finesETA', sender, 2)
					exports.pNotify:SendNotification({text = "The application for the fine has expired.",type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
					lockAskingFine = false
					break
				end
				
				if IsControlPressed(1, 246) then
					TriggerServerEvent('bank:withdrawAmende', amount)

					local msg = "You paid the fine of $ ".. amount .."."
					exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
					TriggerServerEvent('police:finesETA', sender, 0)
					lockAskingFine = false
					break
				end
				
				if IsControlPressed(1, 7) then
					local msg = "You refused to pay the fine."
					exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
					TriggerServerEvent('police:finesETA', sender, 3)
					lockAskingFine = false
					break
				end
			end
		else
			TriggerServerEvent('police:finesETA', sender, 1)
		end
	end)
end)

RegisterNetEvent('police:forceFines')
AddEventHandler('police:forceFines', function(amount)
    TriggerServerEvent('bank:withdrawAmende', amount)
    local msg = "You paid the fine of $ ".. amount .."."
    exports.pNotify:SendNotification({text = msg,type = "error",timeout = 10000,layout = "centerRight",queue = "left"})
end)
--==============================================================================================================================--
--Radar
local info =""
local targetVehicle = nil
local CoordA = nil
local CoordB = nil
local maxSpeed= 40.0
local minSpeed= 0.0
RegisterNetEvent("police:speedgun")
AddEventHandler("police:speedgun",function()
    targetVehicle = getVehicleInDirection(coordA, coordB)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if(isInService) then
	        radartxt(0.66, 1.3, 1.0, 1.0, 0.40, info, 255, 255, 255, 255)	     
			local pos = GetEntityCoords(GetPlayerPed(-1))
			local playerped = GetPlayerPed(-1)
			coordA = GetEntityCoords(playerped, 1)
			coordB = GetOffsetFromEntityInWorldCoords(playerped, 5.0, 60.0, 1.0)
			if targetVehicle ~= 0 and targetVehicle ~= nil then
				local vmodel = GetEntityModel(targetVehicle)
				local vname = GetLabelText(GetDisplayNameFromVehicleModel(vmodel))
				local plate = GetVehicleNumberPlateText(targetVehicle)
				local herSpeedKm = GetEntitySpeed(targetVehicle)*3.6
				local herSpeedMph = GetEntitySpeed(targetVehicle)*2.236936
				if herSpeedKm >= minSpeed then
			    	if herSpeedKm < maxSpeed then 
			      		if plate ~= nil then
							info = string.format("~b~Model:~w~ %s ~n~~b~Plate:~w~ %s ~n~~y~Km/h: ~g~%s~n~~y~Mph: ~g~%s",vname,plate,math.ceil(herSpeedKm),math.ceil(herSpeedMph) )
						end
					else
				  		if plate ~= nil then
							info = string.format("~b~Model:~w~ %s ~n~~b~Plate:~w~ %s ~n~~y~Km/h: ~g~%s~n~~y~Mph: ~g~%s",vname,plate,math.ceil(herSpeedKm),math.ceil(herSpeedMph) )
				  		end
					end 
				end
			end
    	end
    end
end)

function radartxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
	if vehicle ~= nil and vehicle ~= 0 then
		return vehicle
	else

    end
end
--==============================================================================================================================--
--Spike strips

local spikes_deployed = false
local obj1 = nil
local obj2 = nil
local obj3 = nil

--Distance check
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if spikes_deployed then
            for peeps = 0, 32 do
                if NetworkIsPlayerActive(peeps) then                    
                    local currentVeh = GetVehiclePedIsIn(GetPlayerPed(peeps), false)
                    if currentVeh ~= nil and currentVeh ~= false then
                        local currentVehcoords = GetEntityCoords(currentVeh, true)
                        local obj1coords = GetEntityCoords(obj1, true)
                        local obj2coords = GetEntityCoords(obj2, true)
                        local obj3coords = GetEntityCoords(obj3, true)
                        local DistanceBetweenObj1 = Vdist(obj1coords['x'], obj1coords['y'], obj1coords['z'], currentVehcoords['x'], currentVehcoords['y'], currentVehcoords['z'])
                        local DistanceBetweenObj2 = Vdist(obj2coords['x'], obj2coords['y'], obj2coords['z'], currentVehcoords['x'], currentVehcoords['y'], currentVehcoords['z'])
                        local DistanceBetweenObj3 = Vdist(obj3coords['x'], obj3coords['y'], obj3coords['z'], currentVehcoords['x'], currentVehcoords['y'], currentVehcoords['z'])
                        if DistanceBetweenObj1 < 2.2 or DistanceBetweenObj2 < 2.2 or DistanceBetweenObj3 < 2.2 then
                            if IsVehicleTyreBurst(currentVeh, 0, true) and IsVehicleTyreBurst(currentVeh, 1, true) and IsVehicleTyreBurst(currentVeh, 2, true) and IsVehicleTyreBurst(currentVeh, 3, true) and IsVehicleTyreBurst(currentVeh, 4, true) and IsVehicleTyreBurst(currentVeh, 5, true) then
                            elseif IsVehicleTyreBurst(currentVeh, 0, true) and IsVehicleTyreBurst(currentVeh, 1, true) and IsVehicleTyreBurst(currentVeh, 4, true) and IsVehicleTyreBurst(currentVeh, 5, true) then
                            else
                                TriggerServerEvent("police:spikes", currentVeh, GetPlayerServerId(peeps))
                            end
                        end
                    end
                end
            end
        end
    end
end)
--Distance check
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if spikes_deployed then
            local obj1coords = GetEntityCoords(obj1, true)
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), obj1coords.x, obj1coords.y, obj1coords.z, true) > 200 then -- if the player is too far from his Spikes
                SetEntityAsMissionEntity(obj1, false, false)
                SetEntityAsMissionEntity(obj2, false, false)
                SetEntityAsMissionEntity(obj3, false, false)
                SetEntityVisible(obj1, false)
                SetEntityVisible(obj2, false)
                SetEntityVisible(obj3, false)
                DeleteObject(obj1)
                DeleteObject(obj2)
                DeleteObject(obj3)
                DeleteEntity(obj1)
                DeleteEntity(obj2)
                DeleteEntity(obj3)
                obj1 = nil
                obj2 = nil
                obj3 = nil
                exports.pNotify:SendNotification({text = "Removing spikes! (D>200)",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
                spikes_deployed = false
            end
        end
    end
end)
--Spikes spawn/remove
RegisterNetEvent("police:Deploy")
AddEventHandler("police:Deploy", function()
    Citizen.CreateThread(function()
        if not spikes_deployed then
            local spikes = GetHashKey("p_stinger_04")
            RequestModel(spikes)
            while not HasModelLoaded(spikes) do
                Citizen.Wait(0)
            end
            exports.pNotify:SendNotification({text = "Deploying spikes!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            local playerheading = GetEntityHeading(GetPlayerPed(-1))
            coords1 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 3, 10, -0.7)
            coords2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -5, -0.5)
            obj1 = CreateObject(spikes, coords1['x'], coords1['y'], coords1['z'], true, true, true)
            obj2 = CreateObject(spikes, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            obj3 = CreateObject(spikes, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            SetEntityHeading(obj1, playerheading)
            SetEntityHeading(obj2, playerheading)
            SetEntityHeading(obj3, playerheading)
            AttachEntityToEntity(obj1, GetPlayerPed(-1), 1, 0.0, 4.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(obj2, GetPlayerPed(-1), 1, 0.0, 8.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(obj3, GetPlayerPed(-1), 1, 0.0, 12.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            Citizen.Wait(10)
            DetachEntity(obj1, true, true)
            DetachEntity(obj2, true, true)
            DetachEntity(obj3, true, true)
            spikes_deployed = true
        else
            spikes_deployed = false
            exports.pNotify:SendNotification({text = "Removing spikes!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            SetEntityCoords(obj1, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(obj2, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(obj3, -5000.0, -5000.0, 20.0, true, false, false, true)
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj1))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj2))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(obj3))
            FIX_DeleteObject(obj1)
            FIX_DeleteObject(obj2)
            FIX_DeleteObject(obj3)
            obj1 = nil
            obj2 = nil
            obj3 = nil
        end
    end)
end)
--Tyre burst sync
RegisterNetEvent("police:dietyres")
AddEventHandler("police:dietyres", function(currentVeh)
    SetVehicleTyreBurst(currentVeh, 0, true, 0)
    SetVehicleTyreBurst(currentVeh, 1, true, 1)
    SetVehicleTyreBurst(currentVeh, 2, true, 1)
    SetVehicleTyreBurst(currentVeh, 3, true, 1)
    SetVehicleTyreBurst(currentVeh, 4, true, 3)
    SetVehicleTyreBurst(currentVeh, 5, true, 4)
end)

RegisterNetEvent("police:dietyres2")
AddEventHandler("police:dietyres2", function(peeps)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 0, true, 0)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 1, true, 1)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 2, true, 1)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 3, true, 1)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 4, true, 3)
    SetVehicleTyreBurst(GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(peeps)), false), 5, true, 4)
end)
--==============================================================================================================================--
--Misc loops

--Make police cars undrivable for civs
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerId())) then
            local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
            if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
				if isInService == false and exports.emsjob:getIsInService() == true then
				elseif isInService == true and exports.emsjob:getIsInService() == false then
				elseif isInService == true and exports.emsjob:getIsInService() == true then
				elseif isInService == false and exports.emsjob:getIsInService() == false then
					drawTxt("~r~It's against the rules for civilians to drive these vehicles!",0,1,0.5,0.8,0.6,255,255,255,255)           
					SetVehicleUndriveable(veh, true)
				end
			end
        end
    end
end)

--Give chop the dog unlimited stamina
Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
    	local dog = GetEntityModel(GetPlayerPed(-1))
        if dog == -1788665315 then    
        	RestorePlayerStamina(PlayerId(), 1.0)
        end
    end
end)

--Make civs ragdoll that we bit longer when tazed
local ragdoll = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedBeingStunned(GetPlayerPed(-1)) then
			ragdoll = 1
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
		if ragdol == 1 then
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			wait(5000)
			ragdol = 0
 		end
    end	
end)
--==============================================================================================================================--
--Portable speed camera

RegisterNetEvent("police:placeCam")
AddEventHandler("police:placeCam",function()
    police_radar()
end)

local maxSpeedd = 0
local info = ""
local isRadarPlaced = false -- bolean to get radar status
local Radar -- entity object
local RadarBlip -- blip
local RadarPos = {} -- pos
local RadarAng = 0 -- angle
local LastPlate = ""
local LastVehDesc = ""
local LastSpeed = 0
local LastInfo = ""
 
local function GetClosestDrivingPlayerFromPos(radius, pos)
    local players = GetPlayers()
    local closestDistance = radius or -1
    local closestPlayer = -1
    local closestVeh = -1
    for _ ,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local ped = GetPlayerPed(value)
            if GetVehiclePedIsUsing(ped) ~= 0 then
                local targetCoords = GetEntityCoords(ped, 0)
                local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], pos["x"], pos["y"], pos["z"], true)
                if(closestDistance == -1 or closestDistance > distance) then
                    closestVeh = GetVehiclePedIsUsing(ped)
                    closestPlayer = value
                    closestDistance = distance
                end
            end
        end
    end
    return closestPlayer, closestVeh, closestDistance
end
 
 
function radarSetSpeed(defaultText)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", defaultText or "", "", "", "", 5)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local gettxt = tonumber(GetOnscreenKeyboardResult())
        if gettxt ~= nil then
            return gettxt
        else
            ClearPrints()
            SetTextEntry_2("STRING")
            AddTextComponentString("~r~Please enter a correct number !")
            DrawSubtitleTimed(3000, 1)
            return
        end
    end
    return
end
 
 
local function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
 
function police_radar()
    if isRadarPlaced then -- remove the previous radar if it exists, only one radar per cop
       
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), RadarPos.x, RadarPos.y, RadarPos.z, true) < 0.9 then -- if the player is close to his radar
       
            RequestAnimDict("anim@apt_trans@garage")
            while not HasAnimDictLoaded("anim@apt_trans@garage") do
               Wait(1)
            end
            TaskPlayAnim(GetPlayerPed(-1), "anim@apt_trans@garage", "gar_open_1_left", 1.0, -1.0, 5000, 0, 1, true, true, true) -- animation
       
            Citizen.Wait(2000) -- prevent spam radar + synchro spawn with animation time
       
            SetEntityAsMissionEntity(Radar, false, false)
           
            DeleteObject(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
            DeleteEntity(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
            Radar = nil
            RadarPos = {}
            RadarAng = 0
            isRadarPlaced = false
           
            RemoveBlip(RadarBlip)
            RadarBlip = nil
            LastPlate = ""
            LastVehDesc = ""
            LastSpeed = 0
            LastInfo = ""
           
        else
           
            ClearPrints()
            SetTextEntry_2("STRING")
            AddTextComponentString("~r~You are not next to your Radar !")
            DrawSubtitleTimed(3000, 1)
           
            Citizen.Wait(1500) -- prevent spam radar
       
        end
   
    else -- or place a new one
        maxSpeedd = radarSetSpeed("50")
       
        Citizen.Wait(200) -- wait if the player was in moving
        RadarPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.5, 0)
        RadarAng = GetEntityRotation(GetPlayerPed(-1))
       
        if maxSpeedd ~= nil then -- maxSpeed = nil only if the player hasn't entered a valid number
       
            RequestAnimDict("anim@apt_trans@garage")
            while not HasAnimDictLoaded("anim@apt_trans@garage") do
               Wait(1)
            end
            TaskPlayAnim(GetPlayerPed(-1), "anim@apt_trans@garage", "gar_open_1_left", 1.0, -1.0, 5000, 0, 1, true, true, true) -- animation
           
            Citizen.Wait(1500) -- prevent spam radar placement + synchro spawn with animation time
           
            RequestModel("prop_cctv_pole_01a")
            while not HasModelLoaded("prop_cctv_pole_01a") do
               Wait(1)
            end
           
            Radar = CreateObject(1927491455, RadarPos.x, RadarPos.y, RadarPos.z - 7, true, true, true) -- http://gtan.codeshock.hu/objects/index.php?page=1&search=prop_cctv_pole_01a
            SetEntityRotation(Radar, RadarAng.x, RadarAng.y, RadarAng.z - 115)
            -- SetEntityInvincible(Radar, true) -- doesn't work, radar still destroyable
            -- PlaceObjectOnGroundProperly(Radar) -- useless
            SetEntityAsMissionEntity(Radar, true, true)
           
            FreezeEntityPosition(Radar, true) -- set the radar invincible (yeah, SetEntityInvincible just not works, okay FiveM.)
 
            isRadarPlaced = true
           
            RadarBlip = AddBlipForCoord(RadarPos.x, RadarPos.y, RadarPos.z)
            SetBlipSprite(RadarBlip, 380) -- 184 = cam
            SetBlipColour(RadarBlip, 1) -- https://github.com/Konijima/WikiFive/wiki/Blip-Colors
            SetBlipAsShortRange(RadarBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Radar")
            EndTextCommandSetBlipName(RadarBlip)
       
        end
       
    end
end
 
Citizen.CreateThread(function()
    while true do
        Wait(0)
 
        if isRadarPlaced then
       
            if HasObjectBeenBroken(Radar) then -- check is the radar is still there
               
                SetEntityAsMissionEntity(Radar, false, false)
                SetEntityVisible(Radar, false)
                DeleteObject(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
                DeleteEntity(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
               
                Radar = nil
                RadarPos = {}
                RadarAng = 0
                isRadarPlaced = false
               
                RemoveBlip(RadarBlip)
                RadarBlip = nil
               
                LastPlate = ""
                LastVehDesc = ""
                LastSpeed = 0
                LastInfo = ""
               
            end
           
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), RadarPos.x, RadarPos.y, RadarPos.z, true) > 100 then -- if the player is too far from his radar
           
                SetEntityAsMissionEntity(Radar, false, false)
                SetEntityVisible(Radar, false)
                DeleteObject(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
                DeleteEntity(Radar) -- remove the radar pole (otherwise it leaves from inside the ground)
               
                Radar = nil
                RadarPos = {}
                RadarAng = 0
                isRadarPlaced = false
               
                RemoveBlip(RadarBlip)
                RadarBlip = nil
               
                LastPlate = ""
                LastVehDesc = ""
                LastSpeed = 0
                LastInfo = ""
               
                ClearPrints()
                SetTextEntry_2("STRING")
                AddTextComponentString("~r~Too far from your radar !")
                DrawSubtitleTimed(3000, 1)
               
            end
           
        end
       
        if isRadarPlaced then
 
            local viewAngle = GetOffsetFromEntityInWorldCoords(Radar, -8.0, -4.4, 0.0) -- forwarding the camera angle, to increase or reduce the distance, just make a cross product like this one :  ( X * 11.0 ) / 20.0 = Y   gives  (Radar, X, Y, 0.0)
            local ply, veh, dist = GetClosestDrivingPlayerFromPos(20, viewAngle) -- viewAngle
 
            if veh ~= nil then
           
                local vehPlate = GetVehicleNumberPlateText(veh) or ""
                local vehSpeedMph= GetEntitySpeed(veh)*2.236936
                local vehDesc = GetDisplayNameFromVehicleModel(GetEntityModel(veh))--.." "..GetVehicleColor(veh)
                if vehDesc == "CARNOTFOUND" then vehDesc = "" end

                if vehSpeedMph < maxSpeedd then
                    info = string.format("~b~Vehicle  ~w~ %s ~n~~b~Plate    ~w~ %s ~n~~y~Mp/h        ~g~%s", vehDesc, vehPlate, math.ceil(vehSpeedMph))
                else
                    info = string.format("~b~Vehicle  ~w~ %s ~n~~b~Plate    ~w~ %s ~n~~y~Mp/h        ~r~%s", vehDesc, vehPlate, math.ceil(vehSpeedMph))
                    if LastPlate ~= vehPlate then
                        LastSpeed = vehSpeedMph
                        LastVehDesc = vehDesc
                        LastPlate = vehPlate
                    elseif LastSpeed < vehSpeedMph and LastPlate == vehPlate then
                            LastSpeed = vehSpeedMph
                    end
                    LastInfo = string.format("~b~Vehicle  ~w~ %s ~n~~b~Plate    ~w~ %s ~n~~y~Mp/h        ~r~%s", LastVehDesc, LastPlate, math.ceil(LastSpeed))
                end
                   
                DrawRect(0.76, 0.0455, 0.18, 0.09, 0,10, 28, 210)
                drawTxt(0.77, 0.1, 0.185, 0.206, 0.40, info, 255, 255, 255, 255)
               
                DrawRect(0.76, 0.145, 0.18, 0.09, 0,10, 28, 210)
                drawTxt(0.77, 0.20, 0.185, 0.206, 0.40, LastInfo, 255, 255, 255, 255)
                 
                -- end
               
            end
           
        end
           
    end  
end)
--==============================================================================================================================--
--Cones
local cones_deployed = false
local cobj1 = nil
local cobj2 = nil
local cobj3 = nil
local cobj4 = nil
local cobj5 = nil

RegisterNetEvent("police:DeployC")
AddEventHandler("police:DeployC", function()
    Citizen.CreateThread(function()
        if not cones_deployed then
            local cones = GetHashKey("prop_mp_cone_02")
            RequestModel(cones)
            while not HasModelLoaded(cones) do
                Citizen.Wait(0)
            end
            exports.pNotify:SendNotification({text = "Deploying cones!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            local playerheading = GetEntityHeading(GetPlayerPed(-1))
            coords1 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 3, 10, -0.7)
            coords2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -5, -0.5)
            cobj1 = CreateObject(cones, coords1['x'], coords1['y'], coords1['z'], true, true, true)
            cobj2 = CreateObject(cones, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            cobj3 = CreateObject(cones, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            cobj4 = CreateObject(cones, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            cobj5 = CreateObject(cones, coords2['x'], coords2['y'], coords2['z'], true, true, true)
            SetEntityHeading(cobj1, playerheading)
            SetEntityHeading(cobj2, playerheading)
            SetEntityHeading(cobj3, playerheading)
            SetEntityHeading(cobj4, playerheading)
            SetEntityHeading(cobj5, playerheading)
            AttachEntityToEntity(cobj1, GetPlayerPed(-1), 1, 0.0, 4.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(cobj2, GetPlayerPed(-1), 1, 0.0, 8.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(cobj3, GetPlayerPed(-1), 1, 0.0, 12.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(cobj4, GetPlayerPed(-1), 1, 0.0, 16.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            AttachEntityToEntity(cobj5, GetPlayerPed(-1), 1, 0.0, 20.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
            Citizen.Wait(10)
            DetachEntity(cobj1, true, true)
            DetachEntity(cobj2, true, true)
            DetachEntity(cobj3, true, true)
            DetachEntity(cobj4, true, true)
            DetachEntity(cobj5, true, true)
            cones_deployed = true
        else
            cones_deployed = false
            exports.pNotify:SendNotification({text = "Removing cones!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"}) 
            SetEntityCoords(cobj1, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(cobj2, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(cobj3, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(cobj4, -5000.0, -5000.0, 20.0, true, false, false, true)
            SetEntityCoords(cobj5, -5000.0, -5000.0, 20.0, true, false, false, true)
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj1))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj2))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj3))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj4))
            Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(cobj5))
            FIX_DeleteObject(cobj1)
            FIX_DeleteObject(cobj2)
            FIX_DeleteObject(cobj3)
            FIX_DeleteObject(cobj4)
            FIX_DeleteObject(cobj5)
            cobj1 = nil
            cobj2 = nil
            cobj3 = nil
            cobj4 = nil
            cobj5 = nil
        end
    end)
end)

---Make all peds fuck off at the sight of cones
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if cones_deployed then
            local o1x, o1y, o1z = table.unpack(GetEntityCoords(cobj1, true))
            local cVeh = GetClosestVehicle(o1x, o1y, o1z, 50.1, 0, 70)
            if(IsEntityAVehicle(cVeh)) then
                if IsEntityAtEntity(cVeh, cobj1, 20.0, 20.0, 2.0, 0, 1, 0) then
                    local cDriver = GetPedInVehicleSeat(cVeh, -1)
                    TaskVehicleTempAction(cDriver, cVeh, 6, 1000)
                    SetVehicleHandbrake(cVeh, true)
                end
            end
            local o2x, o2y, o2z = table.unpack(GetEntityCoords(cobj2, true))
            local cVeh2 = GetClosestVehicle(o2x, o2y, o2z, 50.1, 0, 70)
            if(IsEntityAVehicle(cVeh2)) then
                if IsEntityAtEntity(cVeh2, cobj2, 20.0, 20.0, 2.0, 0, 1, 0) then
                    local cDriver = GetPedInVehicleSeat(cVeh2, -1)
                    TaskVehicleTempAction(cDriver, cVeh2, 6, 1000)
                    SetVehicleHandbrake(cVeh2, true)
                end
            end
            local o3x, o3y, o3z = table.unpack(GetEntityCoords(cobj3, true))
            local cVeh3 = GetClosestVehicle(o3x, o3y, o3z, 50.1, 0, 70)
            if(IsEntityAVehicle(cVeh3)) then
                if IsEntityAtEntity(cVeh3, cobj3, 20.0, 20.0, 2.0, 0, 1, 0) then
                    local cDriver = GetPedInVehicleSeat(cVeh3, -1)
                    TaskVehicleTempAction(cDriver, cVeh3, 6, 1000)
                    SetVehicleHandbrake(cVeh3, true)
                end
            end
            local o4x, o4y, o4z = table.unpack(GetEntityCoords(cobj3, true))
            local cVeh4 = GetClosestVehicle(o4x, o4y, o4z, 50.1, 0, 70)
            if(IsEntityAVehicle(cVeh4)) then
                if IsEntityAtEntity(cVeh3, cobj3, 20.0, 20.0, 2.0, 0, 1, 0) then
                    local cDriver = GetPedInVehicleSeat(cVeh4, -1)
                    TaskVehicleTempAction(cDriver, cVeh4, 6, 1000)
                    SetVehicleHandbrake(cVeh4, true)
                end
            end
            local o5x, o5y, o5z = table.unpack(GetEntityCoords(cobj3, true))
            local cVeh5 = GetClosestVehicle(o5x, o5y, o5z, 50.1, 0, 70)
            if(IsEntityAVehicle(cVeh5)) then
                if IsEntityAtEntity(cVeh3, cobj3, 20.0, 20.0, 2.0, 0, 1, 0) then
                    local cDriver = GetPedInVehicleSeat(cVeh5, -1)
                    TaskVehicleTempAction(cDriver, cVeh5, 6, 1000)
                    SetVehicleHandbrake(cVeh5, true)
                end
            end
        end
    end
end)
--==============================================================================================================================--
--Breathalyzer

DecorRegister("BAC_Active", 2)
DecorSetBool(GetPlayerPed(-1), "BAC_Active", false)
DecorRegister("_BAC_Level", 1)
DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", 0.0)

function addBAC(amount)
    local BAC_Driving_Limit = 0.08
    local currentBAC = DecorGetFloat(GetPlayerPed(-1), "_BAC_Level")
    local newBAC = currentBAC + amount
    DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", newBAC)
    if newBAC >= BAC_Driving_Limit then
        local isBACactive = DecorGetBool(GetPlayerPed(-1), "BAC_Active")
        if not isBACactive then
            DecorSetBool(GetPlayerPed(-1), "BAC_Active", true)  
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Every Minute remove some BAC
        local currentBAC = DecorGetFloat(GetPlayerPed(-1), "_BAC_Level")
        if currentBAC > 0 then
            local newBAC = currentBAC - 0.0005 --BAC to remove

            if newBAC < 0 then
                newBAC = 0
            end
            DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", newBAC) 
            if newBAC == 0 then
                DecorSetBool(GetPlayerPed(-1), "BAC_Active", false) 
            end
        end

    end
end)
--==============================================================================================================================--
--Gunshot residue test 

local GSR_LastShot = 0
local GSR_ExpireTime = 15 -- Minutes
DecorRegister("GSR_Active", 2)
DecorSetBool(GetPlayerPed(-1), "GSR_Active", false) 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsPedShooting(GetPlayerPed(-1)) then
            TriggerEvent("police:wfired")
        end
        local isGSRactive = DecorGetBool(GetPlayerPed(-1), "GSR_Active")
        if isGSRactive then
            if GSR_LastShot + (GSR_ExpireTime * 1000 * 60) <= GetGameTimer() then
                DecorSetBool(GetPlayerPed(-1), "GSR_Active", false)     
            end
        end
    end
end)

AddEventHandler("police:wfired", function()
    GSR_LastShot = GetGameTimer()
    local isGSRactive = DecorGetBool(GetPlayerPed(-1), "GSR_Active")
    if not isGSRactive then
        DecorSetBool(GetPlayerPed(-1), "GSR_Active", true)
    end
end)
--==============================================================================================================================--
--Charges
currentSuspectCharges = {}
currentSuspect = ""

function addCharge(data)
    if currentSuspectCharges[data.charge] == nil then
        currentSuspectCharges[data.charge] = {}
        currentSuspectCharges[data.charge].cost = data.cost
        currentSuspectCharges[data.charge].time = data.time
        currentSuspectCharges[data.charge].count = 1
    else
        currentSuspectCharges[data.charge].cost = currentSuspectCharges[data.charge].cost + data.cost
        currentSuspectCharges[data.charge].time = currentSuspectCharges[data.charge].time + data.time
        currentSuspectCharges[data.charge].count = currentSuspectCharges[data.charge].count + 1
    end
    TriggerEvent("customNotification","Added Charge: " .. data.charge)
end

function reviewCharges()
    local charges = {}
    local time = 0
    local cost = 0
    for key, val in pairs(currentSuspectCharges) do            
        charges[#charges+1] = (" ^3[" .. currentSuspectCharges[key].count .. "x]^5 " .. key .. "")
        time = time + currentSuspectCharges[key].time
        cost = cost + currentSuspectCharges[key].cost
    end
    charges[#charges+1] = (" ^1||^0 Suggested Jailtime: ^3" .. time .. "^0 seconds ^1" .. "||^0 Suggested Cost: ^2$^3" .. cost .. "")
    TriggerEvent('chatMessage', '[Charges]', {255, 0, 0}, table.concat(charges))
end

function applyCharges()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        local charges = {}
        local time = 0
        local cost = 0
        for key, val in pairs(currentSuspectCharges) do
            charges[#charges+1] = (" ^3[" .. currentSuspectCharges[key].count .. "x]^5 " .. key .. "")
            time = time + currentSuspectCharges[key].time
            cost = cost + currentSuspectCharges[key].cost
        end
        charges[#charges+1] = (" ^1|| ^0 Cost: $^3" .. cost .. "")
        currentSuspect = GetPlayerName(t)
        TriggerServerEvent("police:showCharges", GetPlayerServerId(t), charges)
    else
        Messages(1)
    end
end

function clearCharges()
    currentSuspectCharges = {}
    TriggerEvent("customNotification","Charges Cleared")
end
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
