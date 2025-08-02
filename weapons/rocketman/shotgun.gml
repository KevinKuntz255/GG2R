globalvar WEAPON_SOLDIERSHOTGUN;
WEAPON_SOLDIERSHOTGUN = 15;

globalvar SoldierShotgun;
SoldierShotgun = object_add();
object_set_parent(SoldierShotgun, ShotgunWeapon);

object_event_add(SoldierShotgun,ev_create,0,'
    xoffset=1;
    yoffset=4;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = SHOTGUN;
    shots = 5;
    shotDamage = 7;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SoldierShotgunS.png", 2, 1, 0, 6, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SoldierShotgunFS.png", 4, 1, 0, 6, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SoldierShotgunFRS.png", 16, 1, 0, 18, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_SOLDIERSHOTGUN] = SoldierShotgun;
global.name[WEAPON_SOLDIERSHOTGUN] = "Shotgun";
