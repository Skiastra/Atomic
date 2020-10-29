local PLUGIN = PLUGIN;
local playerMeta = FindMetaTable("Player")

PLUGIN.secondTime = CurTime()
function PLUGIN:Think()
	if (CurTime() > self.secondTime) then
		self.secondTime = CurTime() + 1
		for k, v in pairs(player.GetAll()) do
			if (!v:GetData("playTime")) then
				v:SetData("playTime", 0)
			else
				v:SetData("playTime", v:GetData("playTime") + 1)
			end
			if v:GetCharacter() then
				if (!v:GetCharacterData("charPlayTime")) then
					v:SetCharacterData("charPlayTime", 0)
				else
					v:SetCharacterData("charPlayTime", v:GetCharacterData("charPlayTime") + 1)
				end
			end
		end
	end
end

function playerMeta:PlayTime()
	return self:GetData("playTime") or 0
end

function playerMeta:CharPlayTime()
	if self:GetCharacter() then
		return self:GetCharacterData("charPlayTime") or 0
	else
		return false
	end
end

function ConvertSecondsToMultiples(seconds)
	local days = math.floor(seconds/(60*60*24))
	seconds = seconds - days*24*60*60
	local hours = math.floor(seconds/(60*60))
	seconds = seconds - hours*60*60
	local minutes = math.floor(seconds/60)
	seconds = seconds - minutes*60
	seconds = math.floor(seconds)

	local data = {
		days = days,
		hours = hours,
		minutes = minutes,
		seconds = seconds
	}

	return data
end