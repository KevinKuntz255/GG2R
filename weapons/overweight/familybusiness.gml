globalvar WEAPON_FAMILYBUSINESS;
WEAPON_FAMILYBUSINESS = 67;

globalvar FamilyBusiness;
FamilyBusiness = object_add();
object_set_parent(FamilyBusiness, ShotgunWeapon);

object_event_add(FamilyBusiness,ev_create,0,'
    xoffset=3;
    yoffset=-3;
    refireTime=17;
    spriteBase = "FamilyBusiness";
    event_inherited();
    maxAmmo = 8;
    ammoCount = maxAmmo;
    
    shotDamage = 6;
');

global.weapons[WEAPON_FAMILYBUSINESS] = FamilyBusiness;
global.name[WEAPON_FAMILYBUSINESS] = "Family Business";
