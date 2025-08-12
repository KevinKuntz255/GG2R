globalvar WEAPON_KRITSKRIEG;
WEAPON_KRITSKRIEG = 46;

// there was a minor spelling mistake. 3 programmers in and this hasn't been fixed? For Shame!!!!!!
globalvar Kritzkrieg;
Kritzkrieg = object_add();
object_set_parent(Kritzkrieg, Weapon);

object_event_add(Kritzkrieg,ev_create,0,'
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
    uberType = KRITZ;
    uberReady=false;
    maxAmmo = 0;
    ammoCount = 0;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;
    loopsoundstop(UberIdleSnd);
');

global.weapons[WEAPON_KRITSKRIEG] = Kritzkrieg;
global.name[WEAPON_KRITSKRIEG] = "Kritzkrieg (unimplemented)"
