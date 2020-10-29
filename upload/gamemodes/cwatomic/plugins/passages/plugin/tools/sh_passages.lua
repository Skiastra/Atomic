--[[
	© 2015 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/Clockwork.html
--]]

local TOOL = Clockwork.tool:New();

TOOL.Name 			= "Passages";
TOOL.UniqueID 		= "passage";
TOOL.Category		= "Clockwork";
TOOL.Desc 			= "Add a door to another server!";
TOOL.HelpText		= "Primary: Spawn the door";

TOOL.ClientConVar[ "name" ]	= "";
TOOL.ClientConVar[ "uniqueID" ]	= "";
TOOL.ClientConVar[ "entryUniqueID" ] = "";
TOOL.ClientConVar[ "server" ] = "";
TOOL.ClientConVar[ "password" ] = "";
TOOL.ClientConVar[ "model" ] = "";

function TOOL:LeftClick(tr)
	if (CLIENT) then return true; end;

	local ply = self:GetOwner();

	if (!ply:IsAdmin()) then 
		return false;
	end;

	local door = ents.Create("cw_passage");
	
	if (IsValid(door)) then
		local model = self:GetClientInfo("model");

		if (model and model != "") then
			door:SetModel(model);
		else
			door:SetModel("models/props_doors/door03_slotted_left.mdl");
		end;

		door:SetMoveType(MOVETYPE_VPHYSICS);
		door:PhysicsInit(SOLID_VPHYSICS);
		door:SetUseType(SIMPLE_USE);
		door:SetSolid(SOLID_VPHYSICS);

		Clockwork.entity:MakeFlushToGround(door, tr.HitPos, tr.HitNormal);

		local doorAngle = door:GetAngles();
		local plyAngle = ply:GetAngles();

		-- Make the door face us.
		door:SetAngles(Angle(doorAngle.p, plyAngle.y + 180, doorAngle.r));

		door:Spawn();
		door:Activate();

		door.server = self:GetClientInfo("server");
		door.password = self:GetClientInfo("password");
		door:SetNWString("name", self:GetClientInfo("name"));
		door.uniqueID = self:GetClientInfo("uniqueID");
		door.entryUniqueID = self:GetClientInfo("entryUniqueID");

		undo.Create("Passage");
			undo.AddEntity(door);
			undo.SetPlayer(ply);
		undo.Finish();
		
		Clockwork.player:Notify(ply, "You have added the passage.");
	else
		Clockwork.player:Notify(ply, "The door could not be created!");
	end;
end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { 
		Text = "Passages", 
		Description	= "Add a door to another server." 
	});

	CPanel:AddControl( "TextBox", { 
		Label = "Name",
		MaxLenth = "50",
		Command = "passage_name"
	});

	CPanel:AddControl( "TextBox", { 
		Label = "UniqueID",
		MaxLenth = "50",
		Command = "passage_uniqueID"
	});

	CPanel:AddControl( "TextBox", { 
		Label = "Entry UniqueID",
		MaxLenth = "50",
		Command = "passage_entryUniqueID"
	});

	CPanel:AddControl( "TextBox", { 
		Label = "Server IP:Port",
		MaxLenth = "50",
		Command = "passage_server"
	});

	CPanel:AddControl( "TextBox", { 
		Label = "Server Password",
		MaxLenth = "50",
		Command = "passage_password"
	});

	CPanel:AddControl( "TextBox", { 
		Label = "Model",
		MaxLenth = "50",
		Command = "passage_model"
	});
end;

TOOL:Register();