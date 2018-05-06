RegisterServerEvent("login:getCharacterData")
AddEventHandler("login:getCharacterData",function()
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		if user ~= nil then
			local chars = {name1=1, dob1=1, gen1=1, height1=1, name2=1, dob2=1, gen2=1, height2=1, name3=1, dob3=1, gen3=1, height3=1}
			local data = user.getCharacters()
			if data ~= nil then
				for i = 1, #data do
					if data[i].id ~= nil then
						if data[i].id == 1 then
							chars.name1 = data[i].name
							chars.dob1 = data[i].dob
							chars.gen1 = data[i].gen
							chars.height1 = data[i].height
						elseif data[i].id == 2 then
							chars.name2 = data[i].name
							chars.dob2 = data[i].dob
							chars.gen2 = data[i].gen
							chars.height2 = data[i].height
						elseif data[i].id == 3 then
							chars.name3 = data[i].name
							chars.dob3 = data[i].dob
							chars.gen3 = data[i].gen
							chars.height3 = data[i].height
						end
					end
				end
			end
			if chars.name1 == 1 then
				TriggerClientEvent("OpenCCMenu", source, 1)
			else
				TriggerClientEvent("login:OpenChooseCharMenu", source, chars.name1,chars.dob1,chars.gen1,chars.height1,chars.name2,chars.dob2,chars.gen2,chars.height2,chars.name3,chars.dob3,chars.gen3,chars.height3)
			end
		else
			DropPlayer(source, "For some unknown reason the server was unable to load your account data!")
		end
	end)
end)

RegisterServerEvent("login:CreateCharacter")
AddEventHandler("login:CreateCharacter",function(data, id)
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local name = data.fname.." "..data.lname
		user.CreateCharacter(id,name, data.dob, data.gen, data.height)
		TriggerEvent("login:getCharacterDataAfterCreation", source)
	end)
end)

RegisterServerEvent("login:getCharacterDataAfterCreation")
AddEventHandler("login:getCharacterDataAfterCreation",function(source)
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local chars = {name1=1, dob1=1, gen1=1, height1=1, name2=1, dob2=1, gen2=1, height2=1, name3=1, dob3=1, gen3=1, height3=1}
		local data = user.getCharacters()
		if data then
			for i = 1, #data do
				if data[i].id == 1 then
					chars.name1 = data[i].name
					chars.dob1 = data[i].dob
					chars.gen1 = data[i].gen
					chars.height1 = data[i].height
				elseif data[i].id == 2 then
					chars.name2 = data[i].name
					chars.dob2 = data[i].dob
					chars.gen2 = data[i].gen
					chars.height2 = data[i].height
				elseif data[i].id == 3 then
					chars.name3 = data[i].name
					chars.dob3 = data[i].dob
					chars.gen3 = data[i].gen
					chars.height3 = data[i].height
				end
			end
		end
		if chars.name1 == 1 then
			TriggerClientEvent("OpenCCMenu", source, 1)
		else
			TriggerClientEvent("login:OpenChooseCharMenu", source, chars.name1,chars.dob1,chars.gen1,chars.height1,chars.name2,chars.dob2,chars.gen2,chars.height2,chars.name3,chars.dob3,chars.gen3,chars.height3)
		end
	end)
end)

RegisterServerEvent("login:wipeCharacter")
AddEventHandler("login:wipeCharacter",function(id)
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		user.wipeCharacter(id)
		TriggerEvent("login:getCharacterDataAfterCreation", source)
	end)
end)

RegisterServerEvent("login:ChooseCharacter")
AddEventHandler("login:ChooseCharacter",function(id)
	local source = tonumber(source)
	TriggerEvent('f:getPlayer', source, function(user)
		local chars = {name1=1, dob1=1, gen1=1, height1=1, name2=1, dob2=1, gen2=1, height2=1, name3=1, dob3=1, gen3=1, height3=1}
		local data = user.getCharacters()
		if data then
			for i = 1, #data do
				if data[i].id == 1 then
					chars.name1 = data[i].name
					chars.dob1 = data[i].dob
					chars.gen1 = data[i].gen
					chars.height1 = data[i].height
				elseif data[i].id == 2 then
					chars.name2 = data[i].name
					chars.dob2 = data[i].dob
					chars.gen2 = data[i].gen
					chars.height2 = data[i].height
				elseif data[i].id == 3 then
					chars.name3 = data[i].name
					chars.dob3 = data[i].dob
					chars.gen3 = data[i].gen
					chars.height3 = data[i].height
				end
			end
		end
		if id == 1 then
			if chars.name1 == 1 then 
				TriggerClientEvent("OpenCCMenu", source, id)
			else
				local name = chars.name1
				local dob = chars.dob1
				local gender = chars.gen1
				local height = chars.height1
				local wordcounter = {}
				for word in string.gmatch(name, "%a+") do table.insert(wordcounter,word) end
				user.setIdentity(wordcounter[1],wordcounter[2],dob,gender,height)
				user.setCharacterID(id)
				TriggerEvent("login:afterSelection",source)
			end			
		elseif id == 2 then
			if chars.name2 == 1 then 
				TriggerClientEvent("OpenCCMenu", source, id)
			else
				local name = chars.name2
				local dob = chars.dob2
				local gender = chars.gen2
				local height = chars.height2
				local wordcounter = {}
				for word in string.gmatch(name, "%a+") do table.insert(wordcounter,word) end
				user.setIdentity(wordcounter[1],wordcounter[2],dob,gender,height)
				user.setCharacterID(id)
				TriggerEvent("login:afterSelection",source)
			end
		elseif id == 3 then
			if chars.name3 == 1 then 
				TriggerClientEvent("OpenCCMenu", source, id)
			else
				local name = chars.name3
				local dob = chars.dob3
				local gender = chars.gen3
				local height = chars.height3
				local wordcounter = {}
				for word in string.gmatch(name, "%a+") do table.insert(wordcounter,word) end
				user.setIdentity(wordcounter[1],wordcounter[2],dob,gender,height)
				user.setCharacterID(id)
				TriggerEvent("login:afterSelection",source)
			end
		end
	end)
end)

RegisterServerEvent("login:afterSelection")
AddEventHandler("login:afterSelection",function(source)
	local source = tonumber(source)
	local coords
	TriggerEvent('f:getPlayer', source, function(user)
		local m = user.getMoney()
		local b = user.getBank()
		local d = user.getDirty()
		coords = user.getLastCoordsForCharacter()
		user.displayMoney(m)
		user.displayBank(b)
		user.displayDirty(d)
	end)
	TriggerEvent("inventory:updateitems", source)
	TriggerClientEvent("banking:updateBalance", source, b)
	TriggerClientEvent("es:enablePvp", source)
	TriggerEvent("clothes:firstspawn",source)
	TriggerEvent("police:firstspawn",source)
	TriggerEvent("paramedic:firstspawn",source)
	TriggerEvent('js:firstspawn',source)
	TriggerEvent('phone:firstspawn',source)
	TriggerEvent("garage:firstspawn",source)
	TriggerClientEvent('login:UnFreeze',source, coords)
	TriggerEvent("js:spawn", source)
end)
