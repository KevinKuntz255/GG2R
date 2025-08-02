globalvar WEAPON_NEEDLEGUN;
WEAPON_NEEDLEGUN = 40;

globalvar Needlegun;
Needlegun = object_add();
object_set_parent(Needlegun, Weapon);

object_event_add(Needlegun,ev_create,0,'
    xoffset = -7;
    yoffset = -3;
    refireTime = 3;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmmount = 2/3;
    hphealed = 0;
    maxHealDistance = 300;
    maxMouseSelectDistance = 150;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 40
    ammoCount = maxAmmo;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;

    // Threshhold system numbers
    healTierHealth = 125; // HP above which healing is slowed
    healTierAmount = 0.75; // Factor to which healing is slowed (stacks with healing ramp)


    normalSprite = MedigunGoldS;
    recoilSprite = MedigunGoldFS;
    reloadSprite = MedigunGoldFRS;

    normalSprite = MedigunS;
    recoilSprite = MedigunFS;
    reloadSprite = MedigunFRS;

    sprite_index = normalSprite;
        
    //This makes it so that the timer will keep resetting
    //Until Mouse1 is let go
    recoilTime = refireTime+1;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_NEEDLEGUN] = Needlegun;
global.name[WEAPON_NEEDLEGUN] = "Needlegun (unimplemented)";
