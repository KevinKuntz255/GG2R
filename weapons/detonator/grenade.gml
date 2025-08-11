globalvar WEAPON_GRENADE;
WEAPON_GRENADE = 39;

globalvar GrenadeHand;
GrenadeHand = object_add();
object_set_parent(GrenadeHand, Weapon);

object_event_add(GrenadeHand,ev_create,0,'
    xoffset=-33;
    yoffset=-40;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    image_speed=0;
    
    readyToShoot=false;
    stabdirection=0;
    maxAmmo = 2;
    ammoCount = maxAmmo;
    reloadTime = 44;
    reloadBuffer = 26;
    idle=true;
    time = 0;
    charge = 0;
	lobbed=0;
');

global.weapons[WEAPON_GRENADE] = GrenadeHand;
global.name[WEAPON_GRENADE] = "Hand Grenade (unimplemented)";
