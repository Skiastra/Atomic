--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local THEME = Clockwork.theme:Begin();

-- Called when fonts should be created.
function THEME:CreateFonts()
	surface.CreateFont("ato_Large3D2D", {
		size = Clockwork.kernel:FontScreenScale(2048),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_IntroTextSmall", {
		size = Clockwork.kernel:FontScreenScale(16),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_IntroTextTiny", {
		size = Clockwork.kernel:FontScreenScale(12),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_CinematicText", {
		size = Clockwork.kernel:FontScreenScale(18),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_IntroTextBig", {
		size = Clockwork.kernel:FontScreenScale(18),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_TargetIDText", {
		size = Clockwork.kernel:FontScreenScale(8),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_MenuTextHuge", {
		size = Clockwork.kernel:FontScreenScale(22),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_MenuTextBig", {
		size = Clockwork.kernel:FontScreenScale(20),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});


	surface.CreateFont("ato_MainText", {
		size = Clockwork.kernel:FontScreenScale(8),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_MenuTextSmall", {
		size = Clockwork.kernel:FontScreenScale(10),
		weight = 100,
		antialias = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_MenuTextMedium", {
		size = Clockwork.kernel:FontScreenScale(13),
		weight = 100,
		antialias = true,
		shadow = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_HUDText", {
		size = Clockwork.kernel:FontScreenScale(12),
		weight = 100,
		antialias = true,
		shadow = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_HUDText_small", {
		size = Clockwork.kernel:FontScreenScale(5),
		weight = 100,
		antialias = true,
		shadow = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_HUDText2", {
		size = Clockwork.kernel:FontScreenScale(20),
		weight = 100,
		antialias = true,
		shadow = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_HUDText_blur", {
		size = Clockwork.kernel:FontScreenScale(12),
		weight = 100,
		blursize = 4,
		antialias = true,
		shadow = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_HUDText_small_blur", {
		size = Clockwork.kernel:FontScreenScale(5),
		weight = 100,
		blursize = 4,
		antialias = true,
		shadow = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_HUDText2_blur", {
		size = Clockwork.kernel:FontScreenScale(20),
		weight = 100,
		blursize = 4,
		antialias = true,
		shadow = true,
		font = "Monofonto"
	});

	surface.CreateFont("ato_PrimaryHUDText", {
		size = Clockwork.kernel:FontScreenScale(15),
		weight = 100,
		antialias = true,
		font = "Roboto Condensed Bold"
	});

	surface.CreateFont("ato_PrimaryHUDTextBig", {
		size = Clockwork.kernel:FontScreenScale(18),
		weight = 100,
		antialias = true,
		font = "Roboto Condensed Bold"
	});

	surface.CreateFont("ato_PrimaryHUDTextSmall", {
		size = Clockwork.kernel:FontScreenScale(11),
		weight = 100,
		antialias = true,
		font = "Roboto Condensed Bold"
	});

	surface.CreateFont("ato_PrimaryHUDTextTiny", {
		size = Clockwork.kernel:FontScreenScale(10),
		weight = 100,
		antialias = true,
		font = "Roboto Condensed Bold"
	});

	for k, i in pairs({28, 25, 16, 19, 70, 20}) do
		surface.CreateFont("ato_menu"..i, {
			font = "Tahoma",
			size = i,
			antialias = true,
			weight = 900,
			shadow = true
		})
		
		surface.CreateFont("ato_menu_glow"..i, {
			font = "Tahoma",
			size = i,
			blursize = 4,
			scanlines = 2,
			antialias = true,
			weight = 900
		})
	end;
end;

