--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local CLASS = Clockwork.class:New("Wastelander");
	CLASS.color = Color(165, 155, 95, 255);
	CLASS.factions = {FACTION_WASTELANDER};
	CLASS.isDefault = true;
	CLASS.description = "A survivor of the world's most catastrophic nuclear event.";
	CLASS.defaultPhysDesc = "Wearing dirty clothes and a small satchel";
CLASS_WASTELANDER = CLASS:Register();