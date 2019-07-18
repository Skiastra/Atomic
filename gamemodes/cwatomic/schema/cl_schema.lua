--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

Clockwork.config:AddToSystem("intro_text_small", "The small text displayed for the introduction.");
Clockwork.config:AddToSystem("intro_text_big", "The big text displayed for the introduction.");

Clockwork.config:AddToSystem("Enable Slow Death", "enable_slow_death", "Whether or not a player will slowly bleed out before dying.");
Clockwork.config:AddToSystem("Enable SPECIAL System", "enable_special", "Whether or not the SPECIAL system will be used.");
Clockwork.config:AddToSystem("Show SPECIAL Boosts", "show_boosts", "Whether or not to show exact SPECIAL boosts in menus.");
Clockwork.config:AddToSystem("Show Menu Blur", "show_menu_blur", "Whether or not the screen will blur when the menu is open.");
Clockwork.config:AddToSystem("Enable Anonymous Chat", "can_anon", "Whether or not a player can be anonymous in chat by typing '?' before a message.");
Clockwork.config:AddToSystem("Medical Effect Scale", "medical_effect", "The effectiveness a player's medical skill will have (baseHeal * (1 + (medicineSkill / medical_effect))).", 0, 100, 1);
Clockwork.config:AddToSystem("Agility Effect Scale", "agility_effect", "The effectiveness a player's agility will have in reducing action time (baseTime - (agility * agility_effect)).", 0, 1, 3);
Clockwork.config:AddToSystem("Condition Decrease Scale", "condition_decrease_scale", "The higher the number, the quicker weapons will lose condition.", 0, 4, 3);
Clockwork.config:AddToSystem("Starting SPECIAL points", "default_special_points", "The default amount of extra points that a player has to distribute into their SPECIAL stats.");

Clockwork.setting:AddCheckBox("HUD", "Show Primary HUD.", "cwPrimaryHUD", "Whether or not to display the primary HUD.");

--[[ This will give the devs who worked on Atomic special icons in OOC/LOOC chat, that's it. ]]--
Clockwork.icon:PlayerSet("STEAM_0:0:34834568", "NightAngel", "atomic/dev_icon.png");
Clockwork.icon:PlayerSet("STEAM_0:0:16697568", "Mr. Meow", "atomic/dev_icon.png");
--[[ No, seriously, it's okay. No backdoors or anything. ]]--

-- A function to get whether a text entry is being used.
function Atomic:IsTextEntryBeingUsed()
	if (IsValid(self.textEntryFocused)) then
		if (self.textEntryFocused:IsVisible()) then
			return true;
		end;
	end;
end;

function Atomic:DrawInfoUI(title, nameLeft, valueLeft, nameRight, valueRight, alpha)
	if (!alpha) then alpha = 255; end;

	local color = Clockwork.option:GetColor("information");
	local colorBlack = Color(0, 0, 0, alpha);

	if (CW_CONVAR_PRIMARYHUD:GetInt() == 1 and title) then	
		local y = ScrH() * 0.47;
		local x = ScrW() * 0.66;

		draw.SimpleText(string.upper(title), Clockwork.option:GetFont("prim_hud_text_tiny"), x + 2, y + 2, colorBlack, TEXT_ALIGN_CENTER);
		draw.SimpleText(string.upper(title), Clockwork.option:GetFont("prim_hud_text_tiny"), x, y, color, TEXT_ALIGN_CENTER);
	end;

	self.crosshairFill = true;
end;

function Atomic:DrawUseUI(useText, color, alpha)
	if (!alpha) then alpha = 255; end;

	if (CW_CONVAR_PRIMARYHUD:GetInt() == 1) then
		local colorBlack = Color(0, 0, 0, 255);
		local y = ScrH() * 0.52;

		draw.SimpleText("E) "..string.upper(useText), Clockwork.option:GetFont("prim_hud_text_tiny"), ScrW() * 0.66 + 2, y + 2, colorBlack, TEXT_ALIGN_CENTER);
		draw.SimpleText("E) "..string.upper(useText), Clockwork.option:GetFont("prim_hud_text_tiny"), ScrW() * 0.66, y, Color(color.r, color.g, color.b, 255), TEXT_ALIGN_CENTER);

		self.crosshairFill = true;
	end;
end;

--Thanks to thejjokerr for this function.

-- A function to draw a certain part of a texture
function surface.DrawPartialTexturedRect(x, y, w, h, partx, party, partw, parth, texw, texh)
	local percX, percY = partx / texw, party / texh;
	local percW, percH = partw / texw, parth / texh;

	local vertexData = {
		{
			x = x,
			y = y,
			u = percX,
			v = percY
		},
		{
			x = x + w,
			y = y,
			u = percX + percW,
			v = percY
		},
		{
			x = x + w,
			y = y + h,
			u = percX + percW,
			v = percY + percH
		},
		{
			x = x,
			y = y + h,
			u = percX,
			v = percY + percH
		}
	};
		
	surface.DrawPoly(vertexData);
end;

Clockwork.datastream:Hook("Frequency", function(data)
	Derma_StringRequest("Frequency", "What would you like to set the frequency to?", data, function(text)
		Clockwork.kernel:RunCommand("SetFreq", text);
	end);	
end);

Clockwork.datastream:Hook("ObjectPhysDesc", function(data)
	local entity = data;
	
	if ( IsValid(entity) ) then
		Derma_StringRequest("Description", "What is the physical description of this object?", nil, function(text)
			Clockwork.datastream:Start( "ObjectPhysDesc", {text, entity});
		end);
	end;
end);

Clockwork.datastream:Hook("SetSkillUpdate", function(data)
	Atomic.skillDisplay = {name = data[1], amount = data[2]};
end);