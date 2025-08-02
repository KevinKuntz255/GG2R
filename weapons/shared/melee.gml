globalvar MeleeWeapon;
MeleeWeapon = object_add();
object_set_parent(MeleeWeapon, Weapon);

object_event_add(Weapon, ev_destroy, 0, '
    event_inherited();

    with (MeleeMask) if (ownerPlayer == other.ownerPlayer) instance_destroy();
    with (StabMask) if (ownerPlayer == other.ownerPlayer) instance_destroy();
    with (StabAnim) if (ownerPlayer == other.ownerPlayer) instance_destroy();
');

object_event_add(MeleeWeapon, ev_alarm, 1, '
    event_inherited();

    shot = instance_create(x,y,MeleeMask);
    shot.direction=owner.aimDirection;
    shot.speed=owner.speed;
    shot.owner=owner;
    shot.ownerPlayer=ownerPlayer;
    shot.team=owner.team;
    if (shotDamage != -1) shot.hitDamage = shotDamage; else shot.hitDamage = 35; // default dmg
    shot.weapon=id;

    alarm[2] = 10;
');

object_event_add(Weapon,ev_alarm,2,'
    event_inherited();

    readyToStab = true;
');
