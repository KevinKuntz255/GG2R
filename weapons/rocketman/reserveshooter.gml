globalvar WEAPON_RESERVESHOOTER;
WEAPON_RESERVESHOOTER = 19;

globalvar Reserveshooter;
Reserveshooter = object_add();
object_set_parent(Reserveshooter, ShotgunWeapon);

object_event_add(Reserveshooter,ev_create,0,'
    xoffset=1;
    yoffset=4;
    spriteBase = "reserveshooter";
    event_inherited();
    maxAmmo = 4;
    ammoCount = maxAmmo;
    readyToShoot=true;
');

object_event_add(Reserveshooter,ev_alarm,5,'
    event_inherited();

    if ammoCount >= maxAmmo owner.canSwitch = true;
');

object_event_add(Reserveshooter,ev_step,ev_step_normal,'
    if(ammoCount >= maxAmmo){
        owner.canSwitch = true;
    }else{
        owner.canSwitch = false;
    }
');

global.weapons[WEAPON_RESERVESHOOTER] = Reserveshooter;
global.name[WEAPON_RESERVESHOOTER] = "Reserve Shooter";
