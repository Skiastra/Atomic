--[[
	Copyright (C) 2015 CloudSixteen and TeslaCloud Studios.
	
	The use, modification and sharing of this file is permitted by it's author,
	as long as this copyright notice stays intact.
	(thegarry@teslacloud.net)
--]]

--[[
	This file is a part of TeslaCode project.
	Purpose: Easy macros for panel painting.
--]]

Atomic.Draw = Clockwork.kernel:NewLibrary("ADraw");
Atomic.Draw.Blur = Material("pp/blurscreen");

function Atomic.Draw:Box(x, y, w, h, color)
	draw.RoundedBox(0, x, y, w, h, color);
end;

function Atomic.Draw:SimpleBlurBox(x, y, w, h, color, blurAmt)
	blurAmt = blurAmt or 4;
	
	self:Box(x, y, w, h, color);
	--[[
	surface.SetMaterial(self.Blur);
	surface.SetDrawColor(255, 255, 255, 255);
	
	for i = -0.2, 1, 0.2 do
		self.Blur:SetFloat("$blur", i * blurAmt);
		self.Blur:Recompute();
		
		render.UpdateScreenEffectTexture();
		
		render.SetScissorRect(x, y, x + w, y + h, true);
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH());
		render.SetScissorRect(0, 0, 0, 0, false);
	end;
	--]]
end;

function Atomic.Draw:ShadowedLine(x, y, w, h, color, mode)
	local oX, oY = 0, 0;
	local addW, addH = 0, 0;
	
	if (mode == "up") then
		oY = -1;
	elseif (mode == "down") then
		oY = 1;
	elseif (mode == "left") then
		oX = -1;
	elseif (mode == "right") then
		oX = 1;
	elseif (mode == "leftup") then
		oX = -1;
		oY = -1;
		addH = 1;
	elseif (mode == "rightup") then
		oX = 1;
		oY = -1;
		addH = 1;
	elseif (mode == "leftdown") then
		oX = -1;
		oY = 1;
		addH = 1;
	elseif (mode == "rightdown") then
		oX = 1;
		oY = 1;
		addH = 1;
	else
		oY = -1;
	end;
	
	self:Box(x + oX, y + oY, w + addW, h + addH, Color(20, 20, 20, 255));
	self:Box(x, y, w, h, color);
end;

function Atomic.Draw:BlurBox(px, py, x, y, w, h, color, blurAmt)
	blurAmt = 4;
	
	self:Box(x, y, w, h, color);
	--[[
	
	surface.SetMaterial(self.Blur);
	surface.SetDrawColor(255, 255, 255, 255);
	
	for i = -0.2, 1, 0.2 do
		self.Blur:SetFloat("$blur", i * blurAmt);
		self.Blur:Recompute();
		
		render.UpdateScreenEffectTexture();
		
		render.SetScissorRect(x, y, x + w, y + h, true);
			surface.DrawTexturedRect(-px, -py, ScrW(), ScrH());
		render.SetScissorRect(0, 0, 0, 0, false);
	end;
	--]]
end;

function Atomic.Draw:Bar(x, y, value, max, color, data)
	data = data or {};
	
	local realvalue = math.Clamp(value, 0, max);
	local style = data.style or 1;
	local width = data.width or 150;
	local height = data.height or 12;
	local text = data.text or "";
	local perc = value / max;
	
	local IsScale = data.scale or false;
	
	local fill = math.Clamp(width * perc, 0, width);
	
	if (style == 1) then
		if (IsScale) then
			-- 25% indicator.
			self:Box(x + width * 0.25, y + 2, 2, height - 2, colorDark);
			
			-- 50% indicator.
			self:Box(x + width * 0.50, y, 2, height, colorDark);
			
			-- 75% indicator.
			self:Box(x + width * 0.75, y + 2, 2, height - 2, color);
		end;
		
		-- Left bottom vertical line.
		self:Box(x, y, 2, height, color);
		-- Bottom horizontal line.
		self:Box(x + 2, y + height - 2, width - 4, 2, color);
		-- Right bottom vertical line.
		self:Box(x + width - 2, y, 2, height, color);
		
		if (value != 0) then
			-- Bar fill outline.
			self:Box(x, y - 2, fill + 2, height + 2, color);
			
			-- Bar fill.
			self:Box(x, y, fill, height, color);
		end;
	end;
