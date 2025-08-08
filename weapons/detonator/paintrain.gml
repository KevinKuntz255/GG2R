globalvar WEAPON_PAINTRAIN;
WEAPON_PAINTRAIN = 38;

globalvar Paintrain;
Paintrain = object_add();
object_set_parent(Paintrain, MeleeWeapon);

object_event_add(Paintrain,ev_create,0,'
	xoffset=-9;
	yoffset=-40;
	spriteBase = "PainTrain";
	event_inherited();	
	maxMines = 14;
	lobbed = 0;
	
	//owner.runPower = 5;
');
object_event_add(Paintrain,ev_destroy,0,'
    event_inherited();
	owner.capStrength = 1;
');

global.weapons[WEAPON_PAINTRAIN] = Paintrain;
global.name[WEAPON_PAINTRAIN] = "Paintrain";
