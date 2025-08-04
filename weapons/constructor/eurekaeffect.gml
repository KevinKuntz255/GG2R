globalvar WEAPON_EUREKAEFFECT;
WEAPON_EUREKAEFFECT = 59;

globalvar Eeffect;
Eeffect = object_add();
object_set_parent(Eeffect, MeleeWeapon);

object_event_add(Eeffect,ev_create,0,'
    xoffset=-30;
    yoffset=-39;
    spriteBase = "Wrench";
    event_inherited();
');

global.weapons[WEAPON_EUREKAEFFECT] = Eeffect;
global.name[WEAPON_EUREKAEFFECT] = "Eureka Effect (unimplemented)";