end;

function Atomic.Draw:ReversedBar(x, y, value, max, color, data)
	data = data or {};
	
	local realvalue = math.Clamp(value, 0, max);
	local style = data.style or 1;
	local width = data.width or 150;
	local height = data.height or 12;
	local text = data.text or "";
	local perc = value / max;
	
	local IsScale = data.scale or false;
	
	local fill = math.Clamp(width * perc, 0, width);
	
	if (style == 1) then
		if (IsScale) then
			-- 25% indicator.
			self:Box(x + width * 0.25, y + 2, 2, height - 2, colorDark);
			
			-- 50% indicator.
			self:Box(x + width * 0.50, y, 2, height, colorDark);
			
			-- 75% indicator.
			self:Box(x + width * 0.75, y + 2, 2, height - 2, color);
		end;
		
		-- Left bottom vertical line.
		self:Box(x, y, 2, height, color);
		-- Bottom horizontal line.
		self:Box(x + 2, y + height - 2, width - 4, 2, color);
		-- Right bottom vertical line.
		self:Box(x + width - 2, y, 2, height, color);
		
		if (value != 0) then
			-- Bar fill outline.
			self:Box((width - fill) + x, y - 2, fill + 2, height + 2, color);
			
			-- Bar fill.
			self:Box((width - fill) + x, y, fill, height, color);
		end;
	end;
end;

function Atomic.Draw:WrappedBar(x, y, value, max, color, data)
	data = data or {};
	
	local direction = data.direction or "down";
	
	if (value > max) then
		local newValue = value - max;
		local height = data.height or 12;
		
		self:Bar(x, y, 100, 100, color, data);
		
		if (direction == "down") then
			self:WrappedBar(x, y + height + 6, newValue, max, color, data);
		elseif (direction == "up") then
			self:WrappedBar(x, y - height - 6, newValue, max, color, data);
		end;
	else
		self:Bar(x, y, value, max, color, data);
	end;
end;

function Atomic.Draw:WeaponSelect(x, y, w, h, color, bBackground)
	local colorDarker = Color(
		math.max(color.r - 130, 0),
		math.max(color.g - 130, 0),
		math.max(color.b - 130, 0),
		150
	);
	
	local ox, oy, oh, ow = x - 6, y - 6, h + 12, w + 12;

	if (!bBackground) then
		self:BlurBox(0, 0, ox, oy, ow, oh, colorDarker, 4);
	end;
	
	DisableClipping(true)
		self:ShadowedLine(ox - 2, oy - 2, 2, oh + 4, color, "right");
		self:ShadowedLine(ox, oy - 2, 8, 2, color, "down");
		self:ShadowedLine(ox, oy + oh, 8, 2, color, "up");
		
		self:ShadowedLine(ox + ow + 2, oy - 2, 2, oh + 4, color, "left");
		self:ShadowedLine(ox + ow - 6, oy - 2, 8, 2, color, "down");
		self:ShadowedLine(ox + ow - 6, oy + oh, 8, 2, color, "up");
	DisableClipping(true)
end;

function Atomic.Draw:TextInABox(text, x, y, color)
	surface.SetTextColor(color);
	surface.SetFont("ato_HUDText")
	surface.SetTextPos(x, y)
	surface.DrawText(text);
end;

function Atomic.Draw:WrapNum(base, ceil)
	if (base > ceil) then
		base = base - ceil;
		WrapNum(base, ceil);
	else
		return base;
	end;
end;

function Atomic.Draw:AngleToRelative2D(ang, wide, mult)
	local startPos = wide * mult;
	local perc = (ang + 45) / 360 * 4;
	return -startPos + (wide + wide * perc) - wide / 2;
end;

function Atomic.Draw:StyleNumber(num)
	if (tonumber(num) >= 10) then
		if (tonumber(num) > 100) then
			return num;
		end;
		
		return "0"..num;
	end
	
	return "00"..num;
end;