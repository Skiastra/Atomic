local gripMat = Material("atomic/hud/vert_scrollbar.png");
local upMat = Material("atomic/hud/scroll_up.png");
local downMat = Material("atomic/hud/scroll_down.png");

local PANEL = {};

function PANEL:Init()
	local color = Clockwork.option:GetColor("information");
	local perks = Clockwork.Client:GetPerks();

	self.drawBlur = true;
	self:SetSize(700, 512);
	self:SetTitle("ABILITY REVIEW");

	self.LeftHalf = vgui.Create("DScrollPanel", self);
	self.LeftHalf:SetPos(0, 50);
	self.LeftHalf:SetSize(self:GetWide() * 0.4, self:GetTall() - 70);
	
	function self.LeftHalf:Paint(w, h)
		return false;
	end;

	local sBar = self.LeftHalf:GetVBar();

	function sBar:Paint(w, h)
		return false;
	end;

	function sBar.btnGrip:Paint(w, h)
		surface.SetDrawColor(color);
		surface.SetMaterial(gripMat);
		surface.DrawTexturedRect(0, 0, w, h);
	end;

	function sBar.btnDown:Paint(w, h)
		surface.SetDrawColor(color);
		surface.SetMaterial(downMat);
		surface.DrawTexturedRect(0, 0, w, h);
	end;

	function sBar.btnUp:Paint(w, h)
		surface.SetDrawColor(color);
		surface.SetMaterial(upMat);
		surface.DrawTexturedRect(0, 0, w, h);
	end;

	self.perkImage = vgui.Create("DImageButton", self);

	self.perkImage:SetPos(350, 95);
	self.perkImage:SetSize(256, 256);
	self.perkImage:SetColor(color);

	self.perkDesc = vgui.Create("DLabel", self);

	self.perkDesc:SetPos(300, 280);
	self.perkDesc:SetSize(400, 200);
	self.perkDesc:SetFont(Clockwork.option:GetFont("menu_text_tiny"));
	self.perkDesc:SetText("");
	self.perkDesc:SetColor(color);
	self.perkDesc:SetWrap(true);

	function self.perkImage:Think()
		local isHovering = false;

		if (self.buttons) then
			for k, v in pairs(self.buttons) do
				if (self.IsHovered()) then
					isHovering = true;
				end;
			end;
		end;
	end;

	if (perks and perks[1]) then
		local perk = Atomic.perks:FindByID(perks[1]);

		if (perk) then
			self.perkImage:SetImage(perk.icon);
			self.perkDesc:SetText(perk.description);
		end;
	end;

	self:Rebuild();
end;

function PANEL:Rebuild()
	local color = Clockwork.option:GetColor("information");
	local perks = Clockwork.Client:GetPerks();
	local btnY = 0;

	table.sort(perks, function(a, b)
		return a < b;
	end);

	if (self.buttons and #self.buttons > 0) then
		for k, v in pairs(self.buttons) do
			v:Remove();
		end;
	end;

	self.buttons = {};

	self.perkImage:SetColor(color);
	self.perkDesc:SetColor(color);

	for k, v in pairs(perks) do
		local button = vgui.Create("DImageButton", self.LeftHalf);
		local perk = Atomic.perks:FindByID(v);

		if (perk) then
			button:SetFont(Clockwork.option:GetFont("menu_text_tiny"));
			button:SetText(perk.name)
			button:SetTextColor(color);
			button:SetPos(15, btnY);
			button:SetSize(250, 50);
			button:SetColor(color);

			button.Paint = function(panel, w, h)
				if (panel:IsHovered()) then
					surface.SetDrawColor(color);

					for i=0, 3 do
						surface.DrawOutlinedRect(i, i, w - i * 2, h - i * 2);
					end;

					if (perk.icon) then
						self.perkImage:SetImage(perk.icon);
					end;

					if (perk.description) then
						self.perkDesc:SetText(perk.description);
					else
						self.perkDesc:SetText("");
					end;

					if (!panel.played) then
						Clockwork.option:PlaySound("rollover");

						panel.played = true;
					end;
				else
					if (panel.played) then
						panel.played = nil;
					end;
				end;
			end;

			table.insert(self.buttons, button);

			btnY = btnY + 50;
		end;
	end;

	if (perks and perks[1]) then
		local defPerk = Atomic.perks:FindByID(perks[1]);

		if (defPerk) then
			self.perkImage:SetImage(defPerk.icon);
			self.perkDesc:SetText(defPerk.description);
		end;
	end;
end;

-- Called every frame and every tick.
function PANEL:Think()
	self.lblTitle:SetVisible(false);
	self.btnMaxim:SetVisible(false);
	self.btnMinim:SetVisible(false);
	self.btnClose:SetVisible(false);
	
	if (self.animation) then
		self.animation:Run();
	end;
end;

-- Called when the menu is opened.
function PANEL:OnMenuOpened()
	if (Clockwork.menu:IsPanelActive(self)) then
		self:Rebuild();
	end;
end;

-- Called when the panel is selected.
function PANEL:OnSelected() self:Rebuild(); end;

-- A function to make the panel fade out.
function PANEL:FadeOut(speed, Callback)
	if (self:GetAlpha() > 0 and CW_CONVAR_FADEPANEL:GetInt() == 1 and (!self.animation or !self.animation:Active())) then
		self.animation = Derma_Anim("Fade Panel", self, function(panel, animation, delta, data)
			panel:SetAlpha(255 - (delta * 255));
			
			if (animation.Finished) then
				panel:SetVisible(false);
			end;
			
			if (animation.Finished and Callback) then
				Callback();
			end;
		end);
		
		if (self.animation) then
			self.animation:Start(speed);
		end;
		
		Clockwork.option:PlaySound("rollover");
	else
		self:SetVisible(false);
		self:SetAlpha(0);
		
		if (Callback) then
			Callback();
		end;
	end;
end;

-- A function to make the panel fade in.
function PANEL:FadeIn(speed, Callback)
	if (self:GetAlpha() == 0 and CW_CONVAR_FADEPANEL:GetInt() == 1 and (!self.animation or !self.animation:Active())) then
		self.animation = Derma_Anim("Fade Panel", self, function(panel, animation, delta, data)
			panel:SetVisible(true);
			panel:SetAlpha(delta * 255);
			
			if (animation.Finished) then
				self.animation = nil;
			end;
			
			if (animation.Finished and Callback) then
				Callback();
			end;
		end);
		
		if (self.animation) then
		end;
			self.animation:Start(speed);
	else
		self:SetVisible(true);
		self:SetAlpha(255);
		
		if (Callback) then
			Callback();
		end;
	end;

	Clockwork.option:PlaySound("click_release");
end;

vgui.Register("cwPerks", PANEL, "AtomicFrame");