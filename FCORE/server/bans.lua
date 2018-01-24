local playerCount = 0
local list = {}

bantable = {
    ["Anticheat"] = {},
    ["Normal"] = {},
}

whitelist = {}
whitelist_active = false

RegisterServerEvent('FAC:BanCheater')
AddEventHandler('FAC:BanCheater', function(reason)
	local source = tonumber(source)
   	BanCheater(reason, source)
end)

RegisterServerEvent('FAC:BanCheater2')
AddEventHandler('FAC:Ban2', function(reason)
	local source = tonumber(source)
    Buttoncount = Buttoncount + 1
    if Buttoncount == 3 then
        BanCheater(reason, source)
    end
end)

RegisterServerEvent('FAC:Kick')
AddEventHandler('FAC:Kick', function(target, reason)
	local source = tonumber(source)
   	KickUser(target, reason, source)
end)

RegisterServerEvent('FAC:Ban')
AddEventHandler('FAC:Ban', function(target,time,reason)
	local source = tonumber(source)
	BanUser(target,time,reason,source)
end)

AddEventHandler("playerConnecting", function(name, setReason)
	local source = tonumber(source)
	local identifier = getID("steam", source)
	local license = getID("license", source)

	if identifier and license then
		local steamcheck = string.sub(identifier, 1, 5)
		if playerCount >= 32 then
			setReason(name..", the server is full, hopefully you get in soon :p.")
			CancelEvent()
		else
			if steamcheck == "steam" then
				local age = false
			    getAccountAge(identifier, function(cb)
			    	if cb ~= false then
			    		local week = tonumber(os.time()) - 604800
			    		if cb > week then
			    			age = true
			    		end
			    	end
			    end)
			    if age then
			    	print("[ANTI-CHEAT]::"..identifier.."("..name..") tried to connect but (account age < week)!")
			    	setReason(identifier.."("..name.."), you are not allowed to play on this server! (Account is less than one week old)")
			    	CancelEvent()
			    else
				    local acban = false
				    local banreason = ""
					for k,v in pairs(bantable["Anticheat"]) do
						if v.identifier == identifier or v.license == license then
							acban = true
							print("[ANTI-CHEAT]::"..identifier.."("..name..") tried to connect but was previously banned!")
							banreason = identifier.."("..name.."), you are banned! Reason: "..v.reason.." - You can appeal at gta5police.com/forums"
							break
						end
					end
					if acban then
						setReason(banreason)
						CancelEvent()
					else
						local nban = false
						print("[ANTI-CHEAT]::"..name.." has cleared ban check for cheating")
						for k,v in pairs(bantable["Normal"]) do
							if v.identifier == identifier or v.license == license then
								local currentTime = tonumber(os.time())
								local showdate = os.date("*t", v.duration)
								if currentTime > v.duration then
							        if file_exists("bans.txt",path.bans) then
							            bantable = loadData("bans.txt",path.bans)
							        end
									table.remove(bantable["Normal"], k)
									saveData(bantable, "bans.txt", path.bans)
									print("[BANS]::Unbanning "..name..", identifier:"..identifier.."("..name..")")
									break
								else
									print("[BANS]::"..identifier.."("..name..") tried to connect but was previously banned!")
									nban = true
									banreason = identifier.."("..name.."), you are banned! Expires: "..showdate.month.."/"..showdate.day.."/"..showdate.year.." at "..showdate.hour..":"..showdate.min..":"..showdate.sec.." Reason: "..v.reason.." - You can appeal at gta5police.com/forums"
									break
								end
							end
						end
						if nban then
							setReason(banreason)
							CancelEvent()
						else
							if whitelist_active then
								if whitelist[identifier] then
									if whitelist[identifier].steamname ~= GetPlayerName(source) then
										whitelist[identifier].steamname = GetPlayerName(source)
										saveData(whitelist, "whitelist.txt", path.main)
									end				
									print("[BANS]::"..name.." has cleared ban check for everything else")
								else
									setReason(name.." you must be whitelisted to play on this server, join one of our public servers... www.gta5police.com")
									CancelEvent()
								end
							else
								print("[BANS]::"..name.." has cleared ban check for everything else")
							end
						end
					end
				end
			else
				print("[STEAM CHECK]::("..name..") tried to connect but wasn't signed into steam!")
				setReason(name.." you must be signed into steam!")
				CancelEvent()
			end
		end
	else
		print("[???]::("..name..") tried to connect but we counld't get an identifier!")
		setReason(name.." we couldn't get an identifier? are you signed into steam?")
		CancelEvent()
	end
end)

function getAccountAge(hexId, callback)
    local apiKey = "INSERT STEAM API KEY"
    
    if not hexId then callback(false) return end
    local comId = tonumber(string.sub(hexId, 7), 16)
    if not comId then callback(false) return end

    local url = string.format("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=%s&steamids=%s", apiKey, comId)

    PerformHttpRequest(url, function(err, response, headers)
        if err ~= 200 then callback(false) print("HTTP ERROR: "..err) return end

        local data = json.decode(response)
        local date = data.response.players[1].timecreated

        if not date then callback(false) return end
        callback(date)
    end, "GET", "")
