--[[ 
    © 2014 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html
--]]

local ATTRIBUTE = Clockwork.attribute:New();
	ATTRIBUTE.name = "Survival";
	ATTRIBUTE.maximum = 100;
	ATTRIBUTE.uniqueID = "surv";
	ATTRIBUTE.description = "How effective you are at cooking, making supplies, and surviving.";
	ATTRIBUTE.isOnCharScreen = true;
ATTRIBUTE:Register();