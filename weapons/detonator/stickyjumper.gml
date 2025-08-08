globalvar WEAPON_STICKYJUMPER;
WEAPON_STICKYJUMPER = 33;

globalvar StickyJumper;
StickyJumper = object_add();
object_set_parent(StickyJumper, MineWeapon);

object_event_add(StickyJumper,ev_create,0,'
    xoffset = -3;
    yoffset = 2;
    refireTime = 26;
    spriteBase = "StickyJumper";
    event_inherited();
    maxAmmo = 12;
    ammoCount = maxAmmo;
    mineDamage = 0;
    specialProjectile = JumperMine;
');

global.weapons[WEAPON_STICKYJUMPER] = StickyJumper;
global.name[WEAPON_STICKYJUMPER] = "Sticky Jumper";
