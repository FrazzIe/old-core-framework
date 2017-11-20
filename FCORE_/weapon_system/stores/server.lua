local max_weapons = 20
local LicenseZero = {"Machete","Golfclub","Knuckle dusters","Knife","Dagger","Crowbar","Bat","Bottle","Hammer","Flashlight"}
local LicenseOne = {"Machete","Golfclub","Knuckle dusters","Knife","Dagger","Crowbar","Bat","Bottle","Hammer","Pistol","Pistol 50","SNS Pistol","Heavy Pistol","Revolver"}
local LicenseTwo = {"Machete","Golfclub","Knuckle dusters","Knife","Dagger","Crowbar","Bat","Bottle","Hammer","Pistol","Pistol 50","SNS Pistol","Heavy Pistol","Revolver","Smoke Grenade","Pump Shotgun","Sawn-off Shotgun","Bullpup Shotgun","Double-Barrel","Auto Shotgun"}
local LicenseThree = {"Machete","Golfclub","Knuckle dusters","Knife","Dagger","Crowbar","Bat","Bottle","Hammer","Pistol","Pistol 50","SNS Pistol","Heavy Pistol","Revolver","Smoke Grenade","Pump Shotgun","Sawn-off Shotgun","Bullpup Shotgun","Double-Barrel","Auto Shotgun","MicroSMG","SMG","Assault SMG","MG","Gusenberg"}
local LicenseFour = {"Machete","Golfclub","Knuckle dusters","Knife","Dagger","Crowbar","Bat","Bottle","Hammer","Pistol","Pistol 50","SNS Pistol","Heavy Pistol","Revolver","Smoke Grenade","Pump Shotgun","Sawn-off Shotgun","Bullpup Shotgun","Double-Barrel","Auto Shotgun","MicroSMG","SMG","Assault SMG","MG","Gusenberg","Assault Rifle","Carbine Rifle","Advanced Rifle","Special Carbine"}

