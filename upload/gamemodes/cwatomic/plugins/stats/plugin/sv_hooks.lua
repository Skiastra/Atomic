-- Called when the Clockwork database has connected.
function cwStats:ClockworkDatabaseConnected()
	local CREATE_STATS_TABLE = [[
	CREATE TABLE IF NOT EXISTS `statistics` (
		`_ServerName` varchar(255) NOT NULL,
		`_Stat` varchar(255) NOT NULL,
		`_Value` varchar(255) NOT NULL,
		PRIMARY KEY (`_Stat`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;]];
		
	Clockwork.database:Query(string.gsub(CREATE_STATS_TABLE, "%s", " "), nil, nil, true);

	local isS2K = Clockwork.config:Get("is_s2k"):Get();
	local serverName = (isS2K and "S2K") or "SRP";

	-- Fill the serverside cache with all the current statistic entries.
	local queryObj = Clockwork.database:Select("statistics");
		queryObj:AddColumn("_Value");
		queryObj:AddColumn("_Stat");
		queryObj:AddWhere("_ServerName = ?", serverName);
		queryObj:SetCallback(function(result)
			if (Clockwork.database:IsResult(result)) then
				for k, v in pairs(result) do
					self.global[v._Stat] = v._Value;
				end;
			end;
		end);
	queryObj:Pull();
end;

-- Called when a chat box message has been added.
function cwStats:ChatBoxMessageAdded(info)
	if (IsValid(info.speaker)) then
		self:AddStat(info.speaker, "chat_"..info.class, 1);
		self:AddStat(info.speaker, "chat_overall", 1);
	end;
end;

function cwStats:PostPlayerSpawn(player)
	player.lastCash = player:GetCash();
end;

function cwStats:PlayerCashUpdated(player, roundedAmount, reason, bNoMsg)
	local difference = player.lastCash - player:GetCash();

	if (difference > 0) then
		self:AddStat(player, "cash_lost_overall", roundedAmount);

		if (reason) then
			self:AddStat(player, "cash_lost_"..string.lower(reason), roundedAmount);
		end;
	elseif (difference < 0) then
		self:AddStat(player, "cash_gained_overall", roundedAmount);

		if (reason) then
			self:AddStat(player, "cash_gained_"..string.lower(reason), roundedAmount);
		end;
	end;

	player.lastCash = player:GetCash();
end;

local damageTypes = {
	[DMG_GENERIC] = "generic",
	[DMG_CRUSH] = "crush",
	[DMG_BULLET] = "bullet",
	[DMG_SLASH] = "slash",
	[DMG_BURN] = "burn",
	[DMG_VEHICLE] = "vehicle",
	[DMG_FALL] = "fall",
	[DMG_BLAST] = "blast",
	[DMG_CLUB] = "club",
	[DMG_SHOCK] = "shock",
	[DMG_SONIC] = "sonic",
	[DMG_ENERGYBEAM] = "energy_beam",
	[DMG_DROWN] = "drown",
	[DMG_PARALYZE] = "poison",
	[DMG_NERVEGAS] = "nerve_gas",
	[DMG_POISON] = "poison",
	[DMG_ACID] = "acid",
	[DMG_AIRBOAT] = "airboat",
	[DMG_BUCKSHOT] = "buckshot",
	[DMG_DIRECT] = "direct",
	[DMG_DISSOLVE] = "dissolve",
	[DMG_PHYSGUN] = "physgun",
	[DMG_PLASMA] = "plasma",
	[DMG_RADIATION] = "radiation",
	[DMG_SLOWBURN] = "slow_burn"
};

function cwStats:PlayerDeath(player, inflictor, attacker, damageInfo)
	local damageAmount = (damageInfo and math.floor(damageInfo:GetDamage())) or 0;
	local attackerValid = IsValid(attacker);
	local class = nil;

	if (IsValid(player)) then
		if (attackerValid) then
			local activeWep = attacker:GetActiveWeapon();

			if (IsValid(activeWep)) then
				class = string.lower(activeWep:GetClass());
			end;

			if (class and class != "") then
				self:AddStat(player, "deaths_"..class, 1);
				self:AddStat(player, "damage_taken_"..class, damageAmount);	
			end;
		end;

		for k, v in pairs(damageTypes) do
			if (damageInfo and damageInfo:IsDamageType(k)) then
				self:AddStat(player, "deaths_dmgtype_"..v, 1);
				self:AddStat(player, "damage_taken_dmgtype_"..v, damageAmount);
			end;
		end;

		self:AddStat(player, "deaths_overall", 1);
		self:AddStat(player, "damage_taken_overall", damageAmount);
	end;

	if (attackerValid and attacker:IsPlayer()) then
		if (class and class != "") then
			self:AddStat(attacker, "kills_"..class, 1);
			self:AddStat(attacker, "damage_given_"..class, damageAmount);
			self:AddStat(attacker, "shots_hit_"..class, 1);
		end;

		self:AddStat(attacker, "shots_hit_overall", 1);

		for k, v in pairs(damageTypes) do
			if (damageInfo and damageInfo:IsDamageType(k)) then
				self:AddStat(attacker, "kills_dmgtype_"..v, 1);
				self:AddStat(attacker, "damage_given_dmgtype_"..v, damageAmount);
			end;
		end;

		self:AddStat(attacker, "kills_overall", 1);
		self:AddStat(attacker, "damage_given_overall", damageAmount);
	end;
end;

function cwStats:PlayerTakeDamage(player, inflictor, attacker, hitGroup, damageInfo)
	local damageAmount = math.floor(damageInfo:GetDamage());
	local attackerValid = IsValid(attacker);
	local class = nil;

	if (IsValid(player)) then
		if (attackerValid) then
			local activeWep = attacker:GetActiveWeapon();

			if (IsValid(activeWep)) then
				class = string.lower(activeWep:GetClass());
			end;

			if (class and class != "") then
				self:AddStat(player, "damage_taken_"..class, damageAmount);
			end;
		end;

		for k, v in pairs(damageTypes) do
			if (damageInfo:IsDamageType(k)) then
				self:AddStat(player, "damage_taken_dmgtype_"..v, damageAmount);
			end;
		end;

		self:AddStat(player, "damage_taken_overall", damageAmount);
	end;

	if (attackerValid and attacker:IsPlayer()) then
		if (class and class != "") then
			self:AddStat(attacker, "damage_given_"..class, damageAmount);
			self:AddStat(attacker, "shots_hit_"..class, 1);
		end;

		self:AddStat(attacker, "shots_hit_overall", 1);

		for k, v in pairs(damageTypes) do
			if (damageInfo:IsDamageType(k)) then
				self:AddStat(attacker, "damage_given_dmgtype_"..v, damageAmount);
			end;
		end;

		self:AddStat(attacker, "damage_given_overall", damageAmount);
	end;
end;

local entMeta = FindMetaTable("Entity");

entMeta.cwStatsFireBullets = entMeta.cwStatsFireBullets or entMeta.FireBullets;

function entMeta:FireBullets(bulletInfo)
	local player = self;

	if (!player:IsPlayer()) then
		local owner = player:GetOwner();

		if (owner:IsPlayer()) then
			player = owner;
		else
			return;
		end;
	end;

	local weapon = player:GetActiveWeapon();

	if (IsValid(weapon)) then
		cwStats:AddStat(player, "shots_fired_"..weapon:GetClass(), bulletInfo.Num);
	end;

	cwStats:AddStat(player, "shots_fired_overall", bulletInfo.Num);

	return self:cwStatsFireBullets(bulletInfo);
end;