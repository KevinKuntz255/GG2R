globalvar WEAPON_CHOCOLATE;
WEAPON_CHOCOLATE = 68;

globalvar ChocolateHand;
ChocolateHand = object_add();
object_set_parent(ChocolateHand, Weapon);

object_event_add(ChocolateHand,ev_create,0,'
    xoffset=-12;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    maxAmmo = 1
    ammoCount = maxAmmo;
    reloadTime = 450;
    reloadBuffer = 18;
    idle=true;
    readyToStab=false;
');

global.weapons[WEAPON_CHOCOLATE] = ChocolateHand;
global.name[WEAPON_CHOCOLATE] = "Dalokohs Bar (unimplemented)"
