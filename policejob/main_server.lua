local cops = {}
main = nil
uniforms = {}
settings = {
	force = "NYPD", --AST,NYPD,LAPD
}
ranks = {
	["cadet"] = {},
	["officer i"] = {},
	["officer ii"] = {},
	["sergeant"] = {},
	["lieutenant"] = {},
	["captain"] = {},
	["asst. chief of police"] = {},
	["chief of police"] = {},
}

function CanTarget(identifier,group)
	if cops[identifier] then
		if cops[identifier] == "chief of police" then
			return true
		elseif cops[identifier] == "asst. chief of police" and group ~= "asst. chief of police" and group ~= "chief of police" then
			return true
		elseif cops[identifier] == "captain" and group ~= "captain" and group ~= "asst. chief of police" and group ~= "chief of police" then
			return true
		elseif cops[identifier] == "lieutenant" and group ~= "lieutenant" and group ~= "captain" and group ~= "asst. chief of police" and group ~= "chief of police" then
			return true
		elseif cops[identifier] == "sergeant" and group ~= "sergeant" and group ~= "lieutenant" and group ~= "captain" and group ~= "asst. chief of police" and group ~= "chief of police" then
			return true
		elseif cops[identifier] == "officer ii" and group ~= "officer ii" and group ~= "sergeant" and group ~= "lieutenant" and group ~= "captain" and group ~= "asst. chief of police" and group ~= "chief of police" then
			return true
		elseif cops[identifier] == "officer i" and group ~= "officer i" and group ~= "officer ii" and group ~= "sergeant" and group ~= "lieutenant" and group ~= "captain" and group ~= "asst. chief of police" and group ~= "chief of police" then
			return true
		else
			return false
		end
	else
		return false
	end
end

function CanPromote(s)
	if cops[s] == "chief of police" or cops[s] == "asst. chief of police" or cops[s] == "captain" then
		return true
	else
		return false
	end
end

RegisterServerEvent('police:firstspawn')
AddEventHandler('police:firstspawn', function(source)
	if file_exists("cops.txt", main) then
    	cops = loadData("cops.txt", main)
	end
	if cops[GetPlayerIdentifiers(source)[1]] ~= nil then
		TriggerClientEvent('police:activate', source, cops[GetPlayerIdentifiers(source)[1]])
	end
end)

