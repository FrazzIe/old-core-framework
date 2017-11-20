
RegisterServerEvent("police:VehWeapCheck")
AddEventHandler("police:VehWeapCheck", function(weapon)
	local source = tonumber(source)
	local isPolice = false
	TriggerEvent('f:getPlayer', source, function(user) isPolice = user.getSessionVar('policeInService') end)
	if not isPolice then
		TriggerClientEvent("police:VehWeapDel", source, weapon)
	end
end)