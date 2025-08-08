// Introduce Metered weapons

globalvar WEAPON_BUFFBANNER;
WEAPON_BUFFBANNER = 16;

globalvar BuffBanner;
BuffBanner = object_add();
object_set_parent(BuffBanner, BannerWeapon);

object_event_add(BuffBanner,ev_create,0,'
    xoffset=-9;
    yoffset=-9;
    event_inherited();
    maxAmmo = 1; // this dont matter
	maxMeter = 4;
	meterCount = 0;
    ammoCount = maxAmmo;
    reloadTime = 500;
    reloadBuffer = 18;
    idle=true;
    readyToStab=false;
    image_speed = 0;
    unscopedDamage = 0;
	isMelee = true;
	
    weaponGrade = UNIQUE;
    weaponType = BANNER;

	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BuffBannerS.png", 2, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BuffBannerS.png", 2, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BuffBannerS.png", 2, 1, 0, 0, 0);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(BuffBanner,ev_other,ev_user1,'
	if (!owner.cloak && meterCount >= maxMeter)
	{
		meterCount = 0;
		playsound(x,y,BuffbannerSnd);
        owner.canSwitch = false;
	}
');

global.weapons[WEAPON_BUFFBANNER] = BuffBanner;
global.name[WEAPON_BUFFBANNER] = "Buff Banner (spriteonly)";
