--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

-- Called when a player uses an unknown item function.
function Atomic:PlayerUseUnknownItemFunction(player, itemTable, itemFunction)
	--[[ 
	MAKE THIS A PERK
	if (Clockwork.player:HasFlags(player, "T") and itemFunction == "Caps" and itemTable.cost) then
		local useSounds = {"buttons/button5.wav", "buttons/button4.wav"};
		local instance = Clockwork.item:CreateInstance(itemTable.uniqueID);
		
		player:TakeItem(instance, true);
		player:EmitSound( useSounds[ math.random(1, #useSounds) ] );
		
		Clockwork.player:GiveCash(player, math.Round(itemTable.cost / 2), "scrapped an item");
	end;
	--]]
end;

function Atomic:PrePlayerDefaultFootstep(player)
	if (player:Crouching() and Clockwork.config:Get("mute_crouched"):GetBoolean()) then
		return true;
	end;
end;

function Atomic:PlayerDataLoaded(player)
	Clockwork.datastream:Start(player, "StartIntroduction", {player:GetData("FNVIntro")});
	player:SetData("ClockworkIntro", true);
	player:SetData("FNVIntro", true);
end;

function Atomic:EntityFireBullets(entity, bulletInfo)
	self:DoFireBullets(entity, bulletInfo);
end;

-- Called when a player takes damage.
function Atomic:PlayerTakeDamage(player, inflictor, attacker, hitGroup, damageInfo)
	self:DoTakeDamage(player, inflictor, attacker, hitGroup, damageInfo);
end;

-- Called when a player's attribute has been updated.
function Atomic:PlayerAttributeUpdated(player, attributeTable, amount)
	if (amount and amount > 0) then
		if (attributeTable.name == "Sneak") then
			player:SetNWInt("Sneak", Clockwork.attributes:Get(player, "Sneak"));
		end;

		return Atomic:SetSkillUpdate(player, attributeTable.name);
	end;
end;

-- Called when Clockwork config has changed.
function Atomic:ClockworkConfigChanged(key, data, previousValue, newValue)
	if (key == "enable_special") then
		if (newValue == true) then
			for key, player in pairs(_player.GetAll()) do
				for k, v in pairs(self.special:GetNameTable()) do
					local value = self.special:LoadSpecial(player, v);

					player:SetSpecial(k, value);
				end;
			end;
		else
			for key, player in pairs(_player.GetAll()) do
				for k, v in pairs(self.special:GetNameTable()) do
					Clockwork.plugin:Call("OnSpecialChanged", player, v, 0, 0);
				end;
			end;
		end;
	end;
end;

-- Called when a player attempts to use a lowered weapon.
function Atomic:PlayerCanUseLoweredWeapon(player, weapon, secondary)
	if ( secondary and (weapon.SilenceTime or weapon.PistolBurst) ) then
		return true;
	end;
end;

-- Called when a player's character screen info should be adjusted.
function Atomic:PlayerAdjustCharacterScreenInfo(player, character, info)
	if (character.data["customclass"]) then
		info.customClass = character.data["customclass"];
	end;
end;

-- Called when a player's shared variables should be set.
function Atomic:PlayerSetSharedVars(player, curTime)
	player:SetSharedVar("customClass", player:GetCharacterData("customclass", ""));
end;

-- Called when Clockwork has loaded all of the entities.
function Atomic:ClockworkInitPostEntity()
	self:LoadMusicRadios();
end;

-- Called just after data should be saved.
function Atomic:PostSaveData()
	self:SaveMusicRadios();
end;

-- Called when a player attempts to use the radio.
function Atomic:PlayerCanRadio(player, text, listeners, eavesdroppers)
	if ( player:HasItemByID("handheld_radio") ) then
		if ( !player:GetCharacterData("frequency") ) then
			Clockwork.player:Notify(player, "You need to set the radio frequency first!");
			
			return false;
		end;
	else
		Clockwork.player:Notify(player, "You do not own a radio!");
		
		return false;
	end;
end;

-- Called when a player has been unragdolled.
function Atomic:PlayerUnragdolled(player, state, ragdoll)
	Clockwork.player:SetAction(player, "die", false);
end;

-- Called when a player has been ragdolled.
function Atomic:PlayerRagdolled(player, state, ragdoll)
	Clockwork.player:SetAction(player, "die", false);
end;

-- Called when death attempts to clear a player's recognised names.
function Atomic:PlayerCanDeathClearRecognisedNames(player, attacker, damageInfo) return false; end;

-- Called when death attempts to clear a player's name.
function Atomic:PlayerCanDeathClearName(player, attacker, damageInfo) return false; end;

-- Called when a player attempts to sprint.
function Atomic:PlayerShouldSmoothSprint(player, infoTable)
    return false;
end;

-- Called when a player attempts to use an item.
function Atomic:PlayerCanUseItem(player, itemTable, noMessage)
	if (Clockwork.item:IsWeapon(itemTable) and !itemTable.fakeWeapon) then
		local throwableWeapon = nil;
		local secondaryWeapon = nil;
		local primaryWeapon = nil;
		local meleeWeapon = nil;
		local fault = nil;
		
		for k, v in ipairs( player:GetWeapons() ) do
			local weaponTable = Clockwork.item:GetByWeapon(v);
			
			if (weaponTable and !weaponTable.fakeWeapon) then
				if ( !weaponTable:IsMeleeWeapon() and !weaponTable:IsThrowableWeapon() ) then
					if (weaponTable.weight <= 2) then
						secondaryWeapon = true;
					else
						primaryWeapon = true;
					end;
				elseif ( weaponTable:IsThrowableWeapon() ) then
					throwableWeapon = true;
				else
					meleeWeapon = true;
				end;
			end;
		end;
		
		if ( !itemTable:IsMeleeWeapon() and !itemTable:IsThrowableWeapon() ) then
			if (itemTable.weight <= 2) then
				if (secondaryWeapon) then
					fault = "You cannot use another secondary weapon!";
				end;
			elseif (primaryWeapon) then
				fault = "You cannot use another secondary weapon!";
			end;
		elseif ( itemTable:IsThrowableWeapon() ) then
			if (throwableWeapon) then
				fault = "You cannot use another throwable weapon!";
			end;
		elseif (meleeWeapon) then
			fault = "You cannot use another melee weapon!";
		end;
		
		if (fault) then
			if (!noMessage) then
				Clockwork.player:Notify(player, fault);
			end;
			
			return false;
		end;
	end;
end;

local entCheck = {
	["prop_physics"] = true,
	["gmod_light"] = true,
	["gmod_lamp"] = true,
};

-- Called when an entity is created to set the draw distance.
function Atomic:OnEntityCreated(ent)
	local class = ent:GetClass();

	if (string.find(class, "cw_") or entCheck[class]) then
		ent:SetSaveValue("fademindist", 2048);
		ent:SetSaveValue("fademaxdist", 4096);
	end;
end;

-- Called when chat box info should be adjusted.
function Atomic:ChatBoxAdjustInfo(info)
	if (Clockwork.config:Get("can_anon"):GetBoolean()) then	
		if (info.class != "ooc" and info.class != "looc") then		
			if (IsValid(info.speaker) and info.speaker:HasInitialized()) then
				if (string.sub(info.text, 1, 1) == "?") then
					info.text = string.sub(info.text, 2);
					info.data.anon = true;
				end;
			end;
		end;
	end;
end;

-- Called when a chat box message has been added.
function Atomic:ChatBoxMessageAdded(info)
	if (info.voice) then
		if (IsValid(info.speaker) and info.speaker:HasInitialized()) then
			info.speaker:EmitSound(info.voice.sound, info.voice.volume);
		end;
		
		if (info.voice.global) then
			for k, v in pairs(info.listeners) do
				if (v != info.speaker) then
					Clockwork.player:PlaySound(v, info.voice.sound);
				end;
			end;
		end;
	end;
end;

-- Called when a player's radio info should be adjusted.
function Atomic:PlayerAdjustRadioInfo(player, info)
	for k, v in ipairs( _player.GetAll() ) do
		if ( v:HasInitialized() and v:HasItemByID("handheld_radio") ) then
			if ( v:GetCharacterData("frequency") == player:GetCharacterData("frequency") ) then
				info.listeners[v] = v;
			end;
		end;
	end;
end;

-- Called when an entity's menu option should be handled.
function Atomic:EntityHandleMenuOption(player, entity, option, arguments)
	if (entity:GetClass() == "cw_music_radio") then
		if (arguments == "cw_musicToggle") then
			entity:Toggle();
		elseif (arguments == "cw_musicTake") then
			local bSuccess, fault = player:GiveItem(Clockwork.item:CreateInstance("music_radio"));
			
			if (!bSuccess) then
				Clockwork.player:Notify(player, fault);
			else
				entity:Remove();
			end;
		end;
	end;
end;

function Atomic:PlayerPunchThrown(player)
	player:ProgressAttribute("unarm", 0.035, true);
end;

-- Called when a player has been healed.
function Atomic:PlayerHealed(target, healer, itemTable)
	healer:ProgressAttribute("med", itemTable.baseHeal * 0.35);

	return true;
end;

-- Called when a player equips a clothing item.
function Atomic:OnChangedClothes(player, item, bIsWearing) end;