--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local ITEM = Clockwork.item:New("base_apparel");
	ITEM.cost = 300;
	ITEM.name = "Gasmask Armor";
	ITEM.weight = 1.5;
	ITEM.replacement = "models/tactical_rebel.mdl";
	ITEM.description = "Some leather armor with a mandatory gasmask for protection.";
	ITEM.overlay = "Gasmask";
	ITEM.baseArmor = 50;
	ITEM.isRareSpawn = true;
	ITEM.specialBoost = {
		E = 3
	};
ITEM:Register();