globalvar WEAPON_JARATE;
WEAPON_JARATE = 26;

globalvar JarateHand;
JarateHand = object_add();
object_set_parent(JarateHand, Weapon);

object_event_add(JarateHand,ev_create,0,'
    xoffset=-12;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    maxAmmo = 1
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = 18;
    idle=true;
    readyToStab=false;
    unscopedDamage=0;
	isMelee = true;

    weaponGrade = UNIQUE;
    weaponType = THROWABLE;
    throwProjectile = JarOPiss;
    shotSpeed = 13;
    randomDir = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\JarateHandS.png", 4, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\JarateHandS.png", 4, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\JarateHandS.png", 4, 1, 0, 0, 0);

    sprite_index = normalSprite;
    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(JarateHand,ev_destroy,0,'
    if owner != -1 owner.ammo[105] = alarm[5];
');

object_event_add(JarateHand,ev_other,ev_user0,'
    alarm[0]=refireTime;
    if owner.ammo[105] == -1 alarm[5] = reloadBuffer + reloadTime;
    else alarm[5] = reloadBuffer + owner.ammo[105];
');

global.weapons[WEAPON_JARATE] = JarateHand;
global.name[WEAPON_JARATE] = "Jarate (unimplemented)";
