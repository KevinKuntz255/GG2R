globalvar WEAPON_JARATE;
WEAPON_JARATE = 26;

globalvar JarateHand;
JarateHand = object_add();
object_set_parent(JarateHand, ThrowableWeapon);

object_event_add(JarateHand,ev_create,0,'
    xoffset=-12;
    yoffset=-8;
    refireTime=18;
    event_inherited();

    throwProjectile = JarOPiss;
');

global.weapons[WEAPON_JARATE] = JarateHand;
global.name[WEAPON_JARATE] = "Jarate";
