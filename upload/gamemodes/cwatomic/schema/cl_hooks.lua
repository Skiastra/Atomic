--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local surface = surface;
local gradMat = Material("atomic/hud/line/fade_to_top.png");
local MAT_UP = Material("atomic/hud/arrow_up.png");
local MAT_DOWN = Material("atomic/hud/arrow_down.png");
local cursorMat = Material("srp/fnv/cursor.png");

--[[ 
	Draw the custom cursor. This NEEDS to be drawn after everything else, so the
	cursor will draw over other elements and not be drawn under them.
--]]
function Atomic:PostRenderVGUI()
	if (vgui.CursorVisible() and !(gui.IsGameUIVisible() or gui.IsConsoleVisible() or system.IsOSX())) then -- Sorry Mac users :/
		local hoverPanel = vgui.GetHoveredPanel();

		if (hoverPanel) then
			hoverPanel:SetCursor("blank");
		end;

		local x, y = input.GetCursorPos();
		local w, h = 32, 32;

		surface.SetDrawColor(Clockwork.option:GetColor("information"));
		surface.SetMaterial(cursorMat);
		surface.DrawTexturedRect(x - 4, y - 2, w, h);
	end;
end;

-- This is for drawing our custom menu.
function Atomic:PreRender()
	local isVisible = gui.IsGameUIVisible();

	if (gui.IsConsoleVisible()) then
		self.showDefaultMenu = true;
	end;

	if (self.showDefaultMenu and !isVisible and !self.delayCheck) then
		self.showDefaultMenu = false;
	end;

	if (isVisible and self.delayCheck) then
		self.delayCheck = nil;
	end;

	if (isVisible and !self.showDefaultMenu) then
		gui.HideGameUI();

		if (self.pauseUI) then
			self.pauseUI:Remove();
			self.pauseUI = nil;
		else
			self.pauseUI = vgui.Create("FNVMainMenu");
			self.pauseUI:MakePopup();
		end;
	end;
end;

-- Called when the menu's items should be destroyed.
function Atomic:MenuItemsDestroy(menuItems)
	menuItems:Destroy("Business");
	menuItems:Destroy("Community");
	menuItems:Destroy("Plugin Center");
end;

