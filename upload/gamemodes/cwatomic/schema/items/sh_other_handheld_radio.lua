--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local ITEM = Clockwork.item:New();
	ITEM.name = "Handheld Radio";
	ITEM.cost = 50;
	ITEM.model = "models/deadbodies/dead_male_civilian_radio.mdl";
	ITEM.batch = 1;
	ITEM.weight = 0.25;
	ITEM.access = "T";
	ITEM.business = true;
	ITEM.category = "Communication"
	ITEM.description = "A shiny handheld radio with a frequency tuner.";
	ITEM.customFunctions = {"Frequency"};

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;

	if (SERVER) then
		function ITEM:OnCustomFunction(player, name)
			if (name == "Frequency") then
				Clockwork.datastream:Start( player, "Frequency", player:GetCharacterData("frequency", "") )
			end;
		end;
	end;
ITEM:Register();