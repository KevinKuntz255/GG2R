globalvar WEAPON_SCOTTISHRESISTANCE;
WEAPON_SCOTTISHRESISTANCE = 32;

globalvar ScottishResitance;
ScottishResitance = object_add();
object_set_parent(ScottishResitance, Weapon);

object_event_add(ScottishResitance,ev_create,0,'
    xoffset = -3;
    yoffset = -2;
    refireTime = 26;
    event_inherited();
    maxMines = 14;
    lobbed = 0;
    reloadTime = 20;
    reloadBuffer = 26;
    maxAmmo = 8;
    ammoCount = maxAmmo;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = MINEGUN;
');

global.weapons[WEAPON_SCOTTISHRESISTANCE] = ScottishResitance;
global.name[WEAPON_SCOTTISHRESISTANCE] = "Scottish Resistance (unimplemented)";
