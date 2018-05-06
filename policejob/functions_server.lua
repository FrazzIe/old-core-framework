--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--Cop blips
inServiceCops = {}

RegisterServerEvent('police:setService')
AddEventHandler('police:setService', function (inService)
	TriggerEvent('f:getPlayer',source,function(Player)
		Player.setSessionVar('policeInService', inService)
	end)
end)

RegisterServerEvent('police:takeService')
AddEventHandler('police:takeService', function()
	local source = tonumber(source)
	if(not inServiceCops[source]) then
		inServiceCops[source] = GetPlayerName(source)
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

RegisterServerEvent('police:breakService')
AddEventHandler('police:breakService', function()
	local source = tonumber(source)
	if(inServiceCops[source]) then
		inServiceCops[source] = nil		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

RegisterServerEvent('police:getAllCopsInService')
AddEventHandler('police:getAllCopsInService', function()
	local source = tonumber(source)
	TriggerClientEvent("police:resultAllCopsInService", source, inServiceCops)
end)

AddEventHandler('playerDropped', function()
	local source = tonumber(source)
	if(inServiceCops[source]) then
		inServiceCops[source] = nil		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)
--==============================================================================================================================--
--Cuffing
RegisterServerEvent('police:cuffGranted')
AddEventHandler('police:cuffGranted', function(t)
	TriggerClientEvent('police:getArrested', t)
end)
--==============================================================================================================================--
--Dragging
RegisterServerEvent('police:dragRequest')
AddEventHandler('police:dragRequest', function(t)
	TriggerClientEvent('police:toggleDrag', t, source)
end)
--==============================================================================================================================--
--Force enter
RegisterServerEvent('police:forceEnterAsk')
AddEventHandler('police:forceEnterAsk', function(t, v)
	TriggerClientEvent('police:forcedEnteringVeh', t, v)
end)
--Force exit
RegisterServerEvent('police:confirmUnseat')
AddEventHandler('police:confirmUnseat', function(t)
	TriggerClientEvent('police:unseatme', t)
end)
--==============================================================================================================================--
--Fines
RegisterServerEvent('police:finesGranted')
AddEventHandler('police:finesGranted', function(target, amount)
	TriggerClientEvent('police:payFines', target, amount, source)
end)

RegisterServerEvent('police:finesETA')
AddEventHandler('police:finesETA', function(officer, code)
	if(code==1) then
        TriggerClientEvent("pNotify:SendNotification", officer, {text = '' ..GetPlayerName(source)..' already has a request for a fine',type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
	elseif(code==2) then
        TriggerClientEvent("pNotify:SendNotification", officer, {text = '' ..GetPlayerName(source)..' did not respond to the request in time',type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
	elseif(code==3) then
       	TriggerClientEvent("pNotify:SendNotification", officer, {text = '' ..GetPlayerName(source)..' has refused to pay their fine',type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
	elseif(code==0) then
       	TriggerClientEvent("pNotify:SendNotification", officer, {text = '' ..GetPlayerName(source)..' has successfully paid their fine.',type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
	end
end)

RegisterServerEvent('police:finesForced')
AddEventHandler('police:finesForced', function(target, amount)
	TriggerClientEvent('police:forceFines', target, amount)
	TriggerClientEvent("pNotify:SendNotification", source, {text = '' ..GetPlayerName(target)..' has successfully paid their fine.',type = "error",queue = "left",timeout = 10000,layout = "bottomCenter"})
end)
--==============================================================================================================================--
--Check if the car is stolen

RegisterServerEvent('police:checkingPlate')
AddEventHandler('police:checkingPlate', function(plate)
	local plate = plate
	local source = source
	if plate ~= nil then
		getIdentityFromPlate(plate, function(identity)
			if identity == nil and plate ~= nil then
				TriggerClientEvent("pNotify:SendNotification", source, {text = "The vehicle #"..plate.." is not registered!",type = "error",queue = "left",timeout = 3000,layout = "bottomCenter"})
			else
				TriggerClientEvent("pNotify:SendNotification", source, {text = "The vehicle <span style='color:lime'>"..plate.."</span> belongs to <span style='color:lime'>" .. identity ..".</span>", type = "error",queue = "left",timeout = 6000,layout = "bottomCenter"})
			end
		end)
	else
		TriggerClientEvent("pNotify:SendNotification", source, {text = "This vehicle doesn't even have a license plate?",type = "error",queue = "left",timeout = 3000,layout = "bottomCenter"})
	end
end)

function getIdentityFromPlate(plate, cb)
	local found = false
    TriggerEvent("f:getPlayers", function(users)
        for k , user in pairs(users) do
            if user.getCarOwner(plate) == true then
            	local identity = user.getIdentity()
            	local id = identity.fname.." "..identity.sname
            	found = true
                cb(id)
                return
            end
        end
    end)
    if not found then cb(nil) end
end
--==============================================================================================================================--
--Check the players inventory
RegisterServerEvent('police:targetCheckInventory')
AddEventHandler('police:targetCheckInventory', function(target)
	local source = source
	TriggerEvent('f:getPlayer', target, function(user)
		local inventory = user.getInventory()
		local strResult = "Items of " .. GetPlayerName(target) .. " : "
				
		for _, v in ipairs(inventory) do
			if(v.q > 0) then
				strResult = strResult .. v.n .. " - " .. v.q .. ", "
			end					
		end

		local probs = "Items of " .. GetPlayerName(target) .. " : "
		if strResult == probs then
			strResult = GetPlayerName(target).." has no items"
		end
		TriggerClientEvent("pNotify:SendNotification", source, {text = strResult,type = "error",queue = "left",timeout = 20000,layout = "centerRight"})

    	TriggerClientEvent("pNotify:SendNotification", source, {text = GetPlayerName(target).." has <span style='color:lime'>$</span><span style='color:white'>"..user.getDirty().."</span> in dirty money!",type = "error",queue = "left",timeout = 20000,layout = "centerRight"})
    	TriggerClientEvent("pNotify:SendNotification", target, {text = GetPlayerName(source).." just searched you for illegal goods!",type = "error",queue = "left",timeout = 20000,layout = "centerRight"})
    end)
end)
--==============================================================================================================================--
--Seize the players inventory
RegisterServerEvent('police:targetSeizeInventory')
AddEventHandler('police:targetSeizeInventory', function(target)
	local source = source
	TriggerEvent('f:getPlayer', target, function(user)
		local inventory = user.getInventory()
		for _, v in ipairs(inventory) do
			item = user.isItemIllegal(v.id)
			if item then
				user.removeQuantity(v.id, v.q)
			end
		end
		TriggerClientEvent("pNotify:SendNotification", source, {text = GetPlayerName(target).."'s illegal items have been seized",type = "error",queue = "left",timeout = 10000,layout = "centerRight"})
		TriggerClientEvent("pNotify:SendNotification", target, {text = "Your illegal items have been seized",type = "error",queue = "left",timeout = 10000,layout = "centerRight"})

    	user.setDirtyMoney(0)
    	TriggerClientEvent("pNotify:SendNotification", source, {text = GetPlayerName(target).."'s dirty money has been seized",type = "error",queue = "left",timeout = 10000,layout = "centerRight"})
    	TriggerClientEvent("pNotify:SendNotification", target, {text = "Your dirty money has been seized",type = "error",queue = "left",timeout = 10000,layout = "centerRight"})
    end)
end)
--==============================================================================================================================--
--Check the players guns
RegisterServerEvent('police:targetCheckGuns')
AddEventHandler('police:targetCheckGuns', function(target)
	local source = source
	TriggerEvent('f:getPlayer', target, function(user)
		local weapons = user.getWeapons()
		local strResult = "Weapons of " .. GetPlayerName(target) .. " : "
			
		for _, v in ipairs(weapons) do
			strResult = strResult .. v.wn .. " - lvl "..v.l..", "
		end
		local probs = "Weapons of " .. GetPlayerName(target) .. " : "
		if strResult == probs then
			strResult = GetPlayerName(target).." has no weapons"
		end
		TriggerClientEvent("pNotify:SendNotification", source, {text = strResult,type = "error",queue = "left",timeout = 20000,layout = "centerRight"})
		TriggerClientEvent("pNotify:SendNotification", target, {text = GetPlayerName(source).." just searched you for weapons!",type = "error",queue = "left",timeout = 20000,layout = "centerRight"})
	end)
end)
--==============================================================================================================================--
--Remove a players weapons
RegisterServerEvent('police:byebyeweapons')
AddEventHandler('police:byebyeweapons', function(target)
	local source = source
	TriggerEvent('f:getPlayer', target, function(user)
		user.removeWeapons()
		TriggerClientEvent("pNotify:SendNotification", target, {text = "Your weapons have been confiscated!",type = "error",queue = "left",timeout = 6000,layout = "centerRight"})	
	    TriggerClientEvent("pNotify:SendNotification", source, {text = "Players weapons have been removed!",type = "error",queue = "left",timeout = 6000,layout = "centerRight"})
	    TriggerClientEvent("police:byebyeweapons", target)
	end)
end)
--==============================================================================================================================--
--Sync tyre bursting for all players
RegisterServerEvent('police:spikes')
AddEventHandler('police:spikes', function(currentVeh, peeps)
	TriggerClientEvent("police:dietyres", peeps, currentVeh)
	--TriggerClientEvent("police:dietyres", -1, currentVeh)
	TriggerClientEvent("police:dietyres2", peeps)
end)
--==============================================================================================================================--
--Check the players gun license
RegisterServerEvent('police:targetCheckGunLicense')
AddEventHandler('police:targetCheckGunLicense', function(target)
	local source = source
	TriggerEvent('f:getPlayer', target, function(user)
		TriggerClientEvent("pNotify:SendNotification", source, {text = GetPlayerName(target).." has a level <span style='color:lime'>"..user.getGunlicense().."</span> gun license",type = "error",queue = "left",timeout = 20000,layout = "centerRight"})
	end)
end)
--==============================================================================================================================--
--Seize the players gun license
RegisterServerEvent('police:targetSeizeGunLicense')
AddEventHandler('police:targetSeizeGunLicense', function(target)
	local source = source
	TriggerEvent('f:getPlayer', target, function(user)
		user.setGunlicense(1)
		TriggerClientEvent("pNotify:SendNotification", target, {text = "Your gun license was confiscated by "..GetPlayerName(source),type = "error",queue = "left",timeout = 10000,layout = "centerRight"})
		TriggerClientEvent("pNotify:SendNotification", source, {text = "You removed "..GetPlayerName(target).."'s gun license!",type = "error",queue = "left",timeout = 10000,layout = "centerRight"})
	end)
end)
--==============================================================================================================================--
--Save and Load Uniforms

RegisterServerEvent("police:loadclothing")
AddEventHandler("police:loadclothing", function()
	local source = tonumber(source)
	local data = uniforms[GetPlayerIdentifiers(source)[1]]
	if data ~= nil then
		if data.m == "mp_m_freemode_01" or data.m == "mp_f_freemode_01" then
			TriggerClientEvent("police:changempmodel", source, data)
		else
			TriggerClientEvent("police:changemodel", source, data)
		end
	else
		TriggerClientEvent("police:nomodel", source)
	end
end)

RegisterServerEvent("police:saveclothing")
AddEventHandler("police:saveclothing",function(m, d, t)
	local source = tonumber(source)
	local data = {}
	data.m = m
	data.d1 = d.head
	data.d2 = d.mask
	data.d3 = d.hair
	data.d4 = d.hand
	data.d5 = d.pants
	data.d6 = d.gloves
	data.d7 = d.shoes
	data.d8 = d.eyes
	data.d9 = d.accessories
	data.d10 = d.items
	data.d11 = d.decals
	data.d12 = d.shirts
	data.a13 = d.helmet
	data.a14 = d.glasses
	data.a15 = d.earrings
	data.f16 = d.beard
	data.f17 = d.eyebrow
	data.f18 = d.makeup
	data.f19 = d.lipstick
	data.t1 = t.head
	data.t2 = t.mask
	data.t3 = t.hair
	data.t4 = t.hand
	data.t5 = t.pants
	data.t6 = t.gloves
	data.t7 = t.shoes
	data.t8 = t.eyes
	data.t9 = t.accessories
	data.t10 = t.items
	data.t11 = t.decals
	data.t12 = t.shirts
	data.ta13 = t.helmet
	data.ta14 = t.glasses
	data.ta15 = t.earrings
	uniforms[GetPlayerIdentifiers(source)[1]] = data
	saveUniforms()
end)
--==============================================================================================================================--
--Charges
RegisterServerEvent('police:showCharges')
AddEventHandler('police:showCharges', function (t,charges)
    TriggerClientEvent('chatMessage', t, '[GOVERNMENT]', {255, 0, 0},"You have been charged with: "..table.concat(charges))
    TriggerClientEvent('chatMessage', source, '[GOVERNMENT]', {255, 0, 0}, "You have charged.."..GetPlayerName(t).." with: "..table.concat(charges))
end)
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--