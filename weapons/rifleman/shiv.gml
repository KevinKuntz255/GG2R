globalvar WEAPON_SHIV;
WEAPON_SHIV = 28;

globalvar Shiv;
Shiv = object_add();
object_set_parent(Shiv, MeleeWeapon);

object_event_add(Shiv,ev_create,0,'
    spriteBase = "Shiv";
    event_inherited();
');


global.weapons[WEAPON_SHIV] = Shiv;
global.name[WEAPON_SHIV] = "Tribalman's Shiv & Razorback (unfinished)";
