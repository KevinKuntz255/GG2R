globalvar WEAPON_STICKYJUMPER;
WEAPON_STICKYJUMPER = 33;

globalvar StickyJumper;
StickyJumper = object_add();
object_set_parent(StickyJumper, Weapon);

object_event_add(StickyJumper,ev_create,0,'
    xoffset = -3;
    yoffset = -2;
    refireTime = 26;
    event_inherited();
    maxMines = 8;
    lobbed = 0;
    reloadTime = 20;
    reloadBuffer = 26;
    maxAmmo = 12;
    ammoCount = maxAmmo;
    idle=true;
    unscopedDamage = 0;
');

global.weapons[WEAPON_STICKYJUMPER] = StickyJumper;
global.name[WEAPON_STICKYJUMPER] = "Sticky Jumper (unimplemented)";
