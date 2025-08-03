globalvar WEAPON_MADMILK;
WEAPON_MADMILK = 8;

globalvar MadmilkHand;
MadmilkHand = object_add();
object_set_parent(MadmilkHand, ThrowableWeapon);

object_event_add(MadmilkHand,ev_create,0,'
    xoffset=-10;
    yoffset=-8;
    spriteBase = "MadMilkHand";
    event_inherited();

    throwProjectile = MadMilk;

');

global.weapons[WEAPON_MADMILK] = MadmilkHand;
global.name[WEAPON_MADMILK] = "Madmilk";
