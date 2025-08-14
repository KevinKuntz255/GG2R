globalvar WEAPON_IRON;
WEAPON_IRON = 64;

globalvar IronMaiden;
IronMaiden = object_add();
object_set_parent(IronMaiden, MinigunWeapon);

object_event_add(IronMaiden,ev_create,0,'
    xoffset = -1;
    yoffset = 1;
    refireTime = 2;
    spriteBase = "IronMaiden";
    event_inherited();
    if (variable_local_exists("owner.meter[0]")) maxAmmo = 100 + owner.meter[0];
    ammoCount = maxAmmo;
	//extraAmmo = 0;

    weaponGrade = UNIQUE;
    weaponType = MINIGUN;
    
    //maxMeter = 400;
    //meter = maxAmmo;

    //Overlays for the overheat
    //overlaySprite = MinigunOverlayS;
    //overlayFiringSprite = MinigunOverlayFS;
');
// todo: implement ammo mechanic
global.weapons[WEAPON_IRON] = IronMaiden;
global.name[WEAPON_IRON] = "Iron Maiden";
