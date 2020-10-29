local PLUGIN = PLUGIN;

PLUGIN:SetGlobalAlias("cwPassages");

local lerpDuration = 1.5;

if (SERVER) then
	-- If we're coming into the server from a passage, we want to skip the whole intro.
	function Atomic:PlayerDataLoaded(player)
		local charID = player:GetData("Passages_CharacterID");

		if (charID and charID != "") then
			local uniqueID = player:GetData("Passages_EntryUniqueID");

			if (uniqueID and uniqueID != "") then
				player.entryUniqueID = uniqueID;
			end;

			player:SendLua("Passages_StopCharacter = true");
		else
			Clockwork.datastream:Start(player, "StartIntroduction", {player:GetData("FNVIntro")});
			player:SetData("FNVIntro", true);
		end;

		player:SetData("ClockworkIntro", true);
	end;

	-- Save all the passages.
	function cwPassages:PostSaveData()
		local passages = {};
	
		for k, v in pairs( ents.FindByClass("cw_passage") ) do
			local physicsObject = v:GetPhysicsObject();
			local moveable;
			
			if ( IsValid(physicsObject) ) then
				moveable = physicsObject:IsMoveable();
			end;
			
			passages[#passages + 1] = {
				angles = v:GetAngles(),
				moveable = moveable,
				position = v:GetPos(),
				model = v:GetModel(),
				server = v.server,
				password = v.password,
				name = v:GetNWString("name"),
				uniqueID = v.uniqueID,
				entry = v.entryUniqueID
			};
		end;
		
		Clockwork.kernel:SaveSchemaData("plugins/passages/"..game.GetMap(), passages);
	end;

	-- Load all the passages.
	function cwPassages:ClockworkInitPostEntity()
		local passages = Clockwork.kernel:RestoreSchemaData("plugins/passages/"..game.GetMap());
		
		for k, v in pairs(passages) do
			local entity = ents.Create("cw_passage");
		
			entity:SetAngles(v.angles);
			entity:SetPos(v.position);
			entity:SetModel(v.model);

			entity:SetMoveType(MOVETYPE_VPHYSICS);
			entity:PhysicsInit(SOLID_VPHYSICS);
			entity:SetUseType(SIMPLE_USE);
			entity:SetSolid(SOLID_VPHYSICS);

			entity:Spawn();
			entity:Activate();

			entity.server = v.server;
			entity.password = v.password;
			entity:SetNWString("name", v.name);
			entity.uniqueID = v.uniqueID;
			entity.entryUniqueID = v.entry;

			if (!v.moveable) then
				local physicsObject = entity:GetPhysicsObject();
				
				if ( IsValid(physicsObject) ) then
					physicsObject:EnableMotion(false);
				end;
			end;
		end;
	end;

	-- Main code for transferring character between servers / locations via passage.
	function cwPassages:TransferPlayer(player, server, password, uniqueID)
		player:SendLua("cwPassages:StartFadeOut()"); -- Send clientside code to fade their screen out.
		self:FadePlayerOut(player); -- Fade their model out serverside.

		local hasID = uniqueID and uniqueID != "";

		if (hasID) then -- Cache the uniqueID on the character and inside their data for cross-server.
			player:SetData("Passages_EntryUniqueID", uniqueID);
			player.entryUniqueID = uniqueID;
		end;

		if (server and server != "") then -- Do we go to another server or simply teleport to another door in the same server?
			player:SetData("Passages_CharacterID", Clockwork.player:GetCharacter(player).characterID); -- Set their character to load when getting to the server.

			if (password and password != "") then
				player:SendLua("Clockwork.Client:ConCommand('password "..password.."')"); -- Prepare the password via console command. This has to be done first before connecting to server.
			end;
			
			timer.Simple(lerpDuration, function() -- Wait for them to be fully faded.
				player:SendLua("Clockwork.Client:ConCommand('connect "..server.."')"); -- Send over some code to run clientside to connect them to the next server via console command.
			end);
		elseif (hasID) then -- Make sure we actually have a door to go to.
			timer.Simple(lerpDuration, function() -- Wait for them to be fully faded.
				self:TeleportPlayerToDoor(player); -- Place them in front of the door.
				self:FadePlayerIn(player); -- Fade their model in serverside.

				player:SendLua("cwPassages:StartFadeIn()"); -- Fade their screen back in clientside.
			end);
		end;
	end;

	function cwPassages:FadePlayerOut(player)
		player.cwPassagesFadeStartTime = CurTime();
		player.cwPassagesFadeOut = true;
	end;

	function cwPassages:FadePlayerIn(player)
		player.cwPassagesFadeStartTime = CurTime();
		player.cwPassagesFadeOut = false;
	end;

	function cwPassages:PlayerTick(player)
		local lerpStart = player.cwPassagesFadeStartTime;
		local fadeOut = player.cwPassagesFadeOut;

		if (lerpStart) then
			local fraction = (CurTime() - lerpStart) / lerpDuration;
			
			local targetAlpha = (fadeOut and 0) or 255; -- If fadeOut is true, we want alpha to be 0, if false we want 255.
			local startAlpha = (fadeOut and 255) or 0; -- Same here but in reverse.
			local alpha = Lerp(fraction, startAlpha, targetAlpha);

			self:SetPlayerAlpha(player, alpha);

			if (fraction >= 1) then
				self:SetPlayerAlpha(player, targetAlpha);
				
				player.cwPassagesFadeStartTime = nil;
				player.cwPassagesFadeOut = nil;
			end;
		end;
	end;

	function cwPassages:SetPlayerAlpha(player, alpha)
		local isTransparent = alpha < 255;
		local renderMode = (isTransparent and RENDERMODE_TRANSCOLOR) or RENDERMODE_NORMAL;
		local color = player:GetColor();

		player:SetColor(ColorAlpha(color, alpha));
		player:SetRenderMode(renderMode);
		player:DrawShadow(!isTransparent);

		local weapon = player:GetActiveWeapon();

		if (IsValid(weapon)) then
			local wepColor = weapon:GetColor();

			weapon:SetRenderMode(renderMode);
			weapon:SetColor(ColorAlpha(color, alpha));
		end;
	end;

	function cwPassages:TeleportPlayerToDoor(player)
		local doors = ents.FindByClass("cw_passage");
		local door = nil;

		for k, v in pairs(doors) do
			if (v.uniqueID == player.entryUniqueID) then
				door = v;

				break;
			end;
		end;

		if (IsValid(door)) then
			local plyAngles = player:EyeAngles();
			local doorAngles = door:GetAngles();

			player:SetEyeAngles(Angle(plyAngles.p, doorAngles.y, plyAngles.r));
			player:SetPos(door:GetPos() + (door:GetForward() * 60) + (door:GetRight() * -25));

			timer.Simple(0.5, function()
				door:EmitSound("srp/fnv/door/generic_close.mp3");
			end);
		end;
	end;

	Clockwork.datastream:Hook("Passages_LoadCharacter", function(player, data)
		Clockwork.player:LoadCharacter(player, player:GetData("Passages_CharacterID"));

		player:SetData("Passages_EntryUniqueID", "");
		player:SetData("Passages_CharacterID", "");

		cwPassages:TeleportPlayerToDoor(player);
	end);
