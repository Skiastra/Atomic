--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local ITEM = Clockwork.item:New(nil, true);
	ITEM.name = "base_heal";
	ITEM.cost = 100;
	ITEM.batch = 1;
	ITEM.uniqueID = "base_heal";
	ITEM.model = "models/Items/HealthKit.mdl";
	ITEM.weight = 0.4;
	ITEM.access = "T";
	ITEM.useText = "Heal";
	ITEM.business = true;
	ITEM.category = "Aid"
	ITEM.useSound = "items/medshot4.wav";
	ITEM.description = "A medical kit for healing a person.";
	ITEM.customFunctions = {"Give"};
	ITEM.baseHeal = 10;
--	ITEM.spawnValue = 1;
--	ITEM.spawnType = "medical";

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		if (Clockwork.plugin:Call("PlayerHealed", player, player, self)) then
			player:SetHealth(math.Clamp(player:Health() + Atomic:GetHealAmount(player, self.baseHeal), 0, player:GetMaxHealth()));
			Clockwork.kernel:PrintLog(LOGTYPE_URGENT, player:Name().." has healed themself for "..Atomic:GetHealAmount(player, self.baseHeal)..", leaving them at "..player:Health().." health!");

			player:TakeItem(self);
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;

	if (SERVER) then
		function ITEM:OnCustomFunction(player, name)
			if (name == "Give") then
				Clockwork.player:RunClockworkCommand(player, "CharHeal", self.name);
			end;
		end;
	end;

ITEM:Register();