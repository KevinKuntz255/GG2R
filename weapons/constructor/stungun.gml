globalvar WEAPON_STUNGUN;
WEAPON_STUNGUN = 56;

globalvar Stungun;
Stungun = object_add();
object_set_parent(Stungun, Weapon);

object_event_add(Stungun,ev_create,0,'
    xoffset=-3;
    yoffset=-6;
    refireTime=6;
    event_inherited();
    maxAmmo = 100;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 20;
    idle=true;
    hasShot=true;
');

global.weapons[WEAPON_STUNGUN] = Stungun;
global.name[WEAPON_STUNGUN] = "Stungun (unimplemented)";
