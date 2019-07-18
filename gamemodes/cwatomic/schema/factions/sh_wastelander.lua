--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local FACTION = Clockwork.faction:New("Wastelander");

FACTION.useFullName = true;
FACTION.description = "You're either a loner, or in a group of other people just trying to survive in the post-apocalyptic wasteland. You use whatever or whoever you can to survive.";

-- Called when a player is transferred to the faction.
function FACTION:OnTransferred(player, faction, name)
end;

FACTION_WASTELANDER = FACTION:Register();