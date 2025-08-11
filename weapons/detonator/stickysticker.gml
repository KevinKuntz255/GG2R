globalvar WEAPON_STICKYSTICKER;
WEAPON_STICKYSTICKER = 34;

globalvar Stickysticker;
Stickysticker = object_add();
object_set_parent(Stickysticker, Weapon);

object_event_add(Stickysticker,ev_create,0,'
    xoffset = -3;
    yoffset = -2;
    refireTime = 26;
    event_inherited();
    maxMines = 8;
    lobbed = 0;
    reloadTime = 20;
    reloadBuffer = 26;
    maxAmmo = 8;
    ammoCount = maxAmmo;
    idle=true;
');

global.weapons[WEAPON_STICKYSTICKER] = Stickysticker;
global.name[WEAPON_STICKYSTICKER] = "Stucky Charm (unimplemented)";
