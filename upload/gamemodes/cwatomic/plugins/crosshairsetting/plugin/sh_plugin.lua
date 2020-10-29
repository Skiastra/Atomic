local PLUGIN = PLUGIN;

if (CLIENT) then
	function PLUGIN:Initialize()
		CW_CONVAR_CROSSHAIR = Clockwork.kernel:CreateClientConVar("cwEnableCrosshair", 1, false, true);
	end;

	function PLUGIN:CanDrawHUD(name)
		if (name == "Crosshair") then
			return (CW_CONVAR_CROSSHAIR:GetInt() == 1);
		end;
	end;

	Clockwork.setting:AddCheckBox("Framework", "Enable Crosshair.", "cwEnableCrosshair", "Whether or not the crosshair will draw.");
end;