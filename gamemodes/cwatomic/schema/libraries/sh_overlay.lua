local Clockwork = Clockwork;

Atomic.overlay = Clockwork.kernel:NewLibrary("Overlay");
Atomic.overlay.module = Clockwork.kernel:NewLibrary("OverlayModule");
Atomic.overlay.stored = Atomic.overlay.stored or {};

OVERLAY_FIRSTPERSON = false;
OVERLAY_THIRDPERSON = true;
OVERLAY_BOTH = 2;

if (CLIENT) then
	local colorWhite = Color(255, 255, 255, 255);
	function Atomic.overlay.module:HUDPaint()
		if (Clockwork.plugin:Call("CanDrawOverlays")) then
			for k, v in pairs(Atomic.overlay:GetAll()) do
				if (Atomic.overlay:GetEnabled(k)) then
					if (Clockwork.Client:GetThirdPerson() == v[2] or v[2] == 2) then
						surface.SetDrawColor(colorWhite);
						surface.SetMaterial(v[1]);
						surface.DrawTexturedRect(0, 0, ScrW(), ScrH());
					end;
				end;
			end;
		end;
	end;

	function Atomic.overlay.module:CanDrawOverlays()
		if (self.inPipboy or Clockwork.kernel:IsChoosingCharacter()) then
			return false;
		end;

		return true;
	end;

	function Atomic.overlay:GetEnabled(id)
		return Atomic.overlay:FindByID(id)[3];
	end;

	Clockwork.datastream:Hook("SetOverlayEnabled", function(data)
		Atomic.overlay:SetEnabled(data[1], data[2])
	end);
else
	function Atomic.overlay.module:PlayerCharacterUnloaded(player)
		for k, v in pairs(Atomic.overlay:GetAll()) do
			Atomic.overlay:SetEnabled(k, false, player);
		end;
	end;
end;

Clockwork.plugin:Add("ATOMIC_OVERLAY", Atomic.overlay.module);

Clockwork.datastream:Hook("SetOverlay", function(data)
	Atomic.overlay:Register(data[1], data[1], OVERLAY_FIRSTPERSON);
end);

function Atomic.overlay:GetAll()
	return self.stored;
end;

function Atomic.overlay:Register(name, overlay, perspective)
	local dataTable = {Material(overlay), perspective, false};

	self.stored[name] = dataTable;
end;

function Atomic.overlay:FindByID(id)
	local check = Atomic.overlay:GetAll()[id];

	if (check) then
		return check;
	end;

	MsgC(Color(255, 100, 0, 255), "[Clockwork:Overlay]\nThe "..id.." overlay was not found!");
end;

function Atomic.overlay:SetEnabled(id, bValue, player)
	if (CLIENT) then
		local overlay = Atomic.overlay:FindByID(id);

		if (!overlay) then
			Atomic.overlay:Register(id, id, OVERLAY_FIRSTPERSON);
			overlay = Atomic.overlay:FindByID(id);

			Clockwork.datastream:Start("SetOverlay", {id});
		end;

		overlay[3] = bValue;
	else
		if (player:IsValid()) then
			local overlay = Atomic.overlay:FindByID(id);

			if (!overlay) then
				Atomic.overlay:Register(id, id, OVERLAY_FIRSTPERSON);

				Clockwork.datastream:Start(player, "SetOverlay", {id});
			end;

			Clockwork.datastream:Start(player, "SetOverlayEnabled", {id, bValue});
		end;
	end;
end;
	
Atomic.overlay:Register("T-45d", "atomic/hud/overlay/power_armor_blur.png", OVERLAY_FIRSTPERSON);
Atomic.overlay:Register("T-51b", "atomic/hud/overlay/power_armor_t51b.png", OVERLAY_FIRSTPERSON);
Atomic.overlay:Register("X-02", "atomic/hud/overlay/power_armor_x01.png", OVERLAY_FIRSTPERSON);
Atomic.overlay:Register("Gasmask", "atomic/hud/overlay/gasmask.png", OVERLAY_FIRSTPERSON);