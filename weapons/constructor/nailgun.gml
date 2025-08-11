globalvar WEAPON_NAILGUN;
WEAPON_NAILGUN = 55;

globalvar Nailgun;
Nailgun = object_add();
object_set_parent(Nailgun, Weapon);

object_event_add(Nailgun,ev_create,0,'
    xoffset=-3;
    yoffset=-6;
    refireTime=6;
    event_inherited();
    maxAmmo = 0;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 20;
    idle=true;
');

global.weapons[WEAPON_NAILGUN] = Nailgun;
global.name[WEAPON_NAILGUN] = "Nailgun (unimplemented)";
