--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local ITEM = Clockwork.item:New();
	ITEM.name = "Human Meat";
	ITEM.model = "models/Gibs/Antlion_gib_small_2.mdl";
	ITEM.weight = 0.35;
	ITEM.plural = "Human Meat";
	ITEM.useText = "Eat";
	ITEM.useSound = "npc/barnacle/barnacle_crunch3.wav";
	ITEM.category = "Consumables"
	ITEM.isRareItem = true;
	ITEM.description = "Meat ripped from the body of a human, it smells disgusting.";

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		player:SetHealth(math.Clamp(player:Health() + 8, 0, player:GetMaxHealth()));
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;

	-- Called when the item entity has spawned.
	function ITEM:OnEntitySpawned(entity)
		entity:SetMaterial("models/flesh");
	end;
ITEM:Register();