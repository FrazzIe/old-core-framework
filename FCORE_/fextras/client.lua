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

RegisterNetEvent("ipl:LoadAllIPLS")
AddEventHandler("ipl:LoadAllIPLS", function(weapon)
	Citizen.CreateThread(function()

		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl("chop_props")
		RequestIpl("FIBlobby")
		RemoveIpl("FIBlobbyfake")
		RequestIpl("FBI_colPLUG")
		RequestIpl("FBI_repair")
		RequestIpl("v_tunnel_hole")
		RequestIpl("TrevorsMP")
		RequestIpl("TrevorsTrailer")
		RequestIpl("TrevorsTrailerTidy")
		RemoveIpl("farm_burnt")
		RemoveIpl("farm_burnt_lod")
		RemoveIpl("farm_burnt_props")
		RemoveIpl("farmint_cap")
		RemoveIpl("farmint_cap_lod")
		RequestIpl("farm")
		RequestIpl("farmint")
		RequestIpl("farm_lod")
		RequestIpl("farm_props")
		RequestIpl("facelobby")
		RemoveIpl("CS1_02_cf_offmission")
		RequestIpl("CS1_02_cf_onmission1")
		RequestIpl("CS1_02_cf_onmission2")
		RequestIpl("CS1_02_cf_onmission3")
		RequestIpl("CS1_02_cf_onmission4")
		RequestIpl("v_rockclub")
		RemoveIpl("hei_bi_hw1_13_door")
		RequestIpl("bkr_bi_hw1_13_int")
		RequestIpl("ufo")
		RemoveIpl("v_carshowroom")
		RemoveIpl("shutter_open")
		RemoveIpl("shutter_closed")
		RemoveIpl("shr_int")
		RemoveIpl("csr_inMission")
		RequestIpl("v_carshowroom")
		RequestIpl("shr_int")
		RequestIpl("shutter_closed")
		RequestIpl("smboat")
		RequestIpl("cargoship")
		RequestIpl("railing_start")
		RemoveIpl("sp1_10_fake_interior")
		RemoveIpl("sp1_10_fake_interior_lod")
		RequestIpl("sp1_10_real_interior")
		RequestIpl("sp1_10_real_interior_lod")
		RemoveIpl("id2_14_during_door")
		RemoveIpl("id2_14_during1")
		RemoveIpl("id2_14_during2")
		RemoveIpl("id2_14_on_fire")
		RemoveIpl("id2_14_post_no_int")
		RemoveIpl("id2_14_pre_no_int")
		RemoveIpl("id2_14_during_door")
		RequestIpl("id2_14_during1")
		RequestIpl("coronertrash")
		RequestIpl("Coroner_Int_on")
		RemoveIpl("Coroner_Int_off")
		RemoveIpl("bh1_16_refurb")
		RemoveIpl("jewel2fake")
		RemoveIpl("bh1_16_doors_shut")
		RequestIpl("refit_unload")
		RequestIpl("post_hiest_unload")
		RequestIpl("Carwash_with_spinners")
		RequestIpl("ferris_finale_Anim")
		RemoveIpl("ch1_02_closed")
		RequestIpl("ch1_02_open")
		RequestIpl("AP1_04_TriAf01")
		RequestIpl("CS2_06_TriAf02")
		RequestIpl("CS4_04_TriAf03")
		RemoveIpl("scafstartimap")
		RequestIpl("scafendimap")
		RemoveIpl("DT1_05_HC_REMOVE")
		RequestIpl("DT1_05_HC_REQ")
		RequestIpl("DT1_05_REQUEST")
		RequestIpl("FINBANK")
		RemoveIpl("DT1_03_Shutter")
		RemoveIpl("DT1_03_Gr_Closed")
		RequestIpl("ex_sm_13_office_01a")
		RequestIpl("ex_sm_13_office_01b")
		RequestIpl("ex_sm_13_office_02a")
		RequestIpl("ex_sm_13_office_02b")
		RequestIpl("rc12b_hospitalinterior")
		RequestIpl("rc12b_hospitalinterior_lod")
		RequestIpl("rc12b_fixed")
		RequestIpl("CS3_05_water_grp1")
		RequestIpl("CS3_05_water_grp2")
		RequestIpl("canyonriver01")
		RequestIpl("canyonrvrdeep")
		
	end)
end)

Citizen.CreateThread(function()
	for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
    for _, item in pairs(otherblips) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
	  SetBlipColour(item.blip, item.colour)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
end)

otherblips = {
    {name="Prison", id=285, x=1679.049, y=2513.711, z=45.565},
	{name="Staff Headquarters", colour=81, id=120, x=897.00, y=1257.00, z=363.00},
}