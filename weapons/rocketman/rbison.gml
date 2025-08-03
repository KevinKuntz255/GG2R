globalvar WEAPON_RBISON;
WEAPON_RBISON = 17;

globalvar RBison;
RBison = object_add();
object_set_parent(RBison, laserWeapon);

// one laserWeapon in the roster so far

global.weapons[WEAPON_RBISON] = RBison;
global.name[WEAPON_RBISON] = "Righteous Bison";
