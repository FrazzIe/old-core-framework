local clients = {}

RegisterServerEvent("fblips:activate")
AddEventHandler("fblips:activate", function()
	local source = source
	clients[source] = GetPlayerName(source)
	TriggerClientEvent("fblips:sync", -1, clients)
end)

RegisterServerEvent("fblips:deactivate")
AddEventHandler("fblips:deactivate", function()
	local source = source
	clients[source] = nil
	TriggerClientEvent("fblips:remove", source)
	TriggerClientEvent("fblips:sync", -1, clients)
end)

AddEventHandler("playerDropped", function()
	local source = source
	if clients[source] then
		clients[source] = nil
		TriggerClientEvent("fblips:sync", -1, clients)
	end
end)