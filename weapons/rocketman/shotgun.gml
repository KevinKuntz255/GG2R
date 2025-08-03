globalvar WEAPON_SOLDIERSHOTGUN;
WEAPON_SOLDIERSHOTGUN = 15;

globalvar SoldierShotgun;
SoldierShotgun = object_add();
object_set_parent(SoldierShotgun, ShotgunWeapon);

object_event_add(SoldierShotgun,ev_create,0,'
    xoffset=1;
    yoffset=-4;
    spriteBase = "SoldierShotgun";
    event_inherited();
');

global.weapons[WEAPON_SOLDIERSHOTGUN] = SoldierShotgun;
global.name[WEAPON_SOLDIERSHOTGUN] = "Shotgun";
