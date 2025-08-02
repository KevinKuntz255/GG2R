globalvar WEAPON_SODAPOPPER;
WEAPON_SODAPOPPER = 3;

globalvar SodaPopper;
SodaPopper = object_add();
object_set_parent(SodaPopper, Weapon);
object_set_sprite(SodaPopper, sprite_add(pluginFilePath + "\randomizer_sprites\SodaPopperS.png", 2, 1, 0, 8, -2));

object_event_add(SodaPopper,ev_create,0,'
    xoffset=-5;
    yoffset=-4;
    refireTime=12;
    event_inherited();
    maxAmmo = 2;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 20;
    idle=true;

	hasMeter = true;
	meterName = "HYPE";
	maxMeter=210;
	meterCount=0;
	abilityActive = false;
    abilityVisual = "WEAPON";
    //ability = MINICRIT;
	
    weaponGrade = UNIQUE;
    weaponType = SCATTERGUN;
    fullReload = true;

    shotSpeed[0] = 4;
    shotSpeed[1] = 11;
    shotDir[0] = 15;
    shotDir[1] = 7;
    shots = 6;
    shotDamage = 8;
    

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SodaPopperS.png", 2, 1, 0, 8, -2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SodaPopperFS.png", 4, 1, 0, 8, -2);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SodaPopperFRS.png", 16, 1, 0, 12, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(SodaPopper,ev_step,ev_step_normal, '
	if meterCount >= maxMeter {
		abilityActive = true;
	}
	if (abilityActive) {
		meterCount -= 1;
    }
	if (meterCount <= 0) {
		abilityActive = false;
        if (owner.curMeter == 0) owner.meter[0] = 0; else owner.meter[1] = 0;
    }
');

global.weapons[WEAPON_SODAPOPPER] = SodaPopper;
global.name[WEAPON_SODAPOPPER] = "Soda Popper";
