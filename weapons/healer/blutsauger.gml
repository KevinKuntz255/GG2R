globalvar WEAPON_BLUTSAUGER;
WEAPON_BLUTSAUGER = 41;

globalvar Blutsauger;
Blutsauger = object_add();
object_set_parent(Blutsauger, Weapon);

object_event_add(Blutsauger,ev_create,0,'
    xoffset = -7;
    yoffset = -3;
    refireTime = 3;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmmount = 1;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 40
    ammoCount = maxAmmo;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;
    unscopedDamage = 0;
');

global.weapons[WEAPON_BLUTSAUGER] = Blutsauger;
global.name[WEAPON_BLUTSAUGER] = "Blutsauger (unimplemented)";
