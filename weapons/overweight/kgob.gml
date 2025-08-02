globalvar WEAPON_KGOB;
WEAPON_KGOB = 69;

globalvar KGOB;
KGOB = object_add();
object_set_parent(KGOB, MeleeWeapon);

object_event_add(KGOB,ev_create,0,'
    xoffset=-10;
    yoffset=-5;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    isMelee = true;

    weaponGrade = UNIQUE;
    weaponType = MELEE;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BoxingGlovesS.png", 2, 1, 0, 4, 10);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BoxingGlovesFS.png", 8, 1, 0, 4, 10);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BoxingGlovesS.png", 2, 1, 0, 4, 10);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_KGOB] = KGOB;
global.name[WEAPON_KGOB] = "Killing Gloves Of Boxing";
