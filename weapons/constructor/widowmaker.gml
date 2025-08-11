globalvar WEAPON_WIDOWMAKER;
WEAPON_WIDOWMAKER = 54;

globalvar Widowmaker;
Widowmaker = object_add();
object_set_parent(Widowmaker, ShotgunWeapon);

object_event_add(Widowmaker,ev_create,0,'
    xoffset=-5;
    yoffset=-2;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
');

/* ev_user2
    nutsnbolts -= 20;
*/
global.weapons[WEAPON_WIDOWMAKER] = Widowmaker;
global.name[WEAPON_WIDOWMAKER] = "Widowmaker (unimplemented)";
