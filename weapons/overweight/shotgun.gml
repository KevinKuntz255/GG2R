globalvar WEAPON_HEAVYSHOTGUN;
WEAPON_HEAVYSHOTGUN = 65;

globalvar HeavyShotgun;
HeavyShotgun = object_add();
object_set_parent(HeavyShotgun, ShotgunWeapon);

object_event_add(HeavyShotgun,ev_create,0,'
    xoffset=3;
    yoffset=-3;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    shots = 5;
    weaponGrade = UNIQUE;
    weaponType = SHOTGUN;
    shotDamage = 7;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HeavyShottyS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HeavyShottyFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HeavyShottyFRS.png", 16, 1, 0, 20, 11);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_HEAVYSHOTGUN] = HeavyShotgun;
global.name[WEAPON_HEAVYSHOTGUN] = "Shotgun";
