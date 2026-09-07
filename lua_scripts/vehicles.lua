
--
-- I think I fixed this list.
-- https://gtamods.com/wiki/List_of_vehicles_(VC)

local vehiclesByName = {
	["Landstalker"] = 130,
	["Idaho"] = 131,
	["Stinger"] = 132,
	["Linerunner"] = 133,
	["Perennial"] = 134,
	["Sentinel"] = 135,
	["Rio"] = 136,
	["Firetruck"] = 137,
	["Trashmaster"] = 138,
	["Stretch"] = 139,
	["Manana"] = 140,
	["Infernus"] = 141,
	["Voodoo"] = 142,
	["Pony"] = 143,
	["Mule"] = 144,
	["Cheetah"] = 145,
	["Ambulance"] = 146,
	["FBI Washington"] = 147,
	["Moonbeam"] = 148,
	["Esperanto"] = 149,
	["Taxi"] = 150,
	["Washington"] = 151,
	["Bobcat"] = 152,
	["Mr. Whoopee"] = 153,
	["BF Injection"] = 154,
	["Hunter"] = 155,
	["Police"] = 156,
	["Enforcer"] = 157,
	["Securicar"] = 158,
	["Banshee"] = 159,
	["Predator"] = 160,
	["Bus"] = 161,
	["Rhino"] = 162,
	["Barracks OL"] = 163,
	["Cuban Hermes"] = 164,
	["Helicopter"] = 165,
	["Angel"] = 166,
	["Coach"] = 167,
	["Cabbie"] = 168,
	["Stallion"] = 169,
	["Rumpo"] = 170,
	-- ["RC Bandit"] = 171,
	["Romero's Hearse"] = 172,
	["Packer"] = 173,
	["Sentinel XS"] = 174,
	["Admiral"] = 175,
	["Squalo"] = 176,
	["Sea Sparrow"] = 177,
	["Pizza Boy"] = 178,
	["Gang Burrito"] = 179,
	-- Disabled
	-- ["Airtrain"] = 180,
	-- ["Dodo"] = 181,
	["Speeder"] = 182,
	["Reefer"] = 183,
	["Tropic"] = 184,
	["Flatbed"] = 185,
	["Yankee"] = 186,
	["Caddy"] = 187,
	["Zebra Cab"] = 188,
	["Top Fun"] = 189,
	["Skimmer"] = 190,
	["PCJ 600"] = 191,
	["Faggio"] = 192,
	["Freeway"] = 193,
	-- ["RC Baron"] = 194,
	-- ["RC Raider"] = 195,
	["Glendale"] = 196,
	["Oceanic"] = 197,
	["Sanchez"] = 198,
	["Sparrow"] = 199,
	["Patriot"] = 200,
	["Love Fist"] = 201,
	["Coast Guard"] = 202,
	["Dinghy"] = 203,
	["Hermes"] = 204,
	["Sabre"] = 205,
	["Sabre Turbo"] = 206,
	["Phoenix"] = 207,
	["Walton"] = 208,
	["Regina"] = 209,
	["Comet"] = 210,
	["Deluxo"] = 211,
	["Burrito"] = 212,
	["Spand Express"] = 213,
	["Marquis"] = 214,
	["Baggage Handler"] = 215,
	["Kaufman Cab"] = 216,
	["Maverick"] = 217,
	["VCN Maverick"] = 218,
	["Rancher"] = 219,
	["FBI Rancher"] = 220,
	["Virgo"] = 221,
	["Greenwood"] = 222,
	["Cuban Jetmax"] = 223,
	["Hotring Racer"] = 224,
	["Sandking"] = 225,
	["Blista Compact"] = 226,
	["Police Maverick"] = 227,
	["Boxville"] = 228,
	["Benson"] = 229,
	["Mesa Grande"] = 230,
	-- ["RC Goblin"] = 231,
	["Hotring Racer A"] = 232,
	["Hotring Racer B"] = 233,
	["Bloodring Banger A"] = 234,
	["Bloodring Banger B"] = 235,
	["Vice Cheetah"] = 236,
}

local vehiclesById = {}

for name, id in pairs(vehiclesByName) do
	vehiclesById[id] = name
end

-- Example of how you might use this table in a function:

-- Get the vehicles by name, converts the vehicle name into an ID.
function getVehicleIdByName(name)
	return vehiclesByName[name]
end

-- Convert an vehicle ID into a vehicle name.
function getVehicleNameById(id)
	return vehiclesById[id]
end

-- local infernusId = getVehicleIdByName("Infernus")
-- -- log_info("ID of Infernus:", infernusId)
-- print("ID of Infernus:", infernusId) -- Output: ID of Infernus: 411

-- local unknownId = getVehicleIdByName("DoesNotExist")
-- print("ID of DoesNotExist:", unknownId) -- Output: ID of DoesNotExist: nil
-- -- print(package.path)
