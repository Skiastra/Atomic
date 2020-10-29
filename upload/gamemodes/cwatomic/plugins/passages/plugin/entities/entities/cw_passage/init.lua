--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

include("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

local PLUGIN = PLUGIN;

-- Called when the entity initializes.
function ENT:Initialize()	
	
end;

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;

-- Called when the entity is used.
function ENT:Use(activator, caller)
	if (activator:IsPlayer() and activator:GetEyeTraceNoCursor().Entity == self and !activator.cwPassagesFadeStartTime) then
		local hasServer = self.server and self.server != "";
		local hasID = self.entryUniqueID and self.entryUniqueID != "";
		local hasDoor = false;

		if (hasID and !hasServer) then
			local doors = ents.FindByClass("cw_passage");

			for k, v in pairs(doors) do
				if (v.uniqueID == self.entryUniqueID) then
					hasDoor = true;

					break;
				end;
			end;
		end;

		local canUse = (hasID and hasServer) or hasDoor;

		if (canUse) then
			self:EmitSound("srp/fnv/door/generic_open.mp3");

			PLUGIN:TransferPlayer(activator, self.server, self.password, self.entryUniqueID);

			timer.Simple(1.5, function()
				self:EmitSound("srp/fnv/door/generic_close.mp3");
			end);
		else
			self:EmitSound("srp/fnv/door/locked/locked_0"..math.random(1, 4)..".mp3");
		end;
	end;
end;