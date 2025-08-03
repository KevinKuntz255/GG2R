globalvar WEAPON_PYROSHOTGUN;
WEAPON_PYROSHOTGUN = 85;

globalvar PyroShotgun;
PyroShotgun = object_add();
object_set_parent(PyroShotgun, ShotgunWeapon);

object_event_add(PyroShotgun, ev_create, 0, '
    xoffset=3;
    yoffset=-3;
    spriteBase = "PyroShotgun";
    event_inherited();
');

global.weapons[WEAPON_PYROSHOTGUN] = PyroShotgun;
global.name[WEAPON_PYROSHOTGUN] = "Shotgun";
