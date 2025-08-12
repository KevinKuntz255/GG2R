globalvar WEAPON_QUICKFIX;
WEAPON_QUICKFIX = 47;

globalvar QuickFix;
QuickFix = object_add();
object_set_parent(QuickFix, Weapon);

object_event_add(QuickFix,ev_create,0,'
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
    uberType = FIX;
    uberReady=false;
    maxAmmo = 2000;
    ammoCount = 0;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;
');

global.weapons[WEAPON_QUICKFIX] = QuickFix;
global.name[WEAPON_QUICKFIX] = "Quickfix (unimplemented)";
