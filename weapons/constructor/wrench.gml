globalvar WEAPON_WRENCH;
WEAPON_WRENCH = 57;

globalvar Wrench;
Wrench = object_add();
object_set_parent(Wrench, MeleeWeapon);

object_event_add(Wrench,ev_create,0,'
    xoffset=-30;
    yoffset=-39;
    spriteBase = "Wrench";
    event_inherited();
');

global.weapons[WEAPON_WRENCH] = Wrench;
global.name[WEAPON_WRENCH] = "Wrench (unfinished)";
