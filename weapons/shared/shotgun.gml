globalvar ShotgunWeapon;
ShotgunWeapon = object_add();
object_set_parent(ShotgunWeapon, Weapon);

object_event_add(ShotgunWeapon, ev_create, 0, '
    xoffset=3;
    yoffset=-3;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    shots = 5;
    weaponGrade = UNIQUE;
    weaponType = SHOTGUN;
    idle=true;
    readyToFlare = false;
    
    shotSpeed[0] = 4;
    shotSpeed[1] = 11;
    shotDir[0] = 11;
    shotDir[1] = 5;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShotgunS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShotgunFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShotgunFRS.png", 16, 1, 0, 20, 11);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
