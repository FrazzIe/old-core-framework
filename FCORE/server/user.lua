itemlist = {
	{n="Ore", id=1, cu=0},
	{n="Metal", id=2, cu=0},
	{n="Gold", id=3, cu=0},
	{n="Cannabis", id=4, cu=0},
	{n="Flour", id=5, cu=0},
	{n="Water", id=6, cu=1},
	{n="Coca leaf", id=7, cu=0},
	{n="Joint", id=8, cu=0},
	{n="Ingot", id=9, cu=0},
	{n="Wheat", id=10, cu=0},
	{n="Meth", id=11, cu=0},
	{n="Produced", id=12, cu=0},
	{n="Sassafras Leaf", id=13, cu=0},
	{n="Ecstasy", id=14, cu=0},
	{n="Precious Stone", id=15, cu=0},
	{n="Jewelry", id=16, cu=0},
	{n="Body Shop", id=17, cu=0},
	{n="Sterilized Body", id=18, cu=0},
	{n="Raw Wood", id=19, cu=0},
	{n="board", id=20, cu=0},
	{n="fish", id=21, cu=0},
	{n="Fish fillet", id=22, cu=2},
	{n="Fresh Meat", id=23, cu=0},
	{n="Barley", id=24, cu=0},
	{n="Beer", id=25, cu=1},
	{n="Grapes", id=26, cu=2},
	{n="Bottle of wine", id=27, cu=1},
	{n="Cocaine", id=28, cu=0},
	{n="Secret Documents", id=29, cu=0},
	{n="Sandwich", id=30, cu=2},
	{n="false papers", id=31, cu=0},
	{n="Opium", id=32, cu=0},
	{n="Heroin", id=33, cu=0},
	{n="Medkit", id=34, cu=3},
	{n="Cheap Medkit", id=35, cu=3},
	{n="Lockpick", id=36, cu=5},
	{n="Repair kit", id=37, cu=4},
	{n="Cheap Repair kit", id=38, cu=4},
	{n="Body armor", id=39, cu=6},
	{n="Burger", id=40, cu=2},
	{n="Vodka", id=41, cu=1},
	{n="GPS", id=99, cu=0}
}

illegalItems = {
	{n="Cannabis", id=4},
	{n="Coca leaf", id=7},
	{n="Meth", id=11},
	{n="Produced", id=12},
	{n="Sassafras Leaf", id=13},
	{n="Ecstasy", id=14},
	{n="Opium", id=32},
	{n="Heroin", id=33},
	{n="Cheap Medkit", id=35},
	{n="Lockpick", id=36},
	{n="Cheap Repair kit", id=38},
	{n="Body armor", id=39},
}

jobs = {
	{id=1, name='Unemployed', pay=100},
	{id=2, name='Police', pay={on=5000,off=100}},
	{id=3, name='Pharmacist', pay=700},
	{id=4, name='futurjob2', pay=500},
	{id=5, name='futurjob', pay=500},
	{id=6, name='Farmer', pay=1500},
	{id=7, name='Lumberjack', pay=1500},
	{id=8, name='Gang', pay=1},
	{id=9, name='Miner', pay=1500},
	{id=10, name='Fisher', pay=700},
	{id=11, name='Docker', pay=700},
	{id=12, name='Brewer', pay=1500},
	{id=13, name='Vigneron', pay=1200},
	{id=14, name='Livreur', pay=700},
	{id=15, name='Emergency', pay={on=5000,off=100}},
	{id=16, name='Mechanic', pay=2500},
	{id=17, name='Taxi', pay=2500},
	{id=18, name='FBI', pay=5000},
    {id=19, name="Courier", pay=600},
    {id=20, name="Pool Cleaner", pay=600}, 
    {id=21, name="Garbage Collector", pay=600},
    {id=22, name="Tow", pay=600},
}

