globalvar WEAPON_EQUALIZER;
WEAPON_EQUALIZER = 18;

globalvar Shovel;
Shovel = object_add();
object_set_parent(Shovel, MeleeWeapon);

object_event_add(Shovel,ev_create,0,'
    xoffset=1;
    yoffset=-8;
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
    isMelee = true;

    weaponGrade = UNIQUE;
    weaponType = MELEE;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShovelS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShovelFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShovelS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
	
	//owner.runPower = 5;
');

object_event_add(Shovel,ev_destroy,0,'
    event_inherited();
	owner.runPower = owner.baseRunPower;
	owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
');

object_event_add(Shovel,ev_alarm,1,'
    if (owner.hp < owner.maxHp) 
        shotDamage = 14+(((owner.maxHp+40)/(owner.hp+40))*11);
    else
        shotDamage = 10;
    event_inherited();
');

object_event_add(Shovel,ev_step,ev_step_normal,'
    event_inherited();
	if (owner.hp != owner.maxHp){
		owner.runPower = owner.baseRunPower + (owner.maxHp + 40) / (owner.hp + 40) * 0.2;
		owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
	} else {
		owner.runPower = owner.baseRunPower;
		owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
	}
');

global.weapons[WEAPON_EQUALIZER] = Shovel;
global.name[WEAPON_EQUALIZER] = "Equalizer";
