cwStats.global = cwStats.global or {};

function cwStats:AddStat(player, stat, value, bNoChar, bNoPly, bNoGlobal)
	local isS2K = Clockwork.config:Get("is_s2k"):Get();
	local server = (isS2K and "S2K") or "SRP";

	if (IsValid(player)) then
		if (!bNoPly) then
			player:SetData("cwStats_"..server.."_"..stat, (player:GetData("cwStats_"..server.."_"..stat) or 0) + value);
		end;

		if (!bNoChar and player:GetCharacter()) then
			player:SetCharacterData("cwStats_"..server.."_"..stat, (player:GetCharacterData("cwStats_"..server.."_"..stat) or 0) + value);
		end;

		if (!bNoGlobal) then
			self:AddGlobalStat(stat, value);
		end;
	end;
end;

function cwStats:GetGlobalStat(stat)
	return self.global[stat];
end;

function cwStats:AddGlobalStat(stat, value)
	local oldValue = self:GetGlobalStat(stat);
	local newValue = (oldValue or 0) + value;	

	self.global[stat] = newValue;

	cwStats:PushGlobalStat(stat, newValue);
end;

function cwStats:PushGlobalStat(stat, value)
	local isS2K = Clockwork.config:Get("is_s2k"):Get();
	local server = (isS2K and "S2K") or "SRP";
	local queryObj = Clockwork.database:Select("statistics");
		queryObj:AddColumn("_Value");
		queryObj:AddWhere("_ServerName = ?", server);
		queryObj:AddWhere("_Stat = ?", stat);
		queryObj:SetCallback(function(result)
			if (Clockwork.database:IsResult(result)) then
				self:UpdateGlobalStat(server, stat, value);
			else
				self:InsertGlobalStat(server, stat, value);
			end;
		end);
	queryObj:Pull();
end;

function cwStats:InsertGlobalStat(server, stat, value)
	local queryObj = Clockwork.database:Insert("statistics");
		queryObj:SetValue("_ServerName", server);
		queryObj:SetValue("_Stat", stat);
		queryObj:SetValue("_Value", value);
	queryObj:Push();
end;

function cwStats:UpdateGlobalStat(server, stat, value)
	local queryObj = Clockwork.database:Update("statistics");
		queryObj:AddWhere("_ServerName = ?", server);
		queryObj:AddWhere("_Stat = ?", stat);
		queryObj:SetValue("_Value", value);
	queryObj:Push();
end;

function cwStats:GatherPlayerStats(player)
	for k, v in pairs(player.cwData) do
		
	end;
end;

function cwStats:GatherCharacterStats(player)
	local charStats = {};

	Clockwork.player:GetCharacters(player, function(characters)

	end);

	--[[
	if (self:GetCharacter()) then
		local data = self:QueryCharacter("Data");
		
		if (data[key] != nil) then
			return data[key];
		end;
	end;
	
	return default;
	--]]
end;

--[[
function cwStats:GetStat(player, stat, server)
	if (server) then
		return player:GetData("cwStats_"..server.."_"..stat) or 0;
	end;

	local value = 0;

	value = value + (player:GetData("cwStats_S2K_"..stat) or 0);
	value = value + (player:GetData("cwStats_SRP_"..stat) or 0);

	return value;
end;

function cwStats:GetCharacterStat(player, stat, server)
	if (player:GetCharacter()) then
		if (server) then
			return player:GetCharacterData("cwStats_"..server.."_"..stat) or 0;
		end;

		local value = 0;

		value = value + (player:GetCharacterData("cwStats_S2K_"..stat) or 0);
		value = value + (player:GetCharacterData("cwStats_SRP_"..stat) or 0);

		return value;
	end;
end;
--]]