-- Called when to initialize the theme.
function THEME:Initialize()
	Clockwork.option:SetColor("target_id", Color(165, 155, 95, 255));
	Clockwork.option:SetColor("background", Color(0, 0, 0, 255));

	Clockwork.option:SetFont("bar_text", "ato_IntroTextTiny");
	Clockwork.option:SetFont("main_text", "ato_MainText");
	Clockwork.option:SetFont("hints_text", "ato_IntroTextTiny");
	Clockwork.option:SetFont("large_3d_2d", "ato_Large3D2D");
	Clockwork.option:SetFont("target_id_text", "ato_TargetIDText");
	Clockwork.option:SetFont("cinematic_text", "ato_CinematicText");
	Clockwork.option:SetFont("date_time_text", "ato_IntroTextSmall");
	Clockwork.option:SetFont("menu_text_big", "ato_MenuTextBig");
	Clockwork.option:SetFont("menu_text_huge", "ato_MenuTextHuge");
	Clockwork.option:SetFont("menu_text_tiny", "ato_MainText");
	Clockwork.option:SetFont("intro_text_big", "ato_IntroTextBig");
	Clockwork.option:SetFont("menu_text_small", "ato_MenuTextSmall");
	Clockwork.option:SetFont("menu_text_medium", "ato_MenuTextMedium");
	Clockwork.option:SetFont("intro_text_tiny", "ato_IntroTextTiny");
	Clockwork.option:SetFont("intro_text_small", "ato_IntroTextSmall");
	Clockwork.option:SetFont("player_info_text", "ato_MainText");
	Clockwork.option:SetFont("hud_text", "ato_HUDText");
	Clockwork.option:SetFont("hud_text_small", "ato_HUDText_small");
	Clockwork.option:SetFont("hud_text_big", "ato_HUDText2");
	Clockwork.option:SetFont("hud_text_blur", "ato_HUDText_blur");
	Clockwork.option:SetFont("hud_text_small_blur", "ato_HUDText_small_blur");
	Clockwork.option:SetFont("hud_text_big_blur", "ato_HUDText2_blur");
	Clockwork.option:SetFont("prim_hud_text", "ato_PrimaryHUDText");
	Clockwork.option:SetFont("prim_hud_text_small", "ato_PrimaryHUDTextSmall");
	Clockwork.option:SetFont("prim_hud_text_tiny", "ato_PrimaryHUDTextTiny");
	Clockwork.option:SetFont("prim_hud_text_big", "ato_PrimaryHUDTextBig");

	for k, i in pairs({28, 25, 16, 19, 70, 20}) do
		Clockwork.option:SetFont("atomic_menu_text_"..i, "ato_menu"..i);
		Clockwork.option:SetFont("atomic_menu_text_glow_"..i, "ato_menu_glow"..i);
	end;

	local color = Color(
		GetConVarNumber("cwTextColorR"), 
		GetConVarNumber("cwTextColorG"), 
		GetConVarNumber("cwTextColorB"), 
		GetConVarNumber("cwTextColorA")
	);

	Clockwork.option:SetColor("basic_form_highlight", color);
	Clockwork.option:SetColor("basic_form_color", color);
	Clockwork.option:SetColor("scoreboard_name", color);
	Clockwork.option:SetColor("scoreboard_desc", color);
	Clockwork.option:SetColor("target_id", color);
end;

-- Called just before a bar is drawn.
function THEME.module:PreDrawBar(barInfo)
	if (barInfo.text) then
		barInfo.text = string.upper(barInfo.text);
	end;
end;

-- Called just after a bar is drawn.
function THEME.module:PostDrawBar(barInfo)
end;

-- Called when the menu is opened.
function THEME.module:MenuOpened()
	if (Clockwork.Client:HasInitialized() and Clockwork.config:Get("show_menu_blur"):Get()) then
		Clockwork.kernel:RegisterBackgroundBlur("MainMenu", SysTime());
	end;
end;

-- Called when the menu is closed.
function THEME.module:MenuClosed()
	if (Clockwork.Client:HasInitialized()) then
		Clockwork.kernel:RemoveBackgroundBlur("MainMenu");
	end;
end;

-- Called just before the weapon selection info is drawn.
function THEME.module:PreDrawWeaponSelectionInfo(info)
	THEME:DrawAtomicBorder(info)
	info.drawBackground = false;
end;

-- Called when the weapon list is drawn.
function THEME.module:DrawWeaponList(x, y, w, h, alpha, wepType)
	if (wepType == "current" and alpha) then
		local color = Clockwork.option:GetColor("information");
		
		Atomic.Draw:WeaponSelect(x, y, w, h, color);
	end;
end;

-- A function to draw a border.
function THEME:DrawAtomicBorder(info)
	local color = Clockwork.option:GetColor("information");
	local colorBlack = Color(10, 10, 10, 255);
	local colorDarker = Color(
		math.max(color.r - 130, 0),
		math.max(color.g - 130, 0),
		math.max(color.b - 130, 0),
		150
	);

--	draw.RoundedBox(0, info.x, info.y, info.width, info.height, colorDarker); --BACKGROUND--

	Atomic.Draw:SimpleBlurBox(info.x, info.y, info.width, info.height, colorDarker, 4);

	if (info.lines) then
		local colorDarkest = Color(
			math.max(color.r - 150, 0),
			math.max(color.g - 150, 0),
			math.max(color.b - 150, 0),
			180
		);

		for i = 1, (info.height / 4) - 2 do
			draw.RoundedBox(0, info.x, i * 4 + 5, info.width, 1, colorDarkest);
		end;
	end;
	
	DisableClipping(true);
		Atomic.Draw:ShadowedLine(info.x - 3, info.y + 1, info.width + 6, 2, color, "down");
		Atomic.Draw:ShadowedLine(info.x - 3, info.y + info.height - 3, info.width + 6, 2, color, "up");

		Atomic.Draw:ShadowedLine(info.x - 3, info.y + 3, 2, 12, color, "rightdown");
		Atomic.Draw:ShadowedLine(info.x + info.width + 1, info.y + 3, 2, 12, color, "leftdown");
		
		Atomic.Draw:ShadowedLine(info.x - 3, info.y + info.height - 15, 2, 12, color, "rightup");
		Atomic.Draw:ShadowedLine(info.x + info.width + 1, info.y + info.height - 15, 2, 12, color, "leftup");
	DisableClipping(false);
end;

-- Called just before the local player's information is drawn.
function THEME.module:PreDrawPlayerInfo(boxInfo, information, subInformation)
	THEME:DrawAtomicBorder(boxInfo);
	
	boxInfo.drawBackground = false;
end;

