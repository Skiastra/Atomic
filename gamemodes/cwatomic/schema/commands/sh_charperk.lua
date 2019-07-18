--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local COMMAND = Clockwork.command:New("CharGivePerk");
COMMAND.tip = "Give a character a perk";
COMMAND.text = "<string Name> <string Perk>";
COMMAND.access = "a";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	local perkTable = Atomic.perks:FindPerk(arguments[2]);

	if (target) then
        if (perkTable) then
            if (!target:HasPerk(perkTable.name)) then
                target:AddPerk(perkTable.name, true);

                Clockwork.player:Notify(player, "You've given "..target:Name().." the "..perkTable.name.." perk.");
            else
                Clockwork.player:Notify(player, target:Name().." already has the "..perkTable.name.." perk!");
            end;
        else
            Clockwork.player:Notify(player, arguments[2].." is not a valid perk!");
        end;
    else
        Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
	end;
end;

COMMAND:Register();

local COMMAND = Clockwork.command:New("CharTakePerk");
COMMAND.tip = "Take a perk from a character";
COMMAND.text = "<string Name> <string Perk>";
COMMAND.access = "a";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
    local target = Clockwork.player:FindByID(arguments[1]);
    local perkTable = Atomic.perks:FindPerk(arguments[2]);

    if (target) then
        if (perkTable) then
            if (target:HasPerk(perkTable.name)) then
                target:RemovePerk(perkTable.name, true);

                Clockwork.player:Notify(player, "You've taken the "..perkTable.name.." perk from "..target:Name()..".");
            else
                Clockwork.player:Notify(player, target:Name().." doesn't have the "..perkTable.name.." perk!");
            end;
        else
            Clockwork.player:Notify(player, arguments[2].." is not a valid perk!");
        end;
    else
        Clockwork.player:Notify(player, arguments[1].." is not a valid character!");
    end;
end;

COMMAND:Register();