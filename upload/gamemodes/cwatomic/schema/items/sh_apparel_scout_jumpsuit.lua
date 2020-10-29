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
	ITEM.name = "Scout's Jumpsuit";
	ITEM.group = "group006";
	ITEM.bSpire = true;
	ITEM.weight = 10;
	ITEM.description = "A mechanic's coveralls mildly reinforced with leather hide.";
	ITEM.baseArmor = 10;
	ITEM.isRareSpawn = true;
ITEM:Register();