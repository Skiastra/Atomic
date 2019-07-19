--[[ 
    © 2014 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html
--]]

local ATTRIBUTE = Clockwork.attribute:New();
	ATTRIBUTE.name = "Medicine";
	ATTRIBUTE.maximum = 100;
	ATTRIBUTE.uniqueID = "med";
	ATTRIBUTE.description = "Affects your overall medical skills.";
	ATTRIBUTE.isOnCharScreen = true;
ATTRIBUTE:Register();