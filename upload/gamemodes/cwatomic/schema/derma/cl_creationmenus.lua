local PANEL = {};

PANEL.titleX = PANEL.titleX or 0;
PANEL.titleY = PANEL.titleY or 0;
PANEL.attrH = 100;

ARROW_RIGHT = "▶";
ARROW_LEFT = "◀";
ARROW_UP = "▲";
ARROW_DOWN = "▼";

Atomic.special.choices = {
	s = 1,
	p = 1,
	e = 1,
	c = 1,
	i = 1,
	a = 1,
	l = 1,
	r = 0
};

-- Called when the panel is initialized.
function PANEL:Init()
	self.attributes = {
		a = {
			name = "Strength", 
			desc = "Strength is your general physical strength. Having high Strength is important for those that want to be physically able.", 
			icon = Clockwork.option:GetKey("icon_str"),
			iconData = {
				x = 120,
				y = 50,
				w = 200,
				h = 300,
			}
		},
		b = {
			name = "Perception", 
			desc = "Perception is your general ability to sense things, allowing you to clue into certain things.", 
			icon = Clockwork.option:GetKey("icon_per"),
			iconData = {
				x = 100,
				y = 20,
				w = 250,
				h = 300,
			}
		},
		c = {
			name = "Endurance", 
			desc = "Endurance is stamina and physical toughness. Someone with high Endurance will survive where others may not.", 
			icon = Clockwork.option:GetKey("icon_end"),
			iconData = {
				x = 100,
				y = 20,
				w = 250,
				h = 300,
			}
		},
		d = {
			name = "Charisma", 
			desc = "Charisma is a combination of appearance and charm. Having high Charisma is important for those that want to influence others with words.", 
			icon = Clockwork.option:GetKey("icon_chr"),
			iconData = {
				x = 100,
				y = 20,
				w = 250,
				h = 300,
			}
		},
		e = {
			name = "Intelligence", 
			desc = "Intelligence is the combination of knowledge, wisdom, and the ability to think quickly. Having a high Intelligence is important for any person.", 
			icon = Clockwork.option:GetKey("icon_int"),
			iconData = {
				x = 130,
				y = 50,
				w = 210,
				h = 260,
			}
		},
		f = {
			name = "Agility", 
			desc = "Agility is coordination and the ability to, move well. Having a high Agility is important for any active person.", 
			icon = Clockwork.option:GetKey("icon_agi"),
			iconData = {
				x = 100,
				y = 50,
				w = 235,
				h = 275,
			}
		},
		g = {
			name = "Luck", 
			desc = "Fate. Karma. Your Luck will affect your life - somehow. Events around you may go your way, or may not, based on how lucky you are.", 
			icon = Clockwork.option:GetKey("icon_luck"),
			iconData = {
				x = 90,
				y = 35,
				w = 275,
				h = 300,
			}
		}
	};
	local color = Clockwork.option:GetColor("information");
	
	surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_glow_28"));
	self:SetSize(960, 540);
	self:SetPos(ScrW() / 2 - 480, ScrH() / 2 - 270);
	self:SetTitle("PERSONALITY FORM");
	self:ShouldDrawCloseButton(false);

	self.info = Clockwork.character:GetCreationInfo();
	self.drawBlur = true;

	self.LeftHalf = vgui.Create("EditablePanel", self);
	self.LeftHalf:SetPos(0, 0);
	self.LeftHalf:SetSize(self:GetWide()/2, self:GetTall());
	
	function self.LeftHalf:Paint(w, h)
	end;
	
	self.RightHalf = vgui.Create("EditablePanel", self);
	self.RightHalf:SetPos(self:GetWide()/2, 0);
	self.RightHalf:SetSize(self:GetWide()/2, self:GetTall());
	
	function self.RightHalf:Paint(w, h)
	end;
	
	self.Text = vgui.Create("DLabel", self.LeftHalf);
	self.Text:SetText("");
	self.Text:SetSize(self.LeftHalf:GetWide(), self.LeftHalf:GetTall());
	self.Text:SetPos(0, 0);

	function self.Text:Paint(w, h)
		local name = Clockwork.character:GetCreationInfo().fullName or " ";

		surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_25"));
		surface.SetTextColor(color);
		surface.SetTextPos(20, 40);
		surface.DrawText("Name:");
		
		local tX, tY = surface.GetTextSize(name);
		
		surface.SetTextColor(color);
		surface.SetTextPos(w - tX - 24, 40);
		surface.DrawText(name);
		
		surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_19"));

		local nX, nY = surface.GetTextSize("POINTS AVAILABLE");
		
		surface.SetTextPos(100, h - (h / 5) + 65);
		surface.SetTextColor(color);
		surface.DrawText("POINTS AVAILABLE");

		local numX = 80 + (nX / 2);

		if (Atomic.special.choices.r >= 10) then
			numX = 60 + (nX / 2);
		end;

		surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_70"));
		surface.SetTextPos(numX, h-h/5);
		surface.SetTextColor(color);
		surface.DrawText(Atomic.special.choices.r);		
	end;

	local attriPanels = {};
	
	for k, v in SortedPairs(self.attributes) do
		local attribute = vgui.Create("DButton", self.LeftHalf);

		attribute.attriData = v;
		attribute:SetText("");
		attribute.isSelected = false;
		attribute:SetSize(self.LeftHalf:GetWide(), 45);
		attribute:SetPos(0, self.attrH);

		function attribute:Paint(w, h)
			surface.SetTextColor(color);
			
			if (self:IsHovered() or self.isSelected) then
				draw.RoundedBox(0, 0, 0, w, h, Color(10, 10, 10, 255));
				draw.RoundedBox(0, 0, 0, w - 1, h - 2, color);

				surface.SetTextColor(20, 20, 20, 255);

				if (!self.played) then
					Clockwork.option:PlaySound("rollover");

					self.played = true;
				end;
			else
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0));

				if (self.played) then
					self.played = nil;
				end;
			end;
			
			-- Draw the name of the attribute thing.
			surface.SetFont(Clockwork.option:GetFont("atomic_menu_text_25"));
			surface.SetTextPos(20, 6);
			surface.DrawText(v.name);
			
			surface.SetTextPos(w-64, 6);
			
			if (PANEL:GetAttribute(v.name) == 10) then
				surface.SetTextPos(w-72, 6);
			end;
			
			surface.DrawText(PANEL:GetAttribute(v.name));
		end;
		
		local minus = vgui.Create("DButton", self.LeftHalf);

		minus:SetFont(Clockwork.option:GetFont("atomic_menu_text_25"));
		minus.isSelected = false;
		minus:SetTextColor(color)
		minus:SetText(ARROW_LEFT);
		minus:SetSize(32, 32);
		minus:SetPos(self.LeftHalf:GetWide()-110, self.attrH);

		function minus:Paint(w, h)
		end;
		
		function minus:Think()
			if (self:IsHovered()) then
				attribute.isSelected = true;
			else
				attribute.isSelected = false;
			end;
			
			if ((attribute.isSelected or attribute:IsHovered()) and !self:IsHovered()) then
				self:SetTextColor(Color(20, 20, 20, 255));
			else
				self:SetTextColor(color);
			end;
			
			if (self:IsHovered()) then
				self:SetTextColor(Color(255, 255, 255, 255));
			end;
			
			if (PANEL:GetAttribute(v.name) == 1) then
				self:SetTextColor(Color(100, 100, 100, 255));
			end;
		end;
		
		function minus:DoClick()
			PANEL:ChangeAttribute(v.name, -1);
		end;
		
		local plus = vgui.Create("DButton", self.LeftHalf);

		plus:SetFont(Clockwork.option:GetFont("atomic_menu_text_25"));
		plus.isSelected = false;
		plus:SetTextColor(color);
		plus:SetText(ARROW_RIGHT);
		plus:SetSize(32, 32);
		plus:SetPos(self.LeftHalf:GetWide()-35, self.attrH);

		function plus:Paint(w, h)
		end;
		
		function plus:Think()
			if (self:IsHovered()) then
				attribute.isSelected = true;
			end;
			
			if ((attribute.isSelected or attribute:IsHovered()) and !self:IsHovered()) then
				self:SetTextColor(Color(20, 20, 20, 255));
			else
				self:SetTextColor(color);
			end;
			
			if (self:IsHovered()) then
				minus:SetTextColor(Color(20, 20, 20, 255));
				self:SetTextColor(Color(255, 255, 255, 255));
			end;
			
			if (PANEL:GetAttribute(v.name) == 10 or Atomic.special.choices.r == 0) then
				self:SetTextColor(Color(100, 100, 100, 255));
			end;
		end;
		
		function plus:DoClick()
			PANEL:ChangeAttribute(v.name, 1);
		end;
	
		self.attrH = self.attrH + 45;

		table.insert(attriPanels, attribute);
	end;

	local defaultDesc = "Tell us about yourself! We need to know what kind of citizen you are to ensure your future happiness.";
	local defaultData = {
		x = 120,
		y = 70,
		w = 240,
		h = 260,
		icon = Clockwork.option:GetKey("icon_default")
	};

	local image = vgui.Create("DImage", self.RightHalf);

	image:SetVisible(true);
	image:SetImageColor(color);

	function image:Think()
		if (attriPanels and #attriPanels > 0) then
			local noneSelected = true;

			for k, v in pairs(attriPanels) do
				if (v:IsHovered() or v.isSelected) then
					self:SetPos(v.attriData.iconData.x, v.attriData.iconData.y);
					self:SetSize(v.attriData.iconData.w, v.attriData.iconData.h);

					if (v.attriData.icon) then
						self:SetImage(v.attriData.icon);
					end;

					noneSelected = false;

					break;
				end;
			end;

			if (noneSelected) then
				self:SetPos(defaultData.x, defaultData.y);
				self:SetSize(defaultData.w, defaultData.h);

				if (defaultData.icon) then
					self:SetImage(defaultData.icon);
				end;
			end;
		end;
	end;
		
	local desc = vgui.Create("DLabel", self.RightHalf);

	desc:SetPos(24, self.RightHalf:GetTall() - 260);
	desc:SetSize(self.RightHalf:GetWide() - 48, 256);
	desc:SetFont(Clockwork.option:GetFont("atomic_menu_text_19"));
	desc:SetWrap(true);
	desc:SetTextColor(color);

	function desc:Think()
		if (attriPanels and #attriPanels > 0) then
			local noneSelected = true;

			for k, v in pairs(attriPanels) do
				if (v:IsHovered() or v.isSelected) then
					desc:SetText(v.attriData.desc);

					noneSelected = false;

					break;
				end;
			end;

			if (noneSelected) then
				desc:SetText(defaultDesc);
			end;
		end;
	end;
end;

-- A function to get attribute value by name.
function PANEL:GetAttribute(name)
	if (name == "Strength") then
		return Atomic.special.choices.s;
	elseif (name == "Perception") then
		return Atomic.special.choices.p;
	elseif (name == "Endurance") then
		return Atomic.special.choices.e;
	elseif (name == "Charisma") then
		return Atomic.special.choices.c;
	elseif (name == "Intelligence") then
		return Atomic.special.choices.i;
	elseif (name == "Agility") then
		return Atomic.special.choices.a;
	elseif (name == "Luck") then
		return Atomic.special.choices.l;
	end;
end;

-- A function to change attribute value by name.
function PANEL:ChangeAttribute(name, state)
	if (Atomic.special.choices.r == 0 and state > 0) then return; end;
	if ((self:GetAttribute(name) == 1 and state == -1) or (self:GetAttribute(name) == 10 and state == 1)) then return; end;
	
	if (name == "Strength") then
		Atomic.special.choices.s = Atomic.special.choices.s + state;
		Atomic.special.choices.r = Atomic.special.choices.r - state;
	elseif (name == "Perception") then
		Atomic.special.choices.p = Atomic.special.choices.p + state;
		Atomic.special.choices.r = Atomic.special.choices.r - state;
	elseif (name == "Endurance") then
		Atomic.special.choices.e = Atomic.special.choices.e + state;
		Atomic.special.choices.r = Atomic.special.choices.r - state;
	elseif (name == "Charisma") then
		Atomic.special.choices.c = Atomic.special.choices.c + state;
		Atomic.special.choices.r = Atomic.special.choices.r - state;
	elseif (name == "Intelligence") then
		Atomic.special.choices.i = Atomic.special.choices.i + state;
		Atomic.special.choices.r = Atomic.special.choices.r - state;
	elseif (name == "Agility") then
		Atomic.special.choices.a = Atomic.special.choices.a + state;
		Atomic.special.choices.r = Atomic.special.choices.r - state;
	elseif (name == "Luck") then
		Atomic.special.choices.l = Atomic.special.choices.l + state;
		Atomic.special.choices.r = Atomic.special.choices.r - state;
	end;

	Clockwork.option:PlaySound("tick");
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
			self.animation:Start(speed);
		end;
	else
		self:SetVisible(true);
		self:SetAlpha(255);
		
		if (Callback) then
			Callback();
		end;
	end;

	Atomic.special.choices = {
		s = 1,
		p = 1,
		e = 1,
		c = 1,
		i = 1,
		a = 1,
		l = 1,
	};

	Atomic.special.choices.r = Clockwork.config:Get("default_special_points"):Get();
	
	Clockwork.option:PlaySound("click_release");
end;

-- Called when the next button is pressed.
function PANEL:OnNext()
	self.info.special = {};

	for k, v in pairs(Atomic.special.choices) do
		if (k != "r") then
			local statTable = Atomic.special:GetNameTable();
			local statName = statTable[string.upper(k)];

			self.info.special[statName] = v;
		end;
	end;
end;

vgui.Register("cwCharacterSpecial", PANEL, "AtomicFrame");

local gripMat = Material("atomic/hud/vert_scrollbar.png");
local upMat = Material("atomic/hud/scroll_up.png");
local downMat = Material("atomic/hud/scroll_down.png");

local PANEL = {};

function PANEL:Init()
	local color = Clockwork.option:GetColor("information");
	local factions = {};
	
	for k, v in pairs(Clockwork.faction.stored) do
		if (!v.whitelist or Clockwork.character:IsWhitelisted(v.name)) then
			if (!Clockwork.faction:HasReachedMaximum(k)) then
				factions[#factions + 1] = v;
			end;
		end;
	end;
	
	table.sort(factions, function(a, b)
		return a.name < b.name;
	end);
	
	self.drawBlur = true;
	self:SetSize(700, 512);
	self:SetTitle("ALLEGIANCE FORM");
	self.info = Clockwork.character:GetCreationInfo();

	self.LeftHalf = vgui.Create("DScrollPanel", self);
	self.LeftHalf:SetPos(0, 50);
	self.LeftHalf:SetSize(self:GetWide() * 0.3, self:GetTall() - 70);
	
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

	local btnY = 0;

	local backImage = vgui.Create("DImageButton", self);

	backImage:SetPos(256, 141);
	backImage:SetSize(408, 208);
	
	function backImage:Paint(w, h)
		surface.SetDrawColor(color);
		surface.DrawRect(0, 0, w, h);
	end;

	local factionImage = vgui.Create("DImageButton", self);

	factionImage:SetPos(260, 145);
	factionImage:SetSize(400, 200);

	local defaultFaction = Clockwork.option:GetKey("icon_faction_default");

	if (defaultFaction) then
		factionImage:SetImage(defaultFaction);
	end;

	local factionDesc = vgui.Create("DLabel", self);

	factionDesc:SetPos(260, 300);
	factionDesc:SetSize(400, 200);
	factionDesc:SetFont(Clockwork.option:GetFont("atomic_menu_text_20"));
	factionDesc:SetText("Your friends shape who you are, and we want to know just who those friends are!");
	factionDesc:SetColor(color);
	factionDesc:SetWrap(true);

	local factionName = "CHOOSE YOUR FRIENDS WISELY!";
	local buttons = {};

	for k, v in pairs(factions) do
		local button = vgui.Create("DImageButton", self.LeftHalf);
		local buttonMat = v.buttonMat or v.material;

		if (buttonMat) then
			button:SetImage(buttonMat..".png");
		else
			button:SetText(v.name);
		end;

		button:SetPos(15, btnY);
		button:SetSize(160, 160);
		button:SetColor(color);

		function button:Paint(w, h)
			if (self:IsHovered() or Atomic.selectedFaction == v.name) then
				surface.SetDrawColor(color);

				for i=0, 3 do
					surface.DrawOutlinedRect(i, i, w - i * 2, h - i * 2);
				end;

				if (v.material) then
					factionImage:SetImage(v.material..".png");
				end;

				if (v.description) then
					factionDesc:SetText(v.description);
				else
					factionDesc:SetText("");
				end;

				factionName = string.upper(v.name);

				if (!self.played) then
					Clockwork.option:PlaySound("rollover");

					self.played = true;
				end;
			else
				if (self.played) then
					self.played = nil;
				end;
			end;
		end;

		function button:DoClick()
			if (Atomic.selectedFaction and Atomic.selectedFaction == v.name) then
				Atomic.selectedFaction = nil;
			else
				Atomic.selectedFaction = v.name;
			end;

			Clockwork.option:PlaySound("tick");
		end;

		table.insert(buttons, button);

		btnY = btnY + 160;
	end;

	function factionImage:Think()
		local isHovering = false;

		if (buttons) then
			for k, v in pairs(buttons) do
				if (self.IsHovered()) then
					isHovering = true;
				end;
			end;
		end;

		if (isHovering == false) then
			local defaultMat = Clockwork.option:GetKey("icon_faction_default");

			if (defaultMat) then
				self:SetImage(defaultMat);
			end;

			factionDesc:SetText("Your friends shape who you are, and we want to know just who those friends are!");
			factionName = "CHOOSE YOUR FRIENDS WISELY!";
		end;
	end;

	self.RightHalf = vgui.Create("EditablePanel", self);
	self.RightHalf:SetPos(self:GetWide()*0.3, 50);
	self.RightHalf:SetSize(self:GetWide()*0.7, self:GetTall() - 70);

	function self.RightHalf:Paint(w, h)
		draw.DrawText(factionName, Clockwork.option:GetFont("atomic_menu_text_25"), 245, 60, color, TEXT_ALIGN_CENTER);
	end;
end;

-- Called when the next button is pressed.
function PANEL:OnNext()
	if (Atomic.selectedFaction) then
		for k, v in pairs(Clockwork.faction.stored) do
			if (v.name == Atomic.selectedFaction) then
				self.info.faction = Atomic.selectedFaction;
				Atomic.selectedFaction = nil;

				return true;
			end;
		end;
	end;

	Clockwork.character:SetFault("You did not choose a faction or the one you have chosen is not valid!");
	return false;
end;

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
			self.animation:Start(speed);
		end;
		
		Clockwork.option:PlaySound("click_release");
	else
		self:SetVisible(true);
		self:SetAlpha(255);
		
		if (Callback) then
			Callback();
		end;
	end;
end;

-- Called each frame.
function PANEL:Think()
	self.lblTitle:SetVisible(false);
	self.btnMaxim:SetVisible(false);
	self.btnMinim:SetVisible(false);
	self.btnClose:SetVisible(false);

	if (self.animation) then
		self.animation:Run();
	end;
end;

vgui.Register("cwCharacterFaction", PANEL, "AtomicFrame");

local PANEL = {};

function PANEL:Init()
	local color = Clockwork.option:GetColor("information");

	self.drawBlur = true;
	self:SetSize(700, 512);
	self:SetTitle("IDENTIFICATION FORM");
	self:ShouldDrawCloseButton(false);
	self.info = Clockwork.character:GetCreationInfo();

	local male = vgui.Create("DImageButton", self);

	male:SetPos(105, 65);
	male:SetSize(180, 360);

	local maleMat = Clockwork.option:GetKey("icon_gender_male");

	if (maleMat) then
		male:SetImage(maleMat);
	else
		male:SetFont(Clockwork.option:GetFont("atomic_menu_text_25"));
		male:SetTextColor(color);
		male:SetText("MALE");
	end;

	male:SetColor(color);

	function male:Paint(w, h)
		if (Atomic.selectedGender == "Male") then
			surface.SetDrawColor(color);
			
			for i=0, 3 do
				surface.DrawOutlinedRect(i, i, w - i * 2, h - i * 2);
			end;
		end;
	end;

	function male:DoClick()
		if (Atomic.selectedGender == "Male") then
			Atomic.selectedGender = nil;

			return;
		end;

		Atomic.selectedGender = "Male";

		Clockwork.option:PlaySound("tick");
	end;

	if (maleMat) then
		local maleLabel = vgui.Create("DLabel", self);

		maleLabel:SetPos(165, 430);	
		maleLabel:SetFont(Clockwork.option:GetFont("atomic_menu_text_25"));
		maleLabel:SetText("MALE");
		maleLabel:SetColor(color);
		maleLabel:SizeToContents();
	end;

	local female = vgui.Create("DImageButton", self);

	female:SetPos(425, 65);
	female:SetSize(180, 360);

	local femaleMat = Clockwork.option:GetKey("icon_gender_female");

	if (femaleMat) then
		female:SetImage(femaleMat);
	else
		female:SetFont(Clockwork.option:GetFont("atomic_menu_text_25"));
		female:SetTextColor(color);
		female:SetText("FEMALE");
	end;

	female:SetColor(color);

	function female:Paint(w, h)
		if (Atomic.selectedGender == "Female") then
			surface.SetDrawColor(color);

			for i=0, 3 do
				surface.DrawOutlinedRect(i, i, w - i * 2, h - i * 2);
			end;
		end;
	end;

	function female:DoClick()
		if (Atomic.selectedGender == "Female") then
			Atomic.selectedGender = nil;
			
			return;
		end;

		Atomic.selectedGender = "Female";

		Clockwork.option:PlaySound("tick");
	end;

	if (femaleMat) then
		local femaleLabel = vgui.Create("DLabel", self);

		femaleLabel:SetPos(475, 430);	
		femaleLabel:SetFont(Clockwork.option:GetFont("atomic_menu_text_25"));		
		femaleLabel:SetText("FEMALE");
		femaleLabel:SetColor(color);
		femaleLabel:SizeToContents();
	end;
end;

-- Called when the next button is pressed.
function PANEL:OnNext()
	if (Atomic.selectedGender) then
		self.info.gender = Atomic.selectedGender;
		return true;
	end;

	Clockwork.character:SetFault("You did not choose a gender!");
	return false;
end;

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
			self.animation:Start(speed);
		end;
		
		Clockwork.option:PlaySound("click_release");
	else
		self:SetVisible(true);
		self:SetAlpha(255);
		
		if (Callback) then
			Callback();
		end;
	end;
end;

-- Called each frame.
function PANEL:Think()
	self.lblTitle:SetVisible(false);
	self.btnMaxim:SetVisible(false);
	self.btnMinim:SetVisible(false);
	self.btnClose:SetVisible(false);

	if (self.animation) then
		self.animation:Run();
	end;
end;

vgui.Register("cwCharacterGender", PANEL, "AtomicFrame");