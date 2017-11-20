local admins = {
	"steam:1100001057052a0", -- Fraz
	"steam:1100001183542fe",
}

AddEventHandler('f:loaded', function(source, user)
	local identifier = user.getIdentifier()
	for k,v in pairs(admins) do
		if user.getIdentifier() == v then
			TriggerClientEvent('Anticheat:isAdmin', source)
			break
		end
	end
end)

