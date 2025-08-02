globalvar WEAPON_POMSON;
WEAPON_POMSON = 53;

globalvar Pumson;
Pumson = object_add();
object_set_parent(Pumson, Weapon);

object_event_add(Pumson,ev_create,0,'
    xoffset=-8;
    yoffset=-2;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    unscopedDamage = 0;
');

global.weapons[WEAPON_POMSON] = Pumson;
global.name[WEAPON_POMSON] = "Pomson 6000 (unimplemented)";
