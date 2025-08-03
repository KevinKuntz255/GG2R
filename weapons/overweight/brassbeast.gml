globalvar WEAPON_BRASSBEAST;
WEAPON_BRASSBEAST = 63;

globalvar BrassBeast;
BrassBeast = object_add();
object_set_parent(BrassBeast, MinigunWeapon);

object_event_add(BrassBeast,ev_create,0,'
    xoffset = -3;
    yoffset = 1;
    refireTime = 2;
    spriteBase = "BrassBeast";
    event_inherited();

    shotDamage = 10;
    
    //Overlays for the overheat
    //overlaySprite = MinigunOverlayS;
    //overlayFiringSprite = MinigunOverlayFS;
');

global.weapons[WEAPON_BRASSBEAST] = BrassBeast;
global.name[WEAPON_BRASSBEAST] = "Brass Beast";
