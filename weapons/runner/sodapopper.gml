globalvar WEAPON_SODAPOPPER;
WEAPON_SODAPOPPER = 3;

globalvar SodaPopper;
SodaPopper = object_add();
object_set_parent(SodaPopper, ScattergunWeapon);
object_set_sprite(SodaPopper, sprite_add(pluginFilePath + "\randomizer_sprites\SodaPopperS.png", 2, 1, 0, 8, -2));

object_event_add(SodaPopper,ev_create,0,'
    xoffset=-5;
    yoffset=-4;
    refireTime=12;
    spriteBase = "SodaPopper";
    event_inherited();
    maxAmmo = 2;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 20;

	abilityName = "HYPE";
	maxMeter=210;
	meter=0;
    abilityVisual = "WEAPON";
    ability = MINICRIT;
	
    weaponGrade = UNIQUE;
    weaponType = SCATTERGUN;
    fullReload = true;

    shotSpeed[1] = 11;
    shotDamage = 8;

    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FRS.png", 16, 1, 0, 12, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_SODAPOPPER] = SodaPopper;
global.name[WEAPON_SODAPOPPER] = "Soda Popper";
