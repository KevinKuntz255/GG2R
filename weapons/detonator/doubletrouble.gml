globalvar WEAPON_DOUBLETROUBLE;
WEAPON_DOUBLETROUBLE = 36;

globalvar DoubleTrouble;
DoubleTrouble = object_add();
object_set_parent(DoubleTrouble, Weapon);

object_event_add(DoubleTrouble,ev_create,0,'
    xoffset = -8;
    yoffset = -2;
    refireTime = 26;
    event_inherited();
    maxMines = 8;
    lobbed = 0;
    reloadTime = 20;
    reloadBuffer = 26;
    maxAmmo = 2;
    ammoCount = maxAmmo;
    idle=true;
    unscopedDamage = 0;
');

global.weapons[WEAPON_DOUBLETROUBLE] = DoubleTrouble;
global.name[WEAPON_DOUBLETROUBLE] = "Double Trouble (unimplemented)";
