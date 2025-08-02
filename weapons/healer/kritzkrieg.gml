globalvar WEAPON_KRITSKRIEG;
WEAPON_KRITSKRIEG = 46;

globalvar Kritzieg;
Kritzieg = object_add();
object_set_parent(Kritzieg, Weapon);

object_event_add(Kritzieg,ev_create,0,'
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

global.weapons[WEAPON_KRITSKRIEG] = Kritzieg;
global.name[WEAPON_KRITSKRIEG] = "Kritzkrieg (unimplemented)"
