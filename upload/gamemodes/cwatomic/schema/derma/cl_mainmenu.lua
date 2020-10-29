local PANEL = {};

local colorWhite = Color(255, 255, 255, 255);
local colorBlack = Color(0, 0, 0, 255);

surface.CreateFont("fnv_menuButton", {
	font = "Monofonto",
	size = 30,
	weight = 500
});

surface.CreateFont("fnv_menuButton_blur", {
	font = "Monofonto",
	size = 30,
	weight = 500,
	blursize = 5
});

local buttonList = {
	{
		name = "Continue",
		callback = function(panel)
			panel:Remove();
			Atomic.pauseUI = nil;
		end
	},
	{
		name = "Menu",
		callback = function(panel)
			panel:Remove();

			gui.ActivateGameUI();

			Atomic.showDefaultMenu = true;
			Atomic.delayCheck = true;
		end
	},
	{
		name = "Disconnect",
		callback = function(panel)
			RunConsoleCommand("disconnect");
		end
	}
};

local function drawBorder(x, y, w, h, color)
	local colorDarker = Color(
		math.max(color.r - 130, 0),
		math.max(color.g - 130, 0),
		math.max(color.b - 130, 0),
		150
	);

	draw.RoundedBox(0, x, y, w, h, colorDarker);

	surface.SetDrawColor(color);

	for i = 0, 1 do
		surface.DrawOutlinedRect(i, i, w - (i * 2), h - (i * 2));
	end;
end;

function PANEL:Init()
	local scrW, scrH = ScrW(), ScrH();
	local infoColor = Clockwork.option:GetColor("information");

	self:SetSize(scrW, scrH);
	self:SetPos(0, 0);

	local buttonW, buttonH = scrW * 0.2, scrH * 0.04;
	local buttonX, buttonY = scrW * 0.95 - buttonW, scrH * 0.35;

	for k, v in pairs(buttonList) do
		local button = vgui.Create("DButton", self);

		button.text = v.name;
		button:SetText("");
		button:SetPos(buttonX, buttonY);
		button:SetSize(buttonW, buttonH);

		buttonY = buttonY + buttonH;

		function button:Paint(w, h)
			if (self:IsHovered()) then
				drawBorder(0, 0, w, h, infoColor);
				if (!self.playedSound) then
					surface.PlaySound("atomic/menu_rollover.wav");

					self.playedSound = true;
				end;
			else
				if (self.playedSound) then
					self.playedSound = nil;
				end;
			end;

			draw.SimpleText(self.text, "fnv_menuButton_blur", w * 0.95, h * 0.5, colorBlack, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER);
			draw.SimpleText(self.text, "fnv_menuButton", w * 0.95, h * 0.5, infoColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER);
		end;

		function button.DoClick()
			surface.PlaySound("atomic/menu_release.wav");

			return v.callback(self);
		end;
	end;
end;

local backMat = Material("srp/fnv/pause_back.png");
local blurMat = Material("srp/fnv/pause_blur3.png");

function PANEL:Paint(w, h)
	surface.SetMaterial(backMat);
	surface.SetDrawColor(colorWhite.r, colorWhite.g, colorWhite.b, 225);
	surface.DrawTexturedRect(0, 0, w, h);

	surface.SetMaterial(blurMat);
	surface.SetDrawColor(colorWhite);
	surface.DrawTexturedRect(0, 0, w, h);
end;

vgui.Register("FNVMainMenu", PANEL, "EditablePanel");