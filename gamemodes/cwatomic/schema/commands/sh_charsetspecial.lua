--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

COMMAND = Clockwork.command:New("CharSetSpecial");
COMMAND.tip = "Set a character's special stat.";
COMMAND.text = "<string Name> <string Stat: S, Strength, P, Perception or E, etc> <number Value>";
COMMAND.access = "a";
COMMAND.arguments = 3;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])
	local nameTable = Atomic.special:GetNameTable();
	
	if (target) then
		if (nameTable[arguments[2]] or table.HasValue(nameTable, arguments[2])) then
			local value = tonumber(arguments[3]);

			if (value) then
				if (value >= 0 and value <= 10) then
					Atomic.special:SetSpecial(target, arguments[2], arguments[3], true);

					Clockwork.player:Notify(player, "You have set "..target:Name().."'s "..arguments[2].." stat to "..arguments[3]..".");
				else
					Clockwork.player:Notify(player, arguments[3].." is too high or low!");
				end;
			else
				Clockwork.player:Notify(player, arguments[3].." is not a valid number!");
			end;
		else
			Clockwork.player:Notify(player, arguments[2].." is not a valid SPECIAL stat!");
		end;
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;

COMMAND:Register();