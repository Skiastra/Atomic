local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("AdminPlayTime");
COMMAND.tip = "See someone's playtime.";
COMMAND.text = "<string Name>";
COMMAND.arguments = 1
COMMAND.access = "o";

function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1])
	
	if !target then
		Clockwork.player:Notify(target, target:Name().." is not a valid player!");
		return
	end;
	
	local playTime = ConvertSecondsToMultiples(target:PlayTime())
	local charPlayTime = ConvertSecondsToMultiples(target:CharPlayTime())
	
	local days = playTime.days
	local minutes = playTime.minutes
	local hours = playTime.hours
	local seconds = playTime.seconds
	
	local chardays = charPlayTime.days
	local charminutes = charPlayTime.minutes
	local charhours = charPlayTime.hours
	local charseconds = charPlayTime.seconds
	
	Clockwork.player:Notify(player, target:Name().." has played on the server for: "..days.." Days - "..hours.." Hours - "..minutes.." Minutes - "..seconds.." Seconds.")
	Clockwork.player:Notify(player, target:Name().." has played on this character for: "..chardays.." Days - "..charhours.." Hours - "..charminutes.." Minutes - "..charseconds.." Seconds.")
end;

COMMAND:Register();