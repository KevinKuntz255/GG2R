globalvar WEAPON_MINEGUN;
WEAPON_MINEGUN = 30;

object_event_add(Minegun, ev_create, 0, '
	weaponType = MINEGUN;
');

object_event_add(Minegun, ev_other, ev_user1, '
    // prevent accidentally charging
    owner.doubleTapped = true;
');

/*
object_event_add(Minegun, ev_other, ev_user3, '
	if (owner.abilityActive and owner.ability == DASH)
	{
		ammoCount = max(0, ammoCount-2);
		var left, right;
	    left = createShot(x+lengthdir_x(50,owner.aimDirection),y+lengthdir_y(50,owner.aimDirection), Mine, DAMAGE_SOURCE_MINEGUN, owner.aimDirection, 12);
	    left.image_angle = 0;

	    right = createShot(x+lengthdir_x(-40,owner.aimDirection),y+lengthdir_y(-40,owner.aimDirection), Mine, DAMAGE_SOURCE_MINEGUN, owner.aimDirection, 12);
	    right.image_angle = 0;

	    lobbed += 2;
	}
');*/

global.weapons[WEAPON_MINEGUN] = Minegun;
global.name[WEAPON_MINEGUN] = "Minegun";
