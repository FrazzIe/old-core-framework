local ems = {}
main = nil
uniforms = {}
settings = {
	force = "FDNY", --LifeMed,FDNY,Los Angeles EMS
}

ranks = {
	["ems probationary"] = {},
	["ems paramedic"] = {},
	["ems specialist"] = {},
	["ems lieutenant"] = {},
	["ems chief"] = {},
}

function CanTarget(identifier,group)
	if ems[identifier] then
		if ems[identifier] == "ems chief" then
			return true
		elseif ems[identifier] == "ems lieutenant" and group ~= "ems lieutenant" and group ~= "ems chief" then
			return true
		elseif ems[identifier] == "ems specialist" and group ~= "ems specialist" and group ~= "ems lieutenant" and group ~= "ems chief" then
			return true
		elseif ems[identifier] == "ems paramedic" and group ~= "ems paramedic" and group ~= "ems specialist" and group ~= "ems lieutenant" and group ~= "ems chief" then
			return true
		elseif ems[identifier] == "ems probabtionary" and group ~= "ems probabtionary" and group ~= "ems paramedic" and group ~= "ems specialist" and group ~= "ems lieutenant" and group ~= "ems chief" then
			return true
		else
			return false
		end
	else
		return false
	end
end

function CanPromote(s)
	if ems[s] == "ems chief" then
		return true
	else
		return false
	end
end

RegisterServerEvent('paramedic:firstspawn')
AddEventHandler('paramedic:firstspawn', function(source)
	if file_exists("ems.txt", main) then
		ems = loadData("ems.txt", main)
	end
	if ems[GetPlayerIdentifiers(source)[1]] ~= nil then
		TriggerClientEvent('paramedic:activate', source, ems[GetPlayerIdentifiers(source)[1]])
	end
end)

TriggerEvent('es:addGroupCommand', 'emsadd', "admin", function(source, args, user)
	local source = source
	if(#args < 3) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emsadd [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 3)
			if ranks[rank:lower()] ~= nil then
				if file_exists("ems.txt", main) then
					ems = loadData("ems.txt", main)
				end
				ems[GetPlayerIdentifiers(args[2])[1]] = rank:lower()
				saveData(ems,"ems.txt",main)
				TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>".. GetPlayerName(tonumber(args[2])) .."</span> has been accepted. <br> Congratulations on joining the "..settings.force.."!",type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
				TriggerClientEvent('paramedic:nowParamedic', tonumber(args[2]), rank:lower())
			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "This rank does not exist")
			end
		else
			TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emsadd [ID] [RANK]")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "You don't have the permission to do this !")
end, {help = "Add a player to ems", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "EMS Probationary | EMS Paramedic | EMS Specialist | EMS Lieutenant | EMS Chief"}}})

TriggerEvent('es:addGroupCommand', 'emsrem', "admin", function(source, args, user) 
	local source = source
	if(not args[2]) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emsrem [ID]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil)then
			if file_exists("ems.txt", main) then
				ems = loadData("ems.txt", main)
			end
			if ems[GetPlayerIdentifiers(args[2])[1]] ~= nil then
				ems[GetPlayerIdentifiers(args[2])[1]] = nil
				saveData(ems,"ems.txt",main)
				TriggerClientEvent("pNotify:SendNotification", -1, {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>".. GetPlayerName(tonumber(args[2])) .."</span> has been fired. <br> They are no longer an officer of the "..settings.force.."!",type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
				TriggerClientEvent('paramedic:noLongerParamedic', tonumber(args[2]))
			else
				Notify(source,"This user is not a paramedic")
			end
		else
			Notify(source,"No player with this ID !")
		end
	end
end, function(source, args, user) 
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "You don't have the permission to do this !")
end, {help = "Remove a player from ems", params = {{name = "id", help = "The id of the player"}}})

TriggerEvent('es:addGroupCommand', 'emspromote', "admin", function(source, args, user)
	local source = source
	if(#args < 3) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emspromote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 3)
			if ems[GetPlayerIdentifiers(args[2])[1]] ~= nil then
				if ranks[rank:lower()] ~= nil then
					if CanTarget(GetPlayerIdentifiers(source)[1],ems[GetPlayerIdentifiers(args[2])[1]]) then
						if CanPromote(GetPlayerIdentifiers(source)[1]) then
							if file_exists("ems.txt", main) then
							    ems = loadData("ems.txt", main)
							end
							ems[GetPlayerIdentifiers(args[2])[1]] = rank:lower()
							saveData(ems,"ems.txt",main)
							TriggerClientEvent("pNotify:SendNotification", tonumber(args[2]), {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been promoted!</span><br> You are now a "..rank,type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
							TriggerClientEvent('paramedic:nowParamedic', tonumber(args[2]), rank:lower())
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
				Notify(source,"This user is not a paramedic")
			end
		else
			Notify(source,"Player could not be found")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "You don't have the permission to do this !")
end, {help = "Promote a paramedic", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "EMS Probationary | EMS Paramedic | EMS Specialist | EMS Lieutenant | EMS Chief"}}})

TriggerEvent('es:addGroupCommand', 'emsdemote', "admin", function(source, args, user)
	local source = source
	if(#args < 3) then
		TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Usage : /emsdemote [ID] [RANK]")	
	else
		if(GetPlayerName(tonumber(args[2])) ~= nil and tostring(args[3]) ~= nil)then
			local rank = table.concat(args, " ", 3)
			if ems[GetPlayerIdentifiers(args[2])[1]] ~= nil then
				if ranks[rank:lower()] ~= nil then
					if CanTarget(GetPlayerIdentifiers(source)[1],ems[GetPlayerIdentifiers(args[2])[1]]) then
						if CanPromote(GetPlayerIdentifiers(source)[1]) then
							if file_exists("ems.txt", main) then
							    ems = loadData("ems.txt", main)
							end
							ems[GetPlayerIdentifiers(args[2])[1]] = rank:lower()
							saveData(ems,"ems.txt",main)
							TriggerClientEvent("pNotify:SendNotification", tonumber(args[2]), {text = "<b style='color:red'>Alert</b> <br><span style='color:lime'>You have been demoted!</span><br> You are now a "..rank,type = "error",queue = "left",timeout = 10000,layout = "bottomRight"})
							TriggerClientEvent('paramedic:nowParamedic', tonumber(args[2]), rank:lower())
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
				Notify(source,"This user is not a paramedic")
			end
		else
			Notify(source,"Player could not be found")
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "You don't have the permission to do this !")
end, {help = "Demote a paramedic", params = {{name = "id", help = "The id of the player"},{name = "rank", help = "EMS Probationary | EMS Paramedic | EMS Specialist | EMS Lieutenant | EMS Chief"}}})

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

if file_exists("ems.txt", main) then
    ems = loadData("ems.txt", main)
end
loadUniforms()