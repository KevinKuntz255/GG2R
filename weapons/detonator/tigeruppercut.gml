globalvar WEAPON_TIGERUPPERCUT;
WEAPON_TIGERUPPERCUT = 31;

globalvar TigerUppercut;
TigerUppercut = object_add();
object_set_parent(TigerUppercut, Weapon);

object_event_add(TigerUppercut,ev_create,0,'
    xoffset = -3;
    yoffset = -2;
    refireTime = 24;
    event_inherited();
    maxMines = 5;
    lobbed = 0;
    reloadTime = 17;
    reloadBuffer = 26;
    maxAmmo = 5;
    ammoCount = maxAmmo;
    idle=true;
    readyToStab=false;
    alarm[3]=1 / global.delta_factor;
    canActivate=true;
    activateTime=7;
');

global.weapons[WEAPON_TIGERUPPERCUT] = TigerUppercut;
global.name[WEAPON_TIGERUPPERCUT] = "Tiger Uppercut (unimplemented)";
