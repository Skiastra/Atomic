local PANEL = {};

PANEL.titleX = PANEL.titleX or 0;
PANEL.titleY = PANEL.titleY or 0;
PANEL.attrH = 100;

Atomic.special.choices = {
	s = 1,
	p = 1,
	e = 1,
	c = 1,
	i = 1,
	a = 1,
	l = 1
};

-- Called when the panel is initialized.
function PANEL:Init()
	self.attributes = {
		a = {
			name = "Strength", 
			desc = "Strength is your general physical strength. Having high Strength is important for those that want to be physically able.", 
			icon = Clockwork.option:GetKey("icon_str"),
			iconData = {
				x = 390,
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
				x = 370,
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
				x = 370,
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
				x = 370,
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
				x = 400,
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
				x = 370,
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
				x = 360,
				y = 35,
				w = 275,
				h = 300,
			}
		}
	};
	local color = Clockwork.option:GetColor("information");

	self:SetSize(460, 500);
	self:SetTitle("PERSONALITY REVIEW");
	self:ShouldDrawCloseButton(false);

	local attriPanels = {};
	
	for k, v in SortedPairs(self.attributes) do
		local attribute = vgui.Create("DButton", self);

		attribute.attriData = v;
		attribute:SetText("");
		attribute.isSelected = false;
		attribute:SetSize(self:GetWide() / 2 + 50, 45);
		attribute:SetPos(0, self.attrH);

		function attribute:Paint(w, h)
			color = Clockwork.option:GetColor("information");

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

			local textX = w - 84;
			local attriValue = Clockwork.Client:GetSpecial(v.name, true);
			local attriBoost = Clockwork.Client:GetBoost(v.name);
			
			if (attriValue == 10) then
				textX = w - 92;
			end;
			
			if (attriBoost != 0) then
				surface.SetTextColor(Color(0, 255, 0, 255));

				if (attriBoost < 0) then
					surface.SetTextColor(Color(255, 0, 0, 255));
				else
					attriBoost = "+"..attriBoost;
				end;
			end;

			if (!Clockwork.config:Get("show_boosts"):GetBoolean()) then		
				attriValue = Clockwork.Client:GetSpecial(v.name);
			else
				if (attriBoost != 0) then
					surface.SetTextPos(textX + 45, 6);
					surface.DrawText(attriBoost);
				end;
			end;

			surface.SetTextPos(textX, 6);
			surface.DrawText(attriValue);
		end;
	
		self.attrH = self.attrH + 45;

		table.insert(attriPanels, attribute);
	end;

	local defaultDesc = "Tell us about yourself! Vault-Tec needs to know what kind of citizen you are to ensure your future happiness.";
	local defaultData = {
		x = 390,
		y = 70,
		w = 240,
		h = 260,
		icon = Clockwork.option:GetKey("icon_default")
	};

	local image = vgui.Create("DImage", self);

	image:SetVisible(true);
	image:SetImageColor(color);

	function image:Think()
		if (attriPanels and #attriPanels > 0) then
			local noneSelected = true;
			local infoColor = Clockwork.option:GetColor("information");

			self:SetImageColor(infoColor);

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
		
	local desc = vgui.Create("DLabel", self);

	desc:SetPos(300, self:GetTall() - 230);
	desc:SetSize(self:GetWide() - 48, 256);
	desc:SetFont(Clockwork.option:GetFont("atomic_menu_text_19"));
	desc:SetWrap(true);
	desc:SetTextColor(color);

	function desc:Think()
		if (attriPanels and #attriPanels > 0) then
			local noneSelected = true;
			local infoColor = Clockwork.option:GetColor("information");
			
			self:SetTextColor(infoColor);

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

vgui.Register("cwSpecial", PANEL, "AtomicFrame");