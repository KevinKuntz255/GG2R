globalvar WEAPON_FLAREGUN;
WEAPON_FLAREGUN = 86;

globalvar Flaregun;
Flaregun = object_add();
object_set_parent(Flaregun, Weapon);

object_event_add(Flaregun,ev_create,0,'
    xoffset=5;
    yoffset=-3;
    refireTime=45;
    event_inherited();
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 30;
    reloadBuffer = 45;
    idle=true;
    readyToFlare = false;

    weaponGrade = UNIQUE;
    weaponType = FLAREGUN;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FlareGunS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FlareGunFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FlareGunFRS.png", 18, 1, 0, 14, 7);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_FLAREGUN] = Flaregun;
global.name[WEAPON_FLAREGUN] = "Flaregun";
