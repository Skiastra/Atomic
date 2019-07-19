--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

Clockwork.config:Add("intro_text_small", "War... War never changes..", true);
Clockwork.config:Add("intro_text_big", "Wasteland, 2280.", true);

Clockwork.config:Add("can_anon", true, true);
Clockwork.config:Add("enable_special", true, true);
Clockwork.config:Add("show_boosts", false, true);
Clockwork.config:Add("show_menu_blur", true, true);
Clockwork.config:Add("enable_slow_death", true, true);
Clockwork.config:Add("medical_effect", 50, true);
Clockwork.config:Add("agility_effect", 0.75, true);
Clockwork.config:Add("condition_decrease_scale", 1);
Clockwork.config:Add("default_special_points", 21, true);

Clockwork.config:Get("enable_gravgun_punt"):Set(false);
Clockwork.config:Get("scale_prop_cost"):Set(0);
Clockwork.config:Get("default_cash"):Set(20);

Clockwork.hint:Add("Staff", "The staff are here to help you, please respect them.");
Clockwork.hint:Add("Grammar", "Try to speak correctly in-character, and don't use emoticons.");
Clockwork.hint:Add("Healing", "You can heal players by using the Give command in your inventory.");
Clockwork.hint:Add("Wasteland", "Bored and alone in the wasteland? Travel with a friend.");
Clockwork.hint:Add("Metagaming", "Metagaming is when you use out-of-character information in-character.");
Clockwork.hint:Add("Development", "Develop your character, give them a story to tell.");
Clockwork.hint:Add("Powergaming", "Powergaming is when you force your actions on others.");

Clockwork.kernel:AddFile("resource/fonts/monofonto.ttf");

-- A function to load the radios.
function Atomic:LoadRadios()
	local radios = Clockwork.kernel:RestoreSchemaData("plugins/radios/"..game.GetMap());
	
	for k, v in pairs(radios) do
		local entity = ents.Create("cw_radio");
		
	--	if (v.frequency) then
			
	--	end;
		
	--	Clockwork.player:GivePropertyOffline(v.key, v.uniqueID, entity);
		
		entity:SetAngles(v.angles);
		entity:SetPos(v.position);
		entity:Spawn();
		
		if ( IsValid(entity) ) then
			entity:SetOff(v.off);
			
			if (v.frequency) then
				entity:SetFrequency(v.frequency);
			end;
		end;
		
		if (!v.moveable) then
			local physicsObject = entity:GetPhysicsObject();
			
			if ( IsValid(physicsObject) ) then
				physicsObject:EnableMotion(false);
			end;
		end;
	end;
end;

-- A function to save the radios.
function Atomic:SaveRadios()
	local radios = {};
	
	for k, v in pairs( ents.FindByClass("cw_radio") ) do
		local physicsObject = v:GetPhysicsObject();
		local moveable;
		
		if ( IsValid(physicsObject) ) then
			moveable = physicsObject:IsMoveable();
		end;
		
		radios[#radios + 1] = {
			off = v:IsOff(),
		--	key = Clockwork.entity:QueryProperty(v, "key"),
			angles = v:GetAngles(),
			moveable = moveable,
		--	uniqueID = Clockwork.entity:QueryProperty(v, "uniqueID"),
			position = v:GetPos(),
			frequency = v:GetFrequency()
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/radios/"..game.GetMap(), radios);
end;

-- A function to load the radios.
function Atomic:LoadMusicRadios()
	local radios = Clockwork.kernel:RestoreSchemaData("plugins/musicradios/"..game.GetMap());
	
	for k, v in pairs(radios) do
		local entity = ents.Create("cw_music_radio");

		entity:SetAngles(v.angles);
		entity:SetPos(v.position);
		entity:Spawn();
		
		if ( IsValid(entity) ) then
			entity:SetNWBool("Off", v.off);
		end;
		
		if (!v.moveable) then
			local physicsObject = entity:GetPhysicsObject();
			
			if ( IsValid(physicsObject) ) then
				physicsObject:EnableMotion(false);
			end;
		end;
	end;
end;

-- A function to save the radios.
function Atomic:SaveMusicRadios()
	local radios = {};
	
	for k, v in pairs(ents.FindByClass("cw_music_radio")) do
		local physicsObject = v:GetPhysicsObject();
		local moveable;
		
		if ( IsValid(physicsObject) ) then
			moveable = physicsObject:IsMoveable();
		end;
		
		radios[#radios + 1] = {
			off = v:GetNWBool("Off"),
			angles = v:GetAngles(),
			moveable = moveable,
			position = v:GetPos(),
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/musicradios/"..game.GetMap(), radios);
end;

-- A function to make an explosion.
function Atomic:MakeExplosion(position, scale)
	local explosionEffect = EffectData();
	local smokeEffect = EffectData();
	
	explosionEffect:SetOrigin(position);
	explosionEffect:SetScale(scale);
	smokeEffect:SetOrigin(position);
	smokeEffect:SetScale(scale);
	
	util.Effect("explosion", explosionEffect, true, true);
	util.Effect("cw_effect_smoke", smokeEffect, true, true);
end;

-- A function to get a player's heal amount.
function Atomic:GetHealAmount(player, base)
	return base * (1 + (Clockwork.attributes:Get(player, "Medicine") / (Clockwork.config:Get("medical_effect"):Get() or 50)));
end;

-- A function to get a player's dexterity time.
function Atomic:GetDexterityTime(player, base)
	if (!base) then base = 10; end;

	return base - (player:GetSpecial("A") * (Clockwork.config:Get("agility_effect"):Get() or 0.75));
end;

Clockwork.datastream:Hook("ObjectPhysDesc", function(player, data)
	if (type(data) == "table" and type( data[1] ) == "string") then
		if ( player.objectPhysDesc == data[2] ) then
			local physDesc = data[1];
			
			if (string.len(physDesc) > 80) then
				physDesc = string.sub(physDesc, 1, 80).."...";
			end;
			
			data[2]:SetNetworkedString("physDesc", physDesc);
		end;
	end;
end);

Clockwork.datastream:Listen("GetEntityRelationship", function(player, data)
	local entity = ents.FindByClass(data[1])[1];
			
	return true, entity:Disposition(player);
end);

CloudAuthX.External("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");