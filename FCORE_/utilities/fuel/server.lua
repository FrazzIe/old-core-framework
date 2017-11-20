RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(veh, pfuelcount, fuelcount)
	local source = tonumber(source)
	local addedFuel = (tonumber(fuelcount) - tonumber(pfuelcount))
	local cost = math.floor(tonumber(addedFuel)/1000)
	if cost < 5 then cost = 5 end
	TriggerEvent('f:getPlayer', source, function(user)
		if (tonumber(user.getMoney()) >= tonumber(cost)) then
			user.removeMoney(tonumber(cost))
			TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = "You have paid <span style='color:lime'>$</span><span style='color:white'>"..cost.."</span> for fuel!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
		else
			TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = "Insufficient funds, fuel removed!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
			TriggerClientEvent('fuel:removeFuel', source, veh, pfuelcount)
		end
	end)
end)