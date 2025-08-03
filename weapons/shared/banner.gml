globalvar BannerWeapon;
BannerWeapon = object_add();
object_set_parent(BannerWeapon, Weapon);

object_event_add(BannerWeapon, ev_create, 0, '
    xoffset=-12;
    yoffset=3;
    refireTime=18;
    event_inherited();

    isMelee = true;

    maxAmmo = 1;
    ammoCount = maxAmmo;

    weaponGrade = UNIQUE;
    weaponType = BANNER;

    reloadTime = 300;
    reloadBuffer = refireTime;

    shotSpeed = 13;
    
    throwProjectile = -1;
    projectileSpeed = 13;
    randomDir = false;
    projectileDir[0] = 7;
    projectileDir[1] = 4;

    if (!variable_local_exists("spriteBase")) spriteBase = "JarateHand";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 4, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 4, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 4, 1, 0, 0, 0);

    sprite_index = normalSprite;

    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');


object_event_add(BannerWeapon, ev_alarm, 5,'
    event_inherited();

    ammoCount = maxAmmo;
    if meterCount != -1 meterCount = maxMeter;
');

object_event_add(BannerWeapon,ev_alarm,6,'
    if (reloadSprite != -1 && object_index != Rifle && alarm[5] > 0)
    {
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = 0;
    } 
    else
    {
        sprite_index = normalSprite;
        image_speed = 0;
    }
');

object_event_add(BannerWeapon,ev_step,ev_step_normal,'
    image_index = owner.team+2*real(ammoCount);
');

object_Event_add(BannerWeapon, ev_other, ev_user1,'
    if(ammoCount >= 1 && readyToShoot) {
        playsound(x,y,swingSnd);
        ammoCount -= max(0, ammoCount-1); 
        shot = instance_create(x,y + yoffset + 1,thrownProjectile);
        if (randomDir) shot.direction=owner.aimDirection+ random(projectileDir[0])-projectileDir[1]; else shot.direction=owner.aimDirection;
        shot.speed=projectileSpeed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        with(shot)
            hspeed+=owner.hspeed;
        ammoCount = max(0, ammoCount-1);
        
        alarm[5] = reloadBuffer + reloadTime;
        owner.ammo[105] = -1;
        readyToShoot = false;
        alarm[0] = refireTime;
    }
');
// todo: move couple events around and globalize em