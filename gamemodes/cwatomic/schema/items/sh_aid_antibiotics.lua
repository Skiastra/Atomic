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
	ITEM.name = "Antibiotics";
	ITEM.cost = 40;
	ITEM.batch = 1;
	ITEM.model = "models/healthvial.mdl";
	ITEM.weight = 0.2;
	ITEM.useText = "Swallow";
	ITEM.description = "A strange vial filled with drugs, it says 'take twice a day' on the bottle.";
	ITEM.baseHeal = 20;
ITEM:Register();