globalvar WEAPON_CROSSBOW;
WEAPON_CROSSBOW = 43;

globalvar Crossbow;
Crossbow = object_add();
object_set_parent(Crossbow, Weapon);

object_event_add(Crossbow,ev_create,0,'
    xoffset = -7;
    yoffset = -3;
    refireTime = 35;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmmount = 1;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 35;
    reloadBuffer = 0;
    idle=true;
    unscopedDamage = 0;
');

global.weapons[WEAPON_CROSSBOW] = Crossbow;
global.name[WEAPON_CROSSBOW] = "Crusader's Crossbow (unimplemented)";
