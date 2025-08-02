globalvar WEAPON_RUNDOWN;
WEAPON_RUNDOWN = 2;

globalvar Rundown;
Rundown = object_add();
object_set_parent(Rundown, Weapon);

object_set_sprite(Rundown, sprite_add(pluginFilePath + "\randomizer_sprites\ShortStopS.png", 2, 1, 0, 8, 7));

object_event_add(Rundown,ev_create,0,'
    xoffset=-3;
    yoffset=-6;
    refireTime=13;
    event_inherited();
    maxAmmo = 4;
    ammoCount = maxAmmo;
    reloadTime = 45.6;
    reloadBuffer = 20;
    idle=true;
    weaponGrade = UNIQUE;
    weaponType = SCATTERGUN;
    damSouce = DAMAGE_SOURCE_SCATTERGUN;
    fullReload = true;

    shotSpeed[0] = 2;
    shotSpeed[1] = 12;
    shotDir[0] = 9;
    shotDir[1] = 5;
    shots = 3;
    shotDamage = 14;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShortStopS.png", 2, 1, 0, 8, 7);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShortStopFS.png", 4, 1, 0, 8, 7);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShortStopFRS.png", 16, 1, 0, 12, 15);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_RUNDOWN] = Rundown;
global.name[WEAPON_RUNDOWN] = "Shortstop";
