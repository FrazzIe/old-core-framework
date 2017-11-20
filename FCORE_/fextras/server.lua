
RegisterServerEvent("police:VehWeapCheck")
AddEventHandler("police:VehWeapCheck", function(weapon)
	local sourcePlayer = tonumber(source)
	isPolice( function(result)
		if not result then
			TriggerClientEvent("police:VehWeapDel", sourcePlayer, weapon)
		end
	end)
end)

function isPolice(cb)
	TriggerEvent('f:getPlayer', source, function(user)
		local result = user.getSessionVar('policeInService')
		cb(result)
	end)
end

AddEventHandler('f:loaded', function(source, user)
	TriggerClientEvent("ipl:LoadAllIPLS", source)
end)