else
	local lerpStart = nil;
	local fadeOut = nil;
	lerpDuration = 0.5;

	function cwPassages:Initialize()
		CW_CONVAR_PASSAGEESP = Clockwork.kernel:CreateClientConVar("cwPassageESP", 0, false, true);
	end;
	
	function cwPassages:GetAdminESPInfo(info)
		if (CW_CONVAR_PASSAGEESP:GetInt() == 1) then
			local passages = ents.FindByClass("cw_passage");

			for k, v in pairs(passages) do
				if (v:IsValid()) then
					local position = v:GetPos() + Vector(0, 0, 80);
					local name = v:GetNWString("name");
					local color = Color(100, 150, 0, 255);

					table.insert(info, {
						position = position,
						text = {
							{
								text = "[Passage]", 
								color = color
							},
							{
								text = name, 
								color = color
							}
						}
					});
				end;
			end;
		end;
	end;

	function cwPassages:PlayerCharacterScreenCreated()
		if (Passages_StopCharacter) then
			Clockwork.character:SetPanelOpen(false);
			Clockwork.CinematicScreenDone = true;
			Clockwork.CinematicInfoAlpha = 0;
			Clockwork.CinematicInfoSlide = 0;

			Clockwork.datastream:Start("Passages_LoadCharacter", {});
		end;
	end;

	function cwPassages:StartFadeOut()
		lerpStart = CurTime();
		fadeOut = true;
	end;

	function cwPassages:StartFadeIn()
		lerpStart = CurTime();
		fadeOut = false;
	end;

	function cwPassages:HUDPaint()
		if (lerpStart) then
			local fraction = (CurTime() - lerpStart) / lerpDuration;
			local targetAlpha = (fadeOut and 255) or 0;
			local startAlpha = (fadeOut and 0) or 255;

			surface.SetDrawColor(0, 0, 0, Lerp(fraction, startAlpha, targetAlpha));
			surface.DrawRect(0, 0, ScrW(), ScrH());

			-- We only want to cleanup the fade variables after we're done fading in.
			if (!fadeOut and fraction >= 1) then
				lerpStart = nil;
				fadeOut = nil;
			end;
		end;
	end;

	Clockwork.setting:AddCheckBox("Admin ESP", "Show passage entities.", "cwPassageESP", "Whether or not to view passages in the admin ESP.", function()
		return Clockwork.player:IsAdmin(Clockwork.Client);
	end);
end;