globalvar WEAPON_FLAMETHROWER;
WEAPON_FLAMETHROWER = 80;

object_event_add(Flamethrower, ev_destroy, 0, '
    event_inherited();

    loopsoundstop(FlamethrowerSnd);
');

object_event_add(Weapon,ev_alarm,1,'
    event_inherited();

    readyToBlast = true;
');

object_event_add(Weapon, ev_alarm, 2, '
    event_inherited();

    readyToFlare = true;
');

global.weapons[WEAPON_FLAMETHROWER] = Flamethrower;
global.name[WEAPON_FLAMETHROWER] = "Flamethrower";
