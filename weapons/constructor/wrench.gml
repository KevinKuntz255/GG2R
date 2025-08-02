globalvar WEAPON_WRENCH;
WEAPON_WRENCH = 57;

globalvar Wrench;
Wrench = object_add();
object_set_parent(Wrench, Weapon);

object_event_add(Wrench,ev_create,0,'
    xoffset=-30;
    yoffset=-39;
    refireTime=18;
    event_inherited();
    StabreloadTime = 7;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;
	isMelee = true;
	
    stabdirection=0;
    maxAmmo = 100;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    cooldown = 0;
    unscopedDamage = 0;
	
	isMelee = true;
	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\WrenchS.png", 2, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\WrenchFS.png", 8, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\WrenchS.png", 2, 1, 0, 0, 0);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_WRENCH] = Wrench;
global.name[WEAPON_WRENCH] = "Wrench (unfinished)";
