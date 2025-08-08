globalvar WEAPON_FRONTIERJUSTICE;
WEAPON_FRONTIERJUSTICE = 51;

globalvar FrontierJustice;
FrontierJustice = object_add();
object_set_parent(FrontierJustice, ShotgunWeapon);

object_event_add(FrontierJustice,ev_create,0,'
    xoffset=-5;
    yoffset=-2;
    refireTime=20;
    event_inherited();
    maxAmmo = 3;
    ammoCount = maxAmmo;
');
// mechanics: revenge crits on sentry kill
global.weapons[WEAPON_FRONTIERJUSTICE] = FrontierJustice;
global.name[WEAPON_FRONTIERJUSTICE] = "Frontier Justice (unimplemented)";
