//***************alt_weapons******************* 
//the first 5 are primaries and the last 6 are secondaries for the classes
//PS: This was A LOT of work. A LOT.

// WeaponTypes
globalvar SCATTERGUN, FLAMETHROWER, ROCKETLAUNCHER, MINIGUN, MINEGUN, NEEDLEGUN, SHOTGUN, REVOLVER, RIFLE, PISTOL, GRENADELAUNCHER, NEEDLEGUN, HEALBEAM, NAILGUN, KNIFE, SMG, MELEE, THROWABLE, FLASHLIGHT, FLAREGUN, LASERGUN, BANNER, CONSUMABLE, CROSSBOW, WRANGLER, SAPPER, WEAR, BLADE, MACHINEGUN, BOW;

SCATTERGUN = 0; // oh huh I need to do this, sure
FLAMETHROWER = 1;
ROCKETLAUNCHER = 2;
MINIGUN = 3;
MINEGUN = 4;
NEEDLEGUN = 5;
SHOTGUN = 6;
REVOLVER = 7;
RIFLE = 8;
PISTOL = 9;
GRENADELAUNCHER = 10;
NEEDLEGUN = 11;
HEALBEAM = 12;
NAILGUN = 13;
KNIFE = 14;
SMG = 15;
MELEE = 16;
THROWABLE = 17;
FLASHLIGHT = 18;
FLAREGUN = 19;
LASERGUN = 20;
BANNER = 21;
CONSUMABLE = 22;
CROSSBOW = 23;
WRANGLER = 24;
SAPPER = 25;
WEAR = 26;
BLADE = 27;
MACHINEGUN = 28;
BOW = 29;
// WeaponGrades, them too
globalvar STOCK, UNIQUE, FUN; // Stock, Lorgan's Set, and The newer Ideas (to be implemented...)
STOCK = 0;
UNIQUE = 1;
FUN = 2;


global.weaponTypes = ds_map_create();

ds_map_add(global.weaponTypes, SCATTERGUN, SCATTERGUN);
ds_map_add(global.weaponTypes, FLAMETHROWER, FLAMETHROWER);
ds_map_add(global.weaponTypes, ROCKETLAUNCHER, ROCKETLAUNCHER);
ds_map_add(global.weaponTypes, MINIGUN, MINIGUN);
ds_map_add(global.weaponTypes, MINEGUN, MINEGUN);
ds_map_add(global.weaponTypes, NEEDLEGUN, NEEDLEGUN);
ds_map_add(global.weaponTypes, SHOTGUN, SHOTGUN);
ds_map_add(global.weaponTypes, REVOLVER, REVOLVER);
ds_map_add(global.weaponTypes, RIFLE, RIFLE);
ds_map_add(global.weaponTypes, PISTOL, PISTOL);
ds_map_add(global.weaponTypes, GRENADELAUNCHER, GRENADELAUNCHER);
ds_map_add(global.weaponTypes, NEEDLEGUN, NEEDLEGUN);
ds_map_add(global.weaponTypes, HEALBEAM, HEALBEAM);
ds_map_add(global.weaponTypes, NAILGUN, NAILGUN);
ds_map_add(global.weaponTypes, KNIFE, KNIFE);
ds_map_add(global.weaponTypes, SMG, SMG);
ds_map_add(global.weaponTypes, MELEE, MELEE);
ds_map_add(global.weaponTypes, THROWABLE, THROWABLE);
ds_map_add(global.weaponTypes, FLASHLIGHT, FLASHLIGHT);
ds_map_add(global.weaponTypes, FLAREGUN, FLAREGUN);
ds_map_add(global.weaponTypes, LASERGUN, LASERGUN);
ds_map_add(global.weaponTypes, BANNER, BANNER);
ds_map_add(global.weaponTypes, CONSUMABLE, CONSUMABLE);
ds_map_add(global.weaponTypes, CROSSBOW, CROSSBOW);
ds_map_add(global.weaponTypes, WRANGLER, WRANGLER);
ds_map_add(global.weaponTypes, SAPPER, SAPPER);
ds_map_add(global.weaponTypes, WEAR, WEAR);
ds_map_add(global.weaponTypes, BLADE, BLADE);
ds_map_add(global.weaponTypes, MACHINEGUN, MACHINEGUN);
ds_map_add(global.weaponTypes, BOW, BOW);

//Updating this for modern gg2 was a LOT LOT of work

