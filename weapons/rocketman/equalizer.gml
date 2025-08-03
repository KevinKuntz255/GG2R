globalvar WEAPON_EQUALIZER;
WEAPON_EQUALIZER = 18;

globalvar Shovel;
Shovel = object_add();
object_set_parent(Shovel, MeleeWeapon);

object_event_add(Shovel,ev_create,0,'
    xoffset=1 - 32;
    yoffset=-8 - 32;
    spriteBase = "Shovel";
    event_inherited();
');

object_event_add(Shovel,ev_destroy,0,'
    event_inherited();
	owner.runPower = owner.baseRunPower;
	owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
');

object_event_add(Shovel,ev_alarm,1,'
    if (owner.hp < owner.maxHp) 
        shotDamage = 14+(((owner.maxHp+40)/(owner.hp+40))*11);
    else
        shotDamage = 10;
    event_inherited();
');

object_event_add(Shovel,ev_step,ev_step_normal,'
    event_inherited();
	if (owner.hp != owner.maxHp){
		owner.runPower = owner.baseRunPower + (owner.maxHp + 40) / (owner.hp + 40) * 0.2;
		owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
	} else {
		owner.runPower = owner.baseRunPower;
		owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
	}
');

global.weapons[WEAPON_EQUALIZER] = Shovel;
global.name[WEAPON_EQUALIZER] = "Equalizer";
