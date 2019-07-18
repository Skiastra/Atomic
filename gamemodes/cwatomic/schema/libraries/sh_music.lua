local Clockwork = Clockwork;

Atomic.music = Clockwork.kernel:NewLibrary("Music");

local stored = {};

-- A function to return the stored table.
function Atomic.music:GetStored()
	return stored;
end;

function Atomic.music:TranslateDuration(duration)
	duration = string.Explode(":", duration);
	
	if (duration) then
		for k, v in pairs(duration) do
			v = tonumber(v);
		end;

		if (#duration == 3) then
			duration = (duration[1] * 3600) + (duration[2] * 60) + duration[3];
		elseif (#duration == 2) then
			duration = (duration[1] * 60) + duration[2];
		end;
	end;

	return duration;
end;

-- A function to add a song path to the stored table.
function Atomic.music:Add(songID, songPath, duration)
	if (type(duration) != "number") then
		if (string.find(duration, ":")) then
			duration = self:TranslateDuration(duration);
		end;
	end;

	stored[songID] = {song = songPath, duration = duration};
end;

-- A function to find a song by id.
function Atomic.music:FindByID(id)
	return stored[id];
end;

-- A function to remove a song by id.
function Atomic.music:Remove(id)
	local song = self:FindByID(id);

	if (song) then
		stored[id] = nil;
	end;
end;

Atomic.music:Add("A Wonderful Guy", "atomic/songs/a_wonderful_guy.mp3", "1:52");
Atomic.music:Add("Anything Goes", "atomic/songs/anything_goes.mp3", "3:08");
Atomic.music:Add("Blue Moon", "atomic/songs/blue_moon.mp3", "2:51");
Atomic.music:Add("Boogie Man", "atomic/songs/boogie_man.mp3", "2:23");
Atomic.music:Add("Butcher Pete", "atomic/songs/butcher_pete.mp3", "2:25");
Atomic.music:Add("Civilization", "atomic/songs/civilization.mp3", "3:00");
Atomic.music:Add("Crazy He Calls Me", "atomic/songs/crazy_he_calls_me.mp3", "3:05");
Atomic.music:Add("Easy Living", "atomic/songs/easy_living.mp3", "3:02");
Atomic.music:Add("Fox Boogie", "atomic/songs/fox_boogie.mp3", "3:15");
Atomic.music:Add("Goin' Under", "atomic/songs/goin_under.mp3", "2:56");
Atomic.music:Add("Happy Times", "atomic/songs/happy_times.mp3", "2:45");
Atomic.music:Add("I Don't Want To Set The World On Fire", "atomic/songs/i_don't_want_to_set_the_world_on_fire.mp3", "3:07");
Atomic.music:Add("If I Didn't Care", "atomic/songs/if_i_didn't_care.mp3", "3:07");
Atomic.music:Add("I'm Tickled Pink", "atomic/songs/i'm_tickled_pink.mp3", "1:49");
Atomic.music:Add("Into Each Life Some Rain Must Fall", "atomic/songs/into_each_life_some_rain_must_fall.mp3", "3:06");
Atomic.music:Add("Jazzy Interlude", "atomic/songs/jazzy_interlude.mp3", "2:49");
Atomic.music:Add("Jolly Days", "atomic/songs/jolly_days.mp3", "1:40");
Atomic.music:Add("Kick In The Head", "atomic/songs/kick_in_the_head.mp3", "2:25");
Atomic.music:Add("Let's Go Sunning", "atomic/songs/let's_go_sunning.mp3", "1:41");
Atomic.music:Add("Lone Star", "atomic/songs/lone_star.mp3", "2:30");
Atomic.music:Add("Maybe", "atomic/songs/maybe.mp3", "2:50");
Atomic.music:Add("Mighty Mighty Man", "atomic/songs/mighty_mighty_man.mp3", "2:33");
Atomic.music:Add("Rhythm For You", "atomic/songs/rhythm_for_you.mp3", "2:59");
Atomic.music:Add("Stars Of The Midnight Range", "atomic/songs/stars_of_the_midnight.mp3", "2:52");
Atomic.music:Add("Swing Doors", "atomic/songs/swing_doors.mp3", "2:59");
Atomic.music:Add("Way Back Home", "atomic/songs/way_back_home.mp3", "2:53");