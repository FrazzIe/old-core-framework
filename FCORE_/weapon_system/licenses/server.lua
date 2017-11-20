licenses = {
    {"Level 1", {name="Level 1", price=25000,level=1}},
    {"Level 2", {name="Level 2", price=150000,level=2}},
    {"Level 3", {name="Level 3", price=500000,level=3}},
    {"Level 4", {name="Level 4", price=1000000,level=4}}
}

RegisterServerEvent("license:checkMoney")
AddEventHandler("license:checkMoney", function(item)
	local sourcePlayer = tonumber(source)
	local correctprice = nil
    for i = 1, #licenses do
        if licenses[i][2].name == item.name then
            correctprice = licenses[i][2].price
            break
        end
    end
    if correctprice ~= nil then
    	if correctprice == item.price then
		    TriggerEvent('f:getPlayer', source, function(user)
			    local price = item.price
			    if (tonumber(user.getMoney()) >= tonumber(price)) then
			    	local license = user.getGunlicense()
			    	if license == 0 and item.level == 1 then
			    		user.removeMoney((price))
			    		user.setGunlicense(tonumber(item.level))
			    		TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {text = item.name.." license purchased!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
			    	elseif license == 1 and item.level == 2 then
			    		user.removeMoney((price))
			    		user.setGunlicense(item.level)
			    		TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {text = item.name.." license purchased!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})	 
			    	elseif license == 2 and item.level == 3 then
			    		user.removeMoney((price))
			    		user.setGunlicense(item.level)
			    		TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {text = item.name.." license purchased!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
			    	elseif license == 3 and item.level == 4 then
			    		user.removeMoney((price))
			    		user.setGunlicense(item.level)
			    		TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {text = item.name.." license purchased!",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
			    	else
			    		TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {text ="You must go from 1 to 4",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
			    	end	    	
			    else
			     	TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
			    end
			end)
		else
			BanCheater("[ANTI-CHEAT] Cheatengine usage (Modifying Values)",sourcePlayer)
		end
	else
		print("Cant find the correct price")
		TriggerEvent("f:log", "errors", "[ERROR - GUNLICENSES]::Couldn't find the correct price!")
	end
end)