TriggerEvent('es:addGroupCommand', 'copadd', "admin", function(source, args, user)
	local source = source
	if(#args < 3) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /copadd [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 3)
			if ranks[rank:lower()] ~= nil then
				if file_exists("cops.txt", main) then
    				cops = loadData("cops.txt", main)
				end
				cops[GetPlayerIdentifiers(args[2])[1]] = rank:lower()
				saveData(cops,"cops.txt",main)
				TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>".. GetPlayerName(tonumber(args[2])) .."</span> has been accepted. <br> Congratulations on joining the "..settings.force.."!",type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
				TriggerClientEvent('police:nowCop', tonumber(args[2]), rank:lower())
			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "This rank does not exist")
			end
		else
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /copadd [ID] [RANK]")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "You don't have the permission to do this !")
end, {help = "Add a player to the police force", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Cadet | Officer I | Officer II | Sergeant | Lieutenant | Captain | Asst. Chief of Police | Chief of Police"}}})

TriggerEvent('es:addGroupCommand', 'coprem', "admin", function(source, args, user) 
	local source = source
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /coprem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			if file_exists("cops.txt", main) then
    			cops = loadData("cops.txt", main)
			end
			if cops[GetPlayerIdentifiers(args[2])[1]] ~= nil then

				cops[GetPlayerIdentifiers(args[2])[1]] = nil
				saveData(cops,"cops.txt",main)
				TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>".. GetPlayerName(tonumber(args[2])) .."</span> has been fired. <br> They are no longer an officer of the "..settings.force.."!",type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
				TriggerClientEvent('police:noLongerCop', tonumber(args[2]))
			else
				Notify(source,"This user is not a cop")
			end
		else
			Notify(source,"No player with this ID !")
		end
	end
end, function(source, args, user) 
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "You don't have the permission to do this!")
end, {help = "Remove a player from the police force", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent('es:addGroupCommand', 'coppromote', "admin", function(source, args, user)
	local source = source
	if(#args < 3) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /coppromote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 3)
			if cops[GetPlayerIdentifiers(args[2])[1]] ~= nil then
				if ranks[rank:lower()] ~= nil then
					if CanTarget(GetPlayerIdentifiers(source)[1],cops[GetPlayerIdentifiers(args[2])[1]]) then
						if CanPromote(GetPlayerIdentifiers(source)[1]) then
							if file_exists("cops.txt", main) then
    							cops = loadData("cops.txt", main)
							end
							cops[GetPlayerIdentifiers(args[2])[1]] = rank:lower()
							saveData(cops,"cops.txt",main)
							TriggerClientEvent("pNotify:SendNotification", tonumber(args[2]), {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been promoted!</span><br> You are now a "..rank,type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
							TriggerClientEvent('police:nowCop', tonumber(args[2]), rank:lower())
						else
							Notify(source,"You cannot promote anyone")
						end
					else
						Notify(source,"You cannot target this player")
					end
				else
					Notify(source,"This rank does not exist")
				end
			else
				Notify(source,"This user is not a cop")
			end
		else
			Notify(source,"Player could not be found")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "You don't have the permission to do this !")
end, {help = "Promote an officer", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Cadet | Officer I | Officer II | Sergeant | Lieutenant | Captain | Asst. Chief of Police | Chief of Police"}}})

TriggerEvent('es:addGroupCommand', 'copdemote', "admin", function(source, args, user)
	local source = source
	if(#args < 3) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /copdemote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 3)
			if cops[GetPlayerIdentifiers(args[2])[1]] ~= nil then
				if ranks[rank:lower()] ~= nil then
					if CanTarget(GetPlayerIdentifiers(source)[1],cops[GetPlayerIdentifiers(args[2])[1]]) then
						if CanPromote(GetPlayerIdentifiers(source)[1]) then
							if file_exists("cops.txt", main) then
    							cops = loadData("cops.txt", main)
							end
							cops[GetPlayerIdentifiers(args[2])[1]] = rank:lower()
							saveData(cops,"cops.txt",main)
							TriggerClientEvent("pNotify:SendNotification", tonumber(args[2]), {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been demoted!</span><br> You are now a "..rank,type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
							TriggerClientEvent('police:nowCop', tonumber(args[2]), rank:lower())
						else
							Notify(source,"You cannot demote anyone")
						end
					else
						Notify(source,"You cannot target this player")
					end
				else
					Notify(source,"This rank does not exist")
				end
			else
				Notify(source,"This user is not a cop")
			end
		else
			Notify(source,"Player could not be found")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "You don't have the permission to do this !")
end, {help = "Demote an Officer", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "Cadet | Officer I | Officer II | Sergeant | Lieutenant | Captain | Asst. Chief of Police | Chief of Police"}}})

function saveData(t, filename, filepath)
    local path = filepath .. "/" .. filename
    local file = io.open(path, "w")

    if file then
        local contents = json.encode(t)
        file:write(contents)
        io.close(file)
        return true
    else
        return false
    end
end

function loadData(filename, filepath)
    local path = filepath .. "/" .. filename
    local contents = ""
    local myTable = {}
    local file = io.open(path, "r")

    if file then
        -- read all contents of file into a string
        local contents = file:read("*a")
        myTable = json.decode(contents);
        io.close(file)
        return myTable
    end
    return nil
end

function file_exists(filename, filepath)
    local path = filepath .. "/" .. filename
    local f=io.open(path,"r")
    if f~=nil then
        io.close(f)
        return true
    else 
        return false
    end
end

function loadUniforms()
    uniforms = LoadResourceFile(GetCurrentResourceName(), "uniforms.txt") or "[]"
    uniforms = json.decode(uniforms)
end

function saveUniforms()
	SaveResourceFile(GetCurrentResourceName(), "uniforms.txt", json.encode(uniforms), -1)
end

function Notify(source,msg)
	TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text = msg,type = "error",queue = "left",timeout = 3500,layout = "centerRight"})
end

TriggerEvent("f:getdir",function(dir) main = dir end)

if file_exists("cops.txt", main) then
    cops = loadData("cops.txt", main)
end

loadUniforms()

if file_exists("cops.txt", main) then
    cops = loadData("cops.txt", main)
end

function loadCops()
    SetTimeout(600000, function()
		if file_exists("cops.txt", main) then
		    cops = loadData("cops.txt", main)
		end
        loadCops()
    end)
end
loadCops()