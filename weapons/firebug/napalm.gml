globalvar WEAPON_NAPALM;
WEAPON_NAPALM = 88;

globalvar NapalmHand;
NapalmHand = object_add();
object_set_parent(NapalmHand, ThrowableWeapon);

object_event_add(NapalmHand,ev_create,0,' //do this later
    xoffset=2;
    yoffset=-2;
    event_inherited();
    reloadTime = 240;

    isMetered = true;

    // todo: meter

    throwProjectile = NapalmGrenade;
    shotSpeed = 12.5;
    randomDir = false;
');

global.weapons[WEAPON_NAPALM] = NapalmHand;
global.name[WEAPON_NAPALM] = "Napalm Grenade (unfinished)";
