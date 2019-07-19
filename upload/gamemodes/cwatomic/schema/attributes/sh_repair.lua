--[[ 
    © 2014 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html
--]]

local ATTRIBUTE = Clockwork.attribute:New();
	ATTRIBUTE.name = "Repair";
	ATTRIBUTE.maximum = 100;
	ATTRIBUTE.uniqueID = "rep";
	ATTRIBUTE.description = "How effective you are at general repair.";
	ATTRIBUTE.isOnCharScreen = true;
ATTRIBUTE:Register();