Clockwork.config:AddToSystem("Enable affective wounds", "affectivewounds_enabled", "Whether or not the affective wounds system is active.");
Clockwork.config:AddToSystem("Arm Shots Switch Weapon", "affectivewounds_affectweapon", "Whether or not arm shots will drop the weapon (2), deposit the weapon into the inventory (1) or simply switch the weapon (0).", 1, 2);
Clockwork.config:AddToSystem("Enable affective wounds leg shots", "affectivewounds_legshotenabled", "Whether or not the affective wounds system should apply to leg shots.")
Clockwork.config:AddToSystem("Enable affective wounds arm shots", "affectivewounds_armshotenabled", "Whether or not the affective wounds system should apply to arm shots.")
Clockwork.config:AddToSystem("Leg shot limit", "affectivewounds_legshotlimit", "The base amount of shots a player can take to the legs before falling over.", 1, 10)
Clockwork.config:AddToSystem("Arm shot limit", "affectivewounds_armshotlimit", "The base amount of shots a player can take to the arms before dropping their weapon.", 1, 10)
Clockwork.config:AddToSystem("Affective wounds affect OTA", "affectivewounds_affectota", "Whether or not the affective wounds system should affect the OTA.")
Clockwork.config:AddToSystem("Affective wounds affect MPF", "affectivewounds_affectmpf", "Whether or not the affective wounds system should affect the MPF.")
Clockwork.config:AddToSystem("Additional hits for OTA", "affectivewounds_additionalhitsota", "The amount of additional hits an OTA unit should be able to take. (Takes effect on next character load or fall/disarming)", 0, 10)
Clockwork.config:AddToSystem("Additional hits for MPF", "affectivewounds_additionalhitsmpf", "The amount of additional hits an MPF unit should be able to take. (Takes effect on next character load or fall/disarming)", 0, 10)