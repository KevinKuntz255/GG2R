globalvar WEAPON_MACHINA;
WEAPON_MACHINA = 23;

globalvar Machina;
Machina = object_add();
object_set_parent(Machina, RifleWeapon);

object_event_add(Machina,ev_create,0,'
    spriteBase="Machina";
    event_inherited();
    reloadTime = 70;
');

global.weapons[WEAPON_MACHINA] = Machina;
global.name[WEAPON_MACHINA] = "Machina (unfinished)";
