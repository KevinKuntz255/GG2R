globalvar WEAPON_GRENADELAUNCHER;
WEAPON_GRENADELAUNCHER = 35;

globalvar GrenadeLauncher;
GrenadeLauncher = object_add();
object_set_parent(GrenadeLauncher, Weapon);

object_event_add(GrenadeLauncher,ev_create,0,'
    xoffset = -8;
    yoffset = -2;
    refireTime = 28;
    event_inherited();
    maxMines = 4;
    lobbed = 0;
    reloadTime = 22;
    reloadBuffer = 26;
    maxAmmo = 4;
    ammoCount = maxAmmo;
    idle=true;
    unscopedDamage = 0;
	
    weaponGrade = UNIQUE;
    weaponType = GRENADELAUNCHER;

	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GrenadeLauncherS.png", 1, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GrenadeLauncherFS.png", 1, 1, 0, 10, 6);
    //reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GrenadeLauncherFRS.png", 24, 1, 0, 16, 14);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GrenadeLauncherS.png", 24, 1, 0, 16, 14);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_GRENADELAUNCHER] = GrenadeLauncher;
global.name[WEAPON_GRENADELAUNCHER] = "Grenade Launcher (unimplemented)";