-- Called before the character's background blur is drawn.
function THEME.module:ShouldDrawCharacterBackgroundBlur()
	return Clockwork.config:Get("show_menu_blur"):Get();
end;

local PANEL = {};

-- Called every frame.
function PANEL:Think()
	if (self.animation) then
		self.animation:Run();
	end;
	
	local color = Clockwork.option:GetColor("information");
	local colorBlack = Color(0, 0, 0, 255);
	local colorDisabled = Color(
		math.max(color.r - 170, 0),
		math.max(color.g - 170, 0),
		math.max(color.b - 170, 0),
		255
	);

	if (self:IsHovered()) then
		self:SetTextColor(colorBlack);
	else
		if (self:GetDisabled()) then
			self:SetTextColor(self.OverrideColorHover or colorDisabled);
		else
			self:SetTextColor(self.OverrideColorNormal or color);
		end;
	end;
	
	self:SetExpensiveShadow(1, Color(0, 0, 0, 150));
end;

-- A function to set the panel's Callback.
function PANEL:SetCallback(Callback)
	self.DoClick = function(button)
		surface.PlaySound("atomic/pipboy_t3_press.wav");
		Callback(button);
	end;
end;

vgui.Register("cwMenuLblBtn", PANEL, "cwLabelButton");

-- Called before the character menu has initialized.
function THEME.hooks:PreCharacterMenuInit(panel)
	local smallTextFont = Clockwork.option:GetFont("menu_text_medium");
	local scrH = ScrH();
	local scrW = ScrW();

	local mainButtonX = ScrW() * 0.25;
	local mainButtonY = ScrH() * 0.4;
		
	panel:SetPos(0, 0);
	panel:SetSize(scrW, scrH);
	panel:SetDrawOnTop(false)
	panel:SetPaintBackground(false);
	panel:SetMouseInputEnabled(true);
			
	local schemaLogo = Clockwork.option:GetKey("schema_logo")
	
	panel.createButton = vgui.Create("cwMenuLblBtn", panel);
	panel.createButton:SetFont(smallTextFont);
	panel.createButton:SetText("NEW");
	panel.createButton:FadeIn(0.5);
	panel.createButton:SetCallback(function(panel)
		if (table.Count(Clockwork.character:GetAll()) >= Clockwork.player:GetMaximumCharacters()) then
			return Clockwork.character:SetFault("You cannot create any more characters!");
		end;
		
		Clockwork.character:ResetCreationInfo();
		Clockwork.character:OpenNextCreationPanel();
	end);
	panel.createButton:SizeToContents();
	panel.createButton:SetMouseInputEnabled(true);
	panel.createButton:SetPos(mainButtonX, mainButtonY);
	
	mainButtonY = mainButtonY + panel.createButton:GetTall();
		
	panel.loadButton = vgui.Create("cwMenuLblBtn", panel);
	panel.loadButton:SetFont(smallTextFont);
	panel.loadButton:SetText("LOAD");
	panel.loadButton:FadeIn(0.5);
	
	panel.loadButton:SetCallback(function(PANEL)
		panel:OpenPanel("cwCharacterList", nil, function(PANEL)
			Clockwork.character:RefreshPanelList();
		end);
	end);
	
	panel.loadButton:SizeToContents();
	panel.loadButton:SetMouseInputEnabled(true);
	panel.loadButton:SetPos(mainButtonX, mainButtonY);

	mainButtonY = mainButtonY + panel.createButton:GetTall();

	panel.aboutButton = vgui.Create("cwMenuLblBtn", panel);
	panel.aboutButton:SetFont(smallTextFont);
	panel.aboutButton:SetText("FORUMS");
	panel.aboutButton:SetAlpha(0);
	panel.aboutButton:FadeIn(1);
	
	panel.aboutButton:SetCallback(function(panel)
		gui.OpenURL(Clockwork.option:GetKey("menu_forum_url"));
	end);

	panel.aboutButton:SizeToContents();
	panel.aboutButton:SetMouseInputEnabled(true);
	panel.aboutButton:SetPos(mainButtonX, mainButtonY);

	mainButtonY = mainButtonY + panel.createButton:GetTall();

	panel.disconnectButton = vgui.Create("cwMenuLblBtn", panel);
	panel.disconnectButton:SetFont(smallTextFont);
	panel.disconnectButton:SetText("DISCONNECT");
	panel.disconnectButton:FadeIn(0.5);
	panel.disconnectButton:SetCallback(function(panel)
		if (Clockwork.Client:HasInitialized() and !Clockwork.character:IsMenuReset()) then
			Clockwork.character:SetPanelMainMenu();
			Clockwork.character:SetPanelOpen(false);
		else
			RunConsoleCommand("disconnect");
		end;
	end);
	panel.disconnectButton:SizeToContents();
	panel.disconnectButton:SetPos(mainButtonX, mainButtonY);
	panel.disconnectButton:SetMouseInputEnabled(true);
	
	panel.previousButton = vgui.Create("cwMenuLblBtn", panel);
	panel.previousButton:SetFont(smallTextFont);
	panel.previousButton:SetText("PREVIOUS");
	panel.previousButton:SetCallback(function(panel)
		if (!Clockwork.character:IsCreationProcessActive()) then
			local activePanel = Clockwork.character:GetActivePanel();
			
			if (activePanel and activePanel.OnPrevious) then
				activePanel:OnPrevious();
			end;
		else
			Clockwork.character:OpenPreviousCreationPanel()
		end;
	end);
	panel.previousButton:SizeToContents();
	panel.previousButton:SetMouseInputEnabled(true);
	panel.previousButton:SetPos((scrW * 0.2) - (panel.previousButton:GetWide() / 2), scrH * 0.9);
	
	panel.nextButton = vgui.Create("cwMenuLblBtn", panel);
	panel.nextButton:SetFont(smallTextFont);
	panel.nextButton:SetText("NEXT");
	panel.nextButton:SetCallback(function(panel)
		if (!Clockwork.character:IsCreationProcessActive()) then
			local activePanel = Clockwork.character:GetActivePanel();
			
			if (activePanel and activePanel.OnNext) then
				activePanel:OnNext();
			end;
		else
			Clockwork.character:OpenNextCreationPanel()
		end;
	end);
	panel.nextButton:SizeToContents();
	panel.nextButton:SetMouseInputEnabled(true);
	panel.nextButton:SetPos((scrW * 0.8) - (panel.nextButton:GetWide() / 2), scrH * 0.9);
	
	panel.cancelButton = vgui.Create("cwMenuLblBtn", panel);
	panel.cancelButton:SetFont(smallTextFont);
	panel.cancelButton:SetText("CANCEL");
	panel.cancelButton:SetCallback(function(PANEL)
		panel:ReturnToMainMenu();
	end);
	panel.cancelButton:SizeToContents();
	panel.cancelButton:SetMouseInputEnabled(true);
	panel.cancelButton:SetPos((scrW * 0.5) - (panel.cancelButton:GetWide() / 2), scrH * 0.9);
	
	panel.characterModel = vgui.Create("cwCharacterModel", panel);
	panel.characterModel:SetSize(512, 512);
	panel.characterModel:SetAlpha(0);
	panel.characterModel:SetModel("models/error.mdl");
	panel.createTime = SysTime();

	return true;
