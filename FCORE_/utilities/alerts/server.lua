RegisterServerEvent("alerts:weapon")
AddEventHandler("alerts:weapon", function()
	TriggerClientEvent("alerts:weapon", -1, source)
end)