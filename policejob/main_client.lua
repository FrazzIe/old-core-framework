isCop = false
isInService = false
rank = ""
existingVeh = nil
blipsCops = {}
allServiceCops = {}
settings = {
	force = "NYPD", --AST,NYPD,LAPD
}
-- Location to enable an officer service
local takingService = {
	{x=457.956909179688, y=-992.72314453125, z=30.6895866394043},  -- Mission Row
	{x=-449.90, y=6016.22, z= 31.72}, -- Paleto Bay
	{x=1857.01, y=3689.50, z=34.27}, -- Sandy Shores
	{x=-1113.65, y=-849.21, z=13.45}, -- San Andreas Ave
	{x=-561.28, y=-132.60, z=38.04}, -- Rockford Hills
}
local inamount = 0

RegisterNetEvent('police:activate')
AddEventHandler('police:activate', function(r)
	isCop = true
	rank = r
end)

RegisterNetEvent('police:nowCop')
AddEventHandler('police:nowCop', function(r)
	TriggerServerEvent("js:jobs", 2)
	isCop = true
	rank = r
end)

RegisterNetEvent('police:noLongerCop')
AddEventHandler('police:noLongerCop', function()
	isCop = false
	isInService = false
	TriggerServerEvent("js:jobs", 1)
	TriggerServerEvent("police:setService", isInService)
	TriggerServerEvent("police:breakService")
	BlipRemoval()
 	RemoveAllPedWeapons(GetPlayerPed(-1), true)
	TriggerServerEvent("clothes:spawn")
	if(existingVeh ~= nil) then
		SetEntityAsMissionEntity(existingVeh, true, true)
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(existingVeh))
		existingVeh = nil
	end
end)

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
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

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawThisTxt(x,y ,width,height,scale, text, r,g,b,a,font)
    SetTextFont(font)
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

function getIsInService()
	return isInService
end

function getIsCuffed()
	return handCuffed
end

function getPoliceRank()
	return rank
end

function isNearTakeService()
	for i = 1, #takingService do
		local pos = GetEntityCoords(GetPlayerPed(-1), 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, pos.x, pos.y, pos.z, true)
		if(distance < 30) then
			DrawMarker(1, takingService[i].x, takingService[i].y, takingService[i].z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 0, 0, 255, 155, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

Citizen.CreateThread(function()
    for _, item in pairs(takingService) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 60)
      SetBlipColour(item.blip, 28)
      SetBlipScale(item.blip, 0.8)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Police Station")
      EndTextCommandSetBlipName(item.blip)
    end
    while true do
        Citizen.Wait(0)
        if(isCop) then
			if(isNearTakeService()) then
				if(isInService) then
					drawTxt("Press ~g~E~s~ to go off duty as civilian.",0,1,0.5,0.8,0.6,255,255,255,255)
				else
					drawTxt("Press ~g~E~s~ to go on duty as "..settings.force..".",0,1,0.5,0.8,0.6,255,255,255,255)
				end
				if IsControlJustReleased(1, 38)  then
					isInService = not isInService
					TriggerServerEvent("police:setService", isInService)
					
					if(isInService) then
						TriggerServerEvent("police:loadclothing")
						TriggerServerEvent("police:takeService")
						AddPoliceBlips()
					else
						RemoveAllPedWeapons(GetPlayerPed(-1), true)
						TriggerServerEvent("clothes:spawn")
						TriggerServerEvent("police:breakService")
						RemovePoliceBlips()
						BlipRemoval()
					end
				end
			end
			if(isInService) then
				inamount = 0.03
				drawThisTxt(0.283, 0.92, 0.25, 0.03, 0.50,MissionInformation,255,255,255,255,6)
			end			
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CopCallStatus ~= 0 then
            if CopCallStatus == 1 then
                drawThisTxt(0.283, 0.92 - inamount, 0.25, 0.03, 0.50,'~g~A unit will arrive at the location of the call',255,255,255,255,6)
            else 
                if activeCops == 0 then
                    drawThisTxt(0.283, 0.92 - inamount, 0.25, 0.03, 0.50,'~r~No police officers in service',255,255,255,255,6)
                elseif availableCops == 0 then
                    drawThisTxt(0.283, 0.92 - inamount, 0.25, 0.03, 0.50,'~o~All our units are occupied',255,255,255,255,6)
                else
                    drawThisTxt(0.283, 0.92 - inamount, 0.25, 0.03, 0.50,'~b~Your call is on hold',255,255,255,255,6)
                end
            end 
        end
    end
end)

function NotInService()
    isInService = false
    TriggerServerEvent("police:setService", isInService)
	RemoveAllPedWeapons(GetPlayerPed(-1), true)
	TriggerServerEvent("clothes:spawn")
	TriggerServerEvent("police:breakService")
	BlipRemoval()
end

RegisterNetEvent('emergency:forceRespawn')
AddEventHandler('emergency:forceRespawn', function()
	if(isCop and isInService) then
		NotInService()
	end
		
	if(handCuffed == true) then
		handCuffed = false
	end
end)

function enableCopBlips()

	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
	
	local localIdCops = {}
	for id = 0, 64 do
		if(NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
			for i,c in pairs(allServiceCops) do
				if(i == GetPlayerServerId(id)) then
					localIdCops[id] = c
					break
				end
			end
		end
	end
	
	for id, c in pairs(localIdCops) do
		local ped = GetPlayerPed(id)
		local blip = GetBlipFromEntity(ped)
		
		if not DoesBlipExist( blip ) then

			blip = AddBlipForEntity( ped )
			SetBlipSprite( blip, 1 )
			Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			HideNumberOnBlip( blip )
			SetBlipNameToPlayerName( blip, id )
			
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsCops, blip)
		else
			
			blipSprite = GetBlipSprite( blip )
			
			HideNumberOnBlip( blip )
			if blipSprite ~= 1 then
				SetBlipSprite( blip, 1 )
				Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
			end
			
			Citizen.Trace("Name : "..GetPlayerName(id))
			SetBlipNameToPlayerName( blip, id )
			SetBlipScale( blip,  0.85 )
			SetBlipAlpha( blip, 255 )
			
			table.insert(blipsCops, blip)
		end
	end
end

function BlipRemoval()
	allServiceCops = {}
	
	for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
	blipsCops = {}
end

RegisterNetEvent('police:resultAllCopsInService')
AddEventHandler('police:resultAllCopsInService', function(array)
	allServiceCops = array
	enableCopBlips()
end)

function AddPoliceBlips()
	ClothingBlips()
	ArmouryBlips()
	GarageBlips()
end

function RemovePoliceBlips()
	RemoveClothingBlips()
	RemoveArmouryBlips()
	RemoveGarageBlips()
end