end;

-- Called after the character menu has initialized.
function THEME.hooks:PostCharacterMenuInit(panel) end;

-- Called before the character menu fades in its title elements.
function THEME.hooks:PreCharacterFadeInTitle(panel)
	panel.createButton:FadeIn(0.5)
	panel.loadButton:FadeIn(0.5)
	panel.aboutButton:FadeIn(0.5)
	panel.disconnectButton:FadeIn(0.5)

	return true;
end;

-- Called before the character menu fades out its title elements.
function THEME.hooks:PreCharacterFadeOutTitle(panel)
	panel.createButton:FadeOut(0.5)
	panel.loadButton:FadeOut(0.5)
	panel.aboutButton:FadeOut(0.5)
	panel.disconnectButton:FadeOut(0.5)

	return true;
end;

-- Called every frame that the character menu is open.
function THEME.hooks:PreCharacterMenuThink(panel)
	local characters = table.Count(Clockwork.character:GetAll());
	local bIsLoading = Clockwork.character:IsPanelLoading();
	local schemaLogo = Clockwork.option:GetKey("schema_logo");
	local activePanel = Clockwork.character:GetActivePanel();
	local fault = Clockwork.character:GetFault();
		
	if (Clockwork.plugin:Call("ShouldDrawCharacterBackgroundBlur")) then
		Clockwork.kernel:RegisterBackgroundBlur(panel, panel.createTime);
	else
		Clockwork.kernel:RemoveBackgroundBlur(panel);
	end;
		
	if (panel.characterModel) then
		if (!panel.characterModel.currentModel
		or panel.characterModel.currentModel == "models/error.mdl") then
			panel.characterModel:SetAlpha(0);
		end;
	end;
		
	if (!Clockwork.character:IsCreationProcessActive()) then
		if (activePanel) then
			if (activePanel.GetNextDisabled
			and activePanel:GetNextDisabled()) then
				panel.nextButton:SetDisabled(true);
			else
				panel.nextButton:SetDisabled(false);
			end;
				
			if (activePanel.GetPreviousDisabled
			and activePanel:GetPreviousDisabled()) then
				panel.previousButton:SetDisabled(true);
			else
				panel.previousButton:SetDisabled(false);
			end;
		end;
	else
		local previousPanelInfo = Clockwork.character:GetPreviousCreationPanel();
			
		if (previousPanelInfo) then
			panel.previousButton:SetDisabled(false);
		else
			panel.previousButton:SetDisabled(true);
		end;
			
		panel.nextButton:SetDisabled(false);
	end;
		
	if (characters == 0 or bIsLoading) then
		panel.loadButton:SetDisabled(true);
	else
		panel.loadButton:SetDisabled(false);
	end;
		
	if (characters >= Clockwork.player:GetMaximumCharacters()
	or Clockwork.character:IsPanelLoading()) then
		panel.createButton:SetDisabled(true);
	else
		panel.createButton:SetDisabled(false);
	end;

	if (LocalPlayer():HasInitialized() and !Clockwork.character:IsMenuReset()) then
		panel.disconnectButton:SetText("CANCEL");
		panel.disconnectButton:SizeToContents();
	else
		panel.disconnectButton:SetText("DISCONNECT");
		panel.disconnectButton:SizeToContents();
	--	panel.disconnectButton:SetPos(ScrW() * 0.70, ScrH() * 0.85);
	end;

	if (panel.animation) then
		panel.animation:Run();
	end;
		
	panel:SetSize(ScrW(), ScrH());

	return true;
