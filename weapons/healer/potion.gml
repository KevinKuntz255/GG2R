globalvar WEAPON_POTION;
WEAPON_POTION = 49;

globalvar Brewinggun;
Brewinggun = object_add();
object_set_parent(Brewinggun, Weapon);

object_event_add(Brewinggun,ev_create,0,'
    xoffset = -7;
    yoffset = 0;
    refireTime = 30; //Was 22, 28.6-35.6 would be spread with unlimited ammo
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmount = 0.5;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    //maxAmmo = 0;
    //ammoCount = 0; workaround spotted, keeps crashin tho, so lemme jus
	maxAmmo = 1;
    ammoCount = maxAmmo;
    ammo = 3;   //workaround
    //reloadTime = 0;
    reloadTime = 1;
    reloadBuffer = 20;
    idle=true;
    loopsoundstop(UberIdleSnd);
');

global.weapons[WEAPON_POTION] = Brewinggun;
global.name[WEAPON_POTION] = "Holy Water (unimplemented)";
