globalvar WEAPON_PISTOL;
WEAPON_PISTOL = 5;

globalvar Pistol;
Pistol = object_add();
object_set_parent(Pistol, PistolWeapon);
// no object necessary, only one pistol so far.

global.weapons[WEAPON_PISTOL] = Pistol;
global.name[WEAPON_PISTOL] = "Pistol";