weapons = {
    ["a"] = {
        {"Machete", 1, {name="Machete", price=2000,license=0,model="WEAPON_MACHETE"}},
        {"Golfclub", 1, {name="Golfclub", price=1000,license=0,model="WEAPON_GOLFCLUB"}},
        {"Knuckle dusters", 1, {name="Knuckle dusters", price=600,license=0,model="WEAPON_KNUCKLE"}},
        {"Knife", 1, {name="Knife", price=550,license=0,model="WEAPON_KNIFE"}},
        {"Dagger", 1, {name="Dagger", price=500,license=0,model="WEAPON_DAGGER"}},
        {"Switchblade", 1, {name="Switchblade", price=500,license=0,model="WEAPON_SWITCHBLADE"}},
        {"Crowbar", 1, {name="Crowbar", price=250,license=0,model="WEAPON_CROWBAR"}},
        {"Bat", 1, {name="Bat", price=250,license=0,model="WEAPON_BAT"}},
        {"Bottle", 1, {name="Bottle", price=50,license=0,model="WEAPON_BOTTLE"}},
        {"Hammer", 1, {name="Hammer", price=50,license=0,model="WEAPON_HAMMER"}},
		{"Flashlight", 1, {name="Flashlight", price=50,license=0,model="WEAPON_FLASHLIGHT"}},
    },
    ["b"] = {
        {"Pistol", 1, {name="Pistol",price=2500,license=1,model="WEAPON_Pistol"}},
        {"Pistol 50", 1, {name="Pistol 50",price=5000,license=1,model="WEAPON_PISTOL50"}},
        {"SNS Pistol", 1, {name="SNS Pistol",price=6500,license=1,model="WEAPON_SNSPistol"}},
        {"Heavy Pistol", 1, {name="Heavy Pistol",price=8000,license=1,model="WEAPON_HeavyPistol"}},
        {"Revolver", 1, {name="Revolver",price=9900,license=1,model="WEAPON_Revolver"}},
    },
    ["c"] = {
        {"Pump Shotgun", 1, {name="Pump Shotgun",price=15000,license=2,model="WEAPON_PumpShotgun"}},
        {"Sawn-off Shotgun", 1, {name="Sawn-off Shotgun",price=22000,license=2,model="WEAPON_SAWNOFFSHOTGUN"}},
        {"Bullpup Shotgun", 1, {name="Bullpup Shotgun",price=35000,license=2,model="WEAPON_BullpupShotgun"}},
        {"Double-Barrel", 1, {name="Double-Barrel",price=40000,license=2,model="WEAPON_DoubleBarrelShotgun"}},
        {"Auto Shotgun", 1, {name="Auto Shotgun",price=55000,license=2,model="WEAPON_Autoshotgun"}},
    },
    ["d"] = {
        {"MicroSMG", 1, {name="MicroSMG",price=65000,license=3,model="WEAPON_MicroSMG"}},
        {"SMG", 1, {name="SMG",price=69000,license=3,model="WEAPON_SMG"}},
        {"Assault SMG", 1, {name="Assault SMG",price=73000,license=3,model="WEAPON_AssaultSMG"}},
        {"MG", 1, {name="MG",price=88000,license=3,model="WEAPON_MG"}},
        {"Gusenberg", 1, {name="Gusenberg",price=95000,license=3,model="WEAPON_Gusenberg"}},
    },
    ["e"] = {
        {"Assault Rifle", 1, {name="Assault Rifle",price=100000,license=4,model="WEAPON_AssaultRifle"}},
        {"Carbine Rifle", 1, {name="Carbine Rifle",price=120000,license=4,model="WEAPON_CarbineRifle"}},
        {"Advanced Rifle", 1, {name="Advanced Rifle",price=130000,license=4,model="WEAPON_AdvancedRifle"}},
        {"Special Carbine", 1, {name="Special Carbine",price=150000,license=4,model="WEAPON_SpecialCarbine"}},
    },
    ["f"] = {
        {"Pistol", 2, {name="Pistol",price=6000,license=5,model="WEAPON_Pistol"}},
        {"Gusenberg", 2, {name="Gusenberg", price=120000,license=5,model="WEAPON_Gusenberg"}},
        {"Special Carbine", 2, {name="Special Carbine",price=200000,license=5,model="WEAPON_SpecialCarbine"}},
        {"AP Pistol", 2, {name="AP Pistol",price=50000,license=5,model="WEAPON_APPISTOL"}},
        {"Sawn-Off Shotgun", 2, {name="Sawn-Off Shotgun",price=30000,license=5,model="WEAPON_SAWNOFFSHOTGUN"}},
    }
}

