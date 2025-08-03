globalvar WEAPON_ATOMIZER;
WEAPON_ATOMIZER = 9;

globalvar Atomizer;
Atomizer = object_add();
object_set_parent(Atomizer, MeleeWeapon);

object_event_add(Atomizer,ev_create,0,'
    xoffset=-15;
    yoffset=-25;
    spriteBase = "Atomizer";
    event_inherited();
	trip = false;
    depth = 1;
');
// todo: move trip to owner as done in haxxy_melee_only
object_event_add(Atomizer,ev_step,ev_step_normal,'
	if (owner.doublejumpUsed and !trip){
		owner.doublejumpUsed = false;
		trip = true;
	}
	if (owner.onground)
		trip = false;
    event_inherited();
');

global.weapons[WEAPON_ATOMIZER] = Atomizer;
global.name[WEAPON_ATOMIZER] = "Atomizer (Unfinished)";
