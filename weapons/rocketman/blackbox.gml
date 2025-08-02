globalvar WEAPON_BLACKBOX;
WEAPON_BLACKBOX = 13;

globalvar BlackBox;
BlackBox = object_add();
object_set_parent(BlackBox, Weapon);

object_event_add(BlackBox,ev_create,0,'
    xoffset = -5;
    yoffset = -4;
    refireTime = 30;
    event_inherited();
    reloadTime = 25;
    reloadBuffer = 30;
    maxAmmo = 3;
    ammoCount = maxAmmo;
    rocketrange=501;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = ROCKETLAUNCHER;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BlackboxS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BlackboxFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BlackboxFRS.png", 24, 1, 0, 16, 14);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_BLACKBOX] = BlackBox;
global.name[WEAPON_BLACKBOX] = "Black Box";
