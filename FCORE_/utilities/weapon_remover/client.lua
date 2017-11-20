local vehWeapons = {
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_CARBINERIFLE",
}


local hasBeenInPoliceVehicle = false

local alreadyHaveWeapon = {}

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)

		if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
			if(not hasBeenInPoliceVehicle) then
				hasBeenInPoliceVehicle = true
			end
		else
			if(hasBeenInPoliceVehicle) then
				for i,k in pairs(vehWeapons) do
					if(not alreadyHaveWeapon[i]) then
						TriggerServerEvent("police:VehWeapCheck",k)
					end
				end
				hasBeenInPoliceVehicle = false
			end
		end

	end

end)


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		if(not IsPedInAnyVehicle(GetPlayerPed(-1))) then
			if IsPedGettingIntoAVehicle(GetPlayerPed(-1)) then
				for i= 1, #vehWeapons do
					local ch = GetHashKey(vehWeapons[i])
					if(HasPedGotWeapon(GetPlayerPed(-1), ch, false)==1) then
						alreadyHaveWeapon[i] = true
					else
						alreadyHaveWeapon[i] = false
					end
				end
			end
		end
	end

end)


RegisterNetEvent("police:VehWeapDel")
AddEventHandler("police:VehWeapDel", function(weapon)
	RemoveWeaponFromPed(GetPlayerPed(-1), weapon)
end)