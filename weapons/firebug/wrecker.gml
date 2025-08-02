globalvar WEAPON_WRECKER;
WEAPON_WRECKER = 89;

globalvar Axe;
Axe = object_add();
object_set_parent(Axe, MeleeWeapon);

object_event_add(Axe,ev_create,0,'
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
    readyToFlare = false;
    owner.ammo[107] = -1;
    isMelee = true;

    weaponGrade = UNIQUE;
    weaponType = MELEE;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AxeS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AxeFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AxeS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;

');

global.weapons[WEAPON_WRECKER] = Axe;
global.name[WEAPON_WRECKER] = "Homewrecker";
