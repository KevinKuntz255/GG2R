globalvar WEAPON_AIRSTRIKE;
WEAPON_AIRSTRIKE = 14;

globalvar Airstrike;
Airstrike = object_add();
object_set_parent(Airstrike, Weapon);

object_event_add(Airstrike,ev_create,0,'
    xoffset = -5;
    yoffset = -4;
    refireTime = 30;
    event_inherited();
    reloadTime = 25;
    reloadBuffer = 30;
    maxAmmo = 4;
    ammoCount = maxAmmo;
    rocketrange=501;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = ROCKETLAUNCHER;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AirstrikeS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AirstrikeFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AirstrikeFRS.png", 24, 1, 0, 16, 14);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(Airstrike,ev_other,ev_user2,'
    with(Rocket) {
        if ownerPlayer = other.ownerPlayer && direction != 270 {
        direction = 270;
        image_angle = 270;
        speed -= 2;
        travelDistance=0;
        other.alarm[0] = other.refireTime;
        }
    }
');

global.weapons[WEAPON_AIRSTRIKE] = Airstrike;
global.name[WEAPON_AIRSTRIKE] = "Airstrike";
