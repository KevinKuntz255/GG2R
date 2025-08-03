globalvar WEAPON_KNIFE;
WEAPON_KNIFE = 75;

globalvar Knife;
Knife = object_add();
object_set_parent(Knife, MeleeWeapon);

object_event_add(Knife,ev_create,0,'
    xoffset=5 - 32;
    yoffset=-6 - 32;
    event_inherited();
');

global.weapons[WEAPON_KNIFE] = Knife;
global.name[WEAPON_KNIFE] = "Knife";
