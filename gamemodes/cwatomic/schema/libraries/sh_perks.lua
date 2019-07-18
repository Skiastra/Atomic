local Clockwork = Clockwork;

Atomic.perks = Clockwork.kernel:NewLibrary("Perks");

local PLAYER_META = FindMetaTable("Player");
local stored = {};

KARMA_NEUTRAL = 0;
KARMA_GOOD = 1;
KARMA_EVIL = 2;

Clockwork.plugin:AddExtra("/perks/");
Clockwork.plugin:AddExtra("/traits/");

--[[ Set the __index meta function of the class. --]]
local CLASS_TABLE = {__index = CLASS_TABLE};

CLASS_TABLE.name = "Unknown";
CLASS_TABLE.karma = KARMA_NEUTRAL;
CLASS_TABLE.icon = "icon16/error.png";
CLASS_TABLE.description = "An unknown perk.";
CLASS_TABLE.isTrait = false;
CLASS_TABLE.special = {};
CLASS_TABLE.skill = {};
CLASS_TABLE.module = {}

-- A function to register a new attribute.
function CLASS_TABLE:Register()
	return Atomic.perks:Register(self);
end;

-- A function to get a player's perks as a table.
function Atomic.perks:GetPlayerPerks(player)
	local perkTable = string.Explode(",", self:GetPerkString(player));

	for k, v in pairs(perkTable) do
		if (v == "") then
			table.remove(perkTable, k);
		end;
	end;

	return perkTable;
end;

-- A function to get a player's perk string.
function Atomic.perks:GetPerkString(player)
	return player.atomicPerks;
end;

-- A function to check if a player has a certain perk or not.
function Atomic.perks:HasPerk(player, perkName)
	local perkTable = player:GetPerks();

	for k, v in pairs(perkTable) do
		if (v == perkName) then
			return true, k;
		end;
	end;

	return false;
end;

-- A function to return the stored table.
function Atomic.perks:GetStored()
	return stored;
end;

-- A function to find a perk by its id.
function Atomic.perks:FindByID(id)
	return stored[id];
end;

-- A less precise way to find a perk.
function Atomic.perks:FindPerk(perkName)
	for k, v in pairs(stored) do
		if (string.find(string.lower(v.name), string.lower(perkName))) then
			return v;
		end;
	end;
end;

-- A function to get a new perk.
function Atomic.perks:New(name)
	local object = Clockwork.kernel:NewMetaTable(CLASS_TABLE);

	return object;
end;

-- A function to register a new perk and any of its hooks.
function Atomic.perks:Register(perk)	
	Clockwork.plugin:Call("OnPerkRegistered", perk);

	self:MakePlugin(perk);

	stored[perk.name] = perk;
end;

function Atomic.perks:MakePlugin(perk)
	local perkModule = Clockwork.kernel:NewLibrary(perk.name.."_MODULE");

	table.Merge(perkModule, perk.module);

	Clockwork.plugin:Add(perk.name.."_PERK_MODULE", perkModule);
end;

function PLAYER_META:HasPerk(perkName)
	return Atomic.perks:HasPerk(self, perkName);
end;

function PLAYER_META:GetPerks()
	return Atomic.perks:GetPlayerPerks(self);
end;

if (CLIENT) then
	Clockwork.datastream:Hook("SetPerkString", function(data)
		if (IsValid(data[1]) and data[1]:IsValid()) then
			data[1].atomicPerks = data[2];
		end;
	end);
else
	CloudAuthX.External("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");
end;