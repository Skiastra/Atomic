--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local ITEM = Clockwork.item:New("clothes_base", true);

ITEM.name = "base_apparel";
ITEM.uniqueID = "base_apparel";
ITEM.useSound = "atomic/placeholder.mp3";

-- A function to get the model name.
function ITEM:GetModelName(player, group)
	local modelName = nil;
	
	if (!player) then
		player = Clockwork.Client;
	end;
	
	modelName = string.gsub(string.lower(Clockwork.player:GetDefaultModel(player)), "^.-/.-/.-/.-/", "");
	
	if (!string.find(modelName, "male") and !string.find(modelName, "female")) then
		if (player:GetGender() == GENDER_FEMALE) then
			return "female_04.mdl";
		else
			return "male_05.mdl";
		end;
	else
		return modelName;
	end;
end;

-- Called when the item's client side model is needed.
function ITEM:GetClientSideModel()
	local replacement = nil;
	
	if (self.GetReplacement) then
		replacement = self:GetReplacement(Clockwork.Client);
	end;
	
	if (type(replacement) == "string") then
		return replacement;
	elseif (self("replacement")) then
		return self("replacement");
	elseif (self("group")) then
		if (self("bSpire")) then
			-- This edit is to allow the items to work with the spire models.
			return "models/thespireroleplay/humans/"..self("group").."/"..self:GetModelName();
		else
			return "models/humans/"..self("group").."/"..self:GetModelName();
		end;
	end;
end;

-- Called when a player changes clothes.
function ITEM:OnChangeClothes(player, bIsWearing)
	if (bIsWearing) then
		local replacement = nil;
		
		if (self.GetReplacement) then
			replacement = self:GetReplacement(player);
		end;
		
		if (type(replacement) == "string") then
			player:SetModel(replacement);
		elseif (self("replacement")) then
			player:SetModel(self("replacement"));
		elseif (self("group")) then

			if (self("bSpire")) then
				-- This edit is to allow the items to work with the spire models.
				player:SetModel("models/thespireroleplay/humans/"..self("group").."/"..self:GetModelName(player));
			else
				player:SetModel("models/humans/"..self("group").."/"..self:GetModelName(player));
			end;
		end;

		if (self.specialBoost) then
			for k, v in pairs(self.specialBoost) do
				player:AddBoost(k, v, true);
			end;
		end;

		local armor = self:GetData("Armor");

		if (armor) then
			player:SetArmor(math.Clamp(armor, 0, player:GetMaxArmor()));
		end;

		player:EmitSound("atomic/items/clothing/clothing_equip_0"..math.random(1, 3)..".mp3");
	else
		if (self.specialBoost) then
			for k, v in pairs(self.specialBoost) do
				player:AddBoost(k, 0, true);
			end;
		end;

		Clockwork.player:SetDefaultModel(player);
		Clockwork.player:SetDefaultSkin(player);

		local armor = self:GetData("Armor");

		if (armor) then
			player:SetArmor(math.Clamp(player:Armor() - armor, 0, player:GetMaxArmor()));
		end;

		player:EmitSound("atomic/items/clothing/clothing_remove_0"..math.random(1, 3)..".mp3");
	end;
	
	if (self.overlay) then
		Atomic.overlay:SetEnabled(self.overlay, bIsWearing, player);
	end;

	if (self.OnChangedClothes) then
		self:OnChangedClothes(player, bIsWearing);
	end;

	Clockwork.plugin:Call("OnChangedClothes", player, self, bIsWearing);
end;

ITEM:Register();