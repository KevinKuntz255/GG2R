globalvar WEAPON_SHIV;
WEAPON_SHIV = 28;

globalvar Shiv;
Shiv = object_add();
object_set_parent(Shiv, Weapon);

object_event_add(Shiv,ev_create,0,'
    xoffset=6;
    yoffset=-8;
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
    unscopedDamage=0;
    isMelee = true;

    weaponGrade = UNIQUE;
    weaponType = MELEE;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShivS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShivFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShivS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');


global.weapons[WEAPON_SHIV] = Shiv;
global.name[WEAPON_SHIV] = "Tribalman's Shiv & Razorback (unfinished)";
