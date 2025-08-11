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
	maxMeter = 4;
	meter = 0;
    readyToStab=false;
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
	if (!owner.cloak && owner.meter[ownerPlayer.activeWeapon] >= owner.maxMeter[ownerPlayer.activeWeapon])
	{
		owner.meter[ownerPlayer.activeWeapon] = 0;
		playsound(x,y,BuffbannerSnd);
	}
');

global.weapons[WEAPON_BUFFBANNER] = BuffBanner;
global.name[WEAPON_BUFFBANNER] = "Buff Banner";
