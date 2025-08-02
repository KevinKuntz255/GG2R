globalvar WEAPON_NAPALM;
WEAPON_NAPALM = 88;

globalvar NapalmHand;
NapalmHand = object_add();
object_set_parent(NapalmHand, Weapon);

object_event_add(NapalmHand,ev_create,0,' //do this later
    xoffset=2;
    yoffset=-2;
    refireTime=18;
    event_inherited();
    maxAmmo = 1
    ammoCount = maxAmmo;
    reloadTime = 240;
    reloadBuffer = 18;
    idle=true;
    readyToFlare = false;
    readyToStab=false;
    isMelee = true;

    isMetered = true;
    
    weaponGrade = UNIQUE;
    weaponType = THROWABLE;
    throwProjectile = NapalmGrenade;
    shotSpeed = 12.5;
    randomDir = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NapalmHandS.png", 4, 1, 0, -2, -2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NapalmHandS.png", 4, 1, 0, -2, -2);
    //recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NapalmHandFS.png", 4, 1, 0, 0, 11);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NapalmHandS.png", 4, 1, 0, -2, -2);

    sprite_index = normalSprite;
    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_NAPALM] = NapalmHand;
global.name[WEAPON_NAPALM] = "Napalm Grenade (unfinished)";
