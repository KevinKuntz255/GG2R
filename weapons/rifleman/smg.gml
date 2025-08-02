globalvar WEAPON_SMG;
WEAPON_SMG = 25;

globalvar Smg;
Smg = object_add();
object_set_parent(Smg, Weapon);

object_event_add(Smg,ev_create,0,'
    xoffset=5;
    yoffset=-1;
    refireTime=3;
    event_inherited();
    maxAmmo = 25;
    ammoCount = maxAmmo;
    reloadTime = 45;
    reloadBuffer = 16;
    idle=true;
    unscopedDamage=0;

    weaponGrade = UNIQUE;
    weaponType = SMG;

    shotDamage = 5;
    fullReload = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SmgS.png", 2, 1, 0, 8, 5);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SmgFS.png", 4, 1, 0, 8, 5);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SmgFRS.png", 16, 1, 0, 12, 13);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_SMG] = Smg;
global.name[WEAPON_SMG] = "SMG";
