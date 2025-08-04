globalvar WEAPON_MINEGUN;
WEAPON_MINEGUN = 30;

object_event_add(Minegun, ev_create, 0, '
	weaponType = MINEGUN;
');
global.weapons[WEAPON_MINEGUN] = Minegun;
global.name[WEAPON_MINEGUN] = "Minegun";