function createUser(source, data)
	data["Identifiers"].ip = GetPlayerEP(source)
	
	local self = {}
	self.source = tonumber(source)
	self.permission_level = data["Power"].permissions
	self.money = data["Money"].cash
	self.bank = data["Money"].bank
	self.dirtymoney = data["Money"].dirtymoney
	self.identifier = data["Identifiers"].steam
	self.identifiers = data["Identifiers"]
	self.group = data["Power"].group
	self.inventory = data["Inventory"].normal
	self.model = data["Models"].normal
	self.weapons = data["Weapons"]
	self.gunlicense = data["Extras"].gunlicense
	self.job = data["Extras"].jobs
	self.characters = data["Characters"]
	self.garage = data["Garages"]
	self.CharcterID = 0
	self.identity = 0
	self.jailtime = data["Extras"].jailtime
	self.lastcoords = data["Extras"].coords
	self.phonenumber = data["Extras"].phonenumber
	self.coords = {x = 0.0, y = 0.0, z = 0.0}
	self.session = {}

	self.haveChanged = false

	local f = {}

	f.getPhoneNumber = function()
		return self.phonenumber
	end

	f.setPhoneNumber = function(n)
		self.phonenumber = n
	end

	f.getJail = function()
		return self.jailtime
	end

	f.setJail = function(t)
		self.jailtime = t
		SetChange(self)
	end

	f.getGarages = function()
		return self.garage[self.CharacterID].garages
	end

	f.setGarageAmount = function(id, amount)
		if id ~= 0 then
			if self.garage[self.CharacterID].garages[i] == tonumber(id) then
				self.garage[self.CharacterID].garages[i].count = tonumber(amount)
			end
		end
		TriggerEvent("garage:updatecars", self.source)
		SetChange(self)
	end

	f.removeGarage = function(id)
		for i = 1, #self.garage[self.CharacterID].garages do
			if self.garage[self.CharacterID].garages[i].id == tonumber(id) then
 				table.remove(self.garage[self.CharacterID].garages, i)
 				TriggerEvent("garage:updatecars", self.source)
 				SetChange(self)
 			end
		end
	end

	f.addGarage = function(id,slots,cost)
		for i = 1, #self.garage[self.CharacterID].garages do
			if self.garage[self.CharacterID].garages[i].id == tonumber(id) then
				self.garage[self.CharacterID].garages[i].cost=self.garage[self.CharacterID].garages[i].cost + tonumber(cost)
				self.garage[self.CharacterID].garages[i].count=tonumber(slots)
				TriggerEvent("garage:updatecars", self.source)
				SetChange(self)
				return print("Altered garage")
			end
		end
		table.insert(self.garage[self.CharacterID].garages,
			{
				id=tonumber(id),
				cost=(tonumber(cost)/2),
				count=tonumber(slots)
			}
		)
		TriggerEvent("garage:updatecars", self.source)
		SetChange(self)
	end

	f.getAllCars = function()
		return self.garage
	end

	f.getCars = function()
		return self.garage[self.CharacterID].vehicles
	end

	f.setGarage = function(plate, gid)
		for i = 1, #self.garage[self.CharacterID].vehicles do
			if self.garage[self.CharacterID].vehicles[i].p == plate then
				self.garage[self.CharacterID].vehicles[i].cg = gid
			end
		end
		TriggerEvent("garage:updatecars", self.source)
		SetChange(self)
	end

	f.setInstance = function(plate, instance)
		for i = 1, #self.garage[self.CharacterID].vehicles do
			if self.garage[self.CharacterID].vehicles[i].p == plate then
				self.garage[self.CharacterID].vehicles[i].instance = instance
			end
		end
		TriggerEvent("garage:updatecars", self.source)
		SetChange(self)
	end

	f.setInsurance = function(plate)
		for i = 1, #self.garage[self.CharacterID].vehicles do
			if self.garage[self.CharacterID].vehicles[i].p == plate then
				self.garage[self.CharacterID].vehicles[i].ins = "true"
			end
		end
		TriggerEvent("garage:updatecars", self.source)
		SetChange(self)
	end

	f.setState = function(v)
		local count = 0
		for i = 1, #self.garage[self.CharacterID].vehicles do
			count = count + 1
		end
		if count > 0 then
			for i = 1, #self.garage[self.CharacterID].vehicles do
				self.garage[self.CharacterID].vehicles[i].s=v -- State
			end
			SetChange(self)
		end
		TriggerEvent("garage:updatecars", self.source)
	end

	f.getCar = function(plate)
		for i = 1, #self.garage[self.CharacterID].vehicles do
 			if self.garage[self.CharacterID].vehicles[i].p == tostring(plate) then
 				return self.garage[self.CharacterID].vehicles[i]
 			end
		end
	end

	f.getCarOwner = function(plate)
		if self.CharacterID ~= nil and self.CharacterID ~= 0 then
			if self.garage[self.CharacterID].vehicles ~= nil then
				for i = 1, #self.garage[self.CharacterID].vehicles do
					if self.garage[self.CharacterID].vehicles[i] ~= nil then
		 				if self.garage[self.CharacterID].vehicles[i].p == tostring(plate) then
		 					return true
		 				end
		 			end
				end
			end
		end
		return false
	end

	f.impoundCar = function(plate)
		for i = 1, #self.garage[self.CharacterID].vehicles do
		    if self.garage[self.CharacterID].vehicles[i].p == tostring(plate) then
		    	self.garage[self.CharacterID].vehicles[i].s = "~r~Impounded"
			 	TriggerEvent("garage:updatecars", self.source)
			 	SetChange(self)
			 	break	
		    end
		end
	end
		
	f.removeCar = function(plate)
		if self.CharacterID ~= nil and self.CharacterID ~= 0 then
			if self.garage[self.CharacterID].vehicles ~= nil then
				for i = 1, #self.garage[self.CharacterID].vehicles do
					if self.garage[self.CharacterID].vehicles[i] ~= nil then
		 				if self.garage[self.CharacterID].vehicles[i].p == tostring(plate) then
			 				table.remove(self.garage[self.CharacterID].vehicles, i)
			 				TriggerEvent("garage:updatecars", self.source)
			 				SetChange(self)
			 				break
			 			end
			 		end
			 	end
 			end
		end
	end

	f.addCar = function(data)
		for i = 1, #self.garage[self.CharacterID].vehicles do
		    if self.garage[self.CharacterID].vehicles[i].p == tostring(data.p) then
		    	if data.n ~= "no" then
					self.garage[self.CharacterID].vehicles[i].n=data.n -- Name
				end
				self.garage[self.CharacterID].vehicles[i].m=data.m -- Model
				self.garage[self.CharacterID].vehicles[i].instance=data.instance -- Current Vehicle instance
				self.garage[self.CharacterID].vehicles[i].cg=data.cg -- Current garage
				self.garage[self.CharacterID].vehicles[i].p=data.p -- Plate
				self.garage[self.CharacterID].vehicles[i].s=data.s -- State
				self.garage[self.CharacterID].vehicles[i].cp=data.cp -- Colour Primary
				self.garage[self.CharacterID].vehicles[i].cs=data.cs -- Colour Secondary
				self.garage[self.CharacterID].vehicles[i].pc=data.pc -- Pearlescent Colour
				self.garage[self.CharacterID].vehicles[i].wc=data.wc -- Wheel Colour
				self.garage[self.CharacterID].vehicles[i].pi=data.pi -- Colour of license plate
				self.garage[self.CharacterID].vehicles[i].nc=data.nc -- Neon Colours
				self.garage[self.CharacterID].vehicles[i].wt=data.wt -- Window Tint
				self.garage[self.CharacterID].vehicles[i].wht=data.wht -- Wheel type
				self.garage[self.CharacterID].vehicles[i].m0=data.m0 -- Vehicle Mod 0
				self.garage[self.CharacterID].vehicles[i].m1=data.m1 -- Vehicle Mod 1
				self.garage[self.CharacterID].vehicles[i].m2=data.m2 -- Vehicle Mod 2
				self.garage[self.CharacterID].vehicles[i].m3=data.m3 -- Vehicle Mod 3
				self.garage[self.CharacterID].vehicles[i].m4=data.m4 -- Vehicle Mod 4
				self.garage[self.CharacterID].vehicles[i].m5=data.m5 -- Vehicle Mod 5
				self.garage[self.CharacterID].vehicles[i].m6=data.m6 -- Vehicle Mod 6
				self.garage[self.CharacterID].vehicles[i].m7=data.m7 -- Vehicle Mod 7
				self.garage[self.CharacterID].vehicles[i].m8=data.m8 -- Vehicle Mod 8
				self.garage[self.CharacterID].vehicles[i].m9=data.m9 -- Vehicle Mod 9
				self.garage[self.CharacterID].vehicles[i].m10=data.m10 -- Vehicle Mod 10
				self.garage[self.CharacterID].vehicles[i].m11=data.m11 -- Vehicle Mod 11
				self.garage[self.CharacterID].vehicles[i].m12=data.m12 -- Vehicle Mod 12
				self.garage[self.CharacterID].vehicles[i].m13=data.m13 -- Vehicle Mod 13
				self.garage[self.CharacterID].vehicles[i].m14=data.m14 -- Vehicle Mod 14
				self.garage[self.CharacterID].vehicles[i].m15=data.m15 -- Vehicle Mod 15
				self.garage[self.CharacterID].vehicles[i].m16=data.m16 -- Vehicle Mod 16
				self.garage[self.CharacterID].vehicles[i].t=data.t -- Turbo
				self.garage[self.CharacterID].vehicles[i].xl=data.xl -- Xenon Lights
				self.garage[self.CharacterID].vehicles[i].ts=data.ts -- Tire Smoke
				self.garage[self.CharacterID].vehicles[i].m23=data.m23 -- Vehicle Mod 23
				self.garage[self.CharacterID].vehicles[i].m24=data.m24 -- Vehicle Mod 24
				self.garage[self.CharacterID].vehicles[i].n0=data.n0 -- Neon 0
				self.garage[self.CharacterID].vehicles[i].n1=data.n1 -- Neon 1
				self.garage[self.CharacterID].vehicles[i].n2=data.n2 -- Neon 2
				self.garage[self.CharacterID].vehicles[i].n3=data.n3 -- Neon 3
				self.garage[self.CharacterID].vehicles[i].bp=data.bp -- Bulletproof tyres
				self.garage[self.CharacterID].vehicles[i].sc=data.sc -- Tire smoke colour
				self.garage[self.CharacterID].vehicles[i].cw=data.cw -- Custom Wheels
				TriggerEvent("garage:updatecars", self.source)
				SetChange(self)
		        return 1
		    end
		end
		table.insert(self.garage[self.CharacterID].vehicles,
			{
				n=data.n, -- Name
				c=data.c, -- Cost/2
				m=data.m, -- Model
				instance=data.instance, -- Current Instance
				cg=data.cg, -- Current garage
				p=data.p, -- Plate
				s=data.s, -- State
				cp=data.cp, -- Colour Primary
				cs=data.cs, -- Colour Secondary
				pc=data.pc, -- Pearlescent Colour
				wc=data.wc, -- Wheel Colour
				pi=data.pi, -- Colour of license plate
				nc=data.nc, -- Neon Colours
				wt=data.wt, -- Window Tint
				wht=data.wht, -- Wheel type
				m0=data.m0, -- Vehicle Mod 0
				m1=data.m1, -- Vehicle Mod 1
				m2=data.m2, -- Vehicle Mod 2
				m3=data.m3, -- Vehicle Mod 3
				m4=data.m4, -- Vehicle Mod 4
				m5=data.m5, -- Vehicle Mod 5
				m6=data.m6, -- Vehicle Mod 6
				m7=data.m7, -- Vehicle Mod 7
				m8=data.m8, -- Vehicle Mod 8
				m9=data.m9, -- Vehicle Mod 9
				m10=data.m10, -- Vehicle Mod 10
				m11=data.m11, -- Vehicle Mod 11
				m12=data.m12, -- Vehicle Mod 12
				m13=data.m13, -- Vehicle Mod 13
				m14=data.m14, -- Vehicle Mod 14
				m15=data.m15, -- Vehicle Mod 15
				m16=data.m16, -- Vehicle Mod 16
				t=data.t, -- Turbo
				xl=data.xl, -- Xenon Lights
				ts=data.ts, -- Tire Smoke
				m23=data.m23, -- Vehicle Mod 23
				m24=data.m24, -- Vehicle Mod 24
				n0=data.n0, -- Neon 0
				n1=data.n1, -- Neon 1
				n2=data.n2, -- Neon 2
				n3=data.n3, -- Neon 3
				bp=data.bp, -- Bulletproof tyres
				sc=data.sc, -- Tire smoke colour
				cw=data.cw, -- Custom Wheels
				ins=data.ins, -- Insurance
			}
		)
		TriggerEvent("garage:updatecars", self.source)
		SetChange(self)
		return 0
    end

	f.getCharacterID = function()
		return self.CharacterID
	end

	f.setCharacterID = function(v)
		self.CharacterID = tonumber(v)
	end

	f.CreateCharacter = function(id,n,dob,g,height)
		local key
		local alter = false
		if #self.characters >= 1 then
			for k,v in pairs(self.characters) do
				if id == v.id then
					alter = true
					key = k
					break
				end
			end
		end
		if not alter then
			if #self.characters <= 3 then
				table.insert(self.characters,{id=tonumber(id), name=tostring(n), dob=tostring(dob), gen=tostring(g), height=tonumber(height)})
				SetChange(self)
			else
				print("Call for 4th charater was made?")
			end
		else
			self.characters[key] = {id=tonumber(id), name=tostring(n), dob=tostring(dob), gen=tostring(g), height=tonumber(height)}
			SetChange(self)
		end
	end

	f.getCharacters = function()
		return self.characters
	end

	f.wipeCharacter = function(id)
		local models = {1413662315,-781039234,1077785853,2021631368,1423699487,1068876755,2120901815,-106498753,131961260,-1806291497,1641152947,115168927,330231874,-1444213182,1809430156,1822107721,2064532783,-573920724,-782401935,808859815,-1106743555,-1606864033,1004114196,532905404,1699403886,-1656894598,1674107025,-88831029,-1244692252,951767867,1388848350,1090617681,379310561,-569505431,-1332260293,-840346158}
		local id = tonumber(id)
		local key
		for k,v in pairs(self.characters) do
			if id == v.id then
					key = k
				break
			end
		end
		table.remove(self.characters, key)
		self.money[id] = 2500
		self.bank[id] = 0
		self.dirtymoney[id] = 0
		self.job[id] = 1
		self.inventory[id] = {}
		self.garage[id] = {garages = {{id=1,cost=0,count=3},{id=2,cost=0,count=3},{id=3,cost=0,count=3},{id=4,cost=0,count=3}},vehicles = {}}
		self.gunlicense[id] = 0
		self.model[id] = 
			{
                id = id,
                model = models[math.random(1,tonumber(#models))],
                new = true,
                clothing = {drawables = {0,0,0,0,0,0,0,0,0,0,0,0},textures = {2,0,1,1,0,0,0,0,0,0,0,0},palette = {0,0,0,0,0,0,0,0,0,0,0,0}},
                props = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1}, textures = {-1,-1,-1,-1,-1,-1,-1,-1}},
                overlays = {drawables = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}, opacity = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0}, colours = {{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0},{colourType = 0, colour = 0}}},
            }
		self.weapons[id] = {}
		self.lastcoords[id] = {x = -1858.91, y = -348.509, z = 49.8377}
		self.CharcterID = 0
		self.identity = 0
	end

	f.getIdentity = function()
		return self.identity
	end

	f.setIdentity = function(fname,sname,dob,g,height)
		self.identity = {fname=tostring(fname), sname=tostring(sname), dob=tostring(dob), g=tostring(g), height=tostring(height)}
	end

	f.getJobs = function()
		return self.job
	end

	f.getJob = function()
		for i = 1, #self.job do
			return self.job[self.CharacterID]
		end
	end

	f.setJob = function(v)
		local exist = DoesJobExist(v)
		if exist then
			self.job[self.CharacterID] = tonumber(v)
			SetChange(self)
		else
			print("Resource attempted to setJob but the job does not exist")
		end
	end

	f.getJobData = function()
		for _, j in pairs(jobs) do
			if j.id == self.job[self.CharacterID] then
				return j
			end
		end
	end

	f.addWeapon = function(w,sp,l,wn)
		local count = 0
		for i = 1, #self.weapons[self.CharacterID] do
			count = count + 1
		end
		if count > 6 then
			return false
		else
			table.insert(self.weapons[self.CharacterID],{w=w,sp=tonumber(sp),l=tonumber(l),wn=wn})
		end
		SetChange(self)
	end

	--Never tested it probs broke
	f.removeWeapon = function(model)
		for i = 1, #self.weapons[self.CharacterID] do
			if self.weapons[self.CharacterID][i] ~= nil then
	 			if self.weapons[self.CharacterID][i].w == tostring(model) then
	 				table.remove(self.weapons[self.CharacterID], i)
	 				break
	 			end
	 		end
		end
		SetChange(self)
	end

	f.removeWeapons = function()
		self.weapons[self.CharacterID] = {}
		SetChange(self)
	end

	f.removeAllWeapons = function()
		self.weapons = {}
		SetChange(self)
	end

	f.getWeapons = function()
		return self.weapons[self.CharacterID]
	end

	f.getAllWeapons = function()
		return self.weapons
	end

	f.setGunlicense = function(v)
		self.gunlicense[self.CharacterID] = tonumber(v)
	end

	f.getGunlicense = function()
		return self.gunlicense[self.CharacterID]
	end

	f.getGunlicenses = function()
		return self.gunlicense
	end

	f.setModel = function(data)
		for i = 1, #self.model do
			if self.model[i].id == self.CharacterID then
				local id = self.model[i].id
				self.model[i] = data
				self.model[i].id = id
			end
		end
	end

	f.getModel = function()
		for i = 1, #self.model do
			if self.model[i].id == self.CharacterID then
				return self.model[i]
			end
		end
	end

	f.getModels = function()
		return self.model
	end
	
	f.setInventory = function()
		self.inventory[self.CharacterID] = {}
	end

	f.getInventory = function()
		return self.inventory[self.CharacterID]
	end

	f.getInventories = function()
		return self.inventory
	end

	f.addQuantity = function(itemid, quantity)
		local exist = DoesItemExist(itemid)
		if exist then
	        local thisItemId = tonumber(itemid)
	        local thisQuantity = tonumber(quantity)
	        local isFull = CheckIfFull(self.inventory[self.CharacterID],thisQuantity)
	        if not isFull then
		        for i = 1, #self.inventory[self.CharacterID] do
		            if self.inventory[self.CharacterID][i].id == tonumber(itemid) then
		                self.inventory[self.CharacterID][i].q = self.inventory[self.CharacterID][i].q + tonumber(quantity)
		                TriggerEvent("inventory:updateitems",self.source)
		                SetChange(self)
		                return 1
		            end
		        end
		        local name = getItemname(thisItemId)
		        local canUse = getItemCanUse(thisItemId)
		        table.insert(self.inventory[self.CharacterID],
		            {
		                id = thisItemId,
		                q = thisQuantity,
		                n = name,
		                cu = canUse
		            }
		        )
		        TriggerEvent("inventory:updateitems",self.source)
		        SetChange(self)
	        	return 2
	        else
	        	return 0
	        end
	    else
	    	print("[ERROR - FCORE]::Resource attempted to addQuantity but the item does not exist")
	    	log("errors","[ERROR - FCORE]::Resource attempted to addQuantity but the item does not exist")
	    end
    end

	f.removeQuantity = function(itemid, quantity)

		local exist = DoesItemExist(itemid)
		if exist then
	        local thisItemId = tonumber(itemid)
	        local thisQuantity = tonumber(quantity)
	        for i = 1, #self.inventory[self.CharacterID] do
	            if self.inventory[self.CharacterID][i].id == tonumber(itemid) and self.inventory[self.CharacterID][i].q >= tonumber(quantity) then
	                self.inventory[self.CharacterID][i].q = self.inventory[self.CharacterID][i].q - tonumber(quantity)
	                TriggerEvent("inventory:updateitems",self.source)
	                SetChange(self)
	                return 1
	            elseif self.inventory[self.CharacterID][i].id == tonumber(itemid) and self.inventory[self.CharacterID][i].q < tonumber(quantity) then
	                self.inventory[self.CharacterID][i].q = 0
	                TriggerEvent("inventory:updateitems",self.source)
	                SetChange(self)
	                return 1
	            end
	        end
	    else
	    	print("[ERROR - FCORE]::Resource attempted to remQuantity but the item does not exist")
	    	log("errors","[ERROR - FCORE]::Resource attempted to remQuantity but the item does not exist")
	    end
    end

	f.isAbleToDrop = function(itemid, quantity)
		local exist = DoesItemExist(itemid)
		if exist then
		    local thisItemId = tonumber(itemid)
		    local thisQuantity = tonumber(quantity)
		    for i = 1, #self.inventory[self.CharacterID] do
		        if self.inventory[self.CharacterID][i].id == tonumber(itemid)then
		        	if self.inventory[self.CharacterID][i].q >= tonumber(quantity) then
		            	return true
		            else
		            	return false
		            end
		        end
		    end
	    else
	    	print("[ERROR - FCORE]::Resource attempted to DropQuantity but the item does not exist")
	    	log("errors","[ERROR - FCORE]::Resource attempted to DropQuantity but the item does not exist")
	    end
	end

	f.isAbleToReceive = function(quantity)
		local isFull = CheckIfFull(self.inventory[self.CharacterID], tonumber(quantity))
		if not isFull then
			return true
		else
			return false
		end
	end

	f.isAbleToGive = function(itemId, quantity)
        for i = 1, #self.inventory[self.CharacterID] do
            if tonumber(self.inventory[self.CharacterID][i].id) == tonumber(itemId) then
                if tonumber(quantity) <= tonumber(self.inventory[self.CharacterID][i].q) then
                    return true
                else
                    return false
                end
            end
        end
        return false
    end

	f.isItemIllegal = function(itemId)
		for _, item in pairs(illegalItems) do
			if item.id == tonumber(itemId) then
				return true
			end
		end
		return false
    end

	f.getItemData = function(itemId)
		local itemId = tonumber(itemId)
		local exist = DoesItemExist(itemId)
		if exist then
		    for i = 1, #self.inventory[self.CharacterID] do
		        if self.inventory[self.CharacterID][i].id == tonumber(itemId) then
		            return self.inventory[self.CharacterID][i]
		        end
		    end
			for _, item in pairs(itemlist) do
				if item.id == tonumber(itemId) then
					return {id=item.id,n=item.n,cu=item.cu,q=0}
				end
			end		    
		else
			print("[ERROR - FCORE]::Resource attempted to getItemData but the item does not exist")
			log("errors","[ERROR - FCORE]::Resource attempted to getItemData but the item does not exist")
		end
	end

	f.setMoney = function(m)
		if type(m) == "number" then
			local prevMoney = self.money[self.CharacterID]
			local newMoney = m

			self.money[self.CharacterID] = m

			if((prevMoney - newMoney) < 0)then
				TriggerClientEvent("f:addMoney", self.source, math.abs(prevMoney - newMoney))
			else
				TriggerClientEvent("f:remMoney", self.source, math.abs(prevMoney - newMoney))
			end

			TriggerClientEvent('f:disMoney', self.source , self.money[self.CharacterID])
			
			SetChange(self)
		else
			log("errors","[ERROR - FCORE]::There seems to be an issue while setting money, something else then a number was entered.")			
			print('[ERROR - FCORE]::There seems to be an issue while setting money, something else then a number was entered.')
		end		
	end

	f.getDirty = function()
		return self.dirtymoney[self.CharacterID]
	end

	f.getAllDirty = function()
		return self.dirtymoney
	end

	f.getMoney = function()
		return self.money[self.CharacterID]
	end

	f.getAllMoney = function()
		return self.money
	end

	f.setBankBalance = function(m)
		if type(m) == "number" then
			local prevBank = self.bank[self.CharacterID]
			local newBank = m

			self.bank[self.CharacterID] = m

			if((prevBank - newBank) < 0)then
				TriggerClientEvent("f:addBank", self.source, math.abs(prevBank - newBank))
			else
				TriggerClientEvent("f:remBank", self.source, math.abs(prevBank - newBank))
			end

			TriggerClientEvent('f:disBank', self.source , self.bank[self.CharacterID])

			SetChange(self)
		else
			log("errors",'[ERROR - FCORE]::There seems to be an issue while setting bank, something else then a number was entered.')			
			print('[ERROR - FCORE]::There seems to be an issue while setting bank, something else then a number was entered.')
		end		
	end

	f.setDirtyMoney = function(m)
		if type(m) == "number" then
			local prevDirtyMoney = self.dirtymoney[self.CharacterID]
			local newDirtyMoney = m

			self.dirtymoney[self.CharacterID] = m

			if((prevDirtyMoney - newDirtyMoney) < 0)then
				TriggerClientEvent("f:addDirty", self.source, math.abs(prevDirtyMoney - newDirtyMoney))
			else
				TriggerClientEvent("f:remDirty", self.source, math.abs(prevDirtyMoney - newDirtyMoney))
			end

			TriggerClientEvent('f:disDirty', self.source , self.dirtymoney[self.CharacterID])

			SetChange(self)
		else
			log("errors",'[ERROR - FCORE]::There seems to be an issue while setting dirty money, something else then a number was entered.')			
			print('[ERROR - FCORE]::There seems to be an issue while setting dirty money, something else then a number was entered.')
		end		
	end

	f.addDirtyMoney = function(m)
		if type(m) == "number" then
			local newDirtyMoney = self.dirtymoney[self.CharacterID] + m

			self.dirtymoney[self.CharacterID] = newDirtyMoney

			TriggerClientEvent("f:addDirty", self.source, m)

			TriggerClientEvent('f:disDirty', self.source , self.dirtymoney[self.CharacterID])

			SetChange(self)
		else
			log("errors",'[ERROR - FCORE]::There seems to be an issue while adding dirty money, something else then a number was entered.')			
			print('[ERROR - FCORE]::There seems to be an issue while adding dirty money, something else then a number was entered.')
		end	
	end

	f.removeDirtyMoney = function(m)
		if type(m) == "number" then
			local newDirtyMoney = self.dirtymoney[self.CharacterID] - m

			self.dirtymoney[self.CharacterID] = newDirtyMoney

			TriggerClientEvent("f:remDirty", self.source, m)

			TriggerClientEvent('f:disDirty', self.source , self.dirtymoney[self.CharacterID])

			SetChange(self)
		else
			log("errors",'[ERROR - FCORE]::There seems to be an issue while removing dirty money, something else then a number was entered.')			
			print('[ERROR - FCORE]::There seems to be an issue while removing dirty money, something else then a number was entered.')
		end	
	end

	f.getItems = function()
		return itemlist
	end

	f.getBank = function()
		return self.bank[self.CharacterID]
	end

	f.getAllBank = function()
		return self.bank
	end
	
	f.getCoords = function()
		return self.coords
	end

	f.setCoords = function(x, y, z)
		self.coords = {x = x, y = y, z = z}
		SetChange(self)
	end

	f.setLastCoords = function()
		if self.CharacterID ~= nil and self.CharacterID ~= 0 then
			self.lastcoords[self.CharacterID] = self.coords
		else
		
		end
	end

	f.getLastCoords = function()
		return self.lastcoords
	end

	f.getLastCoordsForCharacter = function()
		return self.lastcoords[self.CharacterID]
	end

	f.kick = function(r)
		DropPlayer(self.source, r)
	end

	f.addMoney = function(m)
		if type(m) == "number" then
			local newMoney = self.money[self.CharacterID] + m

			self.money[self.CharacterID] = newMoney

			TriggerClientEvent("f:addMoney", self.source, m)

			TriggerClientEvent('f:disMoney', self.source , self.money[self.CharacterID])

			SetChange(self)
		else
			log("errors",'[ERROR - FCORE]::There seems to be an issue while adding money, something else then a number was entered.')			
			print('[ERROR - FCORE]::There seems to be an issue while adding money, something else then a number was entered.')
		end	
	end

	f.removeMoney = function(m)
		if type(m) == "number" then
			local newMoney = self.money[self.CharacterID] - m

			self.money[self.CharacterID] = newMoney

			TriggerClientEvent("f:remMoney", self.source, m)

			TriggerClientEvent('f:disMoney', self.source , self.money[self.CharacterID])

			SetChange(self)
		else
			log("errors",'[ERROR - FCORE]::There seems to be an issue while removing money, something else then a number was entered.')			
			print('[ERROR - FCORE]::There seems to be an issue while removing money, something else then a number was entered.')
		end	
	end

	f.addBank = function(m)
		if type(m) == "number" then
			local newBank = self.bank[self.CharacterID] + m
			self.bank[self.CharacterID] = newBank

			TriggerClientEvent("f:addBank", self.source, m)

			TriggerClientEvent('f:disBank', self.source , self.bank[self.CharacterID])

			SetChange(self)
		else
			log("errors",'[ERROR - FCORE]::There seems to be an issue while adding bank, something else then a number was entered.')			
			print('[ERROR - FCORE]::There seems to be an issue while adding bank, something else then a number was entered.')
		end	
	end

	f.removeBank = function(m)
		if type(m) == "number" then
			local newBank = self.bank[self.CharacterID] - m
			self.bank[self.CharacterID] = newBank

			TriggerClientEvent("f:remBank", self.source, m)

			TriggerClientEvent('f:disBank', self.source , self.bank[self.CharacterID])

			SetChange(self)
		else
			log("errors",'[ERROR - FCORE]::There seems to be an issue while removing bank, something else then a number was entered.')			
			print('[ERROR - FCORE]::There seems to be an issue while removing bank, something else then a number was entered.')
		end	
	end

	f.displayMoney = function(m)
		TriggerClientEvent('f:disMoney', self.source , self.money[self.CharacterID])
	end

	f.displayBank = function(m)
		TriggerClientEvent("f:disBank", self.source, self.bank[self.CharacterID])
	end

	f.displayDirty = function(m)
		TriggerClientEvent("f:disDirty", self.source, self.dirtymoney[self.CharacterID])
	end

	f.setSessionVar = function(key, value)
		self.session[key] = value
	end

	f.getSessionVar = function(k)
		return self.session[k]
	end

	f.getPermissions = function()
		return self.permission_level
	end

	f.setPermissions = function(p)
		self.permission_level = p
	end

	f.getIdentifier = function(i)
		return self.identifier
	end

	f.getIdentifiers = function()
		return self.identifiers
	end

	f.getGroup = function()
		return self.group
	end

	f.set = function(k, v)
		self[k] = v
	end

	f.get = function(k)
		return self[k]
	end

	f.setGlobal = function(g, default)
		self[g] = default or ""

		f["get" .. g:gsub("^%l", string.upper)] = function()
			return self[g]
		end

		f["set" .. g:gsub("^%l", string.upper)] = function(e)
			self[g] = e
		end

		Users[self.source] = f
	end

	return f
end

function SetChange(user)
	user.haveChanged = true
end

function CheckIfFull(inventory,quantity)
	local total = 0
    for i = 1, #inventory do
        total = total + tonumber(inventory[i].q)
    end
    if total == 0 then
    	return false
    else
	    total = total + quantity
    	if total > 100 then
    		return true
    	else
        	return false
    	end
    end
end

function DoesItemExist(itemId)
	for _, item in pairs(itemlist) do
		if item.id == tonumber(itemId) then
			return true
		end
	end
	return false
end

function getItemname(itemId)
	for _, item in pairs(itemlist) do
		if item.id == tonumber(itemId) then
			return item.n
		end
	end
	return false
end

function getItemCanUse(itemId)
	for _, item in pairs(itemlist) do
		if item.id == tonumber(itemId) then
			return item.cu
		end
	end
end

function DoesJobExist(job)
	for _, item in pairs(jobs) do
		if item.id == tonumber(job) then
			return true
		end
	end
	return false
end