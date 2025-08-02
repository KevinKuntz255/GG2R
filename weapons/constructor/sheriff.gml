globalvar WEAPON_SHERIFF;
WEAPON_SHERIFF = 52;

globalvar Sheriff;
Sheriff = object_add();
object_set_parent(Sheriff, Weapon);

object_event_add(Sheriff,ev_create,0,'
    xoffset=-5;
    yoffset=-2;
    refireTime=20;
    event_inherited();
    maxAmmo = 3;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    unscopedDamage = 0;
');

global.weapons[WEAPON_SHERIFF] = Sheriff;
global.name[WEAPON_SHERIFF] = "The Sheriff (unimplemented)";
