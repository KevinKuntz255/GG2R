globalvar WEAPON_WRANGLER;
WEAPON_WRANGLER = 58;

globalvar Wrangler;
Wrangler = object_add();
object_set_parent(Wrangler, Weapon);

object_event_add(Wrangler,ev_create,0,'
    xoffset=-3;
    yoffset=-6;
    refireTime=5;
    event_inherited();
    maxAmmo = 100;
    ammoCount = 0;
    reloadTime = 20;
    reloadBuffer = 20;
    idle=true;
');

global.weapons[WEAPON_WRANGLER] = Wrangler;
global.name[WEAPON_WRANGLER] = "Wrangler (unimplemented)";
