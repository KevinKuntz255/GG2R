globalvar WEAPON_BAZAARBARGAIN;
WEAPON_BAZAARBARGAIN = 21;

globalvar BazaarBargain;
BazaarBargain = object_add();
object_set_parent(BazaarBargain, RifleWeapon);

object_event_add(BazaarBargain,ev_create,0,'
    spriteBase = "BazaarBargain";
    event_inherited();
    bonus = 0;
');
// TODO: implement bonus (headHitbox, hmmmmmmmmm)
global.weapons[WEAPON_BAZAARBARGAIN] = BazaarBargain;
global.name[WEAPON_BAZAARBARGAIN] = "Bazaar Bargain (unfinished)";
