globalvar WEAPON_MACHINA;
WEAPON_MACHINA = 23;

globalvar Machina;
Machina = object_add();
object_set_parent(Machina, Weapon);

object_event_add(Machina,ev_create,0,'
    xoffset = -1;
    yoffset = -4;
    refireTime = 40;
    event_inherited();
    reloadTime = 70;
    unscopedDamage = 35;
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
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinaS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinaFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinaFRS.png", 38, 1, 0, 18, 12);

    sprite_index = normalSprite;

    recoilTime = 15;
    recoilAnimLength = sprite_get_number(recoilSprite)/2
    recoilImageSpeed = recoilAnimLength/recoilTime

    longRecoilTime = 60;
    reloadAnimLength = sprite_get_number(reloadSprite)/2
    reloadImageSpeed = reloadAnimLength/(longRecoilTime);
    
    tracerAlpha = 0;
');

global.weapons[WEAPON_MACHINA] = Machina;
global.name[WEAPON_MACHINA] = "Machina (unfinished)";
