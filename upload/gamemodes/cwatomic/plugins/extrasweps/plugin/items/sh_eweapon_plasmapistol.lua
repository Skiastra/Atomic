--[[ 
    � 2015 CloudSixteen.com do not share, re-distribute or modify
    without permission of its author (kurozael@gmail.com).

    Clockwork was created by Conna Wiles (also known as kurozael.)
    http://cloudsixteen.com/license/clockwork.html

    Atomic was developed by NightAngel, if you have any questions or
    wish to give any feedback whatsoever, please send a message to
    http://steamcommunity.com/id/NA1455.
--]]

local ITEM = Clockwork.item:New("weapon_base");
	ITEM.cost = 200;
	ITEM.health = 150;
	ITEM.name = "Plasma Pistol";
	ITEM.category = "Energy Weapons";
	ITEM.model = "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmapistol.mdl";
	ITEM.batch = 1;
	ITEM.weight = 2;
	ITEM.access = "T";
	ITEM.business = true;
	ITEM.weaponClass = "weapon_plasmapistol";
	ITEM.description = "A little pistol-looking weapon.\nThis firearm utilises Electron Charge Pack ammunition.";
	ITEM.isAttachment = true;
	ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
	ITEM.attachmentOffsetAngles = Angle(-180, 180, 90);
	ITEM.attachmentOffsetVector = Vector(-4.19, 0, -8.54);
	ITEM.loweredAngles = Angle(-35, 10, -14);
ITEM:Register();