globalvar WEAPON_ZAPPER;
WEAPON_ZAPPER = 79;

globalvar Zapper;
Zapper = object_add();
object_set_parent(Zapper, MeleeWeapon);

object_event_add(Zapper,ev_create,0,'
    xoffset=5 - 32;
    yoffset=-6 - 32;
    refireTime=18;
    spriteBase = "Zapper";
    event_inherited();
');
// todo: mechanics, alot of em

global.weapons[WEAPON_ZAPPER] = Zapper;
global.name[WEAPON_ZAPPER] = "Zapper (unfinished)";
