--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

COMMAND = Clockwork.command:New("CharSetCustomClass");
COMMAND.tip = "Set a character's custom class.";
COMMAND.text = "<string Name> <string Class>";
COMMAND.access = "o";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])
	
	if (target) then
		target:SetCharacterData("customclass", arguments[2]);
		
		Clockwork.player:NotifyAll(player:Name().." set "..target:Name().."'s custom class to "..arguments[2]..".");
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;

COMMAND:Register();