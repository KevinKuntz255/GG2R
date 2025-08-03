globalvar WEAPON_NORDICGOLD;
WEAPON_NORDICGOLD = 74;

globalvar Goldassistant;
Goldassistant = object_add();
object_set_parent(Goldassistant, RevolverWeapon);

object_event_add(Goldassistant,ev_create,0,'
    xoffset=-4;
    yoffset=0;
    refireTime=18;
    spriteBase = "GoldAssistant"
    event_inherited();

    shotDamage = 25;
    owner.runPower = owner.baseRunPower - 0.08;
');
// todo: add health kits in projectile_init and mechanics

global.weapons[WEAPON_NORDICGOLD] = Goldassistant;
global.name[WEAPON_NORDICGOLD] = "Nordic Gold (unfinished)";