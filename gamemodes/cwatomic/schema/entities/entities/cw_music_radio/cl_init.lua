--[[ 
    © 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

include("shared.lua");

local glowMaterial = Material("sprites/glow04_noz");

-- Called when the target ID HUD should be painted.
function ENT:HUDPaintTargetID(x, y, alpha)
	local power = "ON";

	if (self:GetNWBool("Off")) then
		power = "OFF";
	end;

	Atomic:DrawInfoUI("Music Radio", "POWER", power, "WG", "5", alpha);
end;

-- Called when the entity should draw.
function ENT:Draw()
	self:DrawModel();

    if (!self:GetNWBool("Off")) then
        local curTime = CurTime();
        local r, g, b, a = self:GetColor();
        local neonAlpha = math.abs(math.sin(curTime * 0.5));

        glowMaterial:SetFloat("$alpha", 0.5 + neonAlpha);

        local glowColor = Color(153, 153, 0, 255);
        local position = self:GetPos();
        local forward = self:GetForward() * 6.5;
        local right = self:GetRight() * -0.5;
        local up = self:GetUp() * 6.5;

        cam.Start3D( EyePos(), EyeAngles() );
            render.SetMaterial(glowMaterial);
            render.DrawSprite(position + forward + right + up, 16, 16, glowColor);
        cam.End3D();
    end;
end;