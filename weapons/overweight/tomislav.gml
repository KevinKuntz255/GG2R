globalvar WEAPON_TOMISLAV;
WEAPON_TOMISLAV = 61;

globalvar Tomislav;
Tomislav = object_add();
object_set_parent(Tomislav, MinigunWeapon);

object_event_add(Tomislav,ev_create,0,'
    xoffset = -3;
    yoffset = 1;
    refireTime = 3;
    spriteBase = "Tomislav";
    event_inherited();

    shotDir[0] = 7;
    shotDir[1] = 3.5;

    //Overlays for the overheat
    //overlaySprite = MinigunOverlayS;
    //overlayFiringSprite = MinigunOverlayFS;
');

global.weapons[WEAPON_TOMISLAV] = Tomislav;
global.name[WEAPON_TOMISLAV] = "Tomislav";
