globalvar WEAPON_FLASHLIGHT;
WEAPON_FLASHLIGHT = 4;

globalvar Lasergun;
Lasergun = object_add();

object_set_parent(Lasergun, FlashlightWeapon);

global.weapons[WEAPON_FLASHLIGHT] = Lasergun;
global.name[WEAPON_FLASHLIGHT] = "Flashlight";
