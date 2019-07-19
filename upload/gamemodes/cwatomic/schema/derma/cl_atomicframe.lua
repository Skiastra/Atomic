titleX = titleX or 0;
titleY = titleY or 0;

local PANEL = {};

PANEL.title = "Title";

PANEL.drawClose = false;
PANEL.drawLines = false;

function PANEL:Init()
	local color = Clockwork.option:GetColor("information");
	local colorDark = Color(
		math.max(color.r - 100, 0),
		math.max(color.g - 100, 0),
		math.max(color.b - 100, 0),
		255
	);
	local colorDarker = Color(
		math.max(color.r - 160, 0),
		math.max(color.g - 160, 0),
		math.max(color.b - 160, 0),
		255
	);
	local colorDarkest = Color(
		math.max(color.r - 200, 0),
		math.max(color.g - 200, 0),
		math.max(color.b - 200, 0),
		255
	);
	local frameMat = Clockwork.option:GetKey("icon_frame");

	if (frameMat) then
		frameMat = Material(frameMat);
	end;

	self.logo = frameMat;

	self:SetPos(100, 100);
	self:SetSize(900, 500);
	self:SetDraggable(false);
	self:MakePopup();
	
	if (self.drawClose) then
		self.CloseButton = vgui.Create("DButton", self)
		self.CloseButton:SetSize(20, 20);
		self.CloseButton:SetPos(self:GetWide() - 24, 5);
		self.CloseButton:SetText("");
		self.CloseButton.DoClick = function (button) 
			self:SetVisible(false);
			self:Remove()
			self.CloseButton:SetVisible(false);
			self.CloseButton:Remove();
		end;
	
		function self.CloseButton:Paint(width, height)
			draw.RoundedBox(2, 0, 0, 38, 24, colorDarkest);
			
			surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_glow_16"));
			surface.SetTextColor(color);
			surface.SetTextPos(6, 2)
			surface.DrawText("X")

			surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_16"))
			surface.SetTextPos(6, 2)
			surface.DrawText("X")
		end;
	end;
end;

function PANEL:SetTitle(title)
	if (!title or title == "") then
		self.title = "Title";
	else
		self.title = title;
	end;
end;

function PANEL:ShouldDrawCloseButton(status)
	self.drawClose = status;
end;

function PANEL:ShouldDrawLines(status)
	self.drawLines = status;
end;

function PANEL:Paint(width, height)
	local color = Clockwork.option:GetColor("information");
	local colorDark = Color(
		math.max(color.r - 100, 0),
		math.max(color.g - 100, 0),
		math.max(color.b - 100, 0),
		255
	)
	local colorDarker = Color(
		math.max(color.r - 130, 0),
		math.max(color.g - 130, 0),
		math.max(color.b - 130, 0),
		150
	);
	local colorDarkest = Color(
		math.max(color.r - 200, 0),
		math.max(color.g - 200, 0),
		math.max(color.b - 200, 0),
		255
	);
	
	local w, h = width, height
	local x, y = 0, -2;
--	local px, py = self:GetPos();
	
	--draw.RoundedBox(0, x, y, w, h, colorDarker);
	
