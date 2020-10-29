local PLUGIN = PLUGIN;

PLUGIN:SetGlobalAlias("cwWindowFlash");

if (CLIENT) then
	function cwWindowFlash:FlashWindow()
		if (!system.HasFocus()) then
			system.FlashWindow();
		end;
	end;

	function cwWindowFlash:ChatBoxAdjustInfo(info)
		if (info.filtered == "ic") then
			self:FlashWindow();
		end;
	end;
end;