end;

-- Called after the character menu is painted.
function THEME.hooks:PreCharacterMenuPaint(panel)
	local scrW = ScrW();
	local schemaLogo = Clockwork.option:GetKey("schema_logo");
	local subLabelAlpha = panel.createButton:GetAlpha();
	local color = Clockwork.option:GetColor("information");
	local curTime = CurTime();
	local communityLogo = Clockwork.option:GetKey("community_logo");
		
	if (subLabelAlpha > 0) then
		if (schemaLogo != "") then
			if (!panel.logoTextureID) then
				panel.logoTextureID = Material(schemaLogo..".png");
			end;

			panel.logoTextureID:SetFloat("$alpha", subLabelAlpha);

			surface.SetDrawColor(color.r, color.g, color.b, subLabelAlpha - 70);
			surface.SetMaterial(panel.logoTextureID);
			surface.DrawTexturedRect((scrW * 0.55 - 256), ScrH() * 0.35, 512, 256);

			if (schemaLogo == "atomic/atomic_logo_2") then
				if (!panel.neon) then
					panel.neon = Material("atomic/atomic_logo_neon.png");
				end;

				local neonAlpha = math.abs(math.sin(curTime) * 255);

				if (!panel.nextFlicker or panel.nextFlicker <= curTime) then
					panel.canFlicker = curTime + math.random();
				end;

				if (panel.nextFlicker and panel.nextFlicker >= curTime) then
					if (panel.canFlicker and panel.canFlicker <= curTime) then
						neonAlpha = 0;

						if (!panel.sparkPlayed) then
							surface.PlaySound("ambient/energy/spark"..math.random(1, 4)..".wav");

							panel.sparkPlayed = true;
						end;
					else
						panel.nextFlicker = curTime + math.random(0.1, 3);

						panel.sparkPlayed = nil;
					end;
				else
					panel.nextFlicker = curTime + math.random(0.1, 3);
				end;

				surface.SetDrawColor(255, 255, 255, math.min(subLabelAlpha, 255 - neonAlpha));
				surface.SetMaterial(panel.neon);
				surface.DrawTexturedRect((scrW * 0.55 - 256), ScrH() * 0.35, 512, 256);
			end;
		end;			

		if (!panel.c16) then
			panel.c16 = Material("atomic/c16_logo.png");
		end;

		if (!panel.community) then
			panel.community = Material(communityLogo..".png");				
		end;
			
		if (communityLogo != "") then
			surface.SetDrawColor(color.r, color.g, color.b, subLabelAlpha - 70);
			surface.SetMaterial(panel.community);
			surface.DrawTexturedRect(60, ScrH() - 366, 256, 256);
		end;

		surface.SetDrawColor(color.r, color.g, color.b, subLabelAlpha - 70);
		surface.SetMaterial(panel.c16);
		surface.DrawTexturedRect(60, ScrH() - 110, 256, 80);
	end;
		
	local x, y = panel:CursorPos();
	local canPlay = panel.canPlay;
	local boxX, boxY, boxW, boxH;

	if (subLabelAlpha == 255) then
		THEME:DrawAtomicBorder({
			x = panel.createButton.x - 30,
			y = panel.createButton.y - 30,
			width = 240,
			height = 400
		});

		if (x >= panel.createButton.x and x <= panel.createButton.x + panel.createButton:GetWide()
		and y >= panel.createButton.y and y <= panel.createButton.y + panel.createButton:GetTall()) then
			boxX = panel.createButton.x;
			boxY = panel.createButton.y;
			boxW = panel.createButton:GetWide();
			boxH = panel.createButton:GetTall();

			panel.canPlay = 1;
		elseif (x >= panel.loadButton.x and x <= panel.loadButton.x + panel.loadButton:GetWide()
		and y >= panel.loadButton.y and y <= panel.loadButton.y + panel.loadButton:GetTall()) then
			boxX = panel.loadButton.x;
			boxY = panel.loadButton.y;
			boxW = panel.loadButton:GetWide();
			boxH = panel.loadButton:GetTall();

			panel.canPlay = 2;
		elseif (x >= panel.aboutButton.x and x <= panel.aboutButton.x + panel.aboutButton:GetWide()
		and y >= panel.aboutButton.y and y <= panel.aboutButton.y + panel.aboutButton:GetTall()) then
			boxX = panel.aboutButton.x;
			boxY = panel.aboutButton.y;
			boxW = panel.aboutButton:GetWide();
			boxH = panel.aboutButton:GetTall();

			panel.canPlay = 3;
		elseif (x >= panel.disconnectButton.x and x <= panel.disconnectButton.x + panel.disconnectButton:GetWide()
		and y >= panel.disconnectButton.y and y <= panel.disconnectButton.y + panel.disconnectButton:GetTall()) then
			boxX = panel.disconnectButton.x;
			boxY = panel.disconnectButton.y;
			boxW = panel.disconnectButton:GetWide();
			boxH = panel.disconnectButton:GetTall();	

			panel.canPlay = 4;
		else
			panel.canPlay = nil
		end;
	elseif (panel.previousButton:GetAlpha() == 255) then
		if (x >= panel.previousButton.x and x <= panel.previousButton.x + panel.previousButton:GetWide()
		and y >= panel.previousButton.y and y <= panel.previousButton.y + panel.previousButton:GetTall()) then
			boxX = panel.previousButton.x;
			boxY = panel.previousButton.y;
			boxW = panel.previousButton:GetWide();
			boxH = panel.previousButton:GetTall();	

			panel.canPlay = 5;
		elseif (x >= panel.cancelButton.x and x <= panel.cancelButton.x + panel.cancelButton:GetWide()
		and y >= panel.cancelButton.y and y <= panel.cancelButton.y + panel.cancelButton:GetTall()) then
			boxX = panel.cancelButton.x;
			boxY = panel.cancelButton.y;
			boxW = panel.cancelButton:GetWide();
			boxH = panel.cancelButton:GetTall();	

			panel.canPlay = 6;
		elseif (x >= panel.nextButton.x and x <= panel.nextButton.x + panel.nextButton:GetWide()
		and y >= panel.nextButton.y and y <= panel.nextButton.y + panel.nextButton:GetTall()) then
			boxX = panel.nextButton.x;
			boxY = panel.nextButton.y;
			boxW = panel.nextButton:GetWide();
			boxH = panel.nextButton:GetTall();	

			panel.canPlay = 7;
		else
			panel.canPlay = nil
		end;
	end;

	if (boxX and boxX != nil) then
		boxX = boxX - 10;
		boxW = boxW + 20;

		surface.SetDrawColor(color.r, color.g, color.b, 255);

		if (panel.canPlay > 4) then
			surface.DrawRect(boxX, boxY, boxW, boxH);
		else
			surface.DrawRect(panel.createButton.x - 20, boxY, 220, boxH);
		end;
	end;
		
	if (panel.canPlay and canPlay != panel.canPlay) then
		surface.PlaySound("atomic/pipboy_rollover.wav");
	end;

	return true;
