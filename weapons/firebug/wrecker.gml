globalvar WEAPON_WRECKER;
WEAPON_WRECKER = 89;

globalvar Axe;
Axe = object_add();
object_set_parent(Axe, MeleeWeapon);

object_event_add(Axe,ev_create,0,'
    xoffset=6 - 32;
    yoffset=-8 - 32;
    spriteBase = "Axe";
    event_inherited();
');

global.weapons[WEAPON_WRECKER] = Axe;
global.name[WEAPON_WRECKER] = "Homewrecker";
