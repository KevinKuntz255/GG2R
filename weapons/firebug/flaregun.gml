globalvar WEAPON_FLAREGUN;
WEAPON_FLAREGUN = 86;

globalvar Flaregun;
Flaregun = object_add();
object_set_parent(Flaregun, FlareWeapon);

global.weapons[WEAPON_FLAREGUN] = Flaregun;
global.name[WEAPON_FLAREGUN] = "Flaregun";
