globalvar WEAPON_PISTOL;
WEAPON_PISTOL = 5;

globalvar Pistol;
Pistol = object_add();
object_set_parent(Pistol, Weapon);
object_set_sprite(Pistol, sprite_add(pluginFilePath + "\randomizer_sprites\PistolS.png", 2, 1, 0, 8, 7));

object_event_add(Pistol,ev_create,0,'
    xoffset=-3;
    yoffset=-6;
    refireTime=5;
    event_inherited();
    maxAmmo = 12;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 5;
    idle=true;
    
    weaponGrade = UNIQUE;
    weaponType = PISTOL;
    fullReload = true;
    shotDamage = 8;
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PistolS.png", 2, 1, 0, 8, 7);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PistolFS.png", 4, 1, 0, 8, 7);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PistolFRS.png", 16, 1, 0, 10, 12);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_PISTOL] = Pistol;
global.name[WEAPON_PISTOL] = "Pistol";
