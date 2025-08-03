globalvar WEAPON_DETONATOR;
WEAPON_DETONATOR = 87;

globalvar Detonator;
Detonator = object_add();
object_set_parent(Detonator, FlareWeapon);

object_event_add(Detonator,ev_create,0,'
    spriteBase = "Detonator";
    event_inherited();
    specialProjectile = DetonationFlare;
');

object_event_add(Detonator,ev_other,ev_user2,'
    with(DetonationFlare) {
		if ownerPlayer == other.ownerPlayer {
			event_user(5);
		}
    }
');

global.weapons[WEAPON_DETONATOR] = Detonator;
global.name[WEAPON_DETONATOR] = "Detonator";
