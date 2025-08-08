globalvar WEAPON_BOOTS;
WEAPON_BOOTS = 29;
//Not a weapon so it has no object
// sike
globalvar RocketBoots;
RocketBoots = object_add();
object_set_parent(RocketBoots, Weapon);

object_event_add(RocketBoots,ev_create,0,'
	weaponType = WEAR;
');
global.weapons[WEAPON_BOOTS] = RocketBoots;
global.name[WEAPON_BOOTS] = "Rocket Boots (unimplemented)";
