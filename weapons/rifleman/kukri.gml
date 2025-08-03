globalvar WEAPON_KUKRI;
WEAPON_KUKRI = 27;

globalvar Kukri;
Kukri = object_add();
object_set_parent(Kukri, MeleeWeapon);

object_event_add(Kukri,ev_create,0,'
    xoffset=6 - 32;
    yoffset=-8 - 32;
    spriteBase = "Kukri";
    event_inherited();
');

global.weapons[WEAPON_KUKRI] = Kukri;
global.name[WEAPON_KUKRI] = "Kukri & Darwin's Danger Shield (unfinished)";
