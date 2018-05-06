isParamedic = false
isInService = false
rank = ""
existingVeh = nil
settings = {
	force = "FDNY", --LifeMed,FDNY,Los Angeles EMS
}
-- Location to enable an officer service
local takingService = {
	{x=1155.26, y=-1520.82, z=34.84},
	{x=295.411, y=-1446.88, z=29.9666},
	{x=361.145, y=-584.414, z=28.8277},
	{x=-449.639, y=-340.586, z=34.5018},
	{x=-874.467, y=-307.896, z=39.5699},
	{x=-677.135, y=310.275, z=83.0842},
	{x=1839.39, y=3672.78, z=34.2767},
	{x=-242.968, y=6326.29, z=32.4262},
}
local inamount = 0
RegisterNetEvent('paramedic:activate')
AddEventHandler('paramedic:activate', function(r)
	isParamedic = true
	rank = r
end)

RegisterNetEvent('paramedic:nowParamedic')
AddEventHandler('paramedic:nowParamedic', function(r)
	TriggerServerEvent("js:jobs", 15)
	isParamedic = true
	rank = r
end)

RegisterNetEvent('paramedic:noLongerParamedic')
AddEventHandler('paramedic:noLongerParamedic', function()
	isParamedic = false
	isInService = false
	TriggerServerEvent("js:jobs", 1)
	TriggerServerEvent("paramedic:setService", isInService)
	TriggerServerEvent("paramedic:breakService")
	RemoveParamedicBlips()
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

function getParamedicRank()
	return rank
end

function isNearTakeService()
	for i = 1, #takingService do
		local pos = GetEntityCoords(GetPlayerPed(-1), 0)
		local distance = GetDistanceBetweenCoords(takingService[i].x, takingService[i].y, takingService[i].z, pos.x, pos.y, pos.z, true)
		if(distance < 30) then
			DrawMarker(1, takingService[i].x, takingService[i].y, takingService[i].z-1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 0, 155, 0, 155, 0, 0, 2, 0, 0, 0, 0)
		end
		if(distance < 2) then
			return true
		end
	end
end

Citizen.CreateThread(function()
    for _, item in pairs(takingService) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, 61)
      SetBlipColour(item.blip, 2)
      SetBlipScale(item.blip, 0.8)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Hospital")
      EndTextCommandSetBlipName(item.blip)
    end
    while true do
        Citizen.Wait(0)
        if(isParamedic) then
			if(isNearTakeService()) then
				if(isInService) then
					drawTxt("Press ~g~E~s~ to go off duty as civilian.",0,1,0.5,0.8,0.6,255,255,255,255)
				else
					drawTxt("Press ~g~E~s~ to go on duty as "..settings.force..".",0,1,0.5,0.8,0.6,255,255,255,255)
				end
				if IsControlJustReleased(1, 38)  then
					isInService = not isInService
					TriggerServerEvent("paramedic:setService", isInService)
					
					if(isInService) then
						TriggerServerEvent("paramedic:loadclothing")
						TriggerServerEvent("paramedic:takeService")
						TriggerServerEvent("paramedic:getinteriors")
						AddParamedicBlips()
					else
						RemoveAllPedWeapons(GetPlayerPed(-1), true)
						TriggerServerEvent("clothes:spawn")
						TriggerServerEvent("paramedic:breakService")
						RemoveParamedicBlips()
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
        if MedicCallStatus ~= 0 then
            if MedicCallStatus == 1 then
                drawThisTxt(0.283, 0.92 - inamount, 0.25, 0.03, 0.50,'~g~A unit will arrive at the location of the call',255,255,255,255,6)
            else 
                if activeMedics == 0 then
                    drawThisTxt(0.283, 0.92 - inamount, 0.25, 0.03, 0.50,'~r~No paramedics in service',255,255,255,255,6)
                elseif availableMedics == 0 then
                    drawThisTxt(0.283, 0.92 - inamount, 0.25, 0.03, 0.50,'~o~All ambulances are occupied',255,255,255,255,6)
                else
                    drawThisTxt(0.283, 0.92 - inamount, 0.25, 0.03, 0.50,'~b~Your call is on hold',255,255,255,255,6)
                end
            end 
        end
    end
end)

function NotInService()
    isInService = false
    TriggerServerEvent("paramedic:setService", isInService)
	RemoveAllPedWeapons(GetPlayerPed(-1), true)
	TriggerServerEvent("clothes:spawn")
	TriggerServerEvent("paramedic:breakService")
	RemoveParamedicBlips()
end