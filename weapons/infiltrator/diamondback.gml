globalvar WEAPON_DIAMONDBACK;
WEAPON_DIAMONDBACK = 72;

globalvar Diamondback;
Diamondback = object_add();
object_set_parent(Diamondback, RevolverWeapon);

object_event_add(Diamondback,ev_create,0,'
    xoffset=-4;
    yoffset=0;
    refireTime=18;
    spriteBase = "Diamondback";
    event_inherited();

    shotDamage = 24;
');
// todo: implement critShot for each player backstabbed
// implement incompatibility with zapper too
global.weapons[WEAPON_DIAMONDBACK] = Diamondback;
global.name[WEAPON_DIAMONDBACK] = "Diamondback (unfinished)";