--	Atomic.Draw:SimpleBlurBox(px, py, w, h, colorDarker, 4);
	Atomic.Draw:SimpleBlurBox(0, 0, w, h, colorDarker, 4);
	
	if (self.drawLines) then
		for i=1, h/4 do
			draw.RoundedBox(0, x, i*4+20, w, 1, colorDarkest);
		end;
	end;
	
	DisableClipping(true);
		-- left corner black lines
		draw.RoundedBox(0, x - 1, y + 1, 12, 3, Color(10, 10, 10, 255));
		draw.RoundedBox(0, x - 2, y + 1, 3, 14, Color(10, 10, 10, 255));
		
		-- bottom wide black lines
		draw.RoundedBox(0, -3, y + h - 15, 3, 14, Color(10, 10, 10, 255));
		draw.RoundedBox(0, x + w, y + h - 15, 3, 14, Color(10, 10, 10, 255));
		
		-- upper left corner green lines
		draw.RoundedBox(0, x - 2, y + 1, 2, 12, color);
		draw.RoundedBox(0, x - 1, y + 1, 12, 2, color);
		
		local linePos = titleX + 26;
		local lineWidth = w - titleX - 24 - 110;
		
		-- black lines
		draw.RoundedBox(0, linePos, y + 1, lineWidth - 8, 3, Color(10, 10, 10, 255));
		draw.RoundedBox(0, linePos + lineWidth + 54, y + 1, w - linePos - lineWidth - 53, 3, Color(10, 10, 10, 255));
		
		--right black line
		draw.RoundedBox(0, w, y + 1, 3, 14, Color(10, 10, 10, 255));
		
		-- bottom black line
		draw.RoundedBox(0, -3, y + h - 3, w + 6, 3, Color(10, 10, 10, 255));
		
		-- green stuff
		draw.RoundedBox(0, linePos, y + 1, lineWidth - 8, 2, color);
		draw.RoundedBox(0, linePos + lineWidth + 54, y + 1, w - linePos - lineWidth - 53, 2, color);
		
		-- right upper green line
		draw.RoundedBox(0, w + 1, y + 1, 2, 12, color);
		
		draw.RoundedBox(0, -3, y + h - 2, w + 6, 2, color);
		
		-- left bottom corner
		draw.RoundedBox(0, -3, y + h - 13, 2, 12, color);
		draw.RoundedBox(0, w + 1, y + h - 13, 2, 12, color);

		-- Draw the title
		surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_glow_28"));
		surface.SetTextColor(color);
		
		local tX, tY = surface.GetTextSize(self.title);
		titleX = tX;
		titleY = tY;
			
		surface.SetTextPos(20, -21)
		surface.DrawText(self.title)
		
		surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_28"))
		surface.SetTextPos(20, -21)
		surface.DrawText(self.title)
		
		if (self.logo) then
			surface.SetDrawColor(color);
			surface.SetMaterial(self.logo);
			surface.DrawTexturedRect(width - 110, -11, 50, 22);
		end;

	DisableClipping(false);
end;

function PANEL:SetLogo(path)
	PANEL.logo = Material(path);
end;

function PANEL:Think()
	self.lblTitle:SetVisible(false);
	self.btnMaxim:SetVisible(false);
	self.btnMinim:SetVisible(false);
	self.btnClose:SetVisible(false);
	
--	if (!self.drawClose) then
--		self.CloseButton:SetVisible(false)
--	end;
end;

vgui.Register("AtomicFrame", PANEL, "DFrame");

local PANEL = {};

PANEL.logo = frameMat;
PANEL.title = "Title";

PANEL.drawClose = false;
PANEL.drawLines = false;

function PANEL:Init()
	local color = Clockwork.option:GetColor("information");
	local colorDark = Color(
		math.max(color.r - 100, 0),
		math.max(color.g - 100, 0),
		math.max(color.b - 100, 0),
		255
	);
	local colorDarker = Color(
		math.max(color.r - 160, 0),
		math.max(color.g - 160, 0),
		math.max(color.b - 160, 0),
		255
	);
	local colorDarkest = Color(
		math.max(color.r - 200, 0),
		math.max(color.g - 200, 0),
		math.max(color.b - 200, 0),
		255
	);

	self:SetPos(100, 100);
	self:SetSize(900, 500);
--	self:SetDraggable(false);
	self:MakePopup();
	
	if (self.drawClose) then
		self.CloseButton = vgui.Create("DButton", self)
		self.CloseButton:SetSize(20, 20);
		self.CloseButton:SetPos(self:GetWide() - 24, 25);
		self.CloseButton:SetText("");
		self.CloseButton.DoClick = function (button) 
			self:SetVisible(false);
			self:Remove()
			self.CloseButton:SetVisible(false);
			self.CloseButton:Remove();
		end;
	
		function self.CloseButton:Paint(width, height)
			draw.RoundedBox(2, 0, 0, 38, 24, colorDarkest);
			
			surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_glow_16"));
			surface.SetTextColor(color);
			surface.SetTextPos(6, 2);
			surface.DrawText("X");
			
			surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_16"));
			surface.SetTextPos(6, 2);
			surface.DrawText("X");
		end;
	end;
end;

function PANEL:SetTitle(title)
	if (!title or title == "") then
		self.title = "Title";
	else
		self.title = title;
	end;
end;

function PANEL:ShouldDrawCloseButton(status)
	self.drawClose = status;
end;

function PANEL:ShouldDrawLines(status)
	self.drawLines = status;
