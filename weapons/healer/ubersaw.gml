globalvar WEAPON_OVERDOSE;
WEAPON_OVERDOSE = 44;

globalvar Ubersaw;
Ubersaw = object_add();
object_set_parent(Ubersaw, MeleeWeapon);

object_event_add(Ubersaw,ev_create,0,'
    xoffset=-17;
    yoffset=-34;
    spriteBase = "Ubersaw";
    event_inherited();
    
    depth = 1;
    
    canBuff = false;
    alarm[3] = 90 / global.delta_factor;
	// TEMP
	healTarget = noone;
	if !variable_local_exists("uberCharge")
		uberCharge = 0;
');

global.weapons[WEAPON_OVERDOSE] = Ubersaw;
global.name[WEAPON_OVERDOSE] = "Ubersaw (unfinished)";
