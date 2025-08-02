globalvar WEAPON_MADMILK;
WEAPON_MADMILK = 8;

globalvar MadmilkHand;
MadmilkHand = object_add();
object_set_parent(MadmilkHand, Weapon);

object_event_add(MadmilkHand,ev_create,0,'
    xoffset=-10;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    maxAmmo = 1
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = 18;
    idle=true;
    readyToStab=false;
    isMelee = true;

    weaponGrade = UNIQUE;
    weaponType = THROWABLE;
    throwProjectile = MadMilk;
    projectileSpeed = 13;
    randomDir = true;
    projectileDir[0] = 7;
    projectileDir[1] = 4;
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MadMilkHandS.png", 4, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MadMilkHandS.png", 4, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\madMilkHandS.png", 4, 1, 0, 0, 0);

    sprite_index = normalSprite;
    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(MadmilkHand,ev_other,ev_user0,'
    alarm[0]=refireTime;
    if owner.ammo[105] == -1 alarm[5] = reloadBuffer + reloadTime;
    else alarm[5] = reloadBuffer + owner.ammo[105];
');

global.weapons[WEAPON_MADMILK] = MadmilkHand;
global.name[WEAPON_MADMILK] = "Madmilk";
