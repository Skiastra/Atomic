--[[ 
    © 2014 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html
--]]

-- Called when an entity's menu options are needed.
function cwWriting:GetEntityMenuOptions(entity, options)
	local class = entity:GetClass();
	
	if (class == "cw_paper") then
		if (entity:GetDTBool(0)) then
			options["Read"] = "cw_paperOption";
		else
			options["Write"] = "cw_paperOption";
		end;
	end;
end;
