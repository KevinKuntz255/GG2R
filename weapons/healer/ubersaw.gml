globalvar WEAPON_OVERDOSE;
WEAPON_OVERDOSE = 44;

globalvar Ubersaw;
Ubersaw = object_add();
object_set_parent(Ubersaw, Weapon);

object_event_add(Ubersaw,ev_create,0,'
    xoffset=-17;
    yoffset=-34;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    
    canBuff = false;
    alarm[3] = 90;
    unscopedDamage = 0;
	// TEMP
	healTarget = noone;
	if !variable_local_exists("uberCharge")
		uberCharge = 0;
	
	isMelee = true;
	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\UbersawS.png", 2, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\UbersawFS.png", 8, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\UbersawS.png", 2, 1, 0, 0, 0);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_OVERDOSE] = Ubersaw;
global.name[WEAPON_OVERDOSE] = "Ubersaw (unfinished)";
