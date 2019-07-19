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
	ITEM.cost = 150;
	ITEM.name = "Combat Armor";
	ITEM.group = "group03";
	ITEM.weight = 1;
	ITEM.description = "Some yellow armor manufactured and worn in the wasteland.";
	ITEM.baseArmor = 40;
	ITEM.isRareSpawn = true;
	ITEM.specialBoost = {
		S = 2,
		A = 1
	};
ITEM:Register();