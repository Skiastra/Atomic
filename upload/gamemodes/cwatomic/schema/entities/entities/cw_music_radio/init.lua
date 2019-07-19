--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

Clockwork.kernel:IncludePrefixed("shared.lua");

AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");

-- Called when the entity initializes.
function ENT:Initialize()
	self:SetModel("models/clutter/radio.mdl");
	
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetHealth(25);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetNWBool("Off", true);
	self:ShuffleTracks();
	
	local physicsObject = self:GetPhysicsObject();
	
	if (IsValid(physicsObject)) then
		physicsObject:Wake();
		physicsObject:EnableMotion(true);
	end;
end;

function ENT:PlayNextSong()

	if (self.currentSong) then
		self.music[self.currentSong].sound:Stop();

		table.remove(self.music, self.currentSong);
	end;

	if (!self.music or #self.music == 1) then
		self:ShuffleTracks();
	end;

	local newIndex = math.random(1, #self.music);

	self.currentDuration = self.music[newIndex].duration + CurTime() + 5;

	if (self:GetNWBool("Off")) then return;	end;
	self.music[newIndex].sound:Play();

	return newIndex;
end;

function ENT:Think()
	if (self:GetNWBool("Off")) then return;	end;

	if (!self.currentSong or self.currentSong and self.currentDuration and self.currentDuration <= CurTime()) then
		self.currentSong = self:PlayNextSong();
	end;
end;

function ENT:OnRemove()
	self:StopAll();
	self.currentSong = nil;
	self.currentDuration = nil;
	self.music = nil;
end;

function ENT:StopAll()
	for k, v in pairs(self.music) do
		v.sound:Stop();
	end;
end;

function ENT:Toggle()
	local off = self:GetNWBool("Off");

	self:SetNWBool("Off", !off);

	if (off) then
		self:StopAll();
		self.currentSong = nil;
		self.currentDuration = nil;
		self.music = nil;
	else
		self:PlayNextSong();
	end;
end;

function ENT:ShuffleTracks()
	local music = Atomic.music:GetStored();
	self.music = {};

	if (music) then
		for k, v in pairs(music) do
			local songTable = {
				name = k, 
				sound = CreateSound(self, v.song), 
				duration = v.duration
			};

			songTable.sound:Stop();

			table.insert(self.music, songTable);
		end;
	end;
end;

-- A function to explode the entity.
function ENT:Explode()
	local effectData = EffectData();
	
	effectData:SetStart( self:GetPos() );
	effectData:SetOrigin( self:GetPos() );
	effectData:SetScale(8);
	
	util.Effect("GlassImpact", effectData, true, true);
	
	self:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav");
end;

-- Called when the entity takes damage.
function ENT:OnTakeDamage(damageInfo)
	self:SetHealth( math.max(self:Health() - damageInfo:GetDamage(), 0) );
	
	if (self:Health() <= 0) then
		self:Explode(); self:Remove();
	end;
end;