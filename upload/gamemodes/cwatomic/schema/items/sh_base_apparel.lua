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
			player:SetModel("models/humans/"..self("group").."/"..self:GetModelName(player));
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