--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

COMMAND = Clockwork.command:New("PlyLearn");
COMMAND.tip = "Open the learning webpage.";
COMMAND.text = "<No Arguments>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";

local url = "https://learn.seriousroleplay.net";

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);

	if (IsValid(target)) then
		target:SendLua("gui.OpenURL(\""..url.."\")");

		Clockwork.player:Notify(target, player:Name().." has opened the learning webpage for you.");
		Clockwork.player:Notify(player, "You have opened the learning webpage for "..target:Name()..".");
	else
		Clockwork.player:Notify(player, "That is not a valid player!");
	end;
end;

COMMAND:Register();