-- Called when the menu's items should be destroyed.
function Atomic:MenuItemsAdd(menuItems)
	if (Clockwork.config:Get("enable_special"):Get()) then
		menuItems:Add("SPECIAL", "cwSpecial", "View your current SPECIAL stats.", Clockwork.option:GetKey("icon_data_special"));
	end;

	if (#Clockwork.Client:GetPerks() > 0) then
		menuItems:Add("PERKS", "cwPerks", "View your current perks.", Clockwork.option:GetKey("icon_data_perks"));
	end;
end;
	
local checkList = {
	p = true,
	e = true,
	t = true,
	o = true, -- o, a, s are admin flags, so we're also checking if they're admin.
	a = true,
	s = true
};

-- Called when the player attempts to open the spawn menu.
function Atomic:SpawnMenuOpen()
	for k, v in pairs(checkList) do
		if (Clockwork.player:HasFlags(Clockwork.Client, k)) then
			return true;
		end;
	end;

	return false;
end;

-- Called when a player's scoreboard options are needed.
function Atomic:GetPlayerScoreboardOptions(player, options, menu)
	if (Clockwork.command:FindByID("CharSetCustomClass") != nil) then
		if ( Clockwork.player:HasFlags(Clockwork.Client, Clockwork.command:FindByID("CharSetCustomClass").access) ) then
			options["Custom Class"] = {};
			options["Custom Class"]["Set"] = function()
				Derma_StringRequest(player:Name(), "What would you like to set their custom class to?", player:GetSharedVar("customClass"), function(text)
					Clockwork.kernel:RunCommand("CharSetCustomClass", player:Name(), text);
				end);
			end;
			
			if (player:GetSharedVar("customClass") != "") then
				options["Custom Class"]["Take"] = function()
					Clockwork.kernel:RunCommand( "CharTakeCustomClass", player:Name() );
				end;
			end;
		end;
	end;
end;

-- Called when a player's scoreboard class is needed.
function Atomic:GetPlayerScoreboardClass(player)
	local customClass = player:GetSharedVar("customClass");
	
	if (customClass != "") then
		return customClass;
	end;
end;

-- Called when the local player's character screen faction is needed.
function Atomic:GetPlayerCharacterScreenFaction(character)
	if (character.customClass and character.customClass != "") then
		return character.customClass;
	end;
end;

-- Called when the local player's default color modify should be set.
function Atomic:PlayerSetDefaultColorModify(colorModify)
	colorModify["$pp_colour_brightness"] = -0.02;
	colorModify["$pp_colour_contrast"] = 1.1;
	colorModify["$pp_colour_colour"] = 0.6;
end;

-- Called when the local player's color modify should be changed.
function Atomic:PlayerAdjustColorModify(colorModify)
	if (!Clockwork.kernel:IsChoosingCharacter()) then
		local health = Clockwork.Client:Health();
		local maxHealth = Clockwork.Client:GetMaxHealth();
		local bright = (1 - (health / maxHealth)) * 0.1;

		colorModify["$pp_colour_colour"] = (health / maxHealth) * 0.6;
		colorModify["$pp_colour_brightness"] = -0.02 - bright;
	end;
end;

-- Called when the schema initializes.
function Atomic:Initialize()
	CW_CONVAR_PRIMARYHUD = Clockwork.kernel:CreateClientConVar("cwPrimaryHUD", 1, true, true);

	if (CW_CONVAR_PRIMARYHUD:GetInt() == 1) then
		Clockwork.chatBox:SetCustomPosition(50, ScrH() - 200);
	end;
end;

-- Called when a ConVar has changed.
function Atomic:ClockworkConVarChanged()
	if (CW_CONVAR_PRIMARYHUD:GetInt() == 1) then
		Clockwork.chatBox:SetCustomPosition(50, ScrH() - 200);
	else
		Clockwork.chatBox:ResetCustomPosition();
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

-- Called when an entity's target ID HUD should be painted.
function Atomic:HUDPaintEntityTargetID(entity, info)
	local infoColor = Clockwork.option:GetColor("information");
	local color = Color(infoColor.r, infoColor.g, infoColor.b, info.alpha);
	
	if (entity:GetClass() == "prop_physics") then
		local physDesc = entity:GetNetworkedString("physDesc");
		
		if (physDesc != "") then
			info.y = Clockwork.kernel:DrawInfo(physDesc, info.x, info.y, color, info.alpha);
		end;
	end;
end;

-- Called before the item entity's target ID is drawn. Return false to stop default draw.
function Atomic:PaintItemTargetID(x, y, alpha, itemTable)
	local trace = Clockwork.Client:GetEyeTraceNoCursor();
	local entity = trace.Entity;

	if (entity and entity:NearestPoint(trace.StartPos):Distance(trace.StartPos) <= 80) then
		Atomic:DrawInfoUI(itemTable("name"), "WG", itemTable("weight"), "VAL", itemTable("cost"), alpha);
	end;

	return false;
end;

-- Called when the salesman's target ID is painted.
function Atomic:SalesmanTargetID(entity, x, y, alpha)
	local trace = Clockwork.Client:GetEyeTraceNoCursor();

	if (entity and entity:NearestPoint(trace.StartPos):Distance(trace.StartPos) <= 80) then
		local physDesc = entity:GetNetworkedString("PhysDesc");
		local name = entity:GetNetworkedString("Name");
		local color = Clockwork.option:GetColor("information");

		Clockwork.plugin:Call("DrawInfoUI", name);
		Clockwork.plugin:Call("DrawUseUI", "Talk", color);
	end;

	return false;
end;

-- Called to draw the player's crosshair.
function Atomic:DrawPlayerCrosshair(x, y, color)
	return false;
end;

function Atomic:IsFactionFriendly(fac1, fac2)
	if (fac1 == fac2) then return true; end;
	if (!fac1 or !fac2 or !fac1.friendlyFactions or !fac2.friendlyFactions) then return false; end;
	if (fac1.name == "Raider" or fac2.name == "Raider") then return false; end;
		
	local one, two = false, false;
		
	for k, v in pairs(fac1.friendlyFactions) do
		if (v == fac2.name) then
			one = true;
		end;
	end;
		
	for k, v in pairs(fac2.friendlyFactions) do
		if (v == fac1.name) then
			two = true;
		end;
	end;
		
	if (one or two) then
		return true;
	end;
		
	return false;
end;

function Atomic:GetRadarTable()
	local trace = LocalPlayer():GetEyeTraceNoCursor();
	local entTable = ents.FindInCone(trace.StartPos, trace.Normal, 1024, 0);
	local radarTable = {};

	for k, v in pairs(entTable) do
		if (v:IsValid() and v != Clockwork.Client) then
			if (Atomic:CanSeeBlip(v)) then
				local entry = {ent = v, color = Clockwork.option:GetColor("information")};

				if (v:IsPlayer()) then
					local bIsFriendly = self:IsFactionFriendly(Clockwork.faction:FindByID(v:GetFaction()), Clockwork.faction:FindByID(Clockwork.Client:GetFaction()));
									
					if (!bIsFriendly) then entry.color = Color(240, 70, 20, 255); end;
				else
					if (!v.radarColor) then
						Clockwork.datastream:Request("GetEntityRelationship", {v:GetClass(), Clockwork.Client:Name()}, function(data)
							if (data == 1) then v.radarColor = Color(240, 70, 20, 255); entry.color = v.radarColor; end;
						end);
					else
						entry.color = v.radarColor;
					end;
				end;

				table.insert(radarTable, entry);
			end;
		end;
	end;

	return radarTable;
end;

-- A function to draw the HUD.
function Atomic:DrawPrimaryHUD(color, found, nextFind)
	local w, h = ScrW(), ScrH();
	local colorDark = Color(
		math.max(color.r - 30, 0),
		math.max(color.g - 30, 0),
		math.max(color.b - 30, 0),
		255
	);
	local colorDarker = Color(
		math.max(color.r - 110, 0),
		math.max(color.g - 110, 0),
		math.max(color.b - 110, 0),
		100
	);
	local colorBlack = Color(0, 0, 0, 255);

	-- Health
	if (Clockwork.Client:Health() < Clockwork.Client:GetMaxHealth()) then
		local x = 150;

		Atomic.Draw:Bar(x + 2, h - 90, Clockwork.Client:Health(), Clockwork.Client:GetMaxHealth(), colorBlack, {width = w / 6, height = 13});
		Atomic.Draw:Bar(x, h - 90, Clockwork.Client:Health(), Clockwork.Client:GetMaxHealth(), color, {width = w / 6, height = 11});

		surface.SetFont(Clockwork.option:GetFont("prim_hud_text"));

		surface.SetTextColor(colorBlack);
		surface.SetTextPos(x - 48, h - 100);
		surface.DrawText("HP");
		surface.SetTextColor(color);
		surface.SetTextPos(x - 50, h - 102);
		surface.DrawText("HP");
	end;
				
	if (Clockwork.Client:Armor() > 0) then
		local x = 150;

		-- Stamina
		local armorHeight = h - 90;

		if (Clockwork.Client:Health() < Clockwork.Client:GetMaxHealth()) then
			armorHeight = h - 140;
		end;

		Atomic.Draw:Bar(x + 2, armorHeight, Clockwork.Client:Armor(), 100, colorBlack, {width = w / 6, height = 13});
		Atomic.Draw:Bar(x, armorHeight, Clockwork.Client:Armor(), 100, color, {width = w / 6, height = 11});

		surface.SetFont(Clockwork.option:GetFont("prim_hud_text"));

		surface.SetTextColor(colorBlack);
		surface.SetTextPos(x - 48, armorHeight - 10);
		surface.DrawText("AP");
		surface.SetTextColor(color);
		surface.SetTextPos(x - 50, armorHeight - 12);
		surface.DrawText("AP");
	end;

	if (Clockwork.Client:Crouching()) then
		Atomic.Draw:WeaponSelect(ScrW()/2 - 75, ScrH() * 0.17 + 6, 150, 25, color, true)

		draw.SimpleText("SNEAK", Clockwork.option:GetFont("prim_hud_text_small"), (ScrW() / 2) + 2, (ScrH() * 0.165) + 5, colorBlack, TEXT_ALIGN_CENTER);
		draw.SimpleText("SNEAK", Clockwork.option:GetFont("prim_hud_text_small"), ScrW() / 2, (ScrH() * 0.165) + 3, color, TEXT_ALIGN_CENTER);
	end;
			
	if (Clockwork.plugin:Call("CanDrawHUD", "Crosshair")) then
		local info = {
			x = w / 2, 
			y = h / 2
		};

		Clockwork.plugin:Call("GetPlayerCrosshairInfo", info);

		if (Atomic.crosshairFill) then
			--Top Left
			Atomic.Draw:ShadowedLine(info.x - 26, info.y - 27, 2, 16, color, "rightup");
			Atomic.Draw:ShadowedLine(info.x - 24, info.y - 27, 14, 2, color, "down");
			
			--Bottom Left
			Atomic.Draw:ShadowedLine(info.x - 26 , info.y + 15, 2, 14, color, "right");
			Atomic.Draw:ShadowedLine(info.x - 26, info.y + 27, 16, 2, color, "down");

			-- Top Right
			Atomic.Draw:ShadowedLine(info.x + 12, info.y - 27, 14, 2, color, "down"); --Horizontal
			Atomic.Draw:ShadowedLine(info.x + 26 , info.y - 27, 2, 16, color, "rightup"); --Vertical

			-- Bottom Right
			Atomic.Draw:ShadowedLine(info.x + 12, info.y + 27, 16, 2, color, "down");
			Atomic.Draw:ShadowedLine(info.x + 26, info.y + 15, 2, 14, color, "right");
		elseif (Clockwork.player:GetWeaponRaised(Clockwork.Client)) then
			-- Left
			Atomic.Draw:ShadowedLine(info.x - 12, info.y - 2, 8, 2, color, "down");
			-- Right
			Atomic.Draw:ShadowedLine(info.x + 4, info.y - 2, 8, 2, color, "down");
			-- Top
			Atomic.Draw:ShadowedLine(info.x - 1 , info.y - 12, 2, 8, color, "rightup");
			-- Bottom
			Atomic.Draw:ShadowedLine(info.x - 1 , info.y + 2, 2, 8, color, "right");
		else
			Atomic.Draw:ShadowedLine(info.x - 2, info.y - 2, 4, 4, color, "down");
		end;

		Atomic.crosshairFill = false;
	end;
				
	-- Compass
	local compPart = Clockwork.Client:GetAngles().y;

	if (compPart < 0) then
		compPart = (180 + compPart) + 180;
	end;

	local compDivide = 4.3;
	local compW = (w / compDivide);
	local compX = w / 2 - compW / 2;

	surface.SetDrawColor(colorDarker);
	surface.SetMaterial(gradMat);
	surface.DrawTexturedRect(compX, h - 105, compW + 2, 30);

	Atomic.Draw:Box(compX, h - 78, compW + 4, 5, colorBlack);
	Atomic.Draw:Box(compX, h - 88, 5, 12, colorBlack);
	Atomic.Draw:Box(compX + compW, h - 88, 5, 12, colorBlack);
			
	-- , 180, 90, 270
	local north = Atomic.Draw:AngleToRelative2D(compPart, compW, 1);
	local west = Atomic.Draw:AngleToRelative2D(compPart, compW, 2);
	local south = Atomic.Draw:AngleToRelative2D(compPart, compW, 3);
	local east = Atomic.Draw:AngleToRelative2D(compPart, compW, 4);

	surface.SetFont(Clockwork.option:GetFont("prim_hud_text_small"));
	
	if (compX + north > compX and compX + north < compX + compW) then
		Atomic.Draw:Box(compX + north, h - 78, 5, 16, colorBlack)
		Atomic.Draw:Box(compX + north, h - 78, 3, 15, color)
		surface.SetTextPos(compX + north - 4, h - 64);
		surface.SetTextColor(colorBlack);
		surface.DrawText("N");
		surface.SetTextPos(compX + north - 6, h - 66);
		surface.SetTextColor(color);
		surface.DrawText("N");
	end;

	if (compX + west > compX and compX + west < compX + compW) then
		Atomic.Draw:Box(compX + west, h - 78, 5, 16, colorBlack)
		Atomic.Draw:Box(compX + west, h - 78, 3, 15, color)
		surface.SetTextPos(compX + west - 5, h - 64);
		surface.SetTextColor(colorBlack);
		surface.DrawText("W");
		surface.SetTextPos(compX + west - 7, h - 66);
		surface.SetTextColor(color);
		surface.DrawText("W");
	end;

	if (compX + south > compX and compX + south < compX + compW) then
		Atomic.Draw:Box(compX + south, h - 78, 5, 16, colorBlack)
		Atomic.Draw:Box(compX + south, h - 78, 3, 15, color)
		surface.SetTextPos(compX + south - 3, h - 64);
		surface.SetTextColor(colorBlack);
		surface.DrawText("S");
		surface.SetTextPos(compX + south - 5, h - 66);
		surface.SetTextColor(color);
		surface.DrawText("S");
	end;

	if (compX + east > compX and compX + east < compX + compW) then
		Atomic.Draw:Box(compX + east, h - 78, 5, 16, colorBlack)
		Atomic.Draw:Box(compX + east, h - 78, 3, 15, color)
		surface.SetTextPos(compX + east - 3, h - 64);
		surface.SetTextColor(colorBlack);
		surface.DrawText("E");
		surface.SetTextPos(compX + east - 5, h - 66);
		surface.SetTextColor(color);
		surface.DrawText("E");
	end;

	Atomic.Draw:Box(compX, h - 78, compW + 2, 3, color); -- Bottom Line
	Atomic.Draw:Box(compX, h - 88, 3, 12, color); -- Left Line
	Atomic.Draw:Box(compX + compW, h - 88, 3, 12, color); -- Right Line

	if (!nextFind or nextFind <= CurTime()) then
		found = Atomic:GetRadarTable()

		nextFind = CurTime() + 1;
	end;

	-- Radar (EVS)
	render.SetScissorRect(compX, h - 130, compX + compW, h - 72, true);
		if (#found > 0) then
			for k, v in pairs(found) do
				local pos = v.ent:GetPos();
				local mark = (pos + Vector(0, 0, 16)):ToScreen();
				local plyPos = LocalPlayer():GetPos();

				draw.RoundedBox(0, compX + mark.x / compDivide, h - 104, 10, 10, Color(20, 20, 20, 255));
				draw.RoundedBox(0, compX + mark.x / compDivide, h - 104, 9, 9, v.color);
								
				if ((pos.z - plyPos.z) >= 60) then
					surface.SetDrawColor(v.color)
					surface.SetMaterial(MAT_UP)
					surface.DrawTexturedRect(compX + mark.x / compDivide - 4, h - 120, 19, 17)
					surface.SetTextPos(compX + mark.x / compDivide - 3, h - 122)
				elseif ((plyPos.z - pos.z) >= 60) then
					surface.SetDrawColor(v.color)
					surface.SetMaterial(MAT_DOWN)
					surface.DrawTexturedRect(compX + mark.x / compDivide - 4, h - 96, 19, 17)
					surface.SetTextPos(compX + mark.x / compDivide - 3, h - 122)
				end;
			end;
		end;
	render.SetScissorRect(0, 0, 0, 0, false);

	-- Ammo
	local weapon = Clockwork.Client:GetActiveWeapon();
				
	if (weapon and Clockwork.player:GetWeaponRaised(Clockwork.Client)) then
		if (weapon.Clip1) then
			local clipOne = weapon:Clip1();
						
			if (clipOne >= 0) then
				local Ammo = Clockwork.Client:GetAmmoCount(weapon:GetPrimaryAmmoType())
				local ammoX = w - 165;
				local ammoY = h - 165;
				
				surface.SetFont(Clockwork.option:GetFont("prim_hud_text_big"))

				surface.SetTextColor(colorBlack);
				surface.SetTextPos(ammoX + 2, ammoY - 48)
				surface.DrawText(Atomic.Draw:StyleNumber(clipOne));
				surface.SetTextColor(color);
				surface.SetTextPos(ammoX, ammoY - 50)
				surface.DrawText(Atomic.Draw:StyleNumber(clipOne));
						
				surface.SetTextColor(colorBlack);	
				surface.SetTextPos(ammoX + 2, ammoY + 2)
				surface.DrawText(Atomic.Draw:StyleNumber(Ammo));
				surface.SetTextColor(color);	
				surface.SetTextPos(ammoX, ammoY)
				surface.DrawText(Atomic.Draw:StyleNumber(Ammo));
						
				Atomic.Draw:Box(ammoX, ammoY, 70, 5, colorBlack);
				Atomic.Draw:Box(ammoX, ammoY, 68, 3, color);
			end;
		end;
	end;

	-- What happened to Stamina? :(
	local stamina = Clockwork.Client:GetSharedVar("Stamina") or 100;

	if (stamina < 100) then
		Atomic.Draw:ReversedBar(w - (w / 6 + 148), h - 90, stamina, 100, colorBlack, {width = w / 6, height = 13});
		Atomic.Draw:ReversedBar(w - (w / 6 + 150), h - 90, stamina, 100, color, {width = w / 6, height = 11});

		surface.SetFont(Clockwork.option:GetFont("prim_hud_text"));

		surface.SetTextColor(colorBlack);
		surface.SetTextPos(w - 138, h - 100);
		surface.DrawText("ST");
		surface.SetTextColor(color);
		surface.SetTextPos(w - 140, h - 102);
		surface.DrawText("ST");
	end;

	local entity = Clockwork.Client:GetEyeTraceNoCursor().Entity;
	local eyePos = Clockwork.Client:EyePos();

	if (entity and entity:IsValid() and entity:NearestPoint(eyePos):Distance(eyePos) <= 80) then
		local entityOptions = {};
		local canDraw = false;
		local useText = "Use";
		local useTable = {};

		Clockwork.plugin:Call("GetEntityMenuOptions", entity, entityOptions);

		--[[
			I don't know why checking the number of entries in the table doesn't work, but this dumb way works.
		--]]
		for k, v in pairs(entityOptions) do
			if (k or v) then
				canDraw = true;

				table.insert(useTable, k);
			end;
		end;

		local useNum = #useTable;

		if (useNum == 1) then
			useText = useTable[1];
		elseif (useNum > 1) then
			useText = "Use ["..tostring(useNum).."]";
		end;

		if (canDraw or entity:GetClass() == "cw_item") then
			local y = ScrH() * 0.55;

			Atomic.crosshairFill = true;

			Atomic:DrawUseUI(useText, color);
		end;
	end;
end;

-- Called when the HUD is painted.
function Atomic:HUDPaint()
	if (!Clockwork.kernel:IsChoosingCharacter() and Clockwork.Client:Health() > 0 and !Clockwork.Client:IsRagdolled()) then
		local color = Clockwork.option:GetColor("information");
		local found = {};
		local nextFind = nil;

		if (CW_CONVAR_PRIMARYHUD:GetInt() == 1) then
			self:DrawPrimaryHUD(color, found, nextFind);
		end;
	end;
end;

-- Called when a HUD element wants to be drawn.
function Atomic:CanDrawHUD(name)
	if (name == "Crosshair") then
		return Clockwork.config:Get("enable_crosshair"):Get();
	end;

	return true;
end;

-- Called to determine if the entity will show up on the player's compass.
function Atomic:CanSeeBlip(entity)
	local isPlayer = entity:IsPlayer();
	local isNPC = entity:IsNPC();

	if (!isPlayer and !isNPC) then return false; end;

	if (isPlayer and (entity:Crouching() or entity:IsProne())) then return false; end;
	
	if (!Clockwork.player:CanSeeEntity(Clockwork.Client, entity)) then return false; end;

	if (isPlayer and entity:GetMoveType() == MOVETYPE_WALK) then
		return true;
	elseif (isNPC or string.find(entity:GetClass(), "npc")) then
		return true;
	end;

	return false;
end;

-- Called when a text entry has gotten focus.
function Atomic:OnTextEntryGetFocus(panel)
	self.textEntryFocused = panel;
end;

-- Called when a text entry has lost focus.
function Atomic:OnTextEntryLoseFocus(panel)
	self.textEntryFocused = nil;
end;

-- Called when the cinematic intro info is needed.
function Atomic:GetCinematicIntroInfo()
	return {
		credits = "Designed and developed by "..self:GetAuthor()..".",
		title = Clockwork.config:Get("intro_text_big"):Get(),
		text = Clockwork.config:Get("intro_text_small"):Get()
	};
end;

-- Called when an entity's menu options are needed.
function Atomic:GetEntityMenuOptions(entity, options)
	if (entity:GetClass() == "cw_music_radio") then
		if (!entity:GetNWBool("Off")) then
			options["Turn Off"] = "cw_musicToggle";
		else
			options["Turn On"] = "cw_musicToggle";
		end;
		
		options["Take"] = "cw_musicTake";
	end;
end;

-- Called when the target's status should be drawn.
function Atomic:DrawTargetPlayerStatus(target, alpha, x, y)
	local colorInformation = Clockwork.option:GetColor("information");
	local thirdPerson = "him";
	local mainStatus = nil;
	local gender = "He";
	local action = Clockwork.player:GetAction(target);
	
	if (target:GetGender() == GENDER_FEMALE) then
		thirdPerson = "her";
		gender = "She";
	end;
	
	if ( target:Alive() ) then
		if (target:GetRagdollState() == RAGDOLL_KNOCKEDOUT) then
			mainStatus = gender.." is clearly unconscious.";
		end;
		
		if (mainStatus) then
			y = Clockwork.kernel:DrawInfo(mainStatus, x, y, colorInformation, alpha);
		end;
		
		return y;
	end;
end;

-- Called when the chat box info should be adjusted.
function Atomic:ChatBoxAdjustInfo(info)
	if (Clockwork.config:Get("can_anon"):GetBoolean()) then
		if (IsValid(info.speaker)) then
			if (info.data.anon) then
				info.name = "Somebody";
			end;
		end;
	end;
end;