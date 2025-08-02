globalvar WEAPON_EUREKAEFFECT;
WEAPON_EUREKAEFFECT = 59;

globalvar Eeffect;
Eeffect = object_add();
object_set_parent(Eeffect, Weapon);

object_event_add(Eeffect,ev_create,0,'
    xoffset=-30;
    yoffset=-39;
    refireTime=18;
    event_inherited();
    StabreloadTime = 7;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 100;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    cooldown = 0;
    unscopedDamage = 0;
');

global.weapons[WEAPON_EUREKAEFFECT] = Eeffect;
global.name[WEAPON_EUREKAEFFECT] = "Eureka Effect (unimplemented)";