end;

-- Called after a character menu panel is opened.
function THEME.hooks:PostCharacterMenuOpenPanel(panel) end;

-- Called after the main menu has initialized.
function THEME.hooks:PostMainMenuInit(panel) end;

-- Called after the main menu is rebuilt.
function THEME.hooks:PostMainMenuRebuild(panel) end;

-- Called after a main menu panel is opened.
function THEME.hooks:PostMainMenuOpenPanel(panel, panelToOpen) end;

-- Called after the main menu is painted.
function THEME.hooks:PostMainMenuPaint(panel)
	for k, v in pairs(Clockwork.menu:GetItems()) do
		if (IsValid(v.button)) then
			local activePanel = Clockwork.menu:GetActivePanel();
			local offset = -5;
			
			if (v.button.Icon) then
				offset = 35;
				v.button.Icon:SetImageColor(Clockwork.option:GetColor("information"));				
			end;

			if (v.button.LabelButton:GetHovered() or activePanel == v.panel) then
				THEME:DrawAtomicBorder({
					x = v.button.x + offset,
					y = v.button.y - 5,
					width = v.button.LabelButton:GetWide() + 10,
					height = v.button.LabelButton:GetTall() + 10
				});
			end;
		end;
	end;
end;

-- Called every frame that the main menu is open.
function THEME.hooks:PostMainMenuThink(panel) end;

Clockwork.theme:HookReplace("cwScoreboard", "Paint", function(PANEL, w, h)
	THEME:DrawAtomicBorder({
		x = 0,
		y = 0,
		width = w,
		height = h
	});

	return true;
end);

Clockwork.theme:HookReplace("cwAttributes", "Paint", function(PANEL, w, h)
	THEME:DrawAtomicBorder({
		x = 0,
		y = 0,
		width = w,
		height = h
	});

	return true;
end);

Clockwork.theme:HookReplace("cwSettings", "Paint", function(PANEL, w, h)
	THEME:DrawAtomicBorder({
		x = 0,
		y = 0,
		width = w,
		height = h
	});

	return true;
end);

Clockwork.theme:HookAfter("cwInventory", "Init", function(PANEL)
	PANEL.inventoryList:SetPadding(10);
 	PANEL.inventoryList:SetSpacing(8);
 	PANEL.equipmentList:SetPadding(10);
 	PANEL.equipmentList:SetSpacing(8);

	function PANEL.inventoryList.Paint(invList, w, h)
		THEME:DrawAtomicBorder({
			x = 0,
			y = 0,
			width = w,
			height = h
		});

		return true;
	end;

	function PANEL.equipmentList.Paint(invList, w, h)
		THEME:DrawAtomicBorder({
			x = 0,
			y = 0,
			width = w,
			height = h
		});

		return true;
	end;
end);

