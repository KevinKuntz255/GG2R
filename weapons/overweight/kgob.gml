globalvar WEAPON_KGOB;
WEAPON_KGOB = 69;

globalvar KGOB;
KGOB = object_add();
object_set_parent(KGOB, MeleeWeapon);

object_event_add(KGOB,ev_create,0,'
    xoffset=-12;
    yoffset=-5 - 10;
    spriteBase = "BoxingGloves";
    event_inherited();
');

global.weapons[WEAPON_KGOB] = KGOB;
global.name[WEAPON_KGOB] = "Killing Gloves Of Boxing";
