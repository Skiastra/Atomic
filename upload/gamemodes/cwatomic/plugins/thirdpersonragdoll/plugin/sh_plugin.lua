local PLUGIN = PLUGIN;

if (CLIENT) then
	function PLUGIN:CalcView(player, origin, angles, fov)
		if (Clockwork.Client:IsRagdolled()) then
			return Clockwork.BaseClass:CalcView(player, origin, angles, fov);
		end;
	end;
end;