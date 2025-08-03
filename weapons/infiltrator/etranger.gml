globalvar WEAPON_ETRANGER;
WEAPON_ETRANGER = 71;

globalvar Etranger;
Etranger = object_add();
object_set_parent(Etranger, RevolverWeapon);

object_event_add(Etranger,ev_create,0,'
    xoffset = -4;
    yoffset = 0;
    refireTime = 18;
    spriteBase = "Etranger";
    event_inherited();

    shotDamage = 28;
');
// todo: implement uberCloak
global.weapons[WEAPON_ETRANGER] = Etranger;
global.name[WEAPON_ETRANGER] = "l'Etranger (unfinished)"
