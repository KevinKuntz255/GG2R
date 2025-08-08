globalvar WEAPON_GRENADELAUNCHER;
WEAPON_GRENADELAUNCHER = 35;

globalvar GrenadeLauncher;
GrenadeLauncher = object_add();
object_set_parent(GrenadeLauncher, GrenadeWeapon);

object_event_add(GrenadeLauncher, ev_create, 0, '
	xoffset = 2;
    yoffset = 4;
    refireTime = 28;
    event_inherited();
');

global.weapons[WEAPON_GRENADELAUNCHER] = GrenadeLauncher;
global.name[WEAPON_GRENADELAUNCHER] = "Grenade Launcher";
