globalvar WEAPON_REVOLVER;
WEAPON_REVOLVER = 70;

object_event_add(Revolver, ev_destroy, 0, '
    event_inherited();

    with (SapAnimation) if (ownerPlayer == other.ownerPlayer) instance_destroy();
    with (SapMask) if (ownerPlayer == other.ownerPlayer) instance_destroy();
');

global.weapons[WEAPON_REVOLVER] = Revolver;
global.name[WEAPON_REVOLVER] = "Revolver";
