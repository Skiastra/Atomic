local PLUGIN = PLUGIN;

local whitelist = {
	nocollideworld = true,
	nocollide = true,
	weld = true
};

function PLUGIN:CanTool(player, tr, tool)
	if (Clockwork.config:Get("tools_admin_only"):Get() and !player:IsAdmin() and !whitelist[tool]) then
		return false;
	end;
end;

if (CLIENT) then
	Clockwork.config:AddToSystem("Tools are admin only.", "tools_admin_only", "Whether or not players can only use tools if they're an admin.");
else
	Clockwork.config:Add("tools_admin_only", true, true);
end