// Sounds
globalvar SwitchSnd, FlashlightSnd, swingSnd, BallSnd, DirecthitSnd, ManglerChargesnd, LaserShotSnd, BowSnd, ChargeSnd, FlaregunSnd, BuffbannerSnd, CritSnd, ShotSnd;
globalvar chaingunSnd, pistolSnd, ManglerShotSnd; // had to move due to undebuggable errors, also in lowercase due to the same problem.
SwitchSnd = sound_add(pluginFilePath + '/randomizer_sounds/switchSnd.wav', 0, 1);
FlashlightSnd = sound_add(pluginFilePath + '/randomizer_sounds/FlashlightSnd.wav', 0, 1);
swingSnd = sound_add(pluginFilePath + '/randomizer_sounds/swingSnd.wav', 0, 1);
BallSnd = sound_add(pluginFilePath + '/randomizer_sounds/BallSnd.wav', 0, 1);
DirecthitSnd = sound_add(pluginFilePath + '/randomizer_sounds/DirecthitSnd.wav', 0, 1);
ManglerChargesnd = sound_add(pluginFilePath + '/randomizer_sounds/ManglerchargeSnd.wav', 0, 1);
LaserShotSnd = sound_add(pluginFilePath + '/randomizer_sounds/LaserShotSnd.wav', 0, 1);
BowSnd = sound_add(pluginFilePath + '/randomizer_sounds/BowSnd.wav', 0, 1);
ChargeSnd = sound_add(pluginFilePath + '/randomizer_sounds/DetoChargeSnd.wav', 0, 1);
FlaregunSnd = sound_add(pluginFilePath + '/randomizer_sounds/FlaregunSnd.wav', 0, 1);
BuffbannerSnd = sound_add(pluginFilePath + '/randomizer_sounds/BuffbannerSnd.wav', 0, 1);
CritSnd = sound_add(pluginFilePath + '/randomizer_sounds/CritSnd.wav', 0, 1);
ShotSnd = sound_add(pluginFilePath + '/randomizer_sounds/ShotSnd.wav', 0, 1);
chaingunSnd = sound_add(pluginFilePath + '/randomizer_sounds/ChaingunSnd.wav', 0, 1);
pistolSnd = sound_add(pluginFilePath + '/randomizer_sounds/PistolSnd.wav', 0, 1);
ManglerShotSnd = sound_add(pluginFilePath + '/randomizer_sounds/ManglerShotSnd.wav', 0, 1);
object_event_add(Weapon,ev_create,0,'
    owner.expectedWeaponBytes = 2;

    // necessary variables for weapons not to crash
	//wrangled = false;
	readyToStab=false;
    crit=1;
    playcrit=false;
    //ubering = false;
    //uberCharge=0;
    t=0;
    //speedboost=0;
    lobbed = 0;
	baseDamage=-1; // stops crashing when youre zooming in
    unscopedDamage = 0; // this too

    abilityActive = false;
    abilityVisual = "";
    ability = -1;

    isThrowable = false;

    // weaponGrade for Unique/Stock/Special
    weaponGrade = STOCK;
    // weaponType for each weapon
    weaponType = SHOTGUN;

    damSource = DAMAGE_SOURCE_SHOTGUN;
    // do not name it Dee Mage. do not even comment it. Compilation Error. Game Maker 8 was made by Satan.
	
    isMelee = false;

	 // introducing meters, renamed to ability
	rechargeAbility = false;
	abilityName = "";
	maxMeter=-1;
	meter=-1;

	// Implement fixed reload times by parented variables
	with(owner) { // reminder: activeWeapon is modified before Weapon ev_create is called
		with (player)
			if (!variable_local_exists("activeWeapon")) exit;
			if variable_local_exists("PrimaryRefireTime") && player.activeWeapon == 0 {
				other.alarm[0] = PrimaryRefireTime;
			}
			if variable_local_exists("SecondaryRefireTime") && player.activeWeapon == 1 {
				other.alarm[0] = SecondaryRefireTime;
			}
			if variable_local_exists("reloadFlare") {
				other.alarm[2] = reloadFlare;
			}
		if variable_local_exists("fire") {
			if fire {
				other.readyToShoot = true;
				other.readyToStab = true;
			}
		}
		if (!variable_local_exists("fire") && player.activeWeapon == 1) {
			other.readyToShoot = true; // make a first switch always have your secondary turned on.
			other.readyToStab = true;
			other.readyToFlare = true;
			fire = true;
		}
	}
	if (!owner.cloak) playsound(x,y,SwitchSnd);
');
object_event_add(Weapon,ev_destroy,0,'
	if (alarm[0] > 1.25) {
		if (owner.player.activeWeapon == 1)
			owner.PrimaryRefireTime = alarm[0];
		else
			owner.SecondaryRefireTime = alarm[0];
		owner.fire = false;
	} else {
		owner.fire = true;
	}
	if (alarm[2] > 0 && !isMelee) {
		owner.reloadFlare = alarm[2];
	}
');

object_event_add(Weapon, ev_other, ev_user2, '
	if (owner.pressedKeys) {
		if (owner.ability == DASH) {
			owner.doubleTapped = !owner.doubleTapped;
	        if ((weaponType == MINEGUN || isThrowable) && !owner.doubleTapped) exit; // a sort of buffer for weapons like SandvichHand and Minegun
			if (owner.abilityActive && owner.meter[1] >= 20) {
	            owner.abilityActive = false;
	            owner.meter[1] = 0;
	        } // stop, no matter what
			if (!owner.abilityActive && !owner.cloak && owner.meter[1] >= owner.maxMeter[1]) {
		        owner.abilityActive = true;
				owner.accel = 0;
				owner.moveStatus = 0;
				owner.dashon = true;
		        owner.doubleTapped = true;
		        playsound(x,y,ChargeSnd);
				readyToStab = true;
			}
	    }
	}
');

// Special Variables
globalvar WEAPON_FIREARROW, WEAPON_KUNAIBACKSTAB, WEAPON_SAPPER, WEAPON_MEDICHAINBACKSTAB, WEAPON_FAILSTAB, WEAPON_ARROWHEADSHOT, WEAPON_SPYCICLEBACKSTAB, WEAPON_BACKSTAB;
globalvar Fire Arrow, Kunai Backstab, Sapper, Medichain Backstab, Failstab, Arrow Headshot, Spycicle Backstab, Backstab;
WEAPON_FIREARROW = 100;

//read the loadout file
ini_open("Loadout.gg2");
global.scoutLoadout=ini_read_real("Class","Scout",real("10"+string(WEAPON_SCATTERGUN)+"0"+string(WEAPON_PISTOL)));
global.pyroLoadout=ini_read_real("Class","Pyro",real("1"+string(WEAPON_FLAMETHROWER)+string(WEAPON_PYROSHOTGUN)));
global.soldierLoadout=ini_read_real("Class","Soldier",real("1"+string(WEAPON_ROCKETLAUNCHER)+string(WEAPON_SOLDIERSHOTGUN)));
global.heavyLoadout=ini_read_real("Class","heavy",real("1"+string(WEAPON_MINIGUN)+string(WEAPON_HEAVYSHOTGUN)));
global.demomanLoadout=ini_read_real("Class","Demoman",real("1"+string(WEAPON_MINEGUN)+string(WEAPON_GRENADELAUNCHER)));
global.medicLoadout=ini_read_real("Class","Medic",real("1"+string(WEAPON_NEEDLEGUN)+string(WEAPON_MEDIGUN)));
global.engineerLoadout=ini_read_real("Class","Engineer",real("1"+string(WEAPON_SHOTGUN)+string(WEAPON_NAILGUN)));
global.spyLoadout=ini_read_real("Class","Spy",real("1"+string(WEAPON_REVOLVER)+string(WEAPON_KNIFE)));
global.sniperLoadout=ini_read_real("Class","sniper",real("1"+string(WEAPON_RIFLE)+string(WEAPON_SMG)));

ini_write_real("Class","Scout",global.scoutLoadout);
ini_write_real("Class","Pyro",global.pyroLoadout);
ini_write_real("Class","Soldier",global.soldierLoadout);
ini_write_real("Class","heavy",global.heavyLoadout);
ini_write_real("Class","Demoman",global.demomanLoadout);
ini_write_real("Class","Medic",global.medicLoadout);
ini_write_real("Class","Engineer",global.engineerLoadout);
ini_write_real("Class","Spy",global.spyLoadout);
ini_write_real("Class","sniper",global.sniperLoadout);

ini_close(); 

global.currentLoadout = global.scoutLoadout;
if(global.isHost){
    global.myself.playerLoadout = global.currentLoadout;
}
