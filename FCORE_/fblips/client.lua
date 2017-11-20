local blips_client = {}
local blips_server = {}

function serviceBlips(service)
	for _, existing in ipairs(blips_client) do
		RemoveBlip(existing)
	end

	blips_client = {}

	local blips_client_temp = {}

	for i = 0, 32 do
		if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= GetPlayerPed(-1) then
			for k,v in pairs(blips_server) do
				if k == GetPlayerServerId(i) then
					blips_client_temp[i] = v
					break
				end
			end
		end
	end

	for id,_ in ipairs(blips_client_temp) do
		local blip = GetBlipFromEntity(GetPlayerPed(id))
		if not DoesBlipExist(blip) then
			blip = AddBlipForEntity(GetPlayerPed(id))
			SetBlipSprite(blip,1)
			Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
			HideNumberOnBlip(blip)
			SetBlipNameToPlayerName(blip,id)
			if service == "ems" then
				SetBlipColour(blip, 1)
			elseif service == "police" then
				SetBlipColour(blip, 67)
			end
			SetBlipScale(blip,0.85)
			SetBlipAlpha(blip,255)
			table.insert(blips_client, blip)
		else
			local sprite = GetBlipSprite(blip)
			HideNumberOnBlip(blip)
			if sprite ~= 1 then
				SetBlipSprite(blip,1)
				Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true)
			end

			SetBlipNameToPlayerName(blip,id)
			SetBlipScale(blip,0.85)
			SetBlipAlpha(blip,255)
			table.insert(blips_client, blip)			
		end
	end
end

RegisterNetEvent("fblips:remove")
AddEventHandler("fblips:remove", function()
	blips_server = {}
	for _, existing in pairs(blips_client) do
		RemoveBlip(existing)
	end
end)

RegisterNetEvent("fblips:sync")
AddEventHandler("fblips:sync", function(tbl)
	blips_server = tbl
	local service = nil
	if exports.policejob:isUseraCop() then
		service = "police"
	elseif exports.fbijob:isUseraParamedic() then
		service = "ems"
	end
	serviceBlips(service)
end)