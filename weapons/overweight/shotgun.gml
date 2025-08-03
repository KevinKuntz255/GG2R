globalvar WEAPON_HEAVYSHOTGUN;
WEAPON_HEAVYSHOTGUN = 65;

globalvar HeavyShotgun;
HeavyShotgun = object_add();
object_set_parent(HeavyShotgun, ShotgunWeapon);

object_event_add(HeavyShotgun,ev_create,0,'
    xoffset=3;
    yoffset=-3;
    spriteBase = "HeavyShotty";
    event_inherited();
');

global.weapons[WEAPON_HEAVYSHOTGUN] = HeavyShotgun;
global.name[WEAPON_HEAVYSHOTGUN] = "Shotgun";
