globalvar WEAPON_NATACHA;
WEAPON_NATACHA = 62;

globalvar Natacha;
Natacha = object_add();
object_set_parent(Natacha, Weapon);

object_event_add(Natacha,ev_create,0,'
    xoffset = 3;
    yoffset = 3;
    refireTime = 2;
    event_inherited();
    sndlooping = false;
    maxAmmo = 200;
    ammoCount = maxAmmo;
    reloadBuffer = 15;
    isRefilling = false;
    depth = -1;
    
    weaponGrade = UNIQUE;
    weaponType = MINIGUN;


    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NatachaS.png", 2, 1, 0, 14, 3);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NatachaFS.png", 4, 1, 0, 14, 3);
    reloadSprite = -1;

    sprite_index = normalSprite;

    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    //Overlays for the overheat
    overlaySprite = MinigunOverlayS;
    overlayFiringSprite = MinigunOverlayFS;
');

global.weapons[WEAPON_NATACHA] = Natacha;
global.name[WEAPON_NATACHA] = "Natascha";
