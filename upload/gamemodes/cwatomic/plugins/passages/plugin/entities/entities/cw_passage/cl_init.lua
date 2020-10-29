--[[
	� 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

include("shared.lua");

-- Called when the target ID HUD should be painted.
function ENT:HUDPaintTargetID(x, y, alpha)
	local trace = Clockwork.Client:GetEyeTraceNoCursor();

	if (self:NearestPoint(trace.StartPos):Distance(trace.StartPos) <= 80) then
		local name = self:GetNWString("name");
		local color = Clockwork.option:GetColor("information");

		Clockwork.plugin:Call("DrawInfoUI", name);
		Clockwork.plugin:Call("DrawUseUI", "Open", color);
	end;
end;