end;

local blurTex = Material("pp/blurscreen");
blurTex:SetFloat("$blur", 4);
blurTex:Recompute()

function PANEL:Paint(width, height)
	local color = Clockwork.option:GetColor("information");
	local colorDark = Color(
		math.max(color.r - 100, 0),
		math.max(color.g - 100, 0),
		math.max(color.b - 100, 0),
		255
	);
	local colorDarker = Color(
		math.max(color.r - 160, 0),
		math.max(color.g - 160, 0),
		math.max(color.b - 160, 0),
		255
	);
	local colorDarkest = Color(
		math.max(color.r - 200, 0),
		math.max(color.g - 200, 0),
		math.max(color.b - 200, 0),
		255
	);
	
	local w, h = width, height-20
	local x, y = 0, 20;
	local px, py = self:GetPos();

	if (self.drawBlur) then
		surface.SetMaterial(blurTex);
		surface.SetDrawColor(20, 170, 20, 255);
		render.UpdateScreenEffectTexture();

		surface.SetMaterial(blurTex);
		surface.DrawTexturedRect(-px, -py, ScrW(), ScrH());
	end;
	
	if (self.drawLines) then
		for i=1, h/4 do
			draw.RoundedBox(0, x, i*4+24, w, 1, colorDarkest);
		end;
	end;
	
	draw.RoundedBox(0, x, y, w, h, colorDarker);
	
	draw.RoundedBox(0, x + 1, y + 1, 16, 4, Color(10, 10, 10, 255));
	draw.RoundedBox(0, x + 1, y + 1, 3, 18, Color(10, 10, 10, 255));
	
	draw.RoundedBox(0, x + 1, y + h - 19, 4, 18, Color(10, 10, 10, 255));
	draw.RoundedBox(0, x + w - 5, y + h - 19, 4, 18, Color(10, 10, 10, 255));
	
	draw.RoundedBox(0, x + 1, y + 1, 3, 16, color);
	draw.RoundedBox(0, x + 1, y + 1, 16, 2, color);
	
	local linePos = titleX + 23;
	local lineWidth = w - titleX - 24 - 110;
	
	draw.RoundedBox(0, linePos, y + 1, lineWidth, 4, Color(10, 10, 10, 255));
	draw.RoundedBox(0, linePos + lineWidth + 52, y + 1, w - linePos - lineWidth - 53, 4, Color(10, 10, 10, 255));
	draw.RoundedBox(0, w-4, y + 1, 3, 18, Color(10, 10, 10, 255));
	draw.RoundedBox(0, 1, y + h - 6, w-2, 5, Color(10, 10, 10, 255));
	
	draw.RoundedBox(0, linePos, y + 1, lineWidth, 2, color);
	draw.RoundedBox(0, linePos + lineWidth + 52, y + 1, w - linePos - lineWidth - 53, 2, color);
	draw.RoundedBox(0, w-4, y + 1, 3, 16, color);
	
	draw.RoundedBox(0, 1, y + h - 4, w-2, 3, color);
--	draw.RoundedBox(0, 1, y + h - 2, 16, 2, color);
	
	draw.RoundedBox(0, 1, y + h - 17, 3, 16, color);
	draw.RoundedBox(0, w-4, y + h - 17, 3, 16, color);

	-- Draw the title
	surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_glow_28"));
	surface.SetTextColor(color);
	
	local tX, tY = surface.GetTextSize(self.title);
	titleX = tX;
	titleY = tY;
		
	surface.SetTextPos(20, 0)
	surface.DrawText(self.title)
	
	surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_28"));
	surface.SetTextPos(20, 0);
	surface.DrawText(self.title);
	
	if (self.logo) then
		surface.SetDrawColor(color);
		surface.SetMaterial(self.logo);
		surface.DrawTexturedRect(width - 110, 11, 50, 22);
	end;
end;

function PANEL:SetLogo(path)
	PANEL.logo = Material(path);
end;

function PANEL:Think()
	self.lblTitle:SetVisible(false);
	self.btnMaxim:SetVisible(false);
	self.btnMinim:SetVisible(false);
	self.btnClose:SetVisible(false);
	
	if (!self.drawClose) then
		self.CloseButton:SetVisible(false)
	end;
end;

vgui.Register("AtomicScrollPanel", PANEL, "DScrollPanel");