local PANEL = {};

-- A function to add a new sheet.
function PANEL:AddSheet(label, panel, material)
	if (!IsValid(panel)) then
		return;
	end;
	
	local newSheet = {};
	
	if (self.ButtonOnly) then
		newSheet.Button = vgui.Create("DImageButton", self.Navigation);
		newSheet.Button:Dock(TOP);
		newSheet.Button:DockMargin(0, 1, 0, 0);
	else
		newSheet.Button = vgui.Create("cwIconButton", self.Navigation);
		
		local size = Clockwork.fonts:GetSize(Clockwork.option:GetFont("menu_text_tiny"), 20);
	
		newSheet.Button:SetTall(32);
		newSheet.Button:Dock(TOP);
		newSheet.Button:DockMargin(0, 0, 0, 8);
		newSheet.Button:SetFont(size);
		
		newSheet.Button.Paint = function(sheet, w, h)
			local color = Clockwork.option:GetColor("information");

			sheet:SetColor(color);
			sheet:SetExpensiveShadow(1, color);
		end;
	end;
	
	newSheet.Button:SetImage(material);
	newSheet.Button.Target = panel;
	newSheet.Button:SetText(label);
	newSheet.Button.DoClick = function()
		self:SetActiveButton(newSheet.Button)
	end;
	
	newSheet.Panel = panel;
	newSheet.Panel:SetParent(self.Content);
	newSheet.Panel:SetVisible(false);
	
	if (self.ButtonOnly) then
		newSheet.Button:SizeToContents();
	end;
	
	table.insert(self.Items, newSheet)
	
	if (!IsValid(self.ActiveButton)) then
		self:SetActiveButton(newSheet.Button);
	end;
end;

-- A function to set the active button.
function PANEL:SetActiveButton(active)
	if (self.ActiveButton == active) then
		return;
	end;
	
	if (self.ActiveButton && self.ActiveButton.Target) then	
		self.ActiveButton.Target:SetVisible(false)
		self.ActiveButton:SetSelected(false)

		self.ActiveButton.Paint = function(sheet, w, h)
			local color = Clockwork.option:GetColor("information");

			sheet:SetColor(color);
			sheet:SetExpensiveShadow(1, color);
		end;
	end;

	self.ActiveButton = active;
	
	active.Target:SetVisible(true);
	active:SetSelected(true);

	active.Paint = function(sheet, w, h)
		local color = Clockwork.option:GetColor("information");

		surface.SetDrawColor(color.r, color.g, color.b, 50);
		surface.DrawRect(0, 0, w, h);

		surface.SetDrawColor(color.r, color.g, color.b, alpha);

		for i= 0, 2 do
			surface.DrawOutlinedRect(i, i, w - i * 2, h - i * 2);
		end;

		sheet:SetColor(color);
		sheet:SetExpensiveShadow(1, color);
	end;
	
	self.Content:InvalidateLayout();
end
	
vgui.Register("cwColumnSheet", PANEL, "DColumnSheet");

THEME.skin.frameBorder = Color(255, 255, 255, 255);
THEME.skin.frameTitle = Color(255, 255, 255, 255);

THEME.skin.bgColorBright = Color(255, 255, 255, 255);
THEME.skin.bgColorSleep = Color(70, 70, 70, 255);
THEME.skin.bgColorDark = Color(50, 50, 50, 255);
THEME.skin.bgColor = Color(40, 40, 40, 225);

THEME.skin.controlColorHighlight = Color(70, 70, 70, 255);
THEME.skin.controlColorActive = Color(175, 175, 175, 255);
THEME.skin.controlColorBright = Color(100, 100, 100, 255);
THEME.skin.controlColorDark = Color(30, 30, 30, 255);
THEME.skin.controlColor = Color(60, 60, 60, 255);

THEME.skin.colPropertySheet = Color(255, 255, 255, 255);
THEME.skin.colTabTextInactive = Color(0, 0, 0, 255);
THEME.skin.colTabInactive = Color(255, 255, 255, 255);
THEME.skin.colTabShadow = Color(0, 0, 0, 170);
THEME.skin.colTabText = Color(255, 255, 255, 255);
THEME.skin.colTab = Color(0, 0, 0, 255);

THEME.skin.fontCategoryHeader = "ato_MainText";
THEME.skin.fontMenuOption = "ato_MainText";
THEME.skin.fontFormLabel = "ato_MainText";
THEME.skin.fontButton = "ato_MainText";
THEME.skin.fontFrame = "ato_MainText";
THEME.skin.fontTab = "ato_MainText";

-- A function to draw a generic background.
function THEME.skin:DrawGenericBackground(x, y, w, h, color)
	surface.SetDrawColor(color);
	surface.DrawRect(x, y, w, h);
end;

-- Called when a frame is layed out.
function THEME.skin:LayoutFrame(panel)
	panel.lblTitle:SetFont(self.fontFrame);
	panel.lblTitle:SetText(panel.lblTitle:GetText():upper());
	panel.lblTitle:SetTextColor(Color(0, 0, 0, 255));
	panel.lblTitle:SizeToContents();
	panel.lblTitle:SetExpensiveShadow(nil);
	
	panel.btnClose:SetDrawBackground(true);
	panel.btnClose:SetPos(panel:GetWide() - 22, 2);
	panel.btnClose:SetSize(18, 18);
	panel.lblTitle:SetPos(8, 2);
	panel.lblTitle:SetSize(panel:GetWide() - 25, 20);
