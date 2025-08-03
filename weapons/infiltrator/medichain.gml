globalvar WEAPON_MEDICHAIN;
WEAPON_MEDICHAIN = 76;

globalvar ChainStab;
ChainStab = object_add();
object_set_parent(ChainStab, MeleeWeapon);

object_event_add(ChainStab,ev_create,0,'
    xoffset=5 - 32;
    yoffset=-6 - 32;
    event_inherited();
');
// mechanic: on kill also kill enemy patient, check projectile_init

global.weapons[WEAPON_MEDICHAIN] = ChainStab;
global.name[WEAPON_MEDICHAIN] = "Medichain (unfinished)"
