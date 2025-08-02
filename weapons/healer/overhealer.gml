globalvar WEAPON_OVERHEALER;
WEAPON_OVERHEALER = 48;

globalvar Overhealer;
Overhealer = object_add();
object_set_parent(Overhealer, Weapon);

object_event_add(Overhealer,ev_create,0,'
    xoffset = -7;
    yoffset = 0;
    refireTime = 3;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmount = 0.5;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 0;
    ammoCount = 0;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;
    loopsoundstop(UberIdleSnd);
    unscopedDamage = 0;
');

global.weapons[WEAPON_OVERHEALER] = Overhealer;
global.name[WEAPON_OVERHEALER] = "Overhealer (unimplemented)";
