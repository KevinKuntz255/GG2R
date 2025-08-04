globalvar WEAPON_GRENADELAUNCHER;
WEAPON_GRENADELAUNCHER = 35;

globalvar GrenadeLauncher;
GrenadeLauncher = object_add();
object_set_parent(GrenadeLauncher, GrenadeWeapon);

global.weapons[WEAPON_GRENADELAUNCHER] = GrenadeLauncher;
global.name[WEAPON_GRENADELAUNCHER] = "Grenade Launcher (unimplemented)";
