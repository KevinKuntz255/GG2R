globalvar WEAPON_FAMILYBUSINESS;
WEAPON_FAMILYBUSINESS = 67;

globalvar FamilyBusiness;
FamilyBusiness = object_add();
object_set_parent(FamilyBusiness, Weapon);

object_event_add(FamilyBusiness,ev_create,0,'
    xoffset=3;
    yoffset=-3;
    refireTime=17;
    event_inherited();
    maxAmmo = 8;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    
    shots = 5;
    shotDamage = 6;
    shotSpeed[0] = 4;
    shotSpeed[1] = 11;
    shotDir[0] = 11;
    shotDir[1] = 5;

    weaponGrade = UNIQUE;
    weaponType = SHOTGUN;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FamilyBusinessS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FamilyBusinessFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FamilyBusinessFRS.png", 16, 1, 0, 20, 11);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_FAMILYBUSINESS] = FamilyBusiness;
global.name[WEAPON_FAMILYBUSINESS] = "Family Business";
