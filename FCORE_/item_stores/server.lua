RegisterServerEvent("is:checkMoney")
AddEventHandler("is:checkMoney", function(item, cat)
	local source = tonumber(source)
	local correctprice = nil
    for i = 1, #items[cat] do
        if items[cat][i][2].name == item.name then
            correctprice = items[cat][i][2].price
            break
        end
    end
    if correctprice ~= nil then
    	if correctprice == item.price then
		    TriggerEvent('f:getPlayer', source, function(user)
			    local price = item.price
			    if (tonumber(user.getMoney()) >= tonumber(price)) then
			      user.removeMoney((price))
			      TriggerClientEvent("pNotify:SendNotification", source, {
			        text = item.name.." +1",
			        type = "error",
			        queue = "left",
			        timeout = 2500,
			        layout = "centerRight"
			      })
			      TriggerClientEvent("is:giveitem", source, item)
			    else
			      TriggerClientEvent("pNotify:SendNotification", source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
			    end
			end)
		else
			BanCheater("[ANTI-CHEAT] Cheatengine usage (Modifying Values)",source)
		end
	else
		print("Cant find the correct price")
		TriggerEvent("f:log", "errors", "[ERROR - SHOP]::Couldn't find the correct price!")
	end
end)

items = {
    ["a"] = {
        {"Burger",{name="Burger", id=40, price=12}},
        {"Water",{name="Water", id=6, price=6}},
        {"Vodka",{name="Vodka", id=41, price=30}},
        {"Medkit",{name="Medkit", id=34, price=300}},
        {"Repair kit",{name="Repair kit", id=37, price=1000}},
    },
    ["b"] = {
        {"Medkit",{name="Cheap Medkit", id=35, price=150}},
        {"Repair kit",{name="Cheap Repair kit", id=38, price=500}},
        {"Lockpick",{name="Lockpick", id=36, price=100}},
        {"Body armour",{name="Body armour", id=39, price=1500}},
    }
}