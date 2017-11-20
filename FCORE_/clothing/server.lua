RegisterServerEvent("clothes:firstspawn")
AddEventHandler("clothes:firstspawn",function(source)
	local source = source
	TriggerEvent('f:getPlayer', source, function(user)
		local data = user.getModel()
		TriggerClientEvent("clothes:spawn", source, data)
	end)	
end)

RegisterServerEvent("clothes:spawn")
AddEventHandler("clothes:spawn",function()
	local source = source
	TriggerEvent('f:getPlayer', source, function(user)
		local data = user.getModel()
		TriggerClientEvent("clothes:spawn", source, data)
	end)
end)

RegisterServerEvent("clothes:loaded")
AddEventHandler("clothes:loaded",function()
	TriggerEvent("ws:giveweapons", source)
end)

RegisterServerEvent("clothes:save")
AddEventHandler("clothes:save",function(player_data)
	local source = source
	TriggerEvent('f:getPlayer', source, function(user)
		user.setModel(player_data)
		TriggerEvent("ws:giveweapons", source)
	end)
end)