end

function BanCheater(reason,source)
	local source = tonumber(source)
	local identifier = getID("steam", source)
	local license = getID("license", source)
	local tstamp2 = os.date("*t", os.time())
	local newban = {identifier=identifier,license=license,reason=reason,name=GetPlayerName(source)}
	if file_exists("bans.txt",path.bans) then
		bantable = loadData("bans.txt",path.bans)
	end
	table.insert(bantable["Anticheat"], newban)
	saveData(bantable, "bans.txt", path.bans)
	log("bans", GetPlayerName(source).." | "..identifier.." | "..license.." | Forever | "..reason.." | Anti-Cheat")
			PerformHttpRequest('DISCORD WEBHOOK', function(err, text, headers) end, 'POST', json.encode(
			{
				username = "Ban Bot (Anticheat)",
	    		embeds = {
		    		{
		    			title = "",
		    			description = "",
		    			fields = {
		    				{name = "Display name", value = GetPlayerName(source)}, 
		    				{name = "Identifier", value = identifier}, 
		    				{name = "License", value = license},
		    				{name = "Duration", value = "Permanent"},  
		    				{name = "Reason", value = reason}, 
		    				{name = "Banned by", value = "Anticheat"},
		    			},
		    			color = "16597762",
		    		}
	        	},

	    		content = ""

			}), { ['Content-Type'] = 'application/json' })
	DropPlayer(source, reason)
end

