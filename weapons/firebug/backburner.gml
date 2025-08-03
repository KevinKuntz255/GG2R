globalvar WEAPON_BACKBURNER;
WEAPON_BACKBURNER = 81; //swapped values

globalvar Backburner;
Backburner = object_add();
object_set_parent(Backburner, FlameWeapon);

object_event_add(Backburner,ev_create,0,'
    xoffset = -6;
    yoffset = 6;
    event_inherited();
    blastDrain = 70;
    flameDamage = 3.77;
');

global.weapons[WEAPON_BACKBURNER] = Backburner;
global.name[WEAPON_BACKBURNER] = "Backburner";
