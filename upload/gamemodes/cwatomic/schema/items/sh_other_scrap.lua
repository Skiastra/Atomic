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
	ITEM.name = "Scrap";
	ITEM.cost = 5;
	ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl";
	ITEM.batch = 1;
	ITEM.weight = 1;
	ITEM.category = "Scrap"
	ITEM.description = "Pieces of scrap from various sources.";

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		return false;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();