local required = false
RegisterServerEvent("ws:checkMoney")
AddEventHandler("ws:checkMoney", function(item, cat)
	local source = tonumber(source)
	local correctprice = nil
    for i = 1, #weapons[cat] do
        if weapons[cat][i][3].name == item.name then
            correctprice = weapons[cat][i][3].price
            break
        end
    end
    if correctprice ~= nil then
    	if correctprice == item.price then
		    TriggerEvent('f:getPlayer', source, function(user)
			    local price = item.price
			    local hprice = item.price/2
			    local duplicate = false
			    if (tonumber(user.getMoney()) >= tonumber(price)) then
			    	local weapon_count = 0
			    	local uweapons = user.getWeapons()
			    	for i = 1, #uweapons do
			    		weapon_count = weapon_count + 1
			    		if uweapons[i].w == item.model then
			    			duplicate = true
			    			break
			    		end
			    	end
			    	if duplicate == false then
						if tonumber(max_weapons) > tonumber(weapon_count) then
							local license = user.getGunlicense()
							required = false
							if license == 0 then
								for i = 1, #LicenseZero do
									if item.name == LicenseZero[i] then
										required = true
										user.addWeapon(item.model,hprice,item.license,item.name)
					      				user.removeMoney((price))
					      				WMessages(5,item.name,source)
					      				TriggerClientEvent("ws:giveweapon", source, item)
					      				--TriggerEvent("ws:syncweapons", source)
					      			end
					      		end
					      		if required == false then
					      			WMessages(1,nil,source)
					      		end
				      		elseif license == 1 then
				      			for i = 1, #LicenseOne do
									if item.name == LicenseOne[i] then
										required = true
										user.addWeapon(item.model,hprice,item.license,item.name)
					      				user.removeMoney((price))
					      				WMessages(5,item.name,source)
					      				TriggerClientEvent("ws:giveweapon", source, item)
					      				--TriggerEvent("ws:syncweapons", source)
					      			end
					      		end
					      		if required == false then
					      			WMessages(2,nil,source)
					      		end
				      		elseif license == 2 then
				      			for i = 1, #LicenseTwo do
									if item.name == LicenseTwo[i] then
										required = true
										user.addWeapon(item.model,hprice,item.license,item.name)
					      				user.removeMoney((price))
					      				WMessages(5,item.name,source)
					      				TriggerClientEvent("ws:giveweapon", source, item)
					      				--TriggerEvent("ws:syncweapons", source)
					      			end
					      		end
					      		if required == false then
					      			WMessages(2,nil,source)
					      		end
				      		elseif license == 3 then
				      			for i = 1, #LicenseThree do
									if item.name == LicenseThree[i] then
										required = true
										user.addWeapon(item.model,hprice,item.license,item.name)
					      				user.removeMoney((price))
					      				WMessages(5,item.name,source)
					      				TriggerClientEvent("ws:giveweapon", source, item)
					      				--TriggerEvent("ws:syncweapons", source)
					      			end
					      		end
					      		if required == false then
					      			WMessages(2,nil,source)
					      		end
				      		elseif license == 4 then
				      			for i = 1, #LicenseFour do
									if item.name == LicenseFour[i] then
										required = true
										user.addWeapon(item.model,hprice,item.license,item.name)
					      				user.removeMoney((price))
					      				WMessages(5,item.name,source)
					      				TriggerClientEvent("ws:giveweapon", source, item)
					      				--TriggerEvent("ws:syncweapons", source)
					      			end
					      		end
					      		if required == false then
					      			WMessages(2,nil,source)
					      		end
				      		end      			
				      	else
				      		WMessages(4,nil,source)
				      	end
				    else
				    	WMessages(8,nil,source)
				    end
			    else
					WMessages(3,nil,source)
			    end
			end)
		else
			BanCheater("[ANTI-CHEAT] Cheatengine usage (Modifying Values)",source)
		end
	else
		print("Cant find the correct price")
		TriggerEvent("f:log", "errors", "[ERROR - GUNSHOP]::Couldn't find the correct price!")
	end
end)

RegisterServerEvent("ws:deleteweapons")
AddEventHandler("ws:deleteweapons", function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
    	user.removeWeapons()
    	TriggerClientEvent("ws:removeWeapons", source)
    	--TriggerEvent("ws:syncweapons", source)
    end)
end)

