globalvar WEAPON_TERMINALBREATH;
WEAPON_TERMINALBREATH = 42;

globalvar TerminalBreath;
TerminalBreath = object_add();
object_set_parent(TerminalBreath, Weapon);

object_event_add(TerminalBreath,ev_create,0,'
    xoffset = -7;
    yoffset = -3;
    refireTime = 3;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmmount = 1;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 40
    ammoCount = maxAmmo;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;
');

global.weapons[WEAPON_TERMINALBREATH] = TerminalBreath;
global.name[WEAPON_TERMINALBREATH] = "Terminal Breath (unimplemented)";
