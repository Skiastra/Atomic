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
	ITEM.name = "base_junk";
	ITEM.worth = 1;
	ITEM.uniqueID = "base_junk";
	ITEM.model = "models/props_junk/garbage_plasticbottle001a.mdl";
	ITEM.color = Color(225, 255, 25, 255);
	ITEM.weight = 0.1;
--	ITEM.useText = "Caps";
	ITEM.useSound = {"buttons/button5.wav", "buttons/button4.wav"};
	ITEM.category = "Junk";
	ITEM.isBaseItem = true;
	ITEM.description = "A bottle with a white liquid inside.";
--	ITEM.spawnValue = 1;
--	ITEM.spawnType = "junk";

	-- Called when a player uses the item.
--	function ITEM:OnUse(player, itemEntity)
--		Clockwork.player:GiveCash(player, self.worth, "scrapped some junk");
--	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();