end;

-- Called when a form is schemed.
function THEME.skin:SchemeForm(panel)
	panel.Label:SetFont(self.fontFormLabel);
	panel.Label:SetText(panel.Label:GetText():upper());
	panel.Label:SetTextColor(Color(255, 255, 255, 255));
	panel.Label:SetExpensiveShadow(1, Color(0, 0, 0, 200));
end;

-- Called when a tab is painted.
function THEME.skin:PaintTab(panel)
	if (panel:GetPropertySheet():GetActiveTab() == panel) then
		self:DrawGenericBackground(1, 1, panel:GetWide() - 2, panel:GetTall() + 8, self.colTab);
	else
		self:DrawGenericBackground(1, 2, panel:GetWide() - 2, panel:GetTall() + 8, self.colTabInactive);
	end;
end;

-- Called when a list view is painted.
function THEME.skin:PaintListView(panel)
	if (panel.m_bBackground) then
		surface.SetDrawColor(255, 255, 255, 255);
		panel:DrawFilledRect();
	end;
end;
	
-- Called when a list view line is painted.
function THEME.skin:PaintListViewLine(panel)
	local color = Color(50, 50, 50, 255);
	local textColor = Color(255, 255, 255, 255);
	
	if (panel:IsSelected()) then
		color = Color(255, 255, 255, 255);
		textColor = Color(0, 0, 0, 255);
	elseif (panel.Hovered) then
		color = Color(100, 100, 100, 255);
	elseif (panel.m_bAlt) then
		color = Color(75, 75, 75, 255);
	end;
	
	for k, v in pairs(panel.Columns) do
		v:SetTextColor(textColor);
	end;
 
	surface.SetDrawColor(color.r, color.g, color.b, color.a);
	surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall());
end;

-- Called when a list view label is schemed.
function THEME.skin:SchemeListViewLabel(panel)
	panel:SetTextInset(3);
	panel:SetTextColor(Color(255, 255, 255, 255));
end;

-- Called when a menu is painted.
function THEME.skin:PaintMenu(panel)
	surface.SetDrawColor(Color(0, 0, 0, 255));
	panel:DrawFilledRect(0, 0, w, h);
end;

-- Called when a menu is painted over.
function THEME.skin:PaintOverMenu(panel) end;

-- Called when a menu option is schemed.
function THEME.skin:SchemeMenuOption(panel)
	panel:SetFGColor(255, 255, 255, 255);
end;

-- Called when a menu option is painted.
function THEME.skin:PaintMenuOption(panel)
	local textColor = Color(255, 255, 255, 255);
	
	if (panel.m_bBackground and panel.Hovered) then
		local color = nil;

		if (panel.Depressed) then
			color = Color(225, 225, 225, 255);
		else
			color = Color(255, 255, 255, 255);
		end;

		surface.SetDrawColor(color.r, color.g, color.b, color.a);
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall());
		
		textColor = Color(0, 0, 0, 255);
	end;
	
	panel:SetFGColor(textColor);
end;

-- Called when a menu option is layed out.
function THEME.skin:LayoutMenuOption(panel)
	panel:SetFont(self.fontMenuOption);
	panel:SizeToContents();
	panel:SetWide(panel:GetWide() + 30);
	panel:SetSize(math.max(panel:GetParent():GetWide(), panel:GetWide()), 18);
	
	if (panel.SubMenuArrow) then
		panel.SubMenuArrow:SetSize(panel:GetTall(), panel:GetTall());
		panel.SubMenuArrow:CenterVertical();
		panel.SubMenuArrow:AlignRight();
	end;
end;

-- Called when a button is painted.
function THEME.skin:PaintButton(panel)
	local w, h = panel:GetSize();
	local textColor = Color(255, 255, 255, 255);
	
	if (panel.m_bBackground) then
		local color = Color(0, 0, 0, 255);
		local borderColor = Color(255, 255, 255, 255);
		
		if (panel:GetDisabled()) then
			color = self.controlColorDark;
		elseif (panel.Depressed or panel:GetSelected()) then
			color = Color(255, 255, 255, 255);
			textColor = Color(0, 0, 0, 255);
		elseif (panel.Hovered) then
			color = self.controlColorHighlight;
		end;

		self:DrawGenericBackground(0, 0, w, h, borderColor);
		self:DrawGenericBackground(1, 1, w - 2, h - 2, color);
	end;
	
	panel:SetFGColor(textColor);
end;

-- Called when a scroll bar grip is painted.
function THEME.skin:PaintScrollBarGrip(panel)
	local w, h = panel:GetSize();
	local color = Color(255, 255, 255, 255);

	self:DrawGenericBackground(0, 0, w, h, color);
	self:DrawGenericBackground(2, 2, w - 4, h - 4, Color(0, 0, 0, 255));
end;

Clockwork.theme:Finish(THEME);