--[[ 
    � 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

Schema:SetGlobalAlias("Atomic");

Clockwork.kernel:IncludePrefixed("cl_schema.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_intro.lua");
Clockwork.kernel:IncludePrefixed("cl_theme.lua");
Clockwork.kernel:IncludePrefixed("sh_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_schema.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

Clockwork.option:SetKey("default_date", {month = 8, year = 2280, day = 22});
Clockwork.option:SetKey("default_time", {minute = 0, hour = 12, day = 1});

Clockwork.option:SetKey("name_attributes", "Skills")
Clockwork.option:SetKey("name_attribute", "Skill")

Clockwork.option:SetKey("intro_image", "atomic/atomic_logo_2");
Clockwork.option:SetKey("schema_logo", "atomic/atomic_logo_2");
Clockwork.option:SetKey("community_logo", ""); -- 256 x 256 PNG
Clockwork.option:SetKey("menu_forum_url", "");
Clockwork.option:SetKey("menu_music", "");
Clockwork.option:SetKey("model_cash", "models/props_lab/box01a.mdl");

Clockwork.option:SetKey("format_cash", "%a %n");
Clockwork.option:SetKey("name_cash", "Caps");
Clockwork.option:SetKey("format_singular_cash", "%a");
Clockwork.option:SetKey("model_shipment", "models/props_junk/cardboard_box003b.mdl");

Clockwork.option:SetKey("gradient", "srp/fnv/loading/loading_screen01");

Clockwork.option:SetSound("click_release", "atomic/menu_release.wav");
Clockwork.option:SetSound("rollover", "atomic/menu_rollover.wav");
Clockwork.option:SetSound("click", "atomic/menu_rollover.wav");
Clockwork.option:SetSound("tick", "atomic/menu_rollover1.wav");

Clockwork.plugin:Remove("ClockworkLogoPlugin");

--Damn stamina really do be dead.
--Clockwork.attribute:FindByID("Stamina").maximum = 100;

FACTION_CITIZENS_FEMALE = {};
FACTION_CITIZENS_MALE = {};

for k, v in pairs({34, 37, 38, 40, 41, 42, 43}) do
	for i = 1, 7 do
		if (i != 5) then
			table.insert(FACTION_CITIZENS_FEMALE, "models/humans/group"..v.."/female_0"..i..".mdl");
		end;
	end;

	for i = 1, 9 do
		table.insert(FACTION_CITIZENS_MALE, "models/humans/group"..v.."/male_0"..i..".mdl");
	end;
end;

function Atomic:SetSkillUpdate(player, name, amount)
	if (SERVER) then
		Clockwork.datastream:Start(player, "SetSkillUpdate", {name, amount});
	else
		player.skillDisplay = {name = name, amount = amount};
	end;
end;

if (SERVER) then
	-- A function to get a player's attribute as a fraction.
	function Clockwork.attributes:Fraction(player, attribute, fraction, negative)
		local attributeTable = Clockwork.attribute:FindByID(attribute);
		
		if (attributeTable) then
			local maximum = attributeTable.maximum;
			local amount = self:Get(player, attribute, nil, negative) or 0;
			
			if (amount < 0 and type(negative) == "number") then
				fraction = negative;
			end;
			
			if (!attributeTable.cache[amount][fraction]) then
				attributeTable.cache[amount][fraction] = (fraction / maximum) * amount;
			end;
			
			return attributeTable.cache[amount][fraction];
		else
			return 0;
		end;
	end;
else
	-- A function to get the local player's attribute as a fraction.
	function Clockwork.attributes:Fraction(attribute, fraction, negative)
		local attributeTable = Clockwork.attribute:FindByID(attribute);
		
		if (attributeTable) then
			local maximum = attributeTable.maximum;
			local amount = self:Get(attribute, nil, negative) or 0;
			
			if (amount < 0 and type(negative) == "number") then
				fraction = negative;
			end;
			
			if (!attributeTable.cache[amount][fraction]) then
				attributeTable.cache[amount][fraction] = (fraction / maximum) * amount;
			end;
			
			return attributeTable.cache[amount][fraction];
		else
			return 0;
		end;
	end;
end;