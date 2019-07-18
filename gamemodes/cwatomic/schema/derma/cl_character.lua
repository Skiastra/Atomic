--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

Clockwork.character:RemoveCreationPanel("Persuasion");
Clockwork.character:RegisterCreationPanel("Faction", "cwCharacterFaction", 1, 
	function(info)
		local factions = {};
		
		for k, v in pairs(Clockwork.faction.stored) do
			if (!v.whitelist or Clockwork.character:IsWhitelisted(v.name)) then
				if (!Clockwork.faction:HasReachedMaximum(k)) then
					factions[#factions + 1] = v.name;
				end;
			end;
		end;

		if (#factions > 1) then
			return true;
		end;
		
		info.faction = factions[1];
		return false;
	end
);
Clockwork.character:RegisterCreationPanel("Gender", "cwCharacterGender", 2);
Clockwork.character:RegisterCreationPanel("S.P.E.C.I.A.L.", "cwCharacterSpecial", 4);