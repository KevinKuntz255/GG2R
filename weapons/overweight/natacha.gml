globalvar WEAPON_NATACHA;
WEAPON_NATACHA = 62;

globalvar Natacha;
Natacha = object_add();
object_set_parent(Natacha, MinigunWeapon);

object_event_add(Natacha,ev_create,0,'
    xoffset = -3;
    yoffset = 1;
    refireTime = 2;
    spriteBase = "Natacha";
    event_inherited();
    
    specialShot = NatachaShot;
    
    //Overlays for the overheat
    //overlaySprite = MinigunOverlayS;
    //overlayFiringSprite = MinigunOverlayFS;
');

global.weapons[WEAPON_NATACHA] = Natacha;
global.name[WEAPON_NATACHA] = "Natascha";
