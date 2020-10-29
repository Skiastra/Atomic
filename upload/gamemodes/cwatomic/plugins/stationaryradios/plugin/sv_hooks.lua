local PLUGIN = PLUGIN;

-- Called when an entity's menu option should be handled.
function PLUGIN:EntityHandleMenuOption(player, entity, option, arguments)
	if (entity:GetClass() == "cw_radio") then
		if (option == "Frequency" and type(arguments) == "string") then
			if (string.find(arguments, "^%d%d%d%.%d$")) then
				local start, finish, decimal = string.match(arguments, "(%d)%d(%d)%.(%d)");
				
				start = tonumber(start);
				finish = tonumber(finish);
				decimal = tonumber(decimal);
				
				if (start == 1 and finish > 0 and finish < 10 and decimal > 0 and decimal < 10) then
					entity:SetFrequency(arguments);
					
					Clockwork.player:Notify(player, "You have set this stationary radio's arguments to "..arguments..".");
				else
					Clockwork.player:Notify(player, "The radio arguments must be between 101.1 and 199.9!");
				end;
			else
				Clockwork.player:Notify(player, "The radio arguments must look like xxx.x!");
			end;
		elseif (arguments == "cw_radioToggle") then
			entity:Toggle();
		elseif (arguments == "cw_radioTake") then
			local bSuccess, fault = player:GiveItem(Clockwork.item:CreateInstance("stationary_radio"));
			
			if (!bSuccess) then
				Clockwork.player:Notify(player, fault);
			else
				entity:Remove();
			end;
		end;
	end;
end;

-- Called when a chat box message has been added.
function PLUGIN:ChatBoxMessageAdded(info)
	if (info.class == "ic" or info.class == "yell") then
		local eavesdroppers = {};
		local talkRadius = Clockwork.config:Get("talk_radius"):Get();
		local listeners = {};
		local players = cwPlayer.GetAll();
		local radios = ents.FindByClass("cw_radio");
		local data = {frequency = {}};
		
		for k, v in ipairs(radios) do
			if (!v:IsOff() and info.speaker:GetPos():Distance(v:GetPos()) <= 80) then
				local frequency = v:GetFrequency();
				
				if (frequency and frequency != "") then
					data.frequency[v] = frequency;
				end;
			end;
		end;
		
		for k, v in pairs(data.frequency) do
			if (IsValid(k) and v != "") then
				local pos = k:GetPos();

				for k2, v2 in ipairs(players) do
					if (v2:HasInitialized() and v2:Alive() and !v2:IsRagdolled(RAGDOLL_FALLENOVER)) then
						if ((v2:GetCharacterData("frequency") == v and v2:HasItemByID("handheld_radio")) 
						or info.speaker == v2) then
							listeners[v2] = v2;
						elseif (v2:GetPos():Distance(pos) <= talkRadius and !eavesdroppers[v2]) then
							eavesdroppers[v2] = v2;
						end;
					end;
				end;
					
				for k2, v2 in ipairs(radios) do
					local radioPosition = v2:GetPos();
					local radioFrequency = v2:GetFrequency();
						
					if (!v2:IsOff() and radioFrequency == v) then
						for k2, v2 in ipairs(players) do
							if (v2:HasInitialized() and !listeners[v2] and !eavesdroppers[v2]) then
								if (v2:GetPos():Distance(radioPosition) <= (talkRadius * 2)) then
									eavesdroppers[v2] = v2;
								end;
							end;
							
							break;
						end;
					end;
				end;
			end;
		end;

		if (table.Count(listeners) > 0) then
			Clockwork.chatBox:Add(listeners, info.speaker, "radio", info.text);
		end;
					
		if (table.Count(eavesdroppers) > 0) then
			Clockwork.chatBox:Add(eavesdroppers, info.speaker, "radio_eavesdrop", info.text);
		end;

		for k, v in pairs(info.listeners) do
			if (eavesdroppers[v] or listeners[v]) then
				info.listeners[k] = nil;
			end;
		end;
	end;
end;

-- Called when a player has used their radio.
function PLUGIN:PlayerRadioUsed(player, text, listeners, eavesdroppers)
	local newEavesdroppers = {};
	local talkRadius = Clockwork.config:Get("talk_radius"):Get() * 2;
	local frequency = player:GetCharacterData("frequency");
	
	for k, v in ipairs(ents.FindByClass("cw_radio")) do
		local radioPosition = v:GetPos();
		local radioFrequency = v:GetFrequency();
		
		if (!v:IsOff() and radioFrequency == frequency) then
			for k2, v2 in pairs(_player.GetAll()) do
				if (v2:HasInitialized() and !listeners[v2] and !eavesdroppers[v2]) then
					if (v2:GetPos():Distance(radioPosition) <= talkRadius) then
						newEavesdroppers[v2] = v2;
					end;
				end;
			end;
		end;
	end;
	
	if (table.Count(newEavesdroppers) > 0) then
		Clockwork.chatBox:Add(newEavesdroppers, player, "radio_eavesdrop", text);
	end;
end;

-- Called when Clockwork has loaded all of the entities.
function PLUGIN:ClockworkInitPostEntity()
	local radios = Clockwork.kernel:RestoreSchemaData("plugins/radios/"..game.GetMap());
	
	for k, v in pairs(radios) do
		local entity = ents.Create("cw_radio");
		
		Clockwork.player:GivePropertyOffline(v.key, v.uniqueID, entity);
		
		entity:SetAngles(v.angles);
		entity:SetPos(v.position);
		entity:Spawn();
		
		if (IsValid(entity)) then
			entity:SetFrequency(v.frequency);
			entity:SetOff(v.off);
		end;
		
		if (!v.moveable) then
			local physicsObject = entity:GetPhysicsObject();
			
			if (IsValid(physicsObject)) then
				physicsObject:EnableMotion(false);
			end;
		end;
	end;
end;

-- Called just after data should be saved.
function PLUGIN:PostSaveData()
	local radios = {};
	
	for k, v in pairs(ents.FindByClass("cw_radio")) do
		local physicsObject = v:GetPhysicsObject();
		local moveable;
		
		if (IsValid(physicsObject)) then
			moveable = physicsObject:IsMoveable();
		end;
		
		radios[#radios + 1] = {
			off = v:IsOff(),
			key = Clockwork.entity:QueryProperty(v, "key"),
			angles = v:GetAngles(),
			moveable = moveable,
			uniqueID = Clockwork.entity:QueryProperty(v, "uniqueID"),
			position = v:GetPos(),
			frequency = v:GetFrequency()
		};
	end;
	
	Clockwork.kernel:SaveSchemaData("plugins/radios/"..game.GetMap(), radios);
end;