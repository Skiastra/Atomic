local intro = {};

local colorBlack = Color(0, 0, 0, 255);
local colorWhite = Color(255, 255, 255, 255);

local logoMat = Material("srp/fnv/fnv_logo_base.png");
local boltMat = Material("srp/fnv/fnv_logo_bolt_bloom.png");
local neonMat = Material("srp/fnv/fnv_logo_neon_bloom3.png");

local isPlaying = false;
local drawLogo = false;

local introDuration = 22;

-- Lerp Variables.
local lerpStart;
local lerpTarget;
local lerpOrigin;

local lerpLogoStart;
local lerpLogoTarget;
local lerpLogoOrigin;

-- Fade In/Out Time.
local lerpDuration = 2;

local currentMat;
local nextMat;
local currentIndex = 1;

local images = {
	Material("srp/fnv/intro/intro_bethsoft.png"),
	Material("srp/fnv/intro/intro_obsidian.png"),
	Material("srp/fnv/intro/intro_c16_final1.png")
};

function intro.NextImage()
	lerpStart = CurTime();
	lerpTarget = 255;
	lerpOrigin = 0;

	if (currentIndex <= #images) then
		timer.Create("SlideShowTimer", (introDuration / #images) + (lerpDuration * 0.3), 1, function()
			intro.NextImage();

			if (currentIndex > #images) then
				timer.Simple(lerpDuration, function()
					--[[
						This variable is to keep the song playing 
						when there's that small gap between the intro
						not playing and the menu not being up.
					--]]
					Atomic.keepSong = true;

					Atomic.introPlaying = nil;
					Atomic.KeyPress = nil;	
				end);
			end;
		end);
	end;

	currentMat = nextMat;
	nextMat = images[currentIndex] or nil;
	currentIndex = currentIndex + 1;
end;

local nextFlicker;
local canFlicker;
local canBoltFlicker;
local nextBoltFlicker;
local sparkPlayed;

function Atomic:PostDrawBackgroundBlurs()
	if (!self.introPlaying) then return; end;

	local scrW, scrH = ScrW(), ScrH();
	local curTime = CurTime();

	if (!isPlaying) then
		if (intro.music) then
			intro.music:Stop();
			intro.music = nil;
		end;

		intro.music = CreateSound(LocalPlayer(), "srp/fnv/fnv_main_theme.mp3");
		intro.music:Play();

		timer.Simple(introDuration, function()
			drawLogo = true;
		end);

		intro.NextImage();

		isPlaying = true;
	end;

	-- temp background.
	draw.RoundedBox(0, 0, 0, scrW, scrH, colorBlack);

	local fraction = (curTime - lerpStart) / lerpDuration;
	local introAlpha = Lerp(fraction, lerpOrigin, lerpTarget);

	-- Draw intro images.
	if (currentMat) then
		surface.SetDrawColor(colorWhite.r, colorWhite.g, colorWhite.b, 255 - introAlpha);
		surface.SetMaterial(currentMat);
		surface.DrawTexturedRect(0, 0, scrW, scrH);
	end;

	if (isnumber(nextMat)) then
		nextMat = nil;
	end;

	if (nextMat) then
		surface.SetDrawColor(colorWhite.r, colorWhite.g, colorWhite.b, introAlpha);
		surface.SetMaterial(nextMat);
		surface.DrawTexturedRect(0, 0, scrW, scrH);
	end;

	if (self.introSkippable) then
		local alpha = math.Clamp(math.abs(math.sin(CurTime()) * 255), 0, 255);
		local color = Color(colorWhite.r, colorWhite.g, colorWhite.b, alpha);

		draw.SimpleText("Press the spacebar to skip!", Clockwork.option:GetFont("main_text"), scrW * 0.5, scrH * 0.98, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end;
end;

function Atomic:KeyPress(player, key)
	if (key == IN_JUMP and self.introPlaying and self.introSkippable) then
		self.introPlaying = nil;
		self.KeyPress = nil;
		self.keepSong = true;
	end;
end;

function Atomic:Tick()
	if (Clockwork.character:IsPanelOpen()) then
		if (!intro.music) then
			intro.music = CreateSound(Clockwork.Client, "srp/fnv/fnv_main_theme.mp3");
			intro.music:Play();
			intro.musicFading = false;
		end;

		if (!timer.Exists("MenuSlideShow")) then
			timer.Create("MenuSlideShow", 8, 0, function()
				if (Clockwork.character:IsPanelOpen()) then
					self:nextImage();
				else
					timer.Remove("MenuSlideShow");
				end;
			end);
		end;

		if (self.keepSong) then
			self.keepSong = nil;
		end;
	elseif (intro.music and !intro.musicFading and !self.introPlaying and !self.keepSong) then
		intro.music:FadeOut(8);
		intro.musicFading = true;

		timer.Create("StopMenuMusic", 8, 1, function()
			intro.music = nil;
		end);
	end;
end;

function Atomic:StartIntro()
	self.introPlaying = true;
end;

function Atomic:ShouldCharacterMenuBeCreated()
	if (self.introPlaying) then
		return false;
	end;
end;

Clockwork.datastream:Hook("StartIntroduction", function(data)
	if (data[1]) then
		Atomic.introSkippable = true;
	end;

	Atomic:StartIntro();
end);