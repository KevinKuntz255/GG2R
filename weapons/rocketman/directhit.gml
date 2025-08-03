globalvar WEAPON_DIRECTHIT;
WEAPON_DIRECTHIT = 11;

globalvar DirectHit;
DirectHit = object_add();
object_set_parent(DirectHit, RocketWeapon);

object_event_add(DirectHit,ev_create,0,'
    spriteBase = "DirectHit";
    event_inherited();

    weaponGrade = UNIQUE;
    weaponType = ROCKETLAUNCHER;
    rocketSound = DirecthitSnd; // direct hit specific
    rocketSpeed = 23.4;
    
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DirectHitS.png", 2, 1, 0, 10, 6);

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

global.weapons[WEAPON_DIRECTHIT] = DirectHit;
global.name[WEAPON_DIRECTHIT] = "Direct Hit"
