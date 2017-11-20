local Armed = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedArmed(PlayerPedId(), 7) and not Armed then
			Armed = true
			TriggerServerEvent("alerts:weapon")
		elseif not IsPedArmed(PlayerPedId(), 7) and Armed then
			Armed = false
		end
	end
end)

RegisterNetEvent("alerts:weapon")
AddEventHandler("alerts:weapon", function(sender)
	if GetPlayerFromServerId(sender) == PlayerId() then
		TriggerEvent('chatMessage', "^0-", {30, 144, 255}, "^5You ^3just manipulated a weapon")
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(),0), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(sender)),0), true) < 50 and GetPlayerFromServerId(sender) ~= PlayerId() then
		TriggerEvent('chatMessage', "^0-", {30, 144, 255}, "^5Unknown person ^3just manipulated a weapon")
	end
end)