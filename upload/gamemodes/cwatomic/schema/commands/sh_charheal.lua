--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

COMMAND = Clockwork.command:New("CharHeal");
COMMAND.tip = "Heal a character if you own a medical item.";
COMMAND.text = "<string Item>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local itemTable = Clockwork.item:Get(arguments[1]);
	local entity = player:GetEyeTraceNoCursor().Entity;
	local healed;
	
	local target = Clockwork.entity:GetPlayer(entity);
	
	if (target) then
		if (entity:GetPos():Distance( player:GetShootPos() ) <= 192) then
			if (itemTable and arguments[1]) then
				if (player:HasItem(itemTable.name)) then
					if (Clockwork.plugin:Call("PlayerHealed", target, player, itemTable)) then
						target:SetHealth( math.Clamp( target:Health() + Atomic:GetHealAmount(player, itemTable.baseHeal), 0, target:GetMaxHealth() ) );
						target:EmitSound(itemTable.useSound);
						
						player:TakeItem(itemTable, true);
						
						Clockwork.kernel:PrintLog(LOGTYPE_URGENT, player:Name().." has healed "..target:Name().." for "..Atomic:GetHealAmount(player, itemTable.baseHeal)..", leaving them at "..target:Health()" health!");

						healed = true;
					end;
				else
					Clockwork.player:Notify(player, "You do not own that item!");
				end;
			else
				Clockwork.player:Notify(player, "That is not a valid item!");
			end;
			
			if (healed) then				
				if (Clockwork.player:GetAction(target) == "die") then
					Clockwork.player:SetRagdollState(target, RAGDOLL_NONE);
				end;
				
				player:FakePickup(target);
			end;
		else
			Clockwork.player:Notify(player, "This character is too far away!");
		end;
	else
		Clockwork.player:Notify(player, "You must look at a character!");
	end;
end;

COMMAND:Register();