--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

COMMAND = Clockwork.command:New("PlyTransfer");
COMMAND.tip = "Transfer the character and force the player to the specified server.";
COMMAND.text = "[String CharName] [String Server:Port] [String Password] [String Door UniqueID]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	local server = arguments[2];

	if (IsValid(target) and server) then
		cwPassages:TransferPlayer(target, server, arguments[3], arguments[4]);

		Clockwork.player:Notify(target, player:Name().." has sent you to another server.");
		Clockwork.player:Notify(player, "You have sent "..target:Name().." to "..arguments[2]..".");
	else
		Clockwork.player:Notify(player, "That is not a valid player!");
	end;
end;

COMMAND:Register();