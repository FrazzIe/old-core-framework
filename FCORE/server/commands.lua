commandSuggestions = {}
commands = {}

AddEventHandler('chatMessage', function(source, n, message)
	if(startswith(message, "/"))then
		local command_args = stringsplit(message, " ")

		command_args[1] = string.gsub(command_args[1], "/", "")

		local command = commands[command_args[1]]

		if(command)then
			local source = tonumber(source)
			CancelEvent()
			if(command.perm > 0)then
				if(Users[source].getPermissions() >= command.perm or groups[Users[source].getGroup()]:canTarget(command.group))then
					command.cmd(source, command_args, Users[source])
					TriggerEvent("es:adminCommandRan", source, command_args, Users[source])
					log("commands",'User (' .. GetPlayerName(source) .. ') ran admin command ' .. command_args[1] .. ', with parameters: ' .. table.concat(command_args, ' '))
				else
					command.callbackfailed(source, command_args, Users[source])
					TriggerEvent("es:adminCommandFailed", source, command_args, Users[source])

					log("commands",'User (' .. GetPlayerName(source) .. ') tried to execute command without having permission: ' .. command_args[1])

				end
			else
				command.cmd(source, command_args, Users[source])
				TriggerEvent("es:userCommandRan", source, command_args)
			end
			
			TriggerEvent("es:commandRan", source, command_args, Users[source])
		else
			TriggerEvent('es:invalidCommandHandler', source, command_args, Users[source])

			if WasEventCanceled() then
				CancelEvent()
			end
		end
	else
		TriggerEvent('es:chatMessage', source, message, Users[source])
	end
end)

function addCommand(command, callback, suggestion)
	commands[command] = {}
	commands[command].perm = 0
	commands[command].group = "user"
	commands[command].cmd = callback

	if suggestion then	
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end			
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end			
	
		commandSuggestions[command] = suggestion			
	end

end

AddEventHandler('es:addCommand', function(command, callback, suggestion)
	addCommand(command, callback, suggestion)
end)

function addAdminCommand(command, perm, callback, callbackfailed, suggestion)
	commands[command] = {}
	commands[command].perm = perm
	commands[command].group = "superadmin"
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed

	if suggestion then	
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end			
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end			
	
		commandSuggestions[command] = suggestion			
	end

end

AddEventHandler('es:addAdminCommand', function(command, perm, callback, callbackfailed, suggestion)
	addAdminCommand(command, perm, callback, callbackfailed, suggestion)
end)

function addGroupCommand(command, group, callback, callbackfailed, suggestion)
	commands[command] = {}
	commands[command].perm = math.maxinteger
	commands[command].group = group
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed

	if suggestion then	
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end			
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end			
	
		commandSuggestions[command] = suggestion			
	end

end

AddEventHandler('es:addGroupCommand', function(command, group, callback, callbackfailed, suggestion)
	addGroupCommand(command, group, callback, callbackfailed, suggestion)
end)

function addACECommand(command, group, callback)
	local allowedEveryone = false
	if group == true then allowedEveryone = true end
	RegisterCommand(command, function(source, args)
		if source ~= 0 then
			callback(source, args, Users[source])
		end
	end, allowedEveryone)

	if not allowedEveryone then
		ExecuteCommand('add_ace group.' .. group .. ' command.' .. command .. ' allow')
	end
end

AddEventHandler('es:addACECommand', function(command, group, callback)
	addACECommand(command, group, callback)
end)

RegisterServerEvent('f:updatepos')
AddEventHandler('f:updatepos', function(x, y, z)
	if(Users[source])then
		Users[source].setCoords(x, y, z)
	end
end)

function startswith(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end