function BanUser(target,time,reason,source)
	local source = tonumber(source)
	local bantime = "Default"
	local duration = tostring(time)
	if string.find(duration, "m") then
		duration = string.gsub(duration, "m", "")
		bantime = duration .. " minute(s)"
		duration = os.time() + (tonumber(duration) * 60)
	elseif string.find(duration, "h") then
		duration = string.gsub(duration, "h", "")
		if tonumber(duration) > 999 then
			bantime = "Permanent"
		else
			bantime = duration .. " hour(s)"
		end
		duration = os.time() + (tonumber(duration) * 60 * 60)
	else
		bantime = duration .. " second(s)"
		duration = os.time() + tonumber(duration)
	end
	local identifier = getID("steam", target)
	local license = getID("license", target)
	if identifier ~= nil then
		if license ~= nil then
			local tstamp2 = os.date("*t", os.time())
			local newban = {identifier=identifier,license=license,reason=reason,name=GetPlayerName(target),duration=duration}
	        if file_exists("bans.txt",path.bans) then
	            bantable = loadData("bans.txt",path.bans)
	        end
			table.insert(bantable["Normal"], newban)
			saveData(bantable, "bans.txt", path.bans)
			log("bans", GetPlayerName(target).." | "..identifier.." | "..license.." | "..bantime.." | "..reason.." | "..GetPlayerName(tonumber(source)))
			PerformHttpRequest('DISCORD WEBHOOK', function(err, text, headers) end, 'POST', json.encode(
			{
				username = "Ban Bot",
	    		embeds = {
		    		{
		    			title = "",
		    			description = "",
		    			fields = {
		    				{name = "Display name", value = GetPlayerName(target)}, 
		    				{name = "Identifier", value = identifier}, 
		    				{name = "License", value = license},
		    				{name = "Duration", value = bantime},  
		    				{name = "Reason", value = reason}, 
		    				{name = "Banned by", value = GetPlayerName(tonumber(source))},
		    			},
		    			color = "16597762",
		    		}
	        	},

	    		content = ""

			}), { ['Content-Type'] = 'application/json' })
			DropPlayer(target, reason.." - You can appeal at gta5police.com/forums")
		else
			TriggerClientEvent("pNotify:SendNotification",source, {text = "Attempted to ban but this user doesn't have a license?, are they still in the server?",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
		end
	else
		TriggerClientEvent("pNotify:SendNotification",source, {text = "Attempted to ban but this user doesn't have an identifier?, are they still in the server?",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
	end
end

function BanUserConsole(target,time,reason,banner)
	local bantime = "Default"
	local duration = tostring(time)
	if string.find(duration, "m") then
		duration = string.gsub(duration, "m", "")
		bantime = duration .. " minute(s)"
		duration = os.time() + (tonumber(duration) * 60)
	elseif string.find(duration, "h") then
		duration = string.gsub(duration, "h", "")
		if tonumber(duration) > 999 then
			bantime = "Permanent"
		else
			bantime = duration .. " hour(s)"
		end
		duration = os.time() + (tonumber(duration) * 60 * 60)
	else
		bantime = duration .. " second(s)"
		duration = os.time() + tonumber(duration)
	end
	local identifier = getID("steam", target)
	local license = getID("license", target)
	if identifier ~= nil then
		if license ~= nil then
			local tstamp2 = os.date("*t", os.time())
			local newban = {identifier=identifier,license=license,reason=reason,name=GetPlayerName(target),duration=duration}
	        if file_exists("bans.txt",path.bans) then
	            bantable = loadData("bans.txt",path.bans)
	        end
			table.insert(bantable["Normal"], newban)
			saveData(bantable, "bans.txt", path.bans)
			log("bans", GetPlayerName(target).." | "..identifier.." | "..license.." | "..bantime.." | "..reason.." | "..banner)
			PerformHttpRequest('DISCORD WEBHOOK', function(err, text, headers) end, 'POST', json.encode(
			{
				username = "Ban Bot",
	    		embeds = {
		    		{
		    			title = "",
		    			description = "",
		    			fields = {
		    				{name = "Display name", value = GetPlayerName(target)}, 
		    				{name = "Identifier", value = identifier}, 
		    				{name = "License", value = license},
		    				{name = "Duration", value = bantime},  
		    				{name = "Reason", value = reason}, 
		    				{name = "Kicked by", value = banner},
		    			},
		    			color = "16597762",
		    		}
	        	},

	    		content = ""

			}), { ['Content-Type'] = 'application/json' })
			DropPlayer(target, reason.." - You can appeal at gta5police.com/forums")
		else
			RconPrint("Attempted to ban but this user doesn't have a license?, are they still in the server?")
		end
	else
		RconPrint("Attempted to ban but this user doesn't have an identifier?, are they still in the server?")
	end
end

function KickUser(target,reason,source)
	local source = tonumber(source)
	local identifier = getID("steam", target)
	local license = getID("license", target)
	if identifier ~= nil then
		if license ~= nil then
			PerformHttpRequest('DISCORD WEBHOOK', function(err, text, headers) end, 'POST', json.encode(
			{
				username = "Kick Bot",
	    		embeds = {
		    		{
		    			title = "",
		    			description = "",
		    			fields = {
		    				{name = "Display name", value = GetPlayerName(target)}, 
		    				{name = "Identifier", value = identifier}, 
		    				{name = "License", value = license}, 
		    				{name = "Reason", value = reason}, 
		    				{name = "Kicked by", value = GetPlayerName(tonumber(source))},
		    			},
		    			color = "16597762",
		    		}
	        	},

	    		content = ""

			}), { ['Content-Type'] = 'application/json' })
			DropPlayer(target, reason)
		else
			TriggerClientEvent("pNotify:SendNotification",source, {text = "Attempted to kick but this user doesn't have a license?, are they still in the server?",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
		end
	else
		TriggerClientEvent("pNotify:SendNotification",source, {text = "Attempted to kick but this user doesn't have an identifier?, are they still in the server?",type = "error",queue = "left",timeout = 2500,layout = "centerRight"})
	end
end

function KickUserConsole(target,reason,kicker)
	local identifier = getID("steam", target)
	local license = getID("license", target)
	if identifier ~= nil then
		if license ~= nil then
			PerformHttpRequest('DISCORD WEBHOOK', function(err, text, headers) end, 'POST', json.encode(
			{
				username = "Kick Bot",
	    		embeds = {
		    		{
		    			title = "",
		    			description = "",
		    			fields = {
		    				{name = "Display name", value = GetPlayerName(target)}, 
		    				{name = "Identifier", value = identifier}, 
		    				{name = "License", value = license}, 
		    				{name = "Reason", value = reason}, 
		    				{name = "Kicked by", value = kicker},
		    			},
		    			color = "16597762",
		    		}
	        	},

	    		content = ""

			}), { ['Content-Type'] = 'application/json' })
			DropPlayer(target, reason)
		else
			RconPrint("Attempted to kick but this user doesn't have a license?, are they still in the server?")
		end
	else
		RconPrint("Attempted to kick but this user doesn't have an identifier?, are they still in the server?")
	end
end

function addWhitelist(identifier, name)
	if file_exists("whitelist.txt",path.main) then
		whitelist = loadData("whitelist.txt",path.main)
	end
	if whitelist[identifier] then
		RconPrint("This user is already whitelisted!")
	else
		whitelist[identifier] = {identifier = identifier, name = name, steamname = ""}
		saveData(whitelist, "whitelist.txt", path.main)
		RconPrint("This user has been added to the whitelist!")
	end
end

function remWhitelist(identifier)
	if file_exists("whitelist.txt",path.main) then
		whitelist = loadData("whitelist.txt",path.main)
	end
	if whitelist[identifier] then
		whitelist[identifier] = nil
		saveData(whitelist, "whitelist.txt", path.main)
		RconPrint("This user has been removed from whitelist!")
	else
		RconPrint("This user isn't on the whitelist!")
	end
end

if file_exists("bans.txt",path.bans) then
	bantable = loadData("bans.txt",path.bans)
end

if file_exists("whitelist.txt",path.main) then
	whitelist = loadData("whitelist.txt",path.main)
end

RegisterServerEvent('hardcap:playerActivated')
AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
  end
end)

function loadBans()
    SetTimeout(600000, function()
        if file_exists("bans.txt",path.bans) then
            bantable = loadData("bans.txt",path.bans)
        end
        loadBans()
    end)
end
loadBans()
