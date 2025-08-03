globalvar WEAPON_BIGEARNER;
WEAPON_BIGEARNER = 77;

globalvar BigEarner;
BigEarner = object_add();
object_set_parent(BigEarner, MeleeWeapon);

object_event_add(BigEarner,ev_create,0,'
    xoffset=5 - 32;
    yoffset=-6 - 32;
    spriteBase = "BigEarner";
    event_inherited();
');

global.weapons[WEAPON_BIGEARNER] = BigEarner;
global.name[WEAPON_BIGEARNER] = "Big Earner (unfinished)";
