globalvar WEAPON_PYROSHOTGUN;
WEAPON_PYROSHOTGUN = 85;

globalvar PyroShotgun;
PyroShotgun = object_add();
object_set_parent(PyroShotgun, ShotgunWeapon);

object_event_add(PyroShotgun,ev_create,0,'
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

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PyroShotgunS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PyroShotgunFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PyroShotgunFRS.png", 16, 1, 0, 20, 11);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_PYROSHOTGUN] = PyroShotgun;
global.name[WEAPON_PYROSHOTGUN] = "Shotgun";
