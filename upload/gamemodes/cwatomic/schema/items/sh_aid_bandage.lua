--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local ITEM = Clockwork.item:New("base_heal");
	ITEM.name = "Bandage";
	ITEM.cost = 20; 
	ITEM.model = "models/props_wasteland/prison_toiletchunk01f.mdl";
	ITEM.batch = 1;
	ITEM.weight = 0.2;
	ITEM.useText = "Apply";
	ITEM.description = "A bandage roll, there isn't much so use it wisely.";
	ITEM.baseHeal = 10;
ITEM:Register();