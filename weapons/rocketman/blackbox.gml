globalvar WEAPON_BLACKBOX;
WEAPON_BLACKBOX = 13;

globalvar BlackBox;
BlackBox = object_add();
object_set_parent(BlackBox, RocketWeapon);

object_event_add(BlackBox,ev_create,0,'
    spriteBase = "Blackbox";
    event_inherited();
    maxAmmo = 3;
    ammoCount = maxAmmo;

    weaponGrade = UNIQUE;
    weaponType = ROCKETLAUNCHER;

    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BlackboxFRS.png", 24, 1, 0, 16, 14);

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_BLACKBOX] = BlackBox;
global.name[WEAPON_BLACKBOX] = "Black Box";
