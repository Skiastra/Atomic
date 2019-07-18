--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local ITEM = Clockwork.item:New();
	ITEM.name = "Music Radio";
	ITEM.cost = 150;
	ITEM.model = "models/clutter/radio.mdl";
	ITEM.batch = 1;
	ITEM.weight = 5;
	ITEM.access = "T";
	ITEM.business = true;
	ITEM.category = "Communication"
	ITEM.description = "An old radio, maybe it still works?";

	-- Called when a player uses the item.
	function ITEM:OnUse(player, itemEntity)
		local trace = player:GetEyeTraceNoCursor();
		
		if (trace.HitPos:Distance( player:GetShootPos() ) <= 192) then
			local entity = ents.Create("cw_music_radio");
			
			Clockwork.player:GiveProperty(player, entity);
			
			entity:SetModel(self.model);
			entity:SetPos(trace.HitPos);
			entity:Spawn();
			
			if ( IsValid(itemEntity) ) then
				local physicsObject = itemEntity:GetPhysicsObject();
				
				entity:SetPos( itemEntity:GetPos() );
				entity:SetAngles( itemEntity:GetAngles() );
				
				if ( IsValid(physicsObject) ) then
					if ( !physicsObject:IsMoveable() ) then
						physicsObject = entity:GetPhysicsObject();
						
						if ( IsValid(physicsObject) ) then
							physicsObject:EnableMotion(false);
						end;
					end;
				end;
			else
				Clockwork.entity:MakeFlushToGround(entity, trace.HitPos, trace.HitNormal);
			end;
		else
			Clockwork.player:Notify(player, "You cannot drop a radio that far away!");
			
			return false;
		end;
	end;

	-- Called when a player drops the item.
	function ITEM:OnDrop(player, position) end;
ITEM:Register();