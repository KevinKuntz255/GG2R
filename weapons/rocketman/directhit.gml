globalvar WEAPON_DIRECTHIT;
WEAPON_DIRECTHIT = 11;

globalvar DirectHit;
DirectHit = object_add();
object_set_parent(DirectHit, Weapon);

object_event_add(DirectHit,ev_create,0,'
    xoffset = -5;
    yoffset = -4;
    refireTime = 30;
    event_inherited();
    reloadTime = 25;
    reloadBuffer = 30;
    maxAmmo = 4;
    ammoCount = maxAmmo;
    rocketrange=501;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = ROCKETLAUNCHER;
    rocketSound = DirecthitSnd; // direct hit specific
    rocketSpeed = 23.4;
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DirectHitS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DirectHitFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DirectHitS.png", 2, 1, 0, 10, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_DIRECTHIT] = DirectHit;
global.name[WEAPON_DIRECTHIT] = "Direct Hit"