RegisterServerEvent("ws:checkMoneyillegal")
AddEventHandler("ws:checkMoneyillegal", function(item, cat)
	local source = tonumber(source)
	local correctprice = nil
    for i = 1, #weapons[cat] do
        if weapons[cat][i][3].name == item.name then
            correctprice = weapons[cat][i][3].price
            break
        end
    end
    if correctprice ~= nil then
    	if correctprice == item.price then
		    TriggerEvent('f:getPlayer', source, function(user)
			    local price = item.price
			    local hprice = 2
			    if (tonumber(user.getMoney()) >= tonumber(price)) then
			    	local weapon_count = 0
			    	local uweapons = user.getWeapons()
			    	for i = 1, #uweapons do
			    		weapon_count = weapon_count + 1
			    		if uweapons[i].w == item.model then
			    			duplicate = true
			    			break
			    		end
			    	end
			    	if not duplicate then
						if tonumber(max_weapons) > tonumber(weapon_count) then
							user.addWeapon(item.model,hprice,item.license,item.name)
				      		user.removeMoney((price))
				      		WMessages(5,item.name,source)
				      		TriggerClientEvent("ws:giveweapon", source, item)
				      		--TriggerEvent("ws:syncweapons", source)			
					    else
					      	WMessages(4,nil,source)
					    end
					else
					    WMessages(8,nil,source)
					end
				else
					WMessages(3,nil,source)
				end
			end)
		else
			BanCheater("[ANTI-CHEAT] Cheatengine usage (Modifying Values)",source)
		end
	else
		print("Cant find the correct price")
		TriggerEvent("f:log", "errors", "[ERROR - GUNSHOP]::Couldn't find the correct price!")
	end
end)

RegisterServerEvent("ws:giveweapons")
AddEventHandler("ws:giveweapons", function(source)
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local uweapons = user.getWeapons()
		for i = 1, #uweapons do
			TriggerClientEvent("ws:giveweapon2", source, uweapons[i].w)
		end
		--TriggerEvent("ws:syncweapons", source)
	end)
end)

RegisterServerEvent("ws:sellweapons")
AddEventHandler("ws:sellweapons", function()
	local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
    	local uweapons = user.getWeapons()
        local money = 0
        if(uweapons)then
            for i = 1, #uweapons do
                money = money + tonumber(uweapons[i].sp)
            end
            if money > 0 then
            	user.addMoney(money)
            	user.removeWeapons()
            	TriggerClientEvent("ws:removeWeapons", source)
            	WMessages(6,nil,source)
            else
            	WMessages(7,nil,source)
            end
        else
            print("No result here")
        end
    end)
end)

RegisterServerEvent("ws:sellweapon")
AddEventHandler("ws:sellweapon", function(model,sellprice)
	local source = tonumber(source)
    TriggerEvent('f:getPlayer', source, function(user)
    	local uweapons = user.getWeapons()
    	local correctprice = nil
    	for k,v in pairs(uweapons) do
    		print(v.w.." == "..model)
    		if v.w == model then
    			correctprice = v.sp
    			break
    		end
    	end
    	if correctprice ~= nil then
    		if tonumber(correctprice) == tonumber(sellprice) then
    			user.addMoney(correctprice)
    			user.removeWeapon(model)
    			TriggerClientEvent("ws:removeWeapons", source)
    			TriggerEvent("ws:giveweapons", source)
    			TriggerClientEvent("ws:sold", source)
    		else
    			BanCheater("[ANTI-CHEAT] Cheatengine usage (Modifying Values)",source)
    		end
		else
			print("Cant find the correct price")
			TriggerEvent("f:log", "errors", "[ERROR - GUNSHOP]::Couldn't find the correct price!")
		end
    end)
end)

function WMessages(value, item, source)
	if value == 1 then
		WNotify("You must buy a license!",source)
	elseif value == 2 then
		WNotify("You must upgrade your license!",source)
	elseif value == 3 then
		WNotify("Insufficient funds!",source)
	elseif value == 4 then
		WNotify("You have reached the weapon limit!",source)
	elseif value == 5 then
		WNotify(item.." purchased!",source)
	elseif value == 6 then
		WNotify("Weapons sold!",source)
	elseif value == 7 then
		WNotify("You have no weapons to sell!",source)
	elseif value == 8 then
		WNotify("You already own this weapon!",source)
	end
end

function WNotify(msg,source)
	TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = msg,type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
	CancelEvent()
end

AddEventHandler("ws:syncweapons", function(source)
	TriggerEvent('f:getPlayer', source, function(user)
		TriggerClientEvent("ws:syncweapons", source, user.getWeapons())
	end)
end)