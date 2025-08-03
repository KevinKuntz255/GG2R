globalvar WEAPON_SMG;
WEAPON_SMG = 25;

globalvar Smg;
Smg = object_add();
object_set_parent(Smg, smgWeapon);

global.weapons[WEAPON_SMG] = Smg;
global.name[WEAPON_SMG] = "SMG";
