globalvar WEAPON_BAZAARBARGAIN;
WEAPON_BAZAARBARGAIN = 21;

globalvar BazaarBargain;
BazaarBargain = object_add();
object_set_parent(BazaarBargain, Weapon);

object_event_add(BazaarBargain,ev_create,0,'
    xoffset = -1;
    yoffset = -4;
    refireTime = 40;
    event_inherited();
    reloadTime = 40;
    unscopedDamage = 25;
    baseDamage = 45;
    maxDamage = 75;
    chargeTime = 105;
    hitDamage=baseDamage;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    shot=false;
    t=0;
    bonus = 0;

    weaponGrade = UNIQUE;
    weaponType = RIFLE;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BazaarBargainS.png", 2, 1, 0, 4, 4);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BazaarBargainFS.png", 4, 1, 0, 4, 4);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BazaarBargainFRS.png", 38, 1, 0, 16, 12);

    sprite_index = normalSprite;

    recoilTime = 15;
    recoilAnimLength = sprite_get_number(recoilSprite)/2
    recoilImageSpeed = recoilAnimLength/recoilTime

    longRecoilTime = 60;
    reloadAnimLength = sprite_get_number(reloadSprite)/2
    reloadImageSpeed = reloadAnimLength/(longRecoilTime);
    
    tracerAlpha = 0;
');

global.weapons[WEAPON_BAZAARBARGAIN] = BazaarBargain;
global.name[WEAPON_BAZAARBARGAIN] = "Bazaar Bargain (unfinished)";
