//***************alt_weapons******************* 
//the first 5 are primaries and the last 6 are secondaries for the classes
//PS: This was A LOT of work. A LOT.

// WeaponTypes
globalvar SCATTERGUN, FLAMETHROWER, ROCKETLAUNCHER, MINIGUN, MINEGUN, NEEDLEGUN, SHOTGUN, REVOLVER, RIFLE, PISTOL, GRENADELAUNCHER, NEEDLEGUN, HEALBEAM, NAILGUN, KNIFE, SMG, MELEE, THROWABLE, FLASHLIGHT, FLAREGUN, LASERGUN, BANNER, CONSUMABLE, CROSSBOW, WRANGLER, SAPPER, WEAR, BLADE, MACHINEGUN;

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

//Updating this for modern gg2 was a LOT LOT of work

// Sounds
globalvar SwitchSnd, FlashlightSnd, swingSnd, BallSnd, DirecthitSnd, ManglerChargesnd, LaserShotSnd, BowSnd, ChargeSnd1, ChargeSnd2, ChargeSnd3, FlaregunSnd, BuffbannerSnd, CritSnd, ShotSnd;
SwitchSnd = sound_add(directory + '/randomizer_sounds/switchSnd.wav', 0, 1);
FlashlightSnd = sound_add(directory + '/randomizer_sounds/FlashlightSnd.wav', 0, 1);
swingSnd = sound_add(directory + '/randomizer_sounds/swingSnd.wav', 0, 1);
BallSnd = sound_add(directory + '/randomizer_sounds/BallSnd.wav', 0, 1);
DirecthitSnd = sound_add(directory + '/randomizer_sounds/DirecthitSnd.wav', 0, 1);
ManglerChargesnd = sound_add(directory + '/randomizer_sounds/ManglerchargeSnd.wav', 0, 1);
LaserShotSnd = sound_add(directory + '/randomizer_sounds/LaserShotSnd.wav', 0, 1);
BowSnd = sound_add(directory + '/randomizer_sounds/BowSnd.wav', 0, 1);
ChargeSnd1 = sound_add(directory + '/randomizer_sounds/DetoCharge1Snd.wav', 0, 1);
ChargeSnd2 = sound_add(directory + '/randomizer_sounds/DetoCharge2Snd.wav', 0, 1);
ChargeSnd3 = sound_add(directory + '/randomizer_sounds/DetoCharge3Snd.wav', 0, 1);
FlaregunSnd = sound_add(directory + '/randomizer_sounds/FlaregunSnd.wav', 0, 1);
BuffbannerSnd = sound_add(directory + '/randomizer_sounds/BuffbannerSnd.wav', 0, 1);
CritSnd = sound_add(directory + '/randomizer_sounds/CritSnd.wav', 0, 1);
ShotSnd = sound_add(directory + '/randomizer_sounds/ShotSnd.wav', 0, 1);
object_event_add(Weapon,ev_create,0,'
    owner.expectedWeaponBytes = 2;
    // necessary variables for weapons not to crash
	//wrangled = false;
	readyToStab=false;
    //crit=1;
    //ubering = false;
    //uberCharge=0;
    t=0;
    //speedboost=0;
    lobbed = 0;

    abilityActive = false;
    abilityVisual = "";
    abilityType= -1;

    // weaponGrade for Unique/Stock/Special
    weaponGrade = STOCK;
    // weaponType for each weapon
    weaponType = SHOTGUN;

    damSource = DAMAGE_SOURCE_SHOTGUN;
    // do not name it Dee Mage. do not even comment it. Compilation Error. Game Maker 8 was made by Satan.
	baseDamage=-1; // stops crashing when youre zooming in
	
    isMelee = false;
	
	hasMeter = false; // introducing meters
	meterName = "";
	maxMeter=-1;
	meterCount=-1;
    
    //scattergun/shotgun variables
    shots = 1;
    specialShot = -1;
    shotDamage = -1;
    shotSpeed[0] = -1;
    shotSpeed[1] = -1;
    shotDir[0] = -1;
    shotDir[1] = -1;

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
	playsound(x,y,SwitchSnd);
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

    switch(weaponType)
    {
        case MELEE:
            with (MeleeMask) if (ownerPlayer == other.ownerPlayer) instance_destroy();
            with (StabMask) if (ownerPlayer == other.ownerPlayer) instance_destroy();
            with (StabAnim) if (ownerPlayer == other.ownerPlayer) instance_destroy();
        break;
        case REVOLVER:
            with (SapAnimation) if (ownerPlayer == other.ownerPlayer) instance_destroy();
            with (SapMask) if (ownerPlayer == other.ownerPlayer) instance_destroy();
        break;
        case FLAMETHROWER:
            loopsoundstop(FlamethrowerSnd);
        break;
    }
');
object_event_add(Weapon,ev_alarm,1,'
    switch(weaponType)
    {
        case MELEE:
            shot = instance_create(x,y,MeleeMask);
            shot.direction=owner.aimDirection;
            shot.speed=owner.speed;
            shot.owner=owner;
            shot.ownerPlayer=ownerPlayer;
            shot.team=owner.team;
            shot.hitDamage = shotDamage;
            shot.weapon=object_index;

            alarm[2] = 10;
        break;
        case FLAMETHROWER:
            readyToBlast = true;
        break;
    }
');
object_event_add(Weapon,ev_alarm,2,'
    switch(weaponType)
    {
        case MELEE:
            readyToStab = true;
        break;
        case FLAMETHROWER:
            readyToFlare = true;
        break;
        default:
            readyToShoot = true;
        break;
    }
');
object_event_add(Weapon,ev_alarm,3,'
    switch(weaponType)
    {
        case MELEE:
            shot = instance_create(x,y,StabMask);
            shot.direction=stabdirection;
            shot.speed=0;
            shot.owner=owner;
            shot.ownerPlayer=ownerPlayer;
            shot.team=owner.team;
            shot.hitDamage = 200;
            shot.weapon=DAMAGE_SOURCE_KNIFE;

            alarm[2] = 18;
        break;
        case FLAMETHROWER:
            loopsoundstop(FlamethrowerSnd);
        break;
    }
');
object_event_add(Weapon,ev_alarm,5,'
    switch(weaponType)
    {
        case SCATTERGUN:
        case SHOTGUN:
        case PISTOL:
        case ROCKETLAUNCHER:
            if (ammoCount < maxAmmo)
            {
                ammoCount += 1;
            }
            if (ammoCount < maxAmmo)
            {
                alarm[5] = reloadTime / global.delta_factor;
                sprite_index = reloadSprite;
                image_index = 0;
                image_speed = reloadImageSpeed * global.delta_factor;
            }
        break;
        case MINIGUN || FLAMETHROWER:
            isRefilling = true;
        break;
        case REVOLVER: 
        case FLAREGUN:
            if (ammoCount < maxAmmo)
            {
                ammoCount = maxAmmo;
                ejected = 0;
            }
        break;
        case THROWABLE || MELEE:
            ammoCount = maxAmmo;
        break;
    }
');
object_event_add(Weapon,ev_alarm,6,'
    switch(weaponType)
    {
        case MINIGUN:
            //Reset the sprite
            sprite_index = normalSprite;
            image_speed = 0;
        break;
        case CONSUMABLE:
             if (reloadSprite != -1 && object_index != Rifle && alarm[5] > 0)
            {
                sprite_index = reloadSprite;
                image_index = 0;
                image_speed = 0;
            } 
            else
            {
                sprite_index = normalSprite;
                image_speed = 0;
            }
        break;
        case FLAMETHROWER:
            //Override this if we are airblasting
            if (sprite_index != blastSprite) {
                sprite_index = dropSprite;
                image_speed = dropImageSpeed * global.delta_factor;
                image_index = 0;
                alarm[7] = dropTime / global.delta_factor;
            }
        break;
    }
');
object_event_add(Weapon,ev_alarm,7,'
    if (global.particles == PARTICLES_NORMAL) {
        switch(weaponType)
        {
            case SHOTGUN:
                var shell;
                shell = instance_create(x, y, Shell);
                shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
                shell.image_index = 1;
            break;
            case RIFLE:
                var shell;
                shell = instance_create(x, y, Shell);
                shell.direction = owner.aimDirection + (100 + random(30)) * image_xscale;
                shell.hspeed -= 1 * image_xscale;
                shell.vspeed -= 1;
                shell.image_index = 2;
            break;
            case REVOLVER:
                if !variable_local_exists("ejected") break;
                if (image_alpha > 0.1)
                {
                    repeat(maxAmmo-ammoCount-ejected)
                    {
                        var shell;
                        shell = instance_create(x + lengthdir_x(8, owner.aimDirection), y + lengthdir_y(8, owner.aimDirection) - 5, Shell);
                        shell.direction = 180 + owner.aimDirection + (70 - random(80)) * image_xscale;
                        shell.speed *= 0.7;
                        ejected +=1;
                    }
                }
            break;
            case FLAMETHROWER:
                sprite_index = normalSprite;
                image_speed = 0;
            break;
        }
    }
');
object_event_add(Weapon,ev_step,ev_step_normal,'
    switch(weaponType)
    {
        case MELEE:
            if !variable_local_exists("smashing") break;
            if smashing {
                image_speed=0.3;
                if 1 != 1 { //Removed crit here
                    if image_index >= 11{
                        image_speed=0;
                        image_index=8;
                        stabbing = false;
                    } 
                } else if image_index >= 4*owner.team+3 {
                    image_speed=0;
                    image_index=4*owner.team;
                    stabbing = false;
                }    
            } else {
                if 1 <= 1  image_index=4*owner.team;
                else image_index = 8;
            }
        break;
    }
');
object_event_add(Weapon,ev_step,ev_step_begin,'
    switch(weaponType)
    {
        case MINIGUN:
            if !variable_local_exists("isRefilling") exit;
            if (ammoCount < 0)
                ammoCount = 0;
            else if (ammoCount <= maxAmmo and isRefilling)
                ammoCount += 1 * global.delta_factor;
            if(!readyToShoot and alarm[5] < (25 / global.delta_factor) and !isRefilling)
                alarm[5] += 1;
        break;
        case FLAMETHROWER:
            if (ammoCount < 0)
                ammoCount = 0;
            else if (ammoCount <= maxAmmo and isRefilling)
                ammoCount += 1.8 * global.delta_factor;
        break;
    }
');
object_event_add(Weapon,ev_other,ev_user1,'
    //if (weaponGrade.object_index != STOCK) { // STOCK detected, dont change anything
    //show_error(object_get_name(weaponType), false);
    switch(weaponType) {
        case SCATTERGUN:
        case ROCKETLAUNCHER: 
        case SHOTGUN: 
        case RIFLE:
        case PISTOL: 
        case LASERGUN:
            if(readyToShoot and ammoCount > 0 and global.isHost)
            {
                var seed;
                seed = irandom(65535);
                sendEventFireWeapon(ownerPlayer, seed);
                doEventFireWeapon(ownerPlayer, seed);
            }
        break;
        case MELEE:
            //if !variable_local_exists("Stabreloadtime") break;
            if(readyToStab && !owner.cloak){
                //owner.runPower = 0;
                //owner.jumpStrength = 0;
                smashing = 1;

                justShot=true;
                readyToStab = false;
                alarm[1] = StabreloadTime / global.delta_factor;
                playsound(x,y,swingSnd);
            }
        break;
        case MINIGUN:
            // prevent sputtering
            if (ammoCount < 2)
                ammoCount -= 2;
            if(readyToShoot and ammoCount >= 2)
            {
                playsound(x,y,ChaingunSnd);
                var shot, shotx, shoty;
                randomize();
                
                shotx = x+lengthdir_x(20,owner.aimDirection);
                shoty = y+12+lengthdir_y(20,owner.aimDirection);
                if(!collision_line_bulletblocking(x, y, shotx, shoty))
                {
                    shot = createShot(shotx, shoty, Shot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(7)-3.5), 12+random(1));
                    if(golden)
                        shot.sprite_index = ShotGoldS;
                    shot.hspeed += owner.hspeed;
                    shot.alarm[0] = 30 / global.delta_factor;
                }
                else
                {
                    var imp;
                    imp = instance_create(shotx, shoty, Impact);
                    imp.image_angle = owner.aimDirection;
                }
                
                justShot=true;
                readyToShoot=false;
                isRefilling = false;
                ammoCount -= 3;
                
                var reloadBufferFactor;
                if(ammoCount < 3)
                    reloadBufferFactor = 2.5;
                else
                    //reloadBufferFactor = 1+(cos((ammoCount+2.2)/maxAmmo*pi)+1)/2; // spline from (full ammo = 1*) to (empty ammo = 2*)
                    reloadBufferFactor = 1;
                
                alarm[0] = refireTime / global.delta_factor;
                alarm[5] = reloadBuffer*reloadBufferFactor / global.delta_factor;
                
                if (global.particles == PARTICLES_NORMAL)
                {
                    var shell;
                    shell = instance_create(x, y+4, Shell);
                    shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
                }
            }
        break;
    }
');
object_event_add(Weapon,ev_other,ev_user3, '
    //if (weaponGrade.object_index != STOCK) { // STOCK detected, dont change anything
    switch(weaponType)
    {
        case SCATTERGUN:
            playsound(x,y,ShotgunSnd);
            ammoCount = max(0, ammoCount-1);
            var shot;
            repeat(shots) {
                if (specialShot != -1) shot = createShot(x, y, specialShot, damSource, owner.aimDirection, 13); else shot = createShot(x, y, Shot, damSource, owner.aimDirection, 13);
                if (shotDamage != -1) shot.hitDamage = shotDamage;
                if(golden)
                    shot.sprite_index = ShotGoldS;
                shot.hspeed += owner.hspeed;
                if (shotSpeed[0] != -1) shot.speed += random(shotSpeed[0])-shotSpeed[1]; else shot.speed += random(4)-2;
                if (shotDir[0] != -1) shot.direction += random(shotDir[0])-shotDir[1]; else shot.direction += random(15)-7.5;
                // Move shot forward to avoid immediate collision with a wall behind the character
                shot.x += lengthdir_x(15, shot.direction);
                shot.y += lengthdir_y(15, shot.direction);
                shot.alarm[0] = 35 * ((min(1, abs(cos(degtorad(owner.aimDirection)))*13/abs(cos(degtorad(owner.aimDirection))*13+owner.hspeed))-1)/2+1) / global.delta_factor;
            }
            justShot = true;
            readyToShoot = false;
            alarm[0] = refireTime / global.delta_factor;
            alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
        break;
        case SHOTGUN: // they use slightly different variables, but whatever, better than copypasted lines
            ammoCount = max(0, ammoCount-1);
            playsound(x,y,ShotgunSnd);
            var shot;
            repeat(shots) {
                if (specialShot != -1) shot = createShot(x, y, specialShot, damSource, owner.aimDirection, 13); else shot = createShot(x, y, Shot, damSource, owner.aimDirection, 13);
                if (shotDamage != -1) shot.hitDamage = shotDamage;
                if(golden)
                    shot.sprite_index = ShotGoldS;
                
                shot.hspeed += owner.hspeed;
                if (shotSpeed != -1) shot.speed += shotSpeed; else shot.speed += random(4)-2;
                if (shotDir != -1) shot.direction += shotDir; else shot.direction += random(11)-5.5;
                // Move shot forward to avoid immediate collision with a wall behind the character
                shot.x += lengthdir_x(15, shot.direction);
                shot.y += lengthdir_y(15, shot.direction);
            }
            justShot=true;
            readyToShoot=false;
            alarm[0] = refireTime / global.delta_factor;
            alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
            alarm[7] = alarm[0] / 2;
        break;
    }
');
// Scout
globalvar WEAPON_SCATTERGUN, WEAPON_FAN, WEAPON_RUNDOWN, WEAPON_SODAPOPPER, WEAPON_FLASHLIGHT, WEAPON_PISTOL, WEAPON_BONK, WEAPON_SANDMAN, WEAPON_MADMILK, WEAPON_ATOMIZER;
globalvar ForceANature, Rundown, SodaPopper, Lasergun, Pistol, BonkHand, Sandman, MadmilkHand, Atomizer;
WEAPON_SCATTERGUN = 0;
WEAPON_FAN = 1;
ForceANature = object_add();
object_set_sprite(ForceANature, sprite_add(pluginFilePath + "\randomizer_sprites\ForceANatureS.png", 2, 1, 0, 8, -2));
object_set_parent(ForceANature, Weapon);
object_event_add(ForceANature,ev_create,0,'
    xoffset=-5;
    yoffset=-4;
    refireTime=20;
    event_inherited();
    maxAmmo = 3;
    ammoCount = maxAmmo;
    reloadTime = 90;
    reloadBuffer = 20;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = SCATTERGUN;
    damSource = DAMAGE_SOURCE_SCATTERGUN;
    shots = 6;
    specialShot = FANShot;
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ForceANatureS.png", 2, 1, 0, 8, -2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ForceANatureFS.png", 4, 1, 0, 8, -2);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ForceANatureFRS.png", 16, 1, 0, 12, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(ForceANature,ev_other,ev_user3,'
    shotSpeed[0] = 6+10;
    shotSpeed[1] = 10;
    shotDir[0] = 15;
    shotDir[1] = 7;
    event_inherited();
    with(owner){
        motion_add(aimDirection, -3);
        vspeed*=0.9;
        vspeed -= 2;
        //moveStatus = 3;
        if abs(sin(aimDirection)) > abs(cos(aimDirection)) speed*=0.8;
    }
');
WEAPON_RUNDOWN = 2;
Rundown = object_add();
object_set_sprite(Rundown, sprite_add(pluginFilePath + "\randomizer_sprites\ShortStopS.png", 2, 1, 0, 8, 7));
object_set_parent(Rundown, Weapon);
object_event_add(Rundown,ev_create,0,'
    xoffset=-3;
    yoffset=-6;
    refireTime=13;
    event_inherited();
    maxAmmo = 4;
    ammoCount = maxAmmo;
    reloadTime = 45.6;
    reloadBuffer = 20;
    idle=true;
    weaponGrade = 1;
    weaponType = 0;
    damSouce = DAMAGE_SOURCE_SCATTERGUN;
    shots = 3;
    shotDamage = 14;
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShortStopS.png", 2, 1, 0, 8, 7);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShortStopFS.png", 4, 1, 0, 8, 7);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShortStopFRS.png", 16, 1, 0, 12, 15);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Rundown,ev_other,ev_user3,'
    shotSpeed[0] = 2;
    shotSpeed[1] = 12;
    shotDir[0] = 9;
    shotDir[1] = 5;
    event_inherited();
');
WEAPON_SODAPOPPER = 3;
SodaPopper = object_add();
object_set_sprite(SodaPopper, sprite_add(pluginFilePath + "\randomizer_sprites\SodaPopperS.png", 2, 1, 0, 8, -2));
object_set_parent(SodaPopper, Weapon);
object_event_add(SodaPopper,ev_create,0,'
    xoffset=-5;
    yoffset=-4;
    refireTime=12;
    event_inherited();
    maxAmmo = 2;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 20;
    idle=true;

	hasMeter = true;
	meterName = "HYPE";
	maxMeter=210;
	meterCount=0;
	abilityActive = false;
    abilityVisual = "WEAPON";
    //ability = MINICRIT;
	
    weaponGrade = UNIQUE;
    weaponType = SCATTERGUN;
    shots = 6;
    shotDamage = 8;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SodaPopperS.png", 2, 1, 0, 8, -2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SodaPopperFS.png", 4, 1, 0, 8, -2);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SodaPopperFRS.png", 16, 1, 0, 12, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(SodaPopper,ev_step,ev_step_normal, '
	if meterCount >= maxMeter {
		abilityActive = true;
	}
	if (abilityActive) {
		meterCount -= 1;
    }
	if (meterCount <= 0) {
		abilityActive = false;
        if (owner.curMeter == 0) owner.meter[0] = 0; else owner.meter[1] = 0;
    }
');
object_event_add(SodaPopper,ev_other,ev_user3,'
    shotSpeed[0] = 4;
    shotSpeed[1] = 11;
    shotDir[0] = 15;
    shotDir[1] = 7;
    event_inherited();
');
WEAPON_FLASHLIGHT = 4;
Lasergun = object_add();
object_set_parent(Lasergun, Weapon);
object_event_add(Lasergun,ev_create,0,'
    xoffset=3;
    yoffset=-6;
    refireTime=10;
    event_inherited();
    maxAmmo = 4;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 10;
    idle=true;
    shot = 0;
    hitDamage = 12;

    weaponGrade = UNIQUE;
    weaponType = LASERGUN;
    shotDamage = 12;
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\LasergunS.png", 2, 1, 0, 8, -2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\LasergunFS.png", 4, 1, 0, 8, -2);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\LasergunS.png", 2, 1, 0, 8, -2);

    sprite_index = normalSprite;
    
    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Lasergun,ev_alarm,5,'
    event_inherited();
    if ammoCount < maxAmmo {
        ammoCount += 1;
        
        if (global.particles == PARTICLES_NORMAL)
        {
            var shell;
            shell = instance_create(x, y, Shell);
            shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
            shell.image_index = 1;
        }
    }
    if ammoCount < maxAmmo {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');
object_event_add(Lasergun,ev_other,ev_user3,'
    playsound(x,y,FlashlightSnd);
    shot=true;
    justShot=true;        
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    ammoCount=max(0, ammoCount-1);
    
    var hit i;
    
    for(i=0;i<3;i+=1) {
        var x1,y1,xm,ym, len;
        var hitline;
        len=400;
        x1=x;
        y1=y;
        a[i]=x+lengthdir_x(len,owner.aimDirection-3+i*3);
        b[i]=y+lengthdir_y(len,owner.aimDirection-3+i*3);
        
        while(len>1) {
            xm=(x1+a[i])/2;
            ym=(y1+b[i])/2;
            
            hitline = false;
            with(owner) {
                if (collision_line(x1,y1,xm,ym,Generator,true,true)>=0) {
                    hitline = true;
                    if instance_nearest(x1,y1,Generator).team == team hitline = false;
                }
                if(collision_line(x1,y1,xm,ym,Obstacle,true,true)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,Character,true,true)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,Sentry,true,false)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,TeamGate,true,true)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,IntelGate,true,true)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,ControlPointSetupGate,true,true)>=0) {
                    if ControlPointSetupGate.solid == true hitline = true;
                } else if (collision_line(x1,y1,xm,ym,BulletWall,true,true)>=0) {
                    hitline = true;
                }
            }
            
            if(hitline) {
                a[i]=xm;
                b[i]=ym;
            } else {
                x1=xm;
                y1=ym;
            }
            len/=2;
        }
        
        with(Player) {
            if(id != other.ownerPlayer and team != other.owner.team and object != -1) {
                if(collision_line(other.x,other.y,other.a[i],other.b[i],object,true,false)>=0) && object.ubered == 0 {
					hitDamage *= (1+0*0.35)*1; // re-add crits? maybe!
					damageCharacter(ownerPlayer.object, other.id, hitDamage);
					//if true == true object.hp -= other.hitDamage*(1+0*0.35)*1; //Yeah MCBoss removed crits here
					//object.lastDamageCrit=other.crit;
					object.timeUnscathed = 0;
					if (object.lastDamageDealer != other.ownerPlayer && object.lastDamageDealer != object.player){
						object.secondToLastDamageDealer = object.lastDamageDealer;
						object.alarm[4] = object.alarm[3]
					}
					object.alarm[3] = ASSIST_TIME;
					object.lastDamageDealer = other.ownerPlayer;
					object.cloakAlpha = min(object.cloakAlpha + 0.3, 1);
					if(global.gibLevel > 0 && !object.radioactive){
						blood = instance_create(object.x,object.y,Blood);
						blood.direction = other.owner.aimDirection-180;
					}
                    object.lastDamageSource = WEAPON_FLASHLIGHT;
                }
            }
        }
        
        with(Sentry) {
            if(team != other.owner.team) {
                if(collision_line(other.x,other.y,other.a[i],other.b[i],id,false,false)>=0) {
					hp -= other.hitDamage*1; //Removed crap everywhere for crits
                    //lastDamageCrit=CRIT_FACTOR;
                    lastDamageDealer = other.ownerPlayer;
                    lastDamageSource = WEAPON_FLASHLIGHT;
                }
            }
        }
        
        with(Generator) {
            if(team != other.owner.team) {
                if(collision_line(other.x,other.y,other.a[i],other.b[i],id,true,false)>=0) {
                    alarm[0] = regenerationBuffer;
                    isShieldRegenerating = false;
                    //allow overkill to be applied directly to the target
                    if (other.hitDamage > shieldHp) {
                        hp -= other.hitDamage - shieldHp;
                        hp -= shieldHp * shieldResistance;
                        shieldHp = 0;
                    }
                    else
                    {
                        hp -= other.hitDamage * shieldResistance;
                        shieldHp -= other.hitDamage;
                    }
                    //exit;
                }
            }
        }
    }
');
object_event_add(Lasergun,ev_draw,0,'
    event_inherited();
    {
        if(shot) {
            var origdepth;
            shot=false;
            draw_set_alpha(0.8);
            origdepth = depth;
            depth = -2;
            for(i=0;i<3;i+=1) draw_line_width_color(x,y,a[i],b[i],2,c_yellow,c_black);
            depth = origdepth;
        }
    }
');
WEAPON_PISTOL = 5;
Pistol = object_add();
object_set_sprite(Pistol, sprite_add(pluginFilePath + "\randomizer_sprites\PistolS.png", 2, 1, 0, 8, 7));
object_set_parent(Pistol, Weapon);
object_event_add(Pistol,ev_create,0,'
    xoffset=-3;
    yoffset=-6;
    refireTime=5;
    event_inherited();
    maxAmmo = 12;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 5;
    idle=true;
    
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PistolS.png", 2, 1, 0, 8, 7);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PistolFS.png", 4, 1, 0, 8, 7);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PistolFRS.png", 16, 1, 0, 10, 12);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Pistol,ev_alarm,5,'
    event_inherited();
    if ammoCount < maxAmmo {
        ammoCount = maxAmmo;
        
        if (global.particles == PARTICLES_NORMAL)
        {
            var shell;
            shell = instance_create(x, y, Shell);
            shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
            shell.image_index = 1;
        }
    }
    if ammoCount < maxAmmo {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');
object_event_add(Pistol,ev_other,ev_user3,'
    ammoCount = max(0, ammoCount-1);
    playsound(x,y,ShotgunSnd);
    var shot;
    shot = createShot(x, y, Shot, DAMAGE_SOURCE_SCATTERGUN, owner.aimDirection, 13);
    if(golden)
        shot.sprite_index = ShotGoldS;
    shot.hspeed += owner.hspeed;
    shot.speed = 13;
    shot.direction += random(7)-4;
    shot.hitDamage = 8;
    // Move shot forward to avoid immediate collision with a wall behind the character
    shot.x += lengthdir_x(15, shot.direction);
    shot.y += lengthdir_y(15, shot.direction);
    shot.alarm[0] = 35 * ((min(1, abs(cos(degtorad(owner.aimDirection)))*13
                          /abs(cos(degtorad(owner.aimDirection))*13+owner.hspeed))-1)/2+1)
                    / global.delta_factor;

    justShot = true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
');
WEAPON_BONK = 6;
BonkHand = object_add();
object_set_sprite(BonkHand, sprite_add(pluginFilePath + "\randomizer_sprites\BonkHandS.png", 2, 1, 0, 21, 25));
object_set_parent(BonkHand, Weapon);
object_event_add(BonkHand,ev_create,0,'
    xoffset=-3;
    yoffset=-2;
    refireTime=18;
    event_inherited();
    maxAmmo = 1
    ammoCount = maxAmmo;
    reloadTime = 500;
    reloadBuffer = 18;
    idle=true;
    readyToStab=false;
    unscopedDamage = 0;
	owner.ammo[105] = -1;
	isMelee = true;
	
    weaponType = CONSUMABLE;
    weaponGrade = UNIQUE;
	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BonkHandS.png", 4, 0, 0, 21, 25);
	recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BonkHandS.png", 4, 0, 1, 21, 25);
	reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BonkHandS.png", 4, 0, 1, 21, 25);
	
	sprite_index = normalSprite;
	image_speed = 0;
	
	recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(BonkHand,ev_destroy,0,'
    if owner != -1 owner.ammo[105] = alarm[5];
');
object_event_add(BonkHand,ev_alarm,5,'
    ammoCount = maxAmmo;
    owner.ammo[105] = -1;
');
object_event_add(BonkHand,ev_alarm,6,'
    if (reloadSprite != -1 && object_index != Rifle && alarm[5] > 0)
    {
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = 0;
    } 
    else
    {
        sprite_index = normalSprite;
        image_speed = 0;
    }
');
object_event_add(BonkHand,ev_step,ev_step_normal,'
    image_index = owner.team+2*real(ammoCount);

    if !variable_local_exists("ammoCheck") {
        ammoCheck = 1;
        alarm[5] = owner.ammo[105];
    }
	if (owner.taunting) {
		if (owner.tauntindex >= sprite_get_number(owner.tauntsprite)-1 && !owner.radioactive) {
			owner.radioactive = true;
			playsound(x,y,BallSnd);
			
		}
	}
');
object_event_add(BonkHand,ev_step,ev_step_end,'
    if(!instance_exists(AmmoCounter))
        instance_create(0,0,AmmoCounter);
');
object_event_add(BonkHand,ev_other,ev_user0,'
    alarm[0]=refireTime;
    if owner.ammo[105] == -1 alarm[5] = reloadBuffer + reloadTime;
    else alarm[5] = reloadBuffer + owner.ammo[105];
');
object_event_add(BonkHand,ev_other,ev_user1,'
	if(!owner.player.humiliated && ammoCount >= 1)  {
		owner.taunting=true;
        owner.tauntindex=0;
        owner.image_speed=owner.tauntspeed;
		ammoCount = max(0, ammoCount-1);
		playsound(x,y,PickupSnd);
		alarm[5] = reloadBuffer + reloadTime;
		owner.alarm[10] = 150;
    }
');
object_event_add(BonkHand,ev_draw,0,'
    if (distance_to_point(view_xview + view_wview/2, view_yview + view_hview/2) > 800)
        exit;

    if (!owner.invisible and !owner.taunting and !owner.player.humiliated)
    {
        if (!owner.cloak)
            image_alpha = power(owner.cloakAlpha, 0.5);
        else
            image_alpha = power(owner.cloakAlpha, 2);
        draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        if (owner.ubered)
        {
            if (owner.team == TEAM_RED)
                ubercolour = c_red;
            else if (owner.team == TEAM_BLUE)
                ubercolour = c_blue;
            draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
        }
    }
');

WEAPON_SANDMAN = 7;
Sandman = object_add();
object_set_parent(Sandman, Weapon);
object_event_add(Sandman,ev_create,0,'
    xoffset=6;
    yoffset=0;
    refireTime=18;
    event_inherited();

    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = MELEE;
    shotDamage = 25;

    StabreloadTime = 5; 
    readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    
    owner.ammo[107] = -1;
    depth = 1;
    isMelee = true;
    
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandmanS.png", 2, 1, 0, 21, 25);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandmanFS.png", 8, 1, 0, 21, 25);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandmanS.png", 2, 1, 0, 21, 25);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(Sandman,ev_other,ev_user2,'
    if (readyToStab && !owner.cloak && ammoCount>=1) {
        var oid, newx, newy;
        playsound(x,y,BallSnd);
        ammoCount -= 1;

        oid = instance_create(x+lengthdir_x(10,owner.aimDirection),y+lengthdir_y(10,owner.aimDirection), Ball);
        
        oid.direction=owner.aimDirection;
        oid.speed=15;
        oid.vspeed-=2.5
        oid.crit=1;
        oid.owner=owner;
        oid.ownerPlayer=ownerPlayer;
        oid.team=owner.team;
        oid.weapon=DAMAGE_SOURCE_SCATTERGUN; //temp change
        justShot=true;
        readyToShoot = false;
        //alarm[0] = refireTime;
        readyToStab = false;
        alarm[2]=20;
        alarm[5] = reloadBuffer + reloadTime;
    }
');
WEAPON_MADMILK = 8;
MadmilkHand = object_add();
object_set_parent(MadmilkHand, Weapon);
object_event_add(MadmilkHand,ev_create,0,'
    xoffset=-10;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    maxAmmo = 1
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = 18;
    idle=true;
    readyToStab=false;
    unscopedDamage = 0;
    owner.ammo[105] = -1;
    isMelee = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MadMilkHandS.png", 4, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MadMilkHandS.png", 4, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\madMilkHandS.png", 4, 1, 0, 0, 0);

    sprite_index = normalSprite;
    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(MadmilkHand,ev_destroy,0,'
    if owner != -1 owner.ammo[105] = alarm[5];
');
object_event_add(MadmilkHand,ev_alarm,5,'
    ammoCount = maxAmmo;
    owner.ammo[105] = -1;
');
object_event_add(MadmilkHand,ev_alarm,6,'
    if (reloadSprite != -1 && object_index != Rifle && alarm[5] > 0)
    {
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = 0;
    } 
    else
    {
        sprite_index = normalSprite;
        image_speed = 0;
    }
');
object_event_add(MadmilkHand,ev_step,ev_step_normal,'
    image_index = owner.team+2*real(ammoCount);

    if !variable_local_exists("ammoCheck") {
        ammoCheck = 1;
        alarm[5] = owner.ammo[105];
    }
');
object_event_add(MadmilkHand,ev_step,ev_step_end,'
    if(!instance_exists(AmmoCounter))
        instance_create(0,0,AmmoCounter);
');
object_event_add(MadmilkHand,ev_other,ev_user0,'
    alarm[0]=refireTime;
    if owner.ammo[105] == -1 alarm[5] = reloadBuffer + reloadTime;
    else alarm[5] = reloadBuffer + owner.ammo[105];
');
object_event_add(MadmilkHand,ev_other,ev_user1,'
    if(ammoCount >= 1 && readyToShoot) {
        ammoCount -= max(0, ammoCount-1); 
        shot = instance_create(x,y + yoffset + 1,MadMilk);
        shot.direction=owner.aimDirection+ random(7)-4;
        shot.speed=13;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        with(shot)
            hspeed+=owner.hspeed;
        ammoCount = max(0, ammoCount-1);
		playsound(x,y,swingSnd);
		alarm[5] = reloadBuffer + reloadTime;
        owner.ammo[105] = -1;
		readyToShoot = false;
		alarm[0] = refireTime;
    }
');
object_event_add(MadmilkHand,ev_draw,0,'
    if (distance_to_point(view_xview + view_wview/2, view_yview + view_hview/2) > 800)
        exit;

    if (!owner.invisible and !owner.taunting and !owner.player.humiliated)
    {
        if (!owner.cloak)
            image_alpha = power(owner.cloakAlpha, 0.5);
        else
            image_alpha = power(owner.cloakAlpha, 2);
        draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        if (owner.ubered)
        {
            if (owner.team == TEAM_RED)
                ubercolour = c_red;
            else if (owner.team == TEAM_BLUE)
                ubercolour = c_blue;
            draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
        }
    }
');
WEAPON_ATOMIZER = 9;
Atomizer = object_add();
object_set_parent(Atomizer, Weapon);
object_event_add(Atomizer,ev_create,0,'
    xoffset=6;
    yoffset=0;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    weaponGrade = UNIQUE;
    weaponType = MELEE;
    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    owner.ammo[107] = -1;
    depth = 1;
    isMelee = true;
	trip = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AtomizerS.png", 2, 1, 0, 21, 25);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AtomizerFS.png", 8, 1, 0, 21, 25);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AtomizerS.png", 2, 1, 0, 21, 25);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Atomizer,ev_step,ev_step_normal,'
	if (owner.doublejumpUsed and !trip){
		owner.doublejumpUsed = false;
		trip = true;
	}
	if (owner.onground)
		trip = false;
    event_inherited();

    if !variable_local_exists("ammoCheck") {
        ammoCheck = 1;
        alarm[5] = owner.ammo[107];
    }
');

global.weapons[WEAPON_SCATTERGUN] = Scattergun;
global.name[WEAPON_SCATTERGUN] = "Scattergun";
global.weapons[WEAPON_FAN] = ForceANature;
global.name[WEAPON_FAN] = "Force A Nature";
global.weapons[WEAPON_RUNDOWN] = Rundown;
global.name[WEAPON_RUNDOWN] = "Shortstop";
global.weapons[WEAPON_SODAPOPPER] = SodaPopper;
global.name[WEAPON_SODAPOPPER] = "Soda Popper";
global.weapons[WEAPON_FLASHLIGHT] = Lasergun;
global.name[WEAPON_FLASHLIGHT] = "Flashlight";
global.weapons[WEAPON_PISTOL] = Pistol;
global.name[WEAPON_PISTOL] = "Pistol";
global.weapons[WEAPON_BONK] = BonkHand;
global.name[WEAPON_BONK] = "Bonk! Atomic punch";
global.weapons[WEAPON_SANDMAN] = Sandman;
global.name[WEAPON_SANDMAN] = "Sandman (Unfinished)";
global.weapons[WEAPON_MADMILK] = MadmilkHand;
global.name[WEAPON_MADMILK] = "Madmilk";
global.weapons[WEAPON_ATOMIZER] = Atomizer;
global.name[WEAPON_ATOMIZER] = "Atomizer (Unfinished)";

// Soldier
globalvar WEAPON_ROCKETLAUNCHER, WEAPON_DIRECTHIT, WEAPON_COWMANGLER, WEAPON_BLACKBOX, WEAPON_AIRSTRIKE, WEAPON_SOLDIERSHOTGUN, WEAPON_BUFFBANNER, WEAPON_RBISON, WEAPON_EQUALIZER, WEAPON_RESERVESHOOTER;
globalvar DirectHit, CowMangler, BlackBox, Airstrike, SoldierShotgun, BuffBanner, RBison, Shovel, Reserveshooter;
WEAPON_ROCKETLAUNCHER = 10;
WEAPON_DIRECTHIT = 11;
DirectHit = object_add();
object_set_parent(DirectHit, Weapon);
object_event_add(DirectHit,ev_create,0,'
    xoffset = -5;
    yoffset = -4;
    refireTime = 30;
    event_inherited();
    reloadTime = 25;
    reloadBuffer = 30;
    maxAmmo = 4;
    ammoCount = maxAmmo;
    rocketrange=501;
    idle=true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DirectHitS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DirectHitFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DirectHitS.png", 2, 1, 0, 10, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(DirectHit,ev_alarm,5,'
    event_inherited();

    if (ammoCount < maxAmmo)
    {
        ammoCount += 1;
    }
    if (ammoCount < maxAmmo)
    {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');
object_event_add(DirectHit,ev_other,ev_user1,'
    if(readyToShoot and ammoCount > 0 and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');
object_event_add(DirectHit,ev_other,ev_user3,'
    ammoCount = max(0, ammoCount-1);    
    playsound(x,y,DirecthitSnd);
    var oid, newx, newy;
    newx = x+lengthdir_x(20,owner.aimDirection);
    newy = y+lengthdir_y(20,owner.aimDirection);
    oid = createShot(newx, newy, Rocket, DAMAGE_SOURCE_ROCKETLAUNCHER, owner.aimDirection, 23.4);
    oid.gun=id;
    with (oid)
    {
        if (collision_line_bulletblocking(other.x, other.y, newx, newy))
        {
            // Delay explosion to make same-frame rocketjumping work reliably
            explodeImmediately = true;
        }
    }
    oid.lastknownx = owner.x;
    oid.lastknowny = owner.y;
    justShot=true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
');
WEAPON_COWMANGLER = 12;
CowMangler = object_add();
object_set_parent(CowMangler, Weapon);
object_event_add(CowMangler,ev_create,0,'
    xoffset = -5;
    yoffset = -4;
    refireTime = 30;
    event_inherited();
    reloadTime = 25;
    reloadBuffer = 30;
    maxAmmo = 100;
    ammoCount = maxAmmo;
    rocketrange=501;
    idle=true;
    //ability = CHARGE_WEAPON;
    abilityVisual = "WEAPON";
    abilityActive = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\CowmanglerS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\CowmanglerFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\CowmanglerS.png", 2, 1, 0, 10, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(CowMangler,ev_alarm,5,'
    event_inherited();

    if (ammoCount < maxAmmo)
    {
        ammoCount += 1;
    }
    if (ammoCount < maxAmmo)
    {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');
object_event_add(CowMangler,ev_step,ev_step_normal,'
    if abilityActive {
        owner.runPower = 0.6;
        owner.jumpStrength = 6;
        justShot=true;
        ammoCount -= 2;
        if ammoCount <= 0 {
            abilityActive = false;
            ammoCount=25;
            event_user(1);
        }
    } else if readyToShoot {
        if ammoCount < 0 ammoCount = 0;
        else if ammoCount <= maxAmmo ammoCount +=0.9;
    } else {
        owner.runPower = 0.9;
        owner.jumpStrength = 8+(0.6/2);
    }
');
object_event_add(CowMangler,ev_other,ev_user1,'
    if(readyToShoot and ammoCount > 0 and global.isHost and !abilityActive)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');
object_event_add(CowMangler,ev_other,ev_user2,'
    if(readyToShoot == true && ammoCount >= maxAmmo && !owner.cloak && !abilityActive) {
        abilityActive = true;
        playsound(x,y,ManglerChargesnd);
    }   
');
object_event_add(CowMangler,ev_other,ev_user3,'
    ammoCount = max(0, ammoCount-1);    
    playsound(x,y,RocketSnd);
    var oid, newx, newy;
    newx = x+lengthdir_x(20,owner.aimDirection);
    newy = y+lengthdir_y(20,owner.aimDirection);
    oid = createShot(newx, newy, Rocket, DAMAGE_SOURCE_ROCKETLAUNCHER, owner.aimDirection, 13);
    oid.gun=id;
    with (oid)
    {
        if (collision_line_bulletblocking(other.x, other.y, newx, newy))
        {
            // Delay explosion to make same-frame rocketjumping work reliably
            explodeImmediately = true;
        }
    }
    oid.lastknownx = owner.x;
    oid.lastknowny = owner.y;
    justShot=true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
');
WEAPON_BLACKBOX = 13;
BlackBox = object_add();
object_set_parent(BlackBox, Weapon);
object_event_add(BlackBox,ev_create,0,'
    xoffset = -5;
    yoffset = -4;
    refireTime = 30;
    event_inherited();
    reloadTime = 25;
    reloadBuffer = 30;
    maxAmmo = 3;
    ammoCount = maxAmmo;
    rocketrange=501;
    idle=true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BlackboxS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BlackboxFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BlackboxFRS.png", 24, 1, 0, 16, 14);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(BlackBox,ev_alarm,5,'
    event_inherited();

    if (ammoCount < maxAmmo)
    {
        ammoCount += 1;
    }
    if (ammoCount < maxAmmo)
    {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');
object_event_add(BlackBox,ev_other,ev_user1,'
    if(readyToShoot and ammoCount > 0 and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');
object_event_add(BlackBox,ev_other,ev_user3,'
    ammoCount = max(0, ammoCount-1);    
    playsound(x,y,RocketSnd);
    var oid, newx, newy;
    newx = x+lengthdir_x(20,owner.aimDirection);
    newy = y+lengthdir_y(20,owner.aimDirection);
    oid = createShot(newx, newy, Rocket, DAMAGE_SOURCE_ROCKETLAUNCHER, owner.aimDirection, 13);
    oid.gun=id;
    with (oid)
    {
        if (collision_line_bulletblocking(other.x, other.y, newx, newy))
        {
            // Delay explosion to make same-frame rocketjumping work reliably
            explodeImmediately = true;
        }
    }
    oid.lastknownx = owner.x;
    oid.lastknowny = owner.y;
    justShot=true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
');
WEAPON_AIRSTRIKE = 14;
Airstrike = object_add();
object_set_parent(Airstrike, Weapon);
object_event_add(Airstrike,ev_create,0,'
    xoffset = -5;
    yoffset = -4;
    refireTime = 30;
    event_inherited();
    reloadTime = 25;
    reloadBuffer = 30;
    maxAmmo = 4;
    ammoCount = maxAmmo;
    rocketrange=501;
    idle=true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AirstrikeS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AirstrikeFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AirstrikeFRS.png", 24, 1, 0, 16, 14);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Airstrike,ev_alarm,5,'
    event_inherited();

    if (ammoCount < maxAmmo)
    {
        ammoCount += 1;
    }
    if (ammoCount < maxAmmo)
    {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');
object_event_add(Airstrike,ev_other,ev_user1,'
    if(readyToShoot and ammoCount > 0 and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');
object_event_add(Airstrike,ev_other,ev_user2,'
    with(Rocket) {
        if ownerPlayer = other.ownerPlayer && direction != 270 {
        direction = 270;
        image_angle = 270;
        speed -= 2;
        travelDistance=0;
        other.alarm[0] = other.refireTime;
        }
    }
');
object_event_add(Airstrike,ev_other,ev_user3,'
    ammoCount = max(0, ammoCount-1);    
    playsound(x,y,RocketSnd);
    var oid, newx, newy;
    newx = x+lengthdir_x(20,owner.aimDirection);
    newy = y+lengthdir_y(20,owner.aimDirection);
    oid = createShot(newx, newy, Rocket, DAMAGE_SOURCE_ROCKETLAUNCHER, owner.aimDirection, 13);
    oid.gun=id;
    with (oid)
    {
        if (collision_line_bulletblocking(other.x, other.y, newx, newy))
        {
            // Delay explosion to make same-frame rocketjumping work reliably
            explodeImmediately = true;
        }
    }
    oid.lastknownx = owner.x;
    oid.lastknowny = owner.y;
    justShot=true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
');
WEAPON_SOLDIERSHOTGUN = 15;
SoldierShotgun = object_add();
object_set_parent(SoldierShotgun, Weapon);
object_event_add(SoldierShotgun,ev_create,0,'
    xoffset=1;
    yoffset=4;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = SHOTGUN;
    shots = 5;
    shotDamage = 7;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SoldierShotgunS.png", 2, 1, 0, 6, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SoldierShotgunFS.png", 4, 1, 0, 6, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SoldierShotgunFRS.png", 16, 1, 0, 18, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
// Introduce Metered weapons
WEAPON_BUFFBANNER = 16;
BuffBanner = object_add();
object_set_parent(BuffBanner, Weapon);
object_event_add(BuffBanner,ev_create,0,'
    xoffset=-9;
    yoffset=-9;
    refireTime=18;
    event_inherited();
    maxAmmo = 4; // this dont matter
	maxMeter = 4;
	meterCount = 0;
    ammoCount = 0;
    reloadTime = 500;
    reloadBuffer = 18;
    idle=true;
    readyToStab=false;
    image_speed = 0;
    unscopedDamage = 0;
	isMelee = true;
	
	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BuffBannerS.png", 2, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BuffBannerS.png", 2, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BuffBannerS.png", 2, 1, 0, 0, 0);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(BuffBanner,ev_other,ev_user3,'
	if (!owner.cloak && meterCount >= maxMeter)
	{
		meterCount = 0;
		playsound(x,y,BuffbannerSnd);
		owner.taunting=true;
        owner.tauntindex=0;
        owner.image_speed=owner.tauntspeed;
	}
');
object_event_add(BuffBanner,ev_step,ev_step_normal,'
    image_index = owner.team+2*real(ammoCount);

    if !variable_local_exists("ammoCheck") {
        ammoCheck = 1;
        alarm[5] = owner.ammo[105];
    }
	if (owner.taunting) {
		if (owner.tauntindex >= sprite_get_number(owner.tauntsprite)-1 && !owner.buffbanner) {
			owner.buffbanner = true;
			playsound(x,y,BallSnd);
			
		}
	}
');

WEAPON_RBISON = 17;
RBison = object_add();
object_set_parent(RBison, Weapon);
object_event_add(RBison,ev_create,0,'
    xoffset=5;
    yoffset=1;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\RBisonS.png", 2, 1, 0, 8, 7);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\RBisonFS.png", 4, 1, 0, 8, 7);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\RBisonS.png", 2, 1, 0, 8, 7);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(RBison,ev_alarm,5,'
    event_inherited();

    if ammoCount < maxAmmo {
        ammoCount+=1;
    }
    if ammoCount < maxAmmo {
        alarm[5] = reloadTime / global.delta_factor;
        
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');
object_event_add(RBison,ev_other,ev_user1,'
    if(readyToShoot && ammoCount >0 && !owner.cloak) {
        ammoCount-=1;
        playsound(x,y,LaserShotSnd);
        var shot;
        randomize();
        shot = instance_create(x,y,LaserShot);
        shot.direction=owner.aimDirection+ random(3)-1;
        shot.image_angle = direction;
        shot.speed = 22;
        shot.owner = owner;
        shot.ownerPlayer = ownerPlayer;
        shot.team = owner.team;
        shot.weapon = WEAPON_RBISON;
        with(shot) {   
            hspeed += owner.hspeed;
        
            alarm[0] = 35 * ((min(1, abs(cos(degtorad(other.owner.aimDirection)))*13 / abs(cos(degtorad(other.owner.aimDirection))*13+owner.hspeed))-1)/2+1)
           // motion_add(owner.direction, owner.speed);
        }
        justShot = true;
        readyToShoot = false;
        alarm[0] = refireTime;
        alarm[5] = reloadBuffer + reloadTime;
    }
');
WEAPON_EQUALIZER = 18;
Shovel = object_add();
object_set_parent(Shovel, Weapon);
object_event_add(Shovel,ev_create,0,'
    xoffset=1;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    isMelee = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShovelS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShovelFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShovelS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
	
	//owner.runPower = 5;
');
object_event_add(Shovel,ev_destroy,0,'
	owner.runPower = owner.baseRunPower;
	owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Shovel,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        if (owner.hp < owner.maxHp) 
			shot.hitDamage = 14+(((owner.maxHp+40)/(owner.hp+40))*11);
		else
			shot.hitDamage = 10;
        shot.weapon=WEAPON_EQUALIZER;
        //Removed crit thing here
        alarm[2] = 10;
    }
');
object_event_add(Shovel,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Shovel,ev_alarm,5,'
    ammoCount = 1;
');
object_event_add(Shovel,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }
	if (owner.hp != owner.maxHp){
		owner.runPower = owner.baseRunPower + (owner.maxHp + 40) / (owner.hp + 40) * 0.2;
		owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
	} else {
		owner.runPower = owner.baseRunPower;
		owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
	}
');
object_event_add(Shovel,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    }
');
WEAPON_RESERVESHOOTER = 19;
Reserveshooter = object_add();
object_set_parent(Reserveshooter, Weapon);
object_event_add(Reserveshooter,ev_create,0,'
    xoffset=1;
    yoffset=4;
    refireTime=20;
    event_inherited();
    maxAmmo = 4;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    // cooldown = refireTime; [A typo?]
    couldSwitch = false;
    readyToShoot=true;

    shotDamage = 7;
    shots = 5;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\reserveshooterS.png", 2, 1, 0, 6, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\reserveshooterFS.png", 4, 1, 0, 6, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\reserveshooterFRS.png", 16, 1, 0, 18, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Reserveshooter,ev_alarm,5,'
    event_inherited();

    if ammoCount >= maxAmmo owner.canSwitch = true;
');
object_event_add(Reserveshooter,ev_step,ev_step_normal,'
    if(ammoCount >= maxAmmo){
        owner.canSwitch = true;
    }else{
        owner.canSwitch = false;
    }
');
object_event_add(Reserveshooter,ev_other,ev_user1,'
    shotSpeed[0] = 11;
    shotSpeed[1] = 4;
    shotDir[0] = 11;
    shotDir[1] = 5;
    event_inherited();
');

global.weapons[WEAPON_ROCKETLAUNCHER] = Rocketlauncher;
global.name[WEAPON_ROCKETLAUNCHER] = "Rocketlauncher";
global.weapons[WEAPON_DIRECTHIT] = DirectHit;
global.name[WEAPON_DIRECTHIT] = "Direct Hit"
global.weapons[WEAPON_COWMANGLER] = CowMangler;
global.name[WEAPON_COWMANGLER] = "Cow Mangler 5000 (unfinished)";
global.weapons[WEAPON_BLACKBOX] = BlackBox;
global.name[WEAPON_BLACKBOX] = "Black Box";
global.weapons[WEAPON_AIRSTRIKE] = Airstrike;
global.name[WEAPON_AIRSTRIKE] = "Airstrike";
global.weapons[WEAPON_SOLDIERSHOTGUN] = SoldierShotgun;
global.name[WEAPON_SOLDIERSHOTGUN] = "Shotgun";
global.weapons[WEAPON_BUFFBANNER] = BuffBanner;
global.name[WEAPON_BUFFBANNER] = "Buff Banner (spriteonly)";
global.weapons[WEAPON_RBISON] = RBison;
global.name[WEAPON_RBISON] = "Righteous Bison";
global.weapons[WEAPON_EQUALIZER] = Shovel;
global.name[WEAPON_EQUALIZER] = "Equalizer";
global.weapons[WEAPON_RESERVESHOOTER] = Reserveshooter;
global.name[WEAPON_RESERVESHOOTER] = "Reserve Shooter (unfinished)";

// Sniper
globalvar WEAPON_RIFLE, WEAPON_BAZAARBARGAIN, WEAPON_HUNTSMAN, WEAPON_MACHINA, WEAPON_SYDNEYSLEEPER, WEAPON_SMG, WEAPON_JARATE, WEAPON_KUKRI, WEAPON_SHIV, WEAPON_BOOTS;
globalvar BazaarBargain, HuntsMan, Machina, SydneySleeper, Smg, JarateHand, Kukri, Shiv;
WEAPON_RIFLE = 20;
WEAPON_BAZAARBARGAIN = 21;
BazaarBargain = object_add();
object_set_parent(BazaarBargain, Weapon);
object_event_add(BazaarBargain,ev_create,0,'
    xoffset = -1;
    yoffset = -4;
    refireTime = 40;
    event_inherited();
    reloadTime = 40;
    unscopedDamage = 25;
    baseDamage = 45;
    maxDamage = 75;
    chargeTime = 105;
    hitDamage=baseDamage;
    maxAmmo = 0;
    ammoCount = maxAmmo;
    shot=false;
    t=0;
    bonus = 0;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BazaarBargainS.png", 2, 1, 0, 4, 4);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BazaarBargainFS.png", 4, 1, 0, 4, 4);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BazaarBargainFRS.png", 38, 1, 0, 16, 12);

    sprite_index = normalSprite;

    recoilTime = 15;
    recoilAnimLength = sprite_get_number(recoilSprite)/2
    recoilImageSpeed = recoilAnimLength/recoilTime

    longRecoilTime = 60;
    reloadAnimLength = sprite_get_number(reloadSprite)/2
    reloadImageSpeed = reloadAnimLength/(longRecoilTime);
    
    tracerAlpha = 0;
');
object_event_add(BazaarBargain,ev_alarm,7,'
    if (global.particles == PARTICLES_NORMAL)
    {
        var shell;
        shell = instance_create(x, y, Shell);
        shell.direction = owner.aimDirection + (100 + random(30)) * image_xscale;
        shell.hspeed -= 1 * image_xscale;
        shell.vspeed -= 1;
        shell.image_index = 2;
    }
');
object_event_add(BazaarBargain,ev_step,ev_step_begin,'
    if(owner.zoomed and readyToShoot)
    {
        t += 1 * global.delta_factor;
        if (t > chargeTime)
            t = chargeTime;
    }
    else
        t = 0;
    if(!owner.zoomed)
        hitDamage = unscopedDamage;
    else
        hitDamage = baseDamage + floor(sqrt(t/chargeTime)*(maxDamage-baseDamage));
');
object_event_add(BazaarBargain,ev_step,ev_step_end,'
    if (justShot)
    {
        justShot = false;
        //Recoil Animation
        if (owner.zoomed)
        {
            if (sprite_index != reloadSprite)
            {
                sprite_index = reloadSprite
                image_index = 0
                image_speed = reloadImageSpeed;
            }
            alarm[6] = longRecoilTime;
        }
        else
        {
            if (sprite_index != recoilSprite)
            {
                sprite_index = recoilSprite
                image_index = 0
                image_speed = recoilImageSpeed;
            }
            alarm[6] = recoilTime;
        }
    }
');
object_event_add(BazaarBargain,ev_other,ev_user1,'
    if(readyToShoot and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');
object_event_add(BazaarBargain,ev_other,ev_user3,'
    playsound(x,y,SniperSnd);
    shot=true;
    justShot=true;
    readyToShoot = false;
    alarm[0] = (reloadTime + 20*owner.zoomed) / global.delta_factor;
    alarm[7] = (reloadTime/4 + 10*owner.zoomed) / global.delta_factor;  // Eject a shell during the animation

    // for drawing:
    tracerAlpha = 0.8;
    shotx = x;
    shoty = y;

    var x1, y1, xm, ym, leftmostX, len;
    len = 1500*(((hitDamage*100)/maxDamage)/100)
    x1 = x;
    y1 = y;
    x2 = x+lengthdir_x(len, owner.aimDirection);
    y2 = y+lengthdir_y(len, owner.aimDirection);
    leftmostX = min(x1, x2);

    gunSetSolids();
    alarm[6] = alarm[0];

    // We do a hitscan test here to figure out how far the rifle shot actually goes before it hits something.
    // This works by binary search through collision_line tests on ever smaller segments of our ray.
    //
    // Unfortunately, collision_line can only check for collision against either *all* instances, or instances of one
    // object, or just a single instance. What we need however is to check against *some* instances of *some* objects.
    // 
    // We could make a list of all instances that should stop the bullet and check each of them individually, but that
    // could be slow.
    // 
    // So here is how we do this instead: We do several collision_line checks, but only on an object basis.
    // Those instances which are instances of those objects, but should not stop the bullets are set to an empty
    // collision mask, and that is reverted after we are done.

    var bulletStoppingObjects, originalMask, hitInstance;
    bulletStoppingObjects = ds_list_create();
    originalMask = ds_map_create();
    hitInstance = noone;

    ds_list_add(bulletStoppingObjects, Obstacle);
    ds_list_add(bulletStoppingObjects, Generator);
    ds_list_add(bulletStoppingObjects, Character);
    ds_list_add(bulletStoppingObjects, Sentry);
    if(!global.mapchanging)
        ds_list_add(bulletStoppingObjects, TeamGate);
    ds_list_add(bulletStoppingObjects, IntelGate);
    if(areSetupGatesClosed())
        ds_list_add(bulletStoppingObjects, ControlPointSetupGate);
    ds_list_add(bulletStoppingObjects, BulletWall);

    // Set the collision mask of all instances which should not collide to an empty one
    with(Generator) {
        if(team == other.owner.team) {
            ds_map_add(originalMask, id, mask_index);
            mask_index = emptyMaskS;
        }
    }

    with(Sentry) {
        if(team == other.owner.team) {
            ds_map_add(originalMask, id, mask_index);
            mask_index = emptyMaskS;
        }
    }

    with(owner) {
        ds_map_add(originalMask, id, mask_index);
        mask_index = emptyMaskS;
    }

    // Find the first instance the ray collides with
    var hit, i;
    while(len>1) {
        xm=(x1+x2)/2;
        ym=(y1+y2)/2;
        
        hit = noone;
        for(i = 0; (i < ds_list_size(bulletStoppingObjects)) and !hit; i += 1) {
            hit = collision_line(x1, y1, xm, ym, ds_list_find_value(bulletStoppingObjects, i), true, true);
        }
        
        if(hit) {
            x2=xm;
            y2=ym;
            hitInstance = hit;
        } else {
            x1=xm;
            y1=ym;
        }
        len/=2;
    }

    // Re-assign the original collision masks
    var key, origMask;
    for(key = ds_map_find_first(originalMask); key; key = ds_map_find_next(originalMask, key)) {
        origMask = ds_map_find_value(originalMask, key);
        with(key) {
            mask_index = origMask;
        }
    }

    ds_map_destroy(originalMask);
    ds_list_destroy(bulletStoppingObjects);

    // Apply dramatic effect
    with(hitInstance) {
        if(object_index == Character or object_is_ancestor(object_index, Character)) {
            if(!ubered and team != other.owner.team) {
                damageCharacter(other.ownerPlayer, id, other.hitDamage);
                if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player)
                {
                    secondToLastDamageDealer = lastDamageDealer;
                    alarm[4] = alarm[3]
                }
                alarm[3] = ASSIST_TIME / global.delta_factor;
                lastDamageDealer = other.ownerPlayer;
                dealFlicker(id);
                if(global.gibLevel > 0 && !object.radioactive)
                {
                    blood = instance_create(x, y, Blood);
                    blood.direction = other.owner.aimDirection - 180;
                }
                if (!other.owner.zoomed) {
                    lastDamageSource = DAMAGE_SOURCE_RIFLE;
                } else {
                    lastDamageSource = DAMAGE_SOURCE_RIFLE_CHARGED;
                }
            }
        } else if(object_index == Sentry or object_is_ancestor(object_index, Sentry)) {
            damageSentry(other.ownerPlayer, id, other.hitDamage);
            lastDamageDealer = other.ownerPlayer;
            if (!other.owner.zoomed)
                lastDamageSource = DAMAGE_SOURCE_RIFLE;
            else
                lastDamageSource = DAMAGE_SOURCE_RIFLE_CHARGED;
        } else if(object_index == Generator or object_is_ancestor(object_index, Generator)) {
            damageGenerator(other.ownerPlayer, id, other.hitDamage);
        }
    }

    gunUnsetSolids();
');
object_event_add(BazaarBargain,ev_draw,0,'
    event_inherited();
    if (tracerAlpha > 0.05)
    {
        shot = false;
        var origdepth;
        origdepth = depth;
        depth = -2;
        
        draw_set_alpha(tracerAlpha);
        if(owner.team == TEAM_RED)
            draw_line_width_color(shotx,shoty,x2,y2,2,c_red,c_red);
        else
            draw_line_width_color(shotx,shoty,x2,y2,2,c_blue,c_blue);
        if(global.particles != PARTICLES_OFF)
            tracerAlpha /= delta_mult(1.75);
        else tracerAlpha = 0;
            
        draw_set_alpha(1);
        depth = origdepth;
    }
    else
        tracerAlpha = 0;

    if (owner.zoomed && owner == global.myself.object)
    {
        if (hitDamage < maxDamage)
        {
            draw_set_alpha(0.25);
            draw_sprite_ext(ChargeS, 0, mouse_x + 15*-image_xscale, mouse_y - 10, -image_xscale, 1, 0, c_white, image_alpha);
            draw_set_alpha(0.8);
        }
        else
            draw_sprite_ext(FullChargeS, 0, mouse_x + 65*-image_xscale, mouse_y, 1, 1, 0, c_white, image_alpha);
            draw_sprite_part_ext(ChargeS, 1, 0, 0, ceil((hitDamage-baseDamage)*40/(maxDamage-baseDamage)), 20, mouse_x + 15*-image_xscale, mouse_y - 10, -image_xscale, 1, c_white, image_alpha);
    }
');
WEAPON_HUNTSMAN = 22;
HuntsMan = object_add();
object_set_parent(HuntsMan, Weapon);
object_event_add(HuntsMan,ev_create,0,'
    xoffset=4;
    yoffset=1;
    refireTime = 40;
    event_inherited();
    reloadTime = 40;
    unscopedDamage = 35;
    baseDamage = 45;
    maxDamage = 75;
    chargeTime = 105;
    hitDamage=baseDamage;
    maxAmmo = 0;
    ammoCount = maxAmmo;
    shot=false;
    t=0;
    
    bonus=0;
    charging=false;
    //abilityType = CHARGING;
    abilityActive = false;
    abilityVisual = "WEAPON";
    overheat=0;
    burning = false;
    helper = -1;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HuntsmanS.png", 2, 1, 0, 9, 15);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HuntsmanFS.png", 4, 1, 0, 9, 15);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HuntsmanS.png", 2, 1, 0, 9, 15);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(HuntsMan,ev_alarm,1,'
    abilityActive=false;
');
object_event_add(HuntsMan,ev_step,ev_step_begin,'
    if bonus > 0 && !abilityActive {
            playsound(x,y,BowSnd);
            var shot;
            randomize();
            
            shot = instance_create(x,y + yoffset + 1,Arrow);
            shot.direction=owner.aimDirection;
            shot.speed=10+(bonus/10)*2.2;
            shot.owner=owner;
            //shot.crit=crit;
            shot.ownerPlayer=ownerPlayer;
            shot.team=owner.team;
            if burning {
                shot.burning = true;
                shot.helper = helper;
                shot.weapon = WEAPON_FIREARROW;
            } else shot.weapon=WEAPON_HUNTSMAN;
            with(shot)
                hspeed+=owner.hspeed;
            justShot=true;
            readyToShoot=false;
            alarm[0]=refireTime;
            bonus=0;
            overheat=0;
            owner.runPower = 0.9;
            owner.jumpStrength = 8+(0.6/2);
            burning = false;
    }

    if burning && random(5) > 3.5 effect_create_above(ef_smokeup,x,y,0,c_gray);
');
object_event_add(HuntsMan,ev_collision,BurningProjectile,'
    if other.team == owner.team {
        burning = true;
        helper = other.ownerPlayer;
    }
');
/*
object_event_add(HuntsMan,ev_collision,LaserShot,'
    if other.team == owner.team {
        burning = true;
        helper = other.ownerPlayer;
    }
');
*/
object_event_add(HuntsMan,ev_other,ev_user1,'
    {
        if(readyToShoot && !owner.cloak) {
            owner.runPower = 0.6;
            owner.jumpStrength = 6;
            abilityActive = true;
            alarm[1] = 2;
            if bonus < 100 bonus+=1.2;
            else if overheat < (30*4) overheat+=1;
            else {
                bonus = 0;
                readyToShoot=false;
                alarm[0]=refireTime;
                overheat = 0;
            }
        }
    }
');
object_event_add(HuntsMan,ev_other,ev_user2,'
    abilityActive = false;
    bonus = 0;
    owner.runPower = 0.9;
    owner.jumpStrength = 8+(0.6/2);
');
WEAPON_MACHINA = 23;
Machina = object_add();
object_set_parent(Machina, Weapon);
object_event_add(Machina,ev_create,0,'
    xoffset = -1;
    yoffset = -4;
    refireTime = 40;
    event_inherited();
    reloadTime = 70;
    unscopedDamage = 35;
    baseDamage = 45;
    maxDamage = 75;
    chargeTime = 105;
    hitDamage=baseDamage;
    maxAmmo = 0;
    ammoCount = maxAmmo;
    shot=false;
    t=0;
    bonus = 0;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinaS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinaFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinaFRS.png", 38, 1, 0, 18, 12);

    sprite_index = normalSprite;

    recoilTime = 15;
    recoilAnimLength = sprite_get_number(recoilSprite)/2
    recoilImageSpeed = recoilAnimLength/recoilTime

    longRecoilTime = 60;
    reloadAnimLength = sprite_get_number(reloadSprite)/2
    reloadImageSpeed = reloadAnimLength/(longRecoilTime);
    
    tracerAlpha = 0;
');
object_event_add(Machina,ev_alarm,7,'
    if (global.particles == PARTICLES_NORMAL)
    {
        var shell;
        shell = instance_create(x, y, Shell);
        shell.direction = owner.aimDirection + (100 + random(30)) * image_xscale;
        shell.hspeed -= 1 * image_xscale;
        shell.vspeed -= 1;
        shell.image_index = 2;
    }
');
object_event_add(Machina,ev_step,ev_step_begin,'
    if(owner.zoomed and readyToShoot)
    {
        t += 1 * global.delta_factor;
        if (t > chargeTime)
            t = chargeTime;
    }
    else
        t = 0;
    if(!owner.zoomed)
        hitDamage = unscopedDamage;
    else
        hitDamage = baseDamage + floor(sqrt(t/chargeTime)*(maxDamage-baseDamage));
');
object_event_add(Machina,ev_step,ev_step_end,'
    if (justShot)
    {
        justShot = false;
        //Recoil Animation
        if (owner.zoomed)
        {
            if (sprite_index != reloadSprite)
            {
                sprite_index = reloadSprite
                image_index = 0
                image_speed = reloadImageSpeed;
            }
            alarm[6] = longRecoilTime;
        }
        else
        {
            if (sprite_index != recoilSprite)
            {
                sprite_index = recoilSprite
                image_index = 0
                image_speed = recoilImageSpeed;
            }
            alarm[6] = recoilTime;
        }
    }
');
object_event_add(Machina,ev_other,ev_user1,'
    if(readyToShoot and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');
object_event_add(Machina,ev_other,ev_user3,'
    playsound(x,y,SniperSnd);
    shot=true;
    justShot=true;
    readyToShoot = false;
    alarm[0] = (reloadTime + 20*owner.zoomed) / global.delta_factor;
    alarm[7] = (reloadTime/4 + 10*owner.zoomed) / global.delta_factor;  // Eject a shell during the animation

    // for drawing:
    tracerAlpha = 0.8;
    shotx = x;
    shoty = y;

    var x1, y1, xm, ym, leftmostX, len;
    len = 1500*(((hitDamage*100)/maxDamage)/100)
    x1 = x;
    y1 = y;
    x2 = x+lengthdir_x(len, owner.aimDirection);
    y2 = y+lengthdir_y(len, owner.aimDirection);
    leftmostX = min(x1, x2);

    gunSetSolids();
    alarm[6] = alarm[0];

    // We do a hitscan test here to figure out how far the rifle shot actually goes before it hits something.
    // This works by binary search through collision_line tests on ever smaller segments of our ray.
    //
    // Unfortunately, collision_line can only check for collision against either *all* instances, or instances of one
    // object, or just a single instance. What we need however is to check against *some* instances of *some* objects.
    // 
    // We could make a list of all instances that should stop the bullet and check each of them individually, but that
    // could be slow.
    // 
    // So here is how we do this instead: We do several collision_line checks, but only on an object basis.
    // Those instances which are instances of those objects, but should not stop the bullets are set to an empty
    // collision mask, and that is reverted after we are done.

    var bulletStoppingObjects, originalMask, hitInstance;
    bulletStoppingObjects = ds_list_create();
    originalMask = ds_map_create();
    hitInstance = noone;

    ds_list_add(bulletStoppingObjects, Obstacle);
    ds_list_add(bulletStoppingObjects, Generator);
    ds_list_add(bulletStoppingObjects, Character);
    ds_list_add(bulletStoppingObjects, Sentry);
    if(!global.mapchanging)
        ds_list_add(bulletStoppingObjects, TeamGate);
    ds_list_add(bulletStoppingObjects, IntelGate);
    if(areSetupGatesClosed())
        ds_list_add(bulletStoppingObjects, ControlPointSetupGate);
    ds_list_add(bulletStoppingObjects, BulletWall);

    // Set the collision mask of all instances which should not collide to an empty one
    with(Generator) {
        if(team == other.owner.team) {
            ds_map_add(originalMask, id, mask_index);
            mask_index = emptyMaskS;
        }
    }

    with(Sentry) {
        if(team == other.owner.team) {
            ds_map_add(originalMask, id, mask_index);
            mask_index = emptyMaskS;
        }
    }

    with(owner) {
        ds_map_add(originalMask, id, mask_index);
        mask_index = emptyMaskS;
    }

    // Find the first instance the ray collides with
    var hit, i;
    while(len>1) {
        xm=(x1+x2)/2;
        ym=(y1+y2)/2;
        
        hit = noone;
        for(i = 0; (i < ds_list_size(bulletStoppingObjects)) and !hit; i += 1) {
            hit = collision_line(x1, y1, xm, ym, ds_list_find_value(bulletStoppingObjects, i), true, true);
        }
        
        if(hit) {
            x2=xm;
            y2=ym;
            hitInstance = hit;
        } else {
            x1=xm;
            y1=ym;
        }
        len/=2;
    }

    // Re-assign the original collision masks
    var key, origMask;
    for(key = ds_map_find_first(originalMask); key; key = ds_map_find_next(originalMask, key)) {
        origMask = ds_map_find_value(originalMask, key);
        with(key) {
            mask_index = origMask;
        }
    }

    ds_map_destroy(originalMask);
    ds_list_destroy(bulletStoppingObjects);

    // Apply dramatic effect
    with(hitInstance) {
        if(object_index == Character or object_is_ancestor(object_index, Character)) {
            if(!ubered and team != other.owner.team) {
                damageCharacter(other.ownerPlayer, id, other.hitDamage);
                if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player)
                {
                    secondToLastDamageDealer = lastDamageDealer;
                    alarm[4] = alarm[3]
                }
                alarm[3] = ASSIST_TIME / global.delta_factor;
                lastDamageDealer = other.ownerPlayer;
                dealFlicker(id);
                if(global.gibLevel > 0 && !object.radioactive)
                {
                    blood = instance_create(x, y, Blood);
                    blood.direction = other.owner.aimDirection - 180;
                }
                if (!other.owner.zoomed) {
                    lastDamageSource = DAMAGE_SOURCE_RIFLE;
                } else {
                    lastDamageSource = DAMAGE_SOURCE_RIFLE_CHARGED;
                }
            }
        } else if(object_index == Sentry or object_is_ancestor(object_index, Sentry)) {
            damageSentry(other.ownerPlayer, id, other.hitDamage);
            lastDamageDealer = other.ownerPlayer;
            if (!other.owner.zoomed)
                lastDamageSource = DAMAGE_SOURCE_RIFLE;
            else
                lastDamageSource = DAMAGE_SOURCE_RIFLE_CHARGED;
        } else if(object_index == Generator or object_is_ancestor(object_index, Generator)) {
            damageGenerator(other.ownerPlayer, id, other.hitDamage);
        }
    }

    gunUnsetSolids();
');
object_event_add(Machina,ev_draw,0,'
    event_inherited();
    if (tracerAlpha > 0.05)
    {
        shot = false;
        var origdepth;
        origdepth = depth;
        depth = -2;
        
        draw_set_alpha(tracerAlpha);
        if(owner.team == TEAM_RED)
            draw_line_width_color(shotx,shoty,x2,y2,2,c_red,c_red);
        else
            draw_line_width_color(shotx,shoty,x2,y2,2,c_blue,c_blue);
        if(global.particles != PARTICLES_OFF)
            tracerAlpha /= delta_mult(1.75);
        else tracerAlpha = 0;
            
        draw_set_alpha(1);
        depth = origdepth;
    }
    else
        tracerAlpha = 0;

    if (owner.zoomed && owner == global.myself.object)
    {
        if (hitDamage < maxDamage)
        {
            draw_set_alpha(0.25);
            draw_sprite_ext(ChargeS, 0, mouse_x + 15*-image_xscale, mouse_y - 10, -image_xscale, 1, 0, c_white, image_alpha);
            draw_set_alpha(0.8);
        }
        else
            draw_sprite_ext(FullChargeS, 0, mouse_x + 65*-image_xscale, mouse_y, 1, 1, 0, c_white, image_alpha);
            draw_sprite_part_ext(ChargeS, 1, 0, 0, ceil((hitDamage-baseDamage)*40/(maxDamage-baseDamage)), 20, mouse_x + 15*-image_xscale, mouse_y - 10, -image_xscale, 1, c_white, image_alpha);
    }
');
WEAPON_SYDNEYSLEEPER = 24;
SydneySleeper = object_add();
object_set_parent(SydneySleeper, Weapon);
object_event_add(SydneySleeper,ev_create,0,'
    xoffset = -1;
    yoffset = -4;
    refireTime = 40;
    event_inherited();
    reloadTime = 40;
    unscopedDamage = 30;
    baseDamage = 40;
    maxDamage = 65;
    chargeTime = 105;
    hitDamage=baseDamage;
    maxAmmo = 0;
    ammoCount = maxAmmo;
    shot=false;
    t=0;
    bonus = 0;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SydneySleeperS.png", 2, 1, 0, 4, 4);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SydneySleeperFS.png", 4, 1, 0, 4, 4);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SydneySleeperS.png", 2, 1, 0, 4, 4);

    sprite_index = normalSprite;

    recoilTime = 15;
    recoilAnimLength = sprite_get_number(recoilSprite)/2
    recoilImageSpeed = recoilAnimLength/recoilTime

    longRecoilTime = 60;
    reloadAnimLength = sprite_get_number(reloadSprite)/2
    reloadImageSpeed = reloadAnimLength/(longRecoilTime);
    
    tracerAlpha = 0;
');
object_event_add(SydneySleeper,ev_alarm,7,'
    if (global.particles == PARTICLES_NORMAL)
    {
        var shell;
        shell = instance_create(x, y, Shell);
        shell.direction = owner.aimDirection + (100 + random(30)) * image_xscale;
        shell.hspeed -= 1 * image_xscale;
        shell.vspeed -= 1;
        shell.image_index = 2;
    }
');
object_event_add(SydneySleeper,ev_step,ev_step_begin,'
    if(owner.zoomed and readyToShoot)
    {
        t += 1 * global.delta_factor;
        if (t > chargeTime)
            t = chargeTime;
    }
    else
        t = 0;
    if(!owner.zoomed)
        hitDamage = unscopedDamage;
    else
        hitDamage = baseDamage + floor(sqrt(t/chargeTime)*(maxDamage-baseDamage));
');
object_event_add(SydneySleeper,ev_step,ev_step_end,'
    if (justShot)
    {
        justShot = false;
        //Recoil Animation
        if (owner.zoomed)
        {
            if (sprite_index != reloadSprite)
            {
                sprite_index = reloadSprite
                image_index = 0
                image_speed = reloadImageSpeed;
            }
            alarm[6] = longRecoilTime;
        }
        else
        {
            if (sprite_index != recoilSprite)
            {
                sprite_index = recoilSprite
                image_index = 0
                image_speed = recoilImageSpeed;
            }
            alarm[6] = recoilTime;
        }
    }
');
object_event_add(SydneySleeper,ev_other,ev_user1,'
    if(readyToShoot and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');
object_event_add(SydneySleeper,ev_other,ev_user3,'
    playsound(x,y,SniperSnd);
    shot=true;
    justShot=true;
    readyToShoot = false;
    alarm[0] = (reloadTime + 20*owner.zoomed) / global.delta_factor;
    alarm[7] = (reloadTime/4 + 10*owner.zoomed) / global.delta_factor;  // Eject a shell during the animation

    // for drawing:
    tracerAlpha = 0.8;
    shotx = x;
    shoty = y;

    var x1, y1, xm, ym, leftmostX, len;
    len = 1500*(((hitDamage*100)/maxDamage)/100)
    x1 = x;
    y1 = y;
    x2 = x+lengthdir_x(len, owner.aimDirection);
    y2 = y+lengthdir_y(len, owner.aimDirection);
    leftmostX = min(x1, x2);

    gunSetSolids();
    alarm[6] = alarm[0];

    // We do a hitscan test here to figure out how far the rifle shot actually goes before it hits something.
    // This works by binary search through collision_line tests on ever smaller segments of our ray.
    //
    // Unfortunately, collision_line can only check for collision against either *all* instances, or instances of one
    // object, or just a single instance. What we need however is to check against *some* instances of *some* objects.
    // 
    // We could make a list of all instances that should stop the bullet and check each of them individually, but that
    // could be slow.
    // 
    // So here is how we do this instead: We do several collision_line checks, but only on an object basis.
    // Those instances which are instances of those objects, but should not stop the bullets are set to an empty
    // collision mask, and that is reverted after we are done.

    var bulletStoppingObjects, originalMask, hitInstance;
    bulletStoppingObjects = ds_list_create();
    originalMask = ds_map_create();
    hitInstance = noone;

    ds_list_add(bulletStoppingObjects, Obstacle);
    ds_list_add(bulletStoppingObjects, Generator);
    ds_list_add(bulletStoppingObjects, Character);
    ds_list_add(bulletStoppingObjects, Sentry);
    if(!global.mapchanging)
        ds_list_add(bulletStoppingObjects, TeamGate);
    ds_list_add(bulletStoppingObjects, IntelGate);
    if(areSetupGatesClosed())
        ds_list_add(bulletStoppingObjects, ControlPointSetupGate);
    ds_list_add(bulletStoppingObjects, BulletWall);

    // Set the collision mask of all instances which should not collide to an empty one
    with(Generator) {
        if(team == other.owner.team) {
            ds_map_add(originalMask, id, mask_index);
            mask_index = emptyMaskS;
        }
    }

    with(Sentry) {
        if(team == other.owner.team) {
            ds_map_add(originalMask, id, mask_index);
            mask_index = emptyMaskS;
        }
    }

    with(owner) {
        ds_map_add(originalMask, id, mask_index);
        mask_index = emptyMaskS;
    }

    // Find the first instance the ray collides with
    var hit, i;
    while(len>1) {
        xm=(x1+x2)/2;
        ym=(y1+y2)/2;
        
        hit = noone;
        for(i = 0; (i < ds_list_size(bulletStoppingObjects)) and !hit; i += 1) {
            hit = collision_line(x1, y1, xm, ym, ds_list_find_value(bulletStoppingObjects, i), true, true);
        }
        
        if(hit) {
            x2=xm;
            y2=ym;
            hitInstance = hit;
        } else {
            x1=xm;
            y1=ym;
        }
        len/=2;
    }

    // Re-assign the original collision masks
    var key, origMask;
    for(key = ds_map_find_first(originalMask); key; key = ds_map_find_next(originalMask, key)) {
        origMask = ds_map_find_value(originalMask, key);
        with(key) {
            mask_index = origMask;
        }
    }

    ds_map_destroy(originalMask);
    ds_list_destroy(bulletStoppingObjects);

    // Apply dramatic effect
    with(hitInstance) {
        if(object_index == Character or object_is_ancestor(object_index, Character)) {
            if(!ubered and team != other.owner.team) {
                damageCharacter(other.ownerPlayer, id, other.hitDamage);
                if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player)
                {
                    secondToLastDamageDealer = lastDamageDealer;
                    alarm[4] = alarm[3]
                }
                alarm[3] = ASSIST_TIME / global.delta_factor;
                lastDamageDealer = other.ownerPlayer;
                dealFlicker(id);
                if(global.gibLevel > 0 && !object.radioactive)
                {
                    blood = instance_create(x, y, Blood);
                    blood.direction = other.owner.aimDirection - 180;
                }
                if (!other.owner.zoomed) {
                    lastDamageSource = DAMAGE_SOURCE_RIFLE;
                } else {
                    lastDamageSource = DAMAGE_SOURCE_RIFLE_CHARGED;
                }
            }
        } else if(object_index == Sentry or object_is_ancestor(object_index, Sentry)) {
            damageSentry(other.ownerPlayer, id, other.hitDamage);
            lastDamageDealer = other.ownerPlayer;
            if (!other.owner.zoomed)
                lastDamageSource = DAMAGE_SOURCE_RIFLE;
            else
                lastDamageSource = DAMAGE_SOURCE_RIFLE_CHARGED;
        } else if(object_index == Generator or object_is_ancestor(object_index, Generator)) {
            damageGenerator(other.ownerPlayer, id, other.hitDamage);
        }
    }

    gunUnsetSolids();
');
object_event_add(SydneySleeper,ev_draw,0,'
    event_inherited();
    if (tracerAlpha > 0.05)
    {
        shot = false;
        var origdepth;
        origdepth = depth;
        depth = -2;
        
        draw_set_alpha(tracerAlpha);
        if(owner.team == TEAM_RED)
            draw_line_width_color(shotx,shoty,x2,y2,2,c_red,c_red);
        else
            draw_line_width_color(shotx,shoty,x2,y2,2,c_blue,c_blue);
        if(global.particles != PARTICLES_OFF)
            tracerAlpha /= delta_mult(1.75);
        else tracerAlpha = 0;
            
        draw_set_alpha(1);
        depth = origdepth;
    }
    else
        tracerAlpha = 0;

    if (owner.zoomed && owner == global.myself.object)
    {
        if (hitDamage < maxDamage)
        {
            draw_set_alpha(0.25);
            draw_sprite_ext(ChargeS, 0, mouse_x + 15*-image_xscale, mouse_y - 10, -image_xscale, 1, 0, c_white, image_alpha);
            draw_set_alpha(0.8);
        }
        else
            draw_sprite_ext(FullChargeS, 0, mouse_x + 65*-image_xscale, mouse_y, 1, 1, 0, c_white, image_alpha);
            draw_sprite_part_ext(ChargeS, 1, 0, 0, ceil((hitDamage-baseDamage)*40/(maxDamage-baseDamage)), 20, mouse_x + 15*-image_xscale, mouse_y - 10, -image_xscale, 1, c_white, image_alpha);
    }
');
WEAPON_SMG = 25;
Smg = object_add();
object_set_parent(Smg, Weapon);
object_event_add(Smg,ev_create,0,'
    xoffset=5;
    yoffset=-1;
    refireTime=3;
    event_inherited();
    maxAmmo = 25;
    ammoCount = maxAmmo;
    reloadTime = 45;
    reloadBuffer = 16;
    idle=true;
    unscopedDamage=0;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SmgS.png", 2, 1, 0, 8, 5);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SmgFS.png", 4, 1, 0, 8, 5);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SmgFRS.png", 16, 1, 0, 12, 13);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Smg,ev_alarm,5,'
    ammoCount = maxAmmo;
');
object_event_add(Smg,ev_other,ev_user1,'
    {
        if(readyToShoot && !owner.cloak && ammoCount > 0) {
            ammoCount-=1;
            playsound(x,y,ChaingunSnd);
            var shot;
            randomize();
            
            shot = instance_create(x,y + yoffset + 1,Shot);
            shot.direction=owner.aimDirection+ random(7)-4;
            shot.speed=13;
            shot.owner=owner;
            shot.ownerPlayer=ownerPlayer;
            shot.team=owner.team;
            shot.hitDamage = 5;
            shot.weapon=WEAPON_SMG;
            with(shot)
                hspeed+=owner.hspeed;
            justShot=true;
            readyToShoot=false;
            alarm[0]=refireTime;
            alarm[5] = reloadBuffer + reloadTime;
        }
    }
');
WEAPON_JARATE = 26;
JarateHand = object_add();
object_set_parent(JarateHand, Weapon);
object_event_add(JarateHand,ev_create,0,'
    xoffset=-12;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    maxAmmo = 1
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = 18;
    idle=true;
    readyToStab=false;
    unscopedDamage=0;
	owner.ammo[105] = -1;
	isMelee = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\JarateHandS.png", 4, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\JarateHandS.png", 4, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\JarateHandS.png", 4, 1, 0, 0, 0);

    sprite_index = normalSprite;
    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(JarateHand,ev_destroy,0,'
    if owner != -1 owner.ammo[105] = alarm[5];
');
object_event_add(JarateHand,ev_alarm,5,'
    ammoCount = maxAmmo;
    owner.ammo[105] = -1;
');
object_event_add(JarateHand,ev_alarm,6,'
    if (reloadSprite != -1 && object_index != Rifle && alarm[5] > 0)
    {
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = 0;
    } 
    else
    {
        sprite_index = normalSprite;
        image_speed = 0;
    }
');
object_event_add(JarateHand,ev_step,ev_step_normal,'
    image_index = owner.team+2*real(ammoCount);

    if !variable_local_exists("ammoCheck") {
        ammoCheck = 1;
        alarm[5] = owner.ammo[105];
    }
');
object_event_add(JarateHand,ev_step,ev_step_end,'
    if(!instance_exists(AmmoCounter))
        instance_create(0,0,AmmoCounter);
');
object_event_add(JarateHand,ev_other,ev_user0,'
    alarm[0]=refireTime;
    if owner.ammo[105] == -1 alarm[5] = reloadBuffer + reloadTime;
    else alarm[5] = reloadBuffer + owner.ammo[105];
');
object_event_add(JarateHand,ev_other,ev_user1,'
    if(ammoCount >= 1 && readyToShoot) {
        ammoCount -= max(0, ammoCount-1); 
        shot = instance_create(x,y + yoffset + 1,JarOPiss);
        shot.direction=owner.aimDirection+ random(7)-4;
        shot.speed=13;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        with(shot)
            hspeed+=owner.hspeed;
        ammoCount = max(0, ammoCount-1);
		playsound(x,y,swingSnd);
		alarm[5] = reloadBuffer + reloadTime;
        owner.ammo[105] = -1;
		readyToShoot = false;
		alarm[0] = refireTime;
    }
');
object_event_add(JarateHand,ev_draw,0,'
    if (distance_to_point(view_xview + view_wview/2, view_yview + view_hview/2) > 800)
        exit;

    if (!owner.invisible and !owner.taunting and !owner.player.humiliated)
    {
        if (!owner.cloak)
            image_alpha = power(owner.cloakAlpha, 0.5);
        else
            image_alpha = power(owner.cloakAlpha, 2);
        draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        if (owner.ubered)
        {
            if (owner.team == TEAM_RED)
                ubercolour = c_red;
            else if (owner.team == TEAM_BLUE)
                ubercolour = c_blue;
            draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
        }
    }
');
WEAPON_KUKRI = 27;
Kukri = object_add();
object_set_parent(Kukri, Weapon);
object_event_add(Kukri,ev_create,0,'
    xoffset=6;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    unscopedDamage=0;
    isMelee = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\KukriS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\KukriFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\KukriS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Kukri,ev_destroy,0,'
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Kukri,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 35;
        shot.weapon=WEAPON_KUKRI;
        //Removed crit thing here
        alarm[2] = 10;
    }
');
object_event_add(Kukri,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Kukri,ev_alarm,5,'
    ammoCount = 1;
');
object_event_add(Kukri,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }
');
object_event_add(Kukri,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    }
');
WEAPON_SHIV = 28;
Shiv = object_add();
object_set_parent(Shiv, Weapon);
object_event_add(Shiv,ev_create,0,'
    xoffset=6;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    unscopedDamage=0;
    isMelee = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShivS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShivFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShivS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Shiv,ev_destroy,0,'
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Shiv,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 35;
        shot.weapon=WEAPON_KUKRI;
        //Removed crit thing here
        alarm[2] = 10;
    }
');
object_event_add(Shiv,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Shiv,ev_alarm,5,'
    ammoCount = 1;
');
object_event_add(Shiv,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }
');
object_event_add(Shiv,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    }
');
WEAPON_BOOTS = 29;
//Not a weapon so it has no object

global.weapons[WEAPON_RIFLE] = Rifle;
global.name[WEAPON_RIFLE] = "Sniper Rifle"
global.weapons[WEAPON_BAZAARBARGAIN] = BazaarBargain;
global.name[WEAPON_BAZAARBARGAIN] = "Bazaar Bargain (unfinished)";
global.weapons[WEAPON_HUNTSMAN] = HuntsMan;
global.name[WEAPON_HUNTSMAN] = "Huntsman";
global.weapons[WEAPON_MACHINA] = Machina;
global.name[WEAPON_MACHINA] = "Machina (unfinished)";
global.weapons[WEAPON_SYDNEYSLEEPER] = SydneySleeper;
global.name[WEAPON_SYDNEYSLEEPER] = "Sydney Sleeper (unfinished)";
global.weapons[WEAPON_SMG] = Smg;
global.name[WEAPON_SMG] = "SMG";
global.weapons[WEAPON_JARATE] = JarateHand;
global.name[WEAPON_JARATE] = "Jarate (unimplemented)";
global.weapons[WEAPON_KUKRI] = Kukri;
global.name[WEAPON_KUKRI] = "Kukri & Darwin's Danger Shield (unfinished)";
global.weapons[WEAPON_SHIV] = Shiv;
global.name[WEAPON_SHIV] = "Tribalman's Shiv & Razorback (unfinished)";
global.weapons[WEAPON_BOOTS] = Shiv;
global.name[WEAPON_BOOTS] = "Rocket Boots (unimplemented)";

// Demoman
globalvar WEAPON_MINEGUN, WEAPON_TIGERUPPERCUT, WEAPON_SCOTTISHRESISTANCE, WEAPON_STICKYJUMPER, WEAPON_STICKYSTICKER, WEAPON_GRENADELAUNCHER, WEAPON_DOUBLETROUBLE, WEAPON_EYELANDER, WEAPON_PAINTRAIN, WEAPON_GRENADE;
globalvar TigerUppercut, ScottishResitance, StickyJumper, Stickysticker, GrenadeLauncher, DoubleTrouble, Eyelander, Paintrain, GrenadeHand;
WEAPON_MINEGUN = 30;
WEAPON_TIGERUPPERCUT = 31;
TigerUppercut = object_add();
object_set_parent(TigerUppercut, Weapon);
object_event_add(TigerUppercut,ev_create,0,'
    xoffset = -3;
    yoffset = -2;
    refireTime = 24;
    event_inherited();
    maxMines = 5;
    lobbed = 0;
    reloadTime = 17;
    reloadBuffer = 26;
    maxAmmo = 5;
    ammoCount = maxAmmo;
    idle=true;
    readyToStab=false;
    alarm[3]=1;
    canActivate=true;
    activateTime=7;
    unscopedDamage = 0;
');
WEAPON_SCOTTISHRESISTANCE = 32;
ScottishResitance = object_add();
object_set_parent(ScottishResitance, Weapon);
object_event_add(ScottishResitance,ev_create,0,'
    xoffset = -3;
    yoffset = -2;
    refireTime = 26;
    event_inherited();
    maxMines = 14;
    lobbed = 0;
    reloadTime = 20;
    reloadBuffer = 26;
    maxAmmo = 8;
    ammoCount = maxAmmo;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_STICKYJUMPER = 33;
StickyJumper = object_add();
object_set_parent(StickyJumper, Weapon);
object_event_add(StickyJumper,ev_create,0,'
    xoffset = -3;
    yoffset = -2;
    refireTime = 26;
    event_inherited();
    maxMines = 8;
    lobbed = 0;
    reloadTime = 20;
    reloadBuffer = 26;
    maxAmmo = 12;
    ammoCount = maxAmmo;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_STICKYSTICKER = 34;
Stickysticker = object_add();
object_set_parent(Stickysticker, Weapon);
object_event_add(Stickysticker,ev_create,0,'
    xoffset = -3;
    yoffset = -2;
    refireTime = 26;
    event_inherited();
    maxMines = 8;
    lobbed = 0;
    reloadTime = 20;
    reloadBuffer = 26;
    maxAmmo = 8;
    ammoCount = maxAmmo;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_GRENADELAUNCHER = 35;
GrenadeLauncher = object_add();
object_set_parent(GrenadeLauncher, Weapon);
object_event_add(GrenadeLauncher,ev_create,0,'
    xoffset = -8;
    yoffset = -2;
    refireTime = 28;
    event_inherited();
    maxMines = 4;
    lobbed = 0;
    reloadTime = 22;
    reloadBuffer = 26;
    maxAmmo = 4;
    ammoCount = maxAmmo;
    idle=true;
    unscopedDamage = 0;
	
	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GrenadeLauncherS.png", 1, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GrenadeLauncherFS.png", 1, 1, 0, 10, 6);
    //reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GrenadeLauncherFRS.png", 24, 1, 0, 16, 14);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GrenadeLauncherS.png", 24, 1, 0, 16, 14);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
WEAPON_DOUBLETROUBLE = 36;
DoubleTrouble = object_add();
object_set_parent(DoubleTrouble, Weapon);
object_event_add(DoubleTrouble,ev_create,0,'
    xoffset = -8;
    yoffset = -2;
    refireTime = 26;
    event_inherited();
    maxMines = 8;
    lobbed = 0;
    reloadTime = 20;
    reloadBuffer = 26;
    maxAmmo = 2;
    ammoCount = maxAmmo;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_EYELANDER = 37;
Eyelander = object_add();
object_set_parent(Eyelander, Weapon);
object_event_add(Eyelander,ev_create,0,'
    xoffset=-15;
    yoffset=-40;
    refireTime=18;
	event_inherited();
	maxMines = 8;
    lobbed = 0;
	unscopedDamage = 0;
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;
    abilityVisual = "WEAPON BLUR";
    
    stabdirection=0;
    maxAmmo = 100;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = 26;
    idle=true;
    smashing=false;
	isMelee = true;
	
	hasMeter = true;
	meterName = "CHARGE";
	meterCount = 100;
	maxMeter = 100;
	

	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\EyelanderS.png", 2, 1, 0, 2, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\EyelanderFS.png", 8, 1, 0, 2, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\EyelanderS.png", 2, 1, 0, 2, 0);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Eyelander,ev_destroy,0,'
	with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
	charging = 0;
	owner.jumpStrength = 8+(0.6/2);
');
object_event_add(Eyelander,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction= owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        if (abilityActive) {
			if (meterCount <= 50 || owner.moveStatus == 4 && meterCount <= 60) { // give grace since youre flying
				shot.hitDamage = 50; 
				playsound(x,y,CritSnd);
				shot.crit=1;
			} else if (meterCount <= 70 || owner.moveStatus == 4 && meterCount <= 80) {
				shot.hitDamage = 40; 
				playsound(x,y,CritSnd);
				shot.crit=2;
			}
			abilityActive = false;
			meterCount = 0;
		} else {
			shot.hitDamage = 35;
		}
        shot.weapon=WEAPON_EYELANDER;
        //Removed crit thing here
        alarm[2] = 10;
    }
');
object_event_add(Eyelander,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Eyelander,ev_alarm,5,'
    //ammoCount = 100;
    meterCount = 100;
');
object_event_add(Eyelander,ev_alarm,10,'
    charging = 0;
');
object_event_add(Eyelander,ev_step,ev_step_normal,'
	if (abilityActive) {
        owner.jumpStrength = 0;
        if (owner.moveStatus != 4) meterCount -= 2; else if (owner.moveStatus == 4) meterCount -= 0.8; // lol, I am crazy for this one
        if meterCount <= 0 {
			owner.jumpStrength = 8+(0.6/2);
            abilityActive = false;
        }
		if (owner.moveStatus != 4) {
			if (owner.image_xscale == -1) {
				owner.hspeed -= 3;
			} else if (owner.image_xscale == 1) {
				owner.hspeed += 3;
			}
		} else {
			if (owner.image_xscale == -1) {
				owner.hspeed -= 1.8;
			} else if (owner.image_xscale == 1) {
				owner.hspeed += 1.8;
			}
		}
    } else {
        owner.jumpStrength = 8+(0.6/2);
        if meterCount < 0 meterCount = 0;
        else if meterCount < maxMeter meterCount +=1;
    }
	
    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }
');

object_event_add(Eyelander,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        smashing = 1;
        justShot=true;
        readyToStab = false;
		owner.jumpStrength = 8+(0.6/2);
		alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
	}
');
object_event_add(Eyelander,ev_other,ev_user2,'
    if (!abilityActive && !owner.cloak && meterCount >= maxMeter) {
        abilityActive = true;
		owner.accel = 0;
		owner.moveStatus = 0;
		owner.vspeed -= 0.15; // jerry-rigging consistency in charging by makin u slightly jumped
        playsound(x,y,choose(ChargeSnd1, ChargeSnd2,ChargeSnd3));
		if (smashing != 1) readyToStab = true;
		//alarm[10] = 100;
    }
');

WEAPON_PAINTRAIN = 38;
Paintrain = object_add();
object_set_parent(Paintrain, Weapon);
object_event_add(Paintrain,ev_create,0,'
	{
		xoffset=-9;
		yoffset=-40;
		refireTime=24;
		event_inherited();	
		maxMines = 14;
		lobbed = 0;
		unscopedDamage = 0;
		StabreloadTime = 5;
		//readyToStab = false;
		alarm[2] = 15;
		smashing = false;
		
		stabdirection=0;
		maxAmmo = 1;
		ammoCount = maxAmmo;
		reloadTime = 300;
		reloadBuffer = 24;
		idle=true;
		isMelee = true;
		
		normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PainTrainS.png", 2, 1, 0, 0, 0);
		recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PainTrainFS.png", 2, 1, 0, 0, 0);
		reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PainTrainS.png", 2, 1, 0, 0, 0);

		sprite_index = normalSprite;

		recoilTime = refireTime;
		recoilAnimLength = sprite_get_number(recoilSprite)/2;
		recoilImageSpeed = recoilAnimLength/recoilTime;

		reloadAnimLength = sprite_get_number(reloadSprite)/2;
		reloadImageSpeed = reloadAnimLength/reloadTime;
		
		//owner.runPower = 5;
		owner.capStrength = 2;
	}
');
object_event_add(Paintrain,ev_destroy,0,'
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
	owner.capStrength = 1;
');
object_event_add(Paintrain,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 14;
        shot.weapon=WEAPON_PAINTRAIN;
        //Removed crit thing here
        alarm[2] = 10;
    }
');
object_event_add(Paintrain,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Paintrain,ev_alarm,5,'
    ammoCount = 1;
');
object_event_add(Paintrain,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }
');
object_event_add(Paintrain,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    }
');
WEAPON_GRENADE = 39;
GrenadeHand = object_add();
object_set_parent(GrenadeHand, Weapon);
object_event_add(GrenadeHand,ev_create,0,'
    xoffset=-33;
    yoffset=-40;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    image_speed=0;
    
    readyToShoot=false;
    stabdirection=0;
    maxAmmo = 2;
    ammoCount = maxAmmo;
    reloadTime = 44;
    reloadBuffer = 26;
    idle=true;
    time = 0;
    charge = 0;
    unscopedDamage = 0;
	lobbed=0;
');

global.weapons[WEAPON_MINEGUN] = Minegun;
global.name[WEAPON_MINEGUN] = "Minegun";
global.weapons[WEAPON_TIGERUPPERCUT] = TigerUppercut;
global.name[WEAPON_TIGERUPPERCUT] = "Tiger Uppercut (unimplemented)";
global.weapons[WEAPON_SCOTTISHRESISTANCE] = ScottishResitance;
global.name[WEAPON_SCOTTISHRESISTANCE] = "Scottish Resistance (unimplemented)";
global.weapons[WEAPON_STICKYJUMPER] = StickyJumper;
global.name[WEAPON_STICKYJUMPER] = "Sticky Jumper (unimplemented)";
global.weapons[WEAPON_STICKYSTICKER] = Stickysticker;
global.name[WEAPON_STICKYSTICKER] = "Stucky Charm (unimplemented)";
global.weapons[WEAPON_GRENADELAUNCHER] = GrenadeLauncher;
global.name[WEAPON_GRENADELAUNCHER] = "Grenade Launcher (unimplemented)";
global.weapons[WEAPON_DOUBLETROUBLE] = DoubleTrouble;
global.name[WEAPON_DOUBLETROUBLE] = "Double Trouble (unimplemented)";
global.weapons[WEAPON_EYELANDER] = Eyelander;
global.name[WEAPON_EYELANDER] = "Eyelander";
global.weapons[WEAPON_PAINTRAIN] = Paintrain;
global.name[WEAPON_PAINTRAIN] = "Paintrain";
global.weapons[WEAPON_GRENADE] = GrenadeHand;
global.name[WEAPON_GRENADE] = "Hand Grenade (unimplemented)";

// Medic
globalvar WEAPON_NEEDLEGUN, WEAPON_BLUTSAUGER, WEAPON_TERMINALBREATH, WEAPON_CROSSBOW, WEAPON_OVERDOSE, WEAPON_MEDIGUN, WEAPON_KRITSKRIEG, WEAPON_QUICKFIX, WEAPON_OVERHEALER, WEAPON_POTION;
globalvar Needlegun, Blutsauger, TerminalBreath, Crossbow, Ubersaw, Kritzieg, QuickFix, Overhealer, Brewinggun;
WEAPON_NEEDLEGUN = 40;
Needlegun = object_add();
object_set_parent(Needlegun, Weapon);
object_event_add(Needlegun,ev_create,0,'
    xoffset = -7;
    yoffset = -3;
    refireTime = 3;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmmount = 2/3;
    hphealed = 0;
    maxHealDistance = 300;
    maxMouseSelectDistance = 150;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 40
    ammoCount = maxAmmo;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;

    // Threshhold system numbers
    healTierHealth = 125; // HP above which healing is slowed
    healTierAmount = 0.75; // Factor to which healing is slowed (stacks with healing ramp)


    normalSprite = MedigunGoldS;
    recoilSprite = MedigunGoldFS;
    reloadSprite = MedigunGoldFRS;

    normalSprite = MedigunS;
    recoilSprite = MedigunFS;
    reloadSprite = MedigunFRS;

    sprite_index = normalSprite;
        
    //This makes it so that the timer will keep resetting
    //Until Mouse1 is let go
    recoilTime = refireTime+1;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
WEAPON_BLUTSAUGER = 41;
Blutsauger = object_add();
object_set_parent(Blutsauger, Weapon);
object_event_add(Blutsauger,ev_create,0,'
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
    unscopedDamage = 0;
');
WEAPON_TERMINALBREATH = 42;
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
    unscopedDamage = 0;
');
WEAPON_CROSSBOW = 43;
Crossbow = object_add();
object_set_parent(Crossbow, Weapon);
object_event_add(Crossbow,ev_create,0,'
    xoffset = -7;
    yoffset = -3;
    refireTime = 35;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmmount = 1;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 35;
    reloadBuffer = 0;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_OVERDOSE = 44;
Ubersaw = object_add();
object_set_parent(Ubersaw, Weapon);
object_event_add(Ubersaw,ev_create,0,'
    xoffset=-17;
    yoffset=-34;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    
    canBuff = false;
    alarm[3] = 90;
    unscopedDamage = 0;
	// TEMP
	healTarget = noone;
	if !variable_local_exists("uberCharge")
		uberCharge = 0;
	
	isMelee = true;
	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\UbersawS.png", 2, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\UbersawFS.png", 8, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\UbersawS.png", 2, 1, 0, 0, 0);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Ubersaw,ev_destroy,0,'
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Ubersaw,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 35;
        shot.weapon=WEAPON_WRENCH;
        //Removed crit thing here
        alarm[2] = 10;
    }
');
object_event_add(Ubersaw,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Ubersaw,ev_alarm,5,'
    ammoCount = 1;
');
object_event_add(Ubersaw,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }
');
object_event_add(Ubersaw,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    }
');
WEAPON_MEDIGUN = 45;
WEAPON_KRITSKRIEG = 46;
Kritzieg = object_add();
object_set_parent(Kritzieg, Weapon);
object_event_add(Kritzieg,ev_create,0,'
    xoffset = -7;
    yoffset = 0;
    refireTime = 3;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmount = 0.5;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 0;
    ammoCount = 0;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;
    loopsoundstop(UberIdleSnd);
    unscopedDamage = 0;
');
WEAPON_QUICKFIX = 47;
QuickFix = object_add();
object_set_parent(QuickFix, Weapon);
object_event_add(QuickFix,ev_create,0,'
    xoffset = -7;
    yoffset = 0;
    refireTime = 3;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmount = 0.5;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 2000;
    ammoCount = 0;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_OVERHEALER = 48;
Overhealer = object_add();
object_set_parent(Overhealer, Weapon);
object_event_add(Overhealer,ev_create,0,'
    xoffset = -7;
    yoffset = 0;
    refireTime = 3;
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmount = 0.5;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    maxAmmo = 0;
    ammoCount = 0;
    reloadTime = 55;
    reloadBuffer = 0;
    idle=true;
    loopsoundstop(UberIdleSnd);
    unscopedDamage = 0;
');
WEAPON_POTION = 49;
Brewinggun = object_add();
object_set_parent(Brewinggun, Weapon);
object_event_add(Brewinggun,ev_create,0,'
    xoffset = -7;
    yoffset = 0;
    refireTime = 30; //Was 22, 28.6-35.6 would be spread with unlimited ammo
    event_inherited();
    healTarget = noone;
    healedThisStep = false;
    healAmount = 0.5;
    hphealed = 0;
    maxHealDistance = 300;
    ubering = false;
    uberCharge=0;
    uberReady=false;
    //maxAmmo = 0;
    //ammoCount = 0; workaround spotted, keeps crashin tho, so lemme jus
	maxAmmo = 1;
    ammoCount = maxAmmo;
    ammo = 3;   //workaround
    //reloadTime = 0;
    reloadTime = 1;
    reloadBuffer = 20;
    idle=true;
    loopsoundstop(UberIdleSnd);
    unscopedDamage = 0;
');

global.weapons[WEAPON_NEEDLEGUN] = Needlegun;
global.name[WEAPON_NEEDLEGUN] = "Needlegun (unimplemented)";
global.weapons[WEAPON_BLUTSAUGER] = Blutsauger;
global.name[WEAPON_BLUTSAUGER] = "Blutsauger (unimplemented)";
global.weapons[WEAPON_TERMINALBREATH] = TerminalBreath;
global.name[WEAPON_TERMINALBREATH] = "Terminal Breath (unimplemented)";
global.weapons[WEAPON_CROSSBOW] = Crossbow;
global.name[WEAPON_CROSSBOW] = "Crusader's Crossbow (unimplemented)";
global.weapons[WEAPON_OVERDOSE] = Ubersaw;
global.name[WEAPON_OVERDOSE] = "Ubersaw (unfinished)";
global.weapons[WEAPON_MEDIGUN] = Medigun;
global.name[WEAPON_MEDIGUN] = "Medigun"
global.weapons[WEAPON_KRITSKRIEG] = Kritzieg;
global.name[WEAPON_KRITSKRIEG] = "Kritzkrieg (unimplemented)"
global.weapons[WEAPON_QUICKFIX] = QuickFix;
global.name[WEAPON_QUICKFIX] = "Quickfix (unimplemented)";
global.weapons[WEAPON_OVERHEALER] = Overhealer;
global.name[WEAPON_OVERHEALER] = "Overhealer (unimplemented)";
global.weapons[WEAPON_POTION] = Brewinggun;
global.name[WEAPON_POTION] = "Holy Water (unimplemented)";

// Engineer
globalvar WEAPON_SHOTGUN, WEAPON_FRONTIERJUSTICE, WEAPON_SHERIFF, WEAPON_POMSON, WEAPON_WIDOWMAKER, WEAPON_NAILGUN, WEAPON_STUNGUN, WEAPON_WRENCH, WEAPON_WRANGLER, WEAPON_EUREKAEFFECT;
globalvar FrontierJustice, Sheriff, Pumson, Widowmaker, Nailgun, Stungun, Wrench, Wrangler, Eeffect;
WEAPON_SHOTGUN = 50;
WEAPON_FRONTIERJUSTICE = 51;
FrontierJustice = object_add();
object_set_parent(FrontierJustice, Weapon);
object_event_add(FrontierJustice,ev_create,0,'
    xoffset=-5;
    yoffset=-2;
    refireTime=20;
    event_inherited();
    maxAmmo = 3;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_SHERIFF = 52;
Sheriff = object_add();
object_set_parent(Sheriff, Weapon);
object_event_add(Sheriff,ev_create,0,'
    xoffset=-5;
    yoffset=-2;
    refireTime=20;
    event_inherited();
    maxAmmo = 3;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_POMSON = 53;
Pumson = object_add();
object_set_parent(Pumson, Weapon);
object_event_add(Pumson,ev_create,0,'
    xoffset=-8;
    yoffset=-2;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_WIDOWMAKER = 54;
Widowmaker = object_add();
object_set_parent(Widowmaker, Weapon);
object_event_add(Widowmaker,ev_create,0,'
    xoffset=-5;
    yoffset=-2;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_NAILGUN = 55;
Nailgun = object_add();
object_set_parent(Nailgun, Weapon);
object_event_add(Nailgun,ev_create,0,'
    xoffset=-3;
    yoffset=-6;
    refireTime=6;
    event_inherited();
    maxAmmo = 0;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 20;
    idle=true;
    unscopedDamage = 0;
');
WEAPON_STUNGUN = 56;
Stungun = object_add();
object_set_parent(Stungun, Weapon);
object_event_add(Stungun,ev_create,0,'
    xoffset=-3;
    yoffset=-6;
    refireTime=6;
    event_inherited();
    maxAmmo = 100;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 20;
    idle=true;
    hasShot=true;
    unscopedDamage = 0;
');
WEAPON_WRENCH = 57;
Wrench = object_add();
object_set_parent(Wrench, Weapon);
object_event_add(Wrench,ev_create,0,'
    xoffset=-30;
    yoffset=-39;
    refireTime=18;
    event_inherited();
    StabreloadTime = 7;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;
	isMelee = true;
	
    stabdirection=0;
    maxAmmo = 100;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    cooldown = 0;
    unscopedDamage = 0;
	
	isMelee = true;
	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\WrenchS.png", 2, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\WrenchFS.png", 8, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\WrenchS.png", 2, 1, 0, 0, 0);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Wrench,ev_destroy,0,'
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Wrench,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 35;
        shot.weapon=WEAPON_WRENCH;
        //Removed crit thing here
        alarm[2] = 10;
    }
');
object_event_add(Wrench,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Wrench,ev_alarm,5,'
    ammoCount = 1;
');
object_event_add(Wrench,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }
');
object_event_add(Wrench,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    }
');

WEAPON_WRANGLER = 58;
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
    unscopedDamage = 0;
');
WEAPON_EUREKAEFFECT = 59;
Eeffect = object_add();
object_set_parent(Eeffect, Weapon);
object_event_add(Eeffect,ev_create,0,'
    xoffset=-30;
    yoffset=-39;
    refireTime=18;
    event_inherited();
    StabreloadTime = 7;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 100;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    cooldown = 0;
    unscopedDamage = 0;
');

global.weapons[WEAPON_SHOTGUN] = Shotgun;
global.name[WEAPON_SHOTGUN] = "Shotgun"
global.weapons[WEAPON_FRONTIERJUSTICE] = FrontierJustice;
global.name[WEAPON_FRONTIERJUSTICE] = "Frontier Justice (unimplemented)";
global.weapons[WEAPON_SHERIFF] = Sheriff;
global.name[WEAPON_SHERIFF] = "The Sheriff (unimplemented)";
global.weapons[WEAPON_POMSON] = Pumson;
global.name[WEAPON_POMSON] = "Pomson 6000 (unimplemented)";
global.weapons[WEAPON_WIDOWMAKER] = Widowmaker;
global.name[WEAPON_WIDOWMAKER] = "Widowmaker (unimplemented)";
global.weapons[WEAPON_NAILGUN] = Nailgun;
global.name[WEAPON_NAILGUN] = "Nailgun (unimplemented)";
global.weapons[WEAPON_STUNGUN] = Stungun;
global.name[WEAPON_STUNGUN] = "Stungun (unimplemented)";
global.weapons[WEAPON_WRENCH] = Wrench;
global.name[WEAPON_WRENCH] = "Wrench (unfinished)";
global.weapons[WEAPON_WRANGLER] = Wrangler;
global.name[WEAPON_WRANGLER] = "Wrangler (unimplemented)";
global.weapons[WEAPON_EUREKAEFFECT] = Eeffect;
global.name[WEAPON_EUREKAEFFECT] = "Eureka Effect (unimplemented)";

// Heavy
globalvar WEAPON_MINIGUN, WEAPON_TOMISLAV, WEAPON_NATACHA, WEAPON_BRASSBEAST, WEAPON_IRON, WEAPON_HEAVYSHOTGUN, WEAPON_SANDVICH, WEAPON_FAMILYBUSINESS, WEAPON_CHOCOLATE, WEAPON_KGOB;
globalvar Tomislav, Natacha, BrassBeast, IronMaiden, HeavyShotgun, SandvichHand, FamilyBusiness, ChocolateHand, KGOB;
WEAPON_MINIGUN = 60;
WEAPON_TOMISLAV = 61;
Tomislav = object_add();
object_set_parent(Tomislav, Weapon);
object_event_add(Tomislav,ev_create,0,'
    xoffset = 3;
    yoffset = 3;
    refireTime = 3;
    event_inherited();
    sndlooping = false;
    maxAmmo = 200;
    ammoCount = maxAmmo;
    reloadBuffer = 15;
    isRefilling = false;
    depth = -1;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\TomislavS.png", 2, 1, 0, 14, 3);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\TomislavFS.png", 4, 1, 0, 14, 3);
    reloadSprite = -1;

    sprite_index = normalSprite;

    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    //Overlays for the overheat
    overlaySprite = MinigunOverlayS;
    overlayFiringSprite = MinigunOverlayFS;
');
object_event_add(Tomislav,ev_alarm,5,'
    isRefilling = true;
');
object_event_add(Tomislav,ev_alarm,6,'
    //Reset the sprite
    sprite_index = normalSprite
    image_speed = 0
');
object_event_add(Tomislav,ev_step,ev_step_begin,'
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo and isRefilling)
        ammoCount += 1 * global.delta_factor;
    if(!readyToShoot and alarm[5] < (25 / global.delta_factor) and !isRefilling)
        alarm[5] += 1;
');
object_event_add(Tomislav,ev_other,ev_user1,'
    {
        // prevent sputtering
        if (ammoCount < 2)
            ammoCount -= 2;
        if(readyToShoot and ammoCount >= 2)
        {
            playsound(x,y,ChaingunSnd);
            var shot, shotx, shoty;
            randomize();
            
            shotx = x+lengthdir_x(20,owner.aimDirection);
            shoty = y+12+lengthdir_y(20,owner.aimDirection);
            if(!collision_line_bulletblocking(x, y, shotx, shoty))
            {
                shot = createShot(shotx, shoty, Shot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(7)-3.5), 12+random(1));
                if(golden)
                    shot.sprite_index = ShotGoldS;
                shot.hspeed += owner.hspeed;
                shot.alarm[0] = 30 / global.delta_factor;
            }
            else
            {
                var imp;
                imp = instance_create(shotx, shoty, Impact);
                imp.image_angle = owner.aimDirection;
            }
            
            justShot=true;
            readyToShoot=false;
            isRefilling = false;
            ammoCount -= 3;
            
            var reloadBufferFactor;
            if(ammoCount < 3)
                reloadBufferFactor = 2.5;
            else
                //reloadBufferFactor = 1+(cos((ammoCount+2.2)/maxAmmo*pi)+1)/2; // spline from (full ammo = 1*) to (empty ammo = 2*)
                reloadBufferFactor = 1;
            
            alarm[0] = refireTime / global.delta_factor;
            alarm[5] = reloadBuffer*reloadBufferFactor / global.delta_factor;
            
            if (global.particles == PARTICLES_NORMAL)
            {
                var shell;
                shell = instance_create(x, y+4, Shell);
                shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
            }
        }
    }
');
object_event_add(Tomislav,ev_draw,0,'
    if(owner.taunting or owner.omnomnomnom or owner.player.humiliated)
        exit;
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset);
    if (alarm[6] <= 0){
        //set the sprite to idle
        imageOffset = owner.team;
    }else{
        //We are shooting, loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,c_white,image_alpha);
        /*if (sprite_index == normalSprite) {
             draw_sprite_ext(overlaySprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }else if (sprite_index == recoilSprite) {
            draw_sprite_ext(overlayFiringSprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }*/
        
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }
');
WEAPON_NATACHA = 62;
Natacha = object_add();
object_set_parent(Natacha, Weapon);
object_event_add(Natacha,ev_create,0,'
    xoffset = 3;
    yoffset = 3;
    refireTime = 2;
    event_inherited();
    sndlooping = false;
    maxAmmo = 200;
    ammoCount = maxAmmo;
    reloadBuffer = 15;
    isRefilling = false;
    depth = -1;
    
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NatachaS.png", 2, 1, 0, 14, 3);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NatachaFS.png", 4, 1, 0, 14, 3);
    reloadSprite = -1;

    sprite_index = normalSprite;

    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    //Overlays for the overheat
    overlaySprite = MinigunOverlayS;
    overlayFiringSprite = MinigunOverlayFS;
');
object_event_add(Natacha,ev_alarm,5,'
    isRefilling = true;
');
object_event_add(Natacha,ev_alarm,6,'
    //Reset the sprite
    sprite_index = normalSprite
    image_speed = 0
');
object_event_add(Natacha,ev_step,ev_step_begin,'
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo and isRefilling)
        ammoCount += 1 * global.delta_factor;
    if(!readyToShoot and alarm[5] < (25 / global.delta_factor) and !isRefilling)
        alarm[5] += 1;
');
object_event_add(Natacha,ev_other,ev_user1,'
    {
        // prevent sputtering
        if (ammoCount < 2)
            ammoCount -= 2;
        if(readyToShoot and ammoCount >= 2)
        {
            playsound(x,y,ChaingunSnd);
            var shot, shotx, shoty;
            randomize();
            
            shotx = x+lengthdir_x(20,owner.aimDirection);
            shoty = y+12+lengthdir_y(20,owner.aimDirection);
            if(!collision_line_bulletblocking(x, y, shotx, shoty))
            {
                shot = createShot(shotx, shoty, NatachaShot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(14)-7), 12+random(1));
                if(golden)
                    shot.sprite_index = ShotGoldS;
                shot.hspeed += owner.hspeed;
                shot.alarm[0] = 30 / global.delta_factor;
            }
            else
            {
                var imp;
                imp = instance_create(shotx, shoty, Impact);
                imp.image_angle = owner.aimDirection;
            }
            
            justShot=true;
            readyToShoot=false;
            isRefilling = false;
            ammoCount -= 3;
            
            var reloadBufferFactor;
            if(ammoCount < 3)
                reloadBufferFactor = 2.5;
            else
                //reloadBufferFactor = 1+(cos((ammoCount+2.2)/maxAmmo*pi)+1)/2; // spline from (full ammo = 1*) to (empty ammo = 2*)
                reloadBufferFactor = 1;
            
            alarm[0] = refireTime / global.delta_factor;
            alarm[5] = reloadBuffer*reloadBufferFactor / global.delta_factor;
            
            if (global.particles == PARTICLES_NORMAL)
            {
                var shell;
                shell = instance_create(x, y+4, Shell);
                shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
            }
        }
    }
');
object_event_add(Natacha,ev_draw,0,'
    if(owner.taunting or owner.omnomnomnom or owner.player.humiliated)
        exit;
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset);
    if (alarm[6] <= 0){
        //set the sprite to idle
        imageOffset = owner.team;
    }else{
        //We are shooting, loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,c_white,image_alpha);
        /*if (sprite_index == normalSprite) {
             draw_sprite_ext(overlaySprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }else if (sprite_index == recoilSprite) {
            draw_sprite_ext(overlayFiringSprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }*/
        
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }
');
WEAPON_BRASSBEAST = 63;
BrassBeast = object_add();
object_set_parent(BrassBeast, Weapon);
object_event_add(BrassBeast,ev_create,0,'
    xoffset = 3;
    yoffset = 3;
    refireTime = 2;
    event_inherited();
    sndlooping = false;
    maxAmmo = 200;
    ammoCount = maxAmmo;
    reloadBuffer = 15;
    isRefilling = false;
    depth = -1;
    
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BrassBeastS.png", 2, 1, 0, 14, 3);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BrassBeastFS.png", 4, 1, 0, 14, 3);
    reloadSprite = -1;

    sprite_index = normalSprite;

    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    //Overlays for the overheat
    overlaySprite = MinigunOverlayS;
    overlayFiringSprite = MinigunOverlayFS;
');
object_event_add(BrassBeast,ev_alarm,5,'
    isRefilling = true;
');
object_event_add(BrassBeast,ev_alarm,6,'
    //Reset the sprite
    sprite_index = normalSprite
    image_speed = 0
');
object_event_add(BrassBeast,ev_step,ev_step_begin,'
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo and isRefilling)
        ammoCount += 1 * global.delta_factor;
    if(!readyToShoot and alarm[5] < (25 / global.delta_factor) and !isRefilling)
        alarm[5] += 1;
');
object_event_add(BrassBeast,ev_other,ev_user1,'
    {
        // prevent sputtering
        if (ammoCount < 2)
            ammoCount -= 2;
        if(readyToShoot and ammoCount >= 2)
        {
            playsound(x,y,ChaingunSnd);
            var shot, shotx, shoty;
            randomize();
            
            shotx = x+lengthdir_x(20,owner.aimDirection);
            shoty = y+12+lengthdir_y(20,owner.aimDirection);
            if(!collision_line_bulletblocking(x, y, shotx, shoty))
            {
                shot = createShot(shotx, shoty, Shot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(14)-7), 12+random(1));
                shot.hitDamage = 10;
                if(golden)
                    shot.sprite_index = ShotGoldS;
                shot.hspeed += owner.hspeed;
                shot.alarm[0] = 30 / global.delta_factor;
            }
            else
            {
                var imp;
                imp = instance_create(shotx, shoty, Impact);
                imp.image_angle = owner.aimDirection;
            }
            
            justShot=true;
            readyToShoot=false;
            isRefilling = false;
            ammoCount -= 3;
            
            var reloadBufferFactor;
            if(ammoCount < 3)
                reloadBufferFactor = 2.5;
            else
                //reloadBufferFactor = 1+(cos((ammoCount+2.2)/maxAmmo*pi)+1)/2; // spline from (full ammo = 1*) to (empty ammo = 2*)
                reloadBufferFactor = 1;
            
            alarm[0] = refireTime / global.delta_factor;
            alarm[5] = reloadBuffer*reloadBufferFactor / global.delta_factor;
            
            if (global.particles == PARTICLES_NORMAL)
            {
                var shell;
                shell = instance_create(x, y+4, Shell);
                shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
            }
        }
    }
');
object_event_add(BrassBeast,ev_draw,0,'
    if(owner.taunting or owner.omnomnomnom or owner.player.humiliated)
        exit;
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset);
    if (alarm[6] <= 0){
        //set the sprite to idle
        imageOffset = owner.team;
    }else{
        //We are shooting, loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,c_white,image_alpha);
        /*if (sprite_index == normalSprite) {
             draw_sprite_ext(overlaySprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }else if (sprite_index == recoilSprite) {
            draw_sprite_ext(overlayFiringSprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }*/
        
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }
');
WEAPON_IRON = 64;
IronMaiden = object_add();
object_set_parent(IronMaiden, Weapon);
object_event_add(IronMaiden,ev_create,0,'
    xoffset = 3;
    yoffset = 3;
    refireTime = 2;
    event_inherited();
    sndlooping = false;
    maxAmmo = 100;
    ammoCount = maxAmmo;
	extraAmmo = 0;
    reloadBuffer = 15;
    isRefilling = false;
    depth = -1;
    
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\IronMaidenS.png", 2, 1, 0, 14, 3);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\IronMaidenFS.png", 4, 1, 0, 14, 3);
    reloadSprite = -1;

    sprite_index = normalSprite;

    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    //Overlays for the overheat
    overlaySprite = MinigunOverlayS;
    overlayFiringSprite = MinigunOverlayFS;
');
object_event_add(IronMaiden,ev_alarm,5,'
    isRefilling = true;
');
object_event_add(IronMaiden,ev_alarm,6,'
    //Reset the sprite
    sprite_index = normalSprite
    image_speed = 0
');
object_event_add(IronMaiden,ev_step,ev_step_begin,'
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo+extraAmmo and isRefilling)
        ammoCount += 1 * global.delta_factor;
    if(!readyToShoot and alarm[5] < (25 / global.delta_factor) and !isRefilling)
        alarm[5] += 1;
');
object_event_add(IronMaiden,ev_other,ev_user1,'
    {
        // prevent sputtering
        if (ammoCount < 2)
            ammoCount -= 2;
        if(readyToShoot and ammoCount >= 2)
        {
            playsound(x,y,ChaingunSnd);
            var shot, shotx, shoty;
            randomize();
            
            shotx = x+lengthdir_x(20,owner.aimDirection);
            shoty = y+12+lengthdir_y(20,owner.aimDirection);
            if(!collision_line_bulletblocking(x, y, shotx, shoty))
            {
                shot = createShot(shotx, shoty, Shot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(14)-7), 12+random(1));
                if(golden)
                    shot.sprite_index = ShotGoldS;
                shot.hspeed += owner.hspeed;
                shot.alarm[0] = 30 / global.delta_factor;
            }
            else
            {
                var imp;
                imp = instance_create(shotx, shoty, Impact);
                imp.image_angle = owner.aimDirection;
            }
            
            justShot=true;
            readyToShoot=false;
            isRefilling = false;
            ammoCount -= 3;
            
            var reloadBufferFactor;
            if(ammoCount < 3)
                reloadBufferFactor = 2.5;
            else
                //reloadBufferFactor = 1+(cos((ammoCount+2.2)/maxAmmo*pi)+1)/2; // spline from (full ammo = 1*) to (empty ammo = 2*)
                reloadBufferFactor = 1;
            
            alarm[0] = refireTime / global.delta_factor;
            alarm[5] = reloadBuffer*reloadBufferFactor / global.delta_factor;
            
            if (global.particles == PARTICLES_NORMAL)
            {
                var shell;
                shell = instance_create(x, y+4, Shell);
                shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
            }
        }
    }
');
object_event_add(IronMaiden,ev_draw,0,'
    if(owner.taunting or owner.omnomnomnom or owner.player.humiliated)
        exit;
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset);
    if (alarm[6] <= 0){
        //set the sprite to idle
        imageOffset = owner.team;
    }else{
        //We are shooting, loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,c_white,image_alpha);
        /*if (sprite_index == normalSprite) {
             draw_sprite_ext(overlaySprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }else if (sprite_index == recoilSprite) {
            draw_sprite_ext(overlayFiringSprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }*/
        
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }
');
WEAPON_HEAVYSHOTGUN = 65;
HeavyShotgun = object_add();
object_set_parent(HeavyShotgun, Weapon);
object_event_add(HeavyShotgun,ev_create,0,'
    xoffset=3;
    yoffset=-3;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    shots = 5;
    weaponGrade = UNIQUE;
    weaponType = SHOTGUN;
    shotDamage = 7;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HeavyShottyS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HeavyShottyFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HeavyShottyFRS.png", 16, 1, 0, 20, 11);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
WEAPON_SANDVICH = 66;
SandvichHand = object_add();
object_set_parent(SandvichHand, Weapon);
object_event_add(SandvichHand,ev_create,0,'
    xoffset=-12;
    yoffset=3;
    refireTime=18;
    event_inherited();
    owner.expectedWeaponBytes = 3;
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    owner.ammo[105] = -1;
    isMelee = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandvichHandS.png", 4, 1, 0, 0, 11);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandvichHandS.png", 4, 1, 0, 0, 11);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandvichHandS.png", 4, 1, 0, 0, 11);

    sprite_index = normalSprite;
    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(SandvichHand,ev_destroy,0,'
    if owner != -1 owner.ammo[105] = alarm[5];
');
object_event_add(SandvichHand,ev_alarm,5,'
    ammoCount = maxAmmo;
    owner.ammo[105] = -1;
');
object_event_add(SandvichHand,ev_alarm,6,'
    if (reloadSprite != -1 && object_index != Rifle && alarm[5] > 0)
    {
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = 0;
    } 
    else
    {
        sprite_index = normalSprite;
        image_speed = 0;
    }
');
object_event_add(SandvichHand,ev_step,ev_step_normal,'
    //if(ammoCount >= 1){
    //    owner.canEat = true;
    //}else{
    //    owner.canEat = false;
    //}
    image_index = owner.team+2*real(owner.canEat);

    if !variable_local_exists("ammoCheck") {
        ammoCheck = 1;
        alarm[5] = owner.ammo[105];
    }
');
object_event_add(SandvichHand,ev_step,ev_step_end,'
    if(!instance_exists(AmmoCounter))
        instance_create(0,0,AmmoCounter);
');
object_event_add(SandvichHand,ev_other,ev_user0,'
    alarm[0]=refireTime;
    if owner.ammo[105] == -1 alarm[5] = reloadBuffer + reloadTime;
    else alarm[5] = reloadBuffer + owner.ammo[105];
');
object_event_add(SandvichHand,ev_other,ev_user1,'
    if(global.isHost){
        if(owner != -1) {
            if(!ownerPlayer.humiliated
                and !owner.taunting
                and !owner.omnomnomnom
                and owner.canEat
                and ownerPlayer.class==CLASS_HEAVY)
            {                            
                write_ubyte(global.sendBuffer, OMNOMNOMNOM);
                write_ubyte(global.sendBuffer, ds_list_find_index(global.players, ownerPlayer));
                with(owner)
                {
                    omnomnomnom = true;
                    omnomnomnomindex=0;
                    omnomnomnomend=32;
                    xscale=image_xscale;
                }             
            }
        }
    }
');
object_event_add(SandvichHand,ev_other,ev_user2,'
    if(owner.canEat && !owner.cloak) {
        with(Sandvich) {
            if ownerPlayer == other.ownerPlayer instance_destroy();
        }
        ammoCount -= 1; 
        shot = instance_create(x,y + yoffset + 1,Sandvich);
        shot.direction=owner.aimDirection+ random(7)-4;
        shot.speed=5;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        with(shot)
            hspeed+=owner.hspeed;
        owner.alarm[6] = owner.eatCooldown / global.delta_factor;
        owner.canEat = false;
        owner.ammo[105] = -1;
    }
');
object_event_add(SandvichHand,ev_other,ev_user12,'
    event_inherited();
    {
        write_ubyte(global.serializeBuffer, real(owner.canEat));
    }
');
object_event_add(SandvichHand,ev_other,ev_user13,'
    event_inherited();
    {
        receiveCompleteMessage(global.serverSocket, 1, global.deserializeBuffer); 
        owner.canEat = read_ubyte(global.deserializeBuffer); 
    }
');
object_event_add(SandvichHand,ev_draw,0,'
    if (distance_to_point(view_xview + view_wview/2, view_yview + view_hview/2) > 800)
        exit;

    if (!owner.invisible and !owner.taunting and !owner.omnomnomnom and !owner.player.humiliated)
    {
        if (!owner.cloak)
            image_alpha = power(owner.cloakAlpha, 0.5);
        else
            image_alpha = power(owner.cloakAlpha, 2);
        draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        if (owner.ubered)
        {
            if (owner.team == TEAM_RED)
                ubercolour = c_red;
            else if (owner.team == TEAM_BLUE)
                ubercolour = c_blue;
            draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
        }
    }
');
WEAPON_FAMILYBUSINESS = 67;
FamilyBusiness = object_add();
object_set_parent(FamilyBusiness, Weapon);
object_event_add(FamilyBusiness,ev_create,0,'
    xoffset=3;
    yoffset=-3;
    refireTime=17;
    event_inherited();
    maxAmmo = 8;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    
    shots = 5;
    shotDamage = 6;
    weaponGrade = UNIQUE;
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FamilyBusinessS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FamilyBusinessFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FamilyBusinessFRS.png", 16, 1, 0, 20, 11);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(FamilyBusiness,ev_other,ev_user3,'
    shotSpeed[0] = 4;
    shotSpeed[1] = 11;
    shotDir[0] = 11;
    shotDir[1] = 5;
    event_inherited();
');
WEAPON_CHOCOLATE = 68;
ChocolateHand = object_add();
object_set_parent(ChocolateHand, Weapon);
object_event_add(ChocolateHand,ev_create,0,'
    xoffset=-12;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    maxAmmo = 1
    ammoCount = maxAmmo;
    reloadTime = 450;
    reloadBuffer = 18;
    idle=true;
    readyToStab=false;
    unscopedDamage = 0;
');
WEAPON_KGOB = 69;
KGOB = object_add();
object_set_parent(KGOB, Weapon);
object_event_add(KGOB,ev_create,0,'
    xoffset=-10;
    yoffset=-5;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    owner.ammo[105] = -1;
    isMelee = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BoxingGlovesS.png", 2, 1, 0, 4, 10);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BoxingGlovesFS.png", 8, 1, 0, 4, 10);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BoxingGlovesS.png", 2, 1, 0, 4, 10);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(KGOB,ev_destroy,0,'
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(KGOB,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 45;
        shot.weapon=WEAPON_KGOB;
        //Removed crit thing here
        alarm[2] = 15;
    }
');
object_event_add(KGOB,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(KGOB,ev_alarm,5,'
    ammoCount = 1;
');
object_event_add(KGOB,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }

    if !variable_local_exists("ammoCheck") {
        ammoCheck = 1;
        alarm[5] = owner.ammo[105];
    }
');
object_event_add(KGOB,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    }
');

global.weapons[WEAPON_MINIGUN] = Minigun;
global.name[WEAPON_MINIGUN] = "Minigun";
global.weapons[WEAPON_TOMISLAV] = Tomislav;
global.name[WEAPON_TOMISLAV] = "Tomislav";
global.weapons[WEAPON_NATACHA] = Natacha;
global.name[WEAPON_NATACHA] = "Natascha";
global.weapons[WEAPON_BRASSBEAST] = BrassBeast;
global.name[WEAPON_BRASSBEAST] = "Brass Beast";
global.weapons[WEAPON_IRON] = IronMaiden;
global.name[WEAPON_IRON] = "Iron Maiden (unfinished)";
global.weapons[WEAPON_HEAVYSHOTGUN] = HeavyShotgun;
global.name[WEAPON_HEAVYSHOTGUN] = "Shotgun";
global.weapons[WEAPON_SANDVICH] = SandvichHand;
global.name[WEAPON_SANDVICH] = "Sandvich";
global.weapons[WEAPON_FAMILYBUSINESS] = FamilyBusiness;
global.name[WEAPON_FAMILYBUSINESS] = "Family Business";
global.weapons[WEAPON_CHOCOLATE] = ChocolateHand;
global.name[WEAPON_CHOCOLATE] = "Dalokohs Bar (unimplemented)"
global.weapons[WEAPON_KGOB] = KGOB;
global.name[WEAPON_KGOB] = "Killing Gloves Of Boxing";

// Spy
globalvar WEAPON_REVOLVER, WEAPON_ETRANGER, WEAPON_DIAMONDBACK, WEAPON_DIPLOMAT, WEAPON_NORDICGOLD, WEAPON_KNIFE, WEAPON_MEDICHAIN, WEAPON_BIGEARNER, WEAPON_SPYCICLE, WEAPON_ZAPPER;
globalvar Etranger, Diamondback, Diplomat, Goldassistant, Knife, ChainStab, BigEarner, Spycicle, Zapper;
WEAPON_REVOLVER = 70;
WEAPON_ETRANGER = 71;
Etranger = object_add();
object_set_parent(Etranger, Weapon);
object_event_add(Etranger,ev_create,0,'
    xoffset=-4;
    yoffset=0;
    refireTime=18;
    event_inherited();
    StabreloadTime = 20;
    readyToStab = true;

    stabdirection=0;
    maxAmmo = 6;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 45; //15 when not loading as clip
    reloadBuffer = refireTime;
    idle=true;
    unscopedDamage = 0;
    readyToStab=true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\EtrangerS.png", 2, 1, 0, -1, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\EtrangerFS.png", 4, 1, 0, -1, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\EtrangerFRS.png", 44, 1, 0, 15, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Etranger,ev_destroy,0,'
    with (SapAnimation) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
                
    with (SapMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Etranger,ev_alarm,1,'
    { 
        shot = instance_create(x,y,SapMask);
        shot.direction=stabdirection;
        shot.speed=0;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.weapon=DAMAGE_SOURCE_REVOLVER;
        alarm[2] = 20;
        playsound(x,y,KnifeSnd)
    }
');
object_event_add(Etranger,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Etranger,ev_alarm,5,'
    if (ammoCount < maxAmmo)
    {
        ammoCount = maxAmmo;
        ejected = 0;
    }
    event_inherited();
');
object_event_add(Etranger,ev_alarm,7,'
    if (global.particles == PARTICLES_NORMAL && image_alpha > 0.1)
    {
        repeat(maxAmmo-ammoCount-ejected)
        {
            var shell;
            shell = instance_create(x + lengthdir_x(8, owner.aimDirection), y + lengthdir_y(8, owner.aimDirection) - 5, Shell);
            shell.direction = 180 + owner.aimDirection + (70 - random(80)) * image_xscale;
            shell.speed *= 0.7;
            ejected +=1;
        }
    }
');
object_event_add(Etranger,ev_other,ev_user1,'
    if(readyToShoot && !owner.cloak && ammoCount > 0)
    {
        if(global.isHost)
        {
            var seed;
            seed = irandom(65535);
            sendEventFireWeapon(ownerPlayer, seed);
            doEventFireWeapon(ownerPlayer, seed);
        }
    }
    else if(readyToStab && owner.cloak && !(owner.keyState & $08))
    {
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,SapAnimation);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = DAMAGE_SOURCE_KNIFE;
        stab.golden = golden;
        
        // BH reward - *B*obble *H*ead
        if(hasClassReward(ownerPlayer, "BH"))
        {
            ds_list_add(stab.overlays, HatBobbleSpyStabS);
        }
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
    }
');
object_event_add(Etranger,ev_other,ev_user3,'
    ammoCount = max(0, ammoCount-1);
    playsound(x,y,RevolverSnd);
    var shot;

    shot = createShot(x,y + yoffset + 1,Shot, DAMAGE_SOURCE_REVOLVER, owner.aimDirection, 21);
    shot.hitDamage = 28;
    if(golden)
        shot.sprite_index = ShotGoldS;
    with(shot)
        speed += owner.hspeed*hspeed/15;

    // Move shot forward one 30fps step to avoid immediate collision with a wall behind the character
    // delta_factor is left out intentionally!
    shot.x += lengthdir_x(shot.speed, shot.direction);
    shot.y += lengthdir_y(shot.speed, shot.direction);
        
    justShot=true;
    readyToShoot=false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    alarm[7] = alarm[5] * 3 / 5;
');
WEAPON_DIAMONDBACK = 72;
Diamondback = object_add();
object_set_parent(Diamondback, Weapon);
object_event_add(Diamondback,ev_create,0,'
    xoffset=-4;
    yoffset=0;
    refireTime=18;
    event_inherited();
    StabreloadTime = 20;
    readyToStab = true;

    stabdirection=0;
    maxAmmo = 6;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 45; //15 when not loading as clip
    reloadBuffer = refireTime;
    idle=true;
    unscopedDamage = 0;
    readyToStab=true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DiamondbackS.png", 2, 1, 0, -1, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DiamondbackFS.png", 4, 1, 0, -1, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DiamondbackFRS.png", 44, 1, 0, 15, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Diamondback,ev_destroy,0,'
    with (SapAnimation) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
                
    with (SapMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Diamondback,ev_alarm,1,'
    { 
        shot = instance_create(x,y,SapMask);
        shot.direction=stabdirection;
        shot.speed=0;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.weapon=DAMAGE_SOURCE_REVOLVER;
        alarm[2] = 20;
        playsound(x,y,KnifeSnd)
    }
');
object_event_add(Diamondback,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Diamondback,ev_alarm,5,'
    if (ammoCount < maxAmmo)
    {
        ammoCount = maxAmmo;
        ejected = 0;
    }
    event_inherited();
');
object_event_add(Diamondback,ev_alarm,7,'
    if (global.particles == PARTICLES_NORMAL && image_alpha > 0.1)
    {
        repeat(maxAmmo-ammoCount-ejected)
        {
            var shell;
            shell = instance_create(x + lengthdir_x(8, owner.aimDirection), y + lengthdir_y(8, owner.aimDirection) - 5, Shell);
            shell.direction = 180 + owner.aimDirection + (70 - random(80)) * image_xscale;
            shell.speed *= 0.7;
            ejected +=1;
        }
    }
');
object_event_add(Diamondback,ev_other,ev_user1,'
    if(readyToShoot && !owner.cloak && ammoCount > 0)
    {
        if(global.isHost)
        {
            var seed;
            seed = irandom(65535);
            sendEventFireWeapon(ownerPlayer, seed);
            doEventFireWeapon(ownerPlayer, seed);
        }
    }
    else if(readyToStab && owner.cloak && !(owner.keyState & $08))
    {
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,SapAnimation);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = DAMAGE_SOURCE_KNIFE;
        stab.golden = golden;
        
        // BH reward - *B*obble *H*ead
        if(hasClassReward(ownerPlayer, "BH"))
        {
            ds_list_add(stab.overlays, HatBobbleSpyStabS);
        }
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
    }
');
object_event_add(Diamondback,ev_other,ev_user3,'
    ammoCount = max(0, ammoCount-1);
    playsound(x,y,RevolverSnd);
    var shot;

    shot = createShot(x,y + yoffset + 1,Shot, DAMAGE_SOURCE_REVOLVER, owner.aimDirection, 21);
    shot.hitDamage = 24;
    if(golden)
        shot.sprite_index = ShotGoldS;
    with(shot)
        speed += owner.hspeed*hspeed/15;

    // Move shot forward one 30fps step to avoid immediate collision with a wall behind the character
    // delta_factor is left out intentionally!
    shot.x += lengthdir_x(shot.speed, shot.direction);
    shot.y += lengthdir_y(shot.speed, shot.direction);
        
    justShot=true;
    readyToShoot=false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    alarm[7] = alarm[5] * 3 / 5;
');
WEAPON_DIPLOMAT = 73;
Diplomat = object_add();
object_set_parent(Diplomat, Weapon);
object_event_add(Diplomat,ev_create,0,'
    xoffset=-4;
    yoffset=0;
    refireTime=23.4;
    event_inherited();
    StabreloadTime = 20;
    readyToStab = true;

    stabdirection=0;
    maxAmmo = 6;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 45; //15 when not loading as clip
    reloadBuffer = refireTime;
    idle=true;
    unscopedDamage = 0;
    readyToStab=true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DiplomatS.png", 2, 1, 0, -1, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DiplomatFS.png", 4, 1, 0, -1, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DiplomatFRS.png", 44, 1, 0, 15, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Diplomat,ev_destroy,0,'
    with (SapAnimation) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
                
    with (SapMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Diplomat,ev_alarm,1,'
    { 
        shot = instance_create(x,y,SapMask);
        shot.direction=stabdirection;
        shot.speed=0;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.weapon=DAMAGE_SOURCE_REVOLVER;
        alarm[2] = 20;
        playsound(x,y,KnifeSnd)
    }
');
object_event_add(Diplomat,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Diplomat,ev_alarm,5,'
    if (ammoCount < maxAmmo)
    {
        ammoCount = maxAmmo;
        ejected = 0;
    }
    event_inherited();
');
object_event_add(Diplomat,ev_alarm,7,'
    if (global.particles == PARTICLES_NORMAL && image_alpha > 0.1)
    {
        repeat(maxAmmo-ammoCount-ejected)
        {
            var shell;
            shell = instance_create(x + lengthdir_x(8, owner.aimDirection), y + lengthdir_y(8, owner.aimDirection) - 5, Shell);
            shell.direction = 180 + owner.aimDirection + (70 - random(80)) * image_xscale;
            shell.speed *= 0.7;
            ejected +=1;
        }
    }
');
object_event_add(Diplomat,ev_other,ev_user1,'
    if(readyToShoot && !owner.cloak && ammoCount > 0)
    {
        if(global.isHost)
        {
            var seed;
            seed = irandom(65535);
            sendEventFireWeapon(ownerPlayer, seed);
            doEventFireWeapon(ownerPlayer, seed);
        }
    }
    else if(readyToStab && owner.cloak && !(owner.keyState & $08))
    {
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,SapAnimation);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = DAMAGE_SOURCE_KNIFE;
        stab.golden = golden;
        
        // BH reward - *B*obble *H*ead
        if(hasClassReward(ownerPlayer, "BH"))
        {
            ds_list_add(stab.overlays, HatBobbleSpyStabS);
        }
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
    }
');
object_event_add(Diplomat,ev_other,ev_user3,'
    ammoCount = max(0, ammoCount-1);
    playsound(x,y,RevolverSnd);
    var shot;

    shot = createShot(x,y + yoffset + 1,Shot, DAMAGE_SOURCE_REVOLVER, owner.aimDirection, 21);
    shot.hitDamage = 21;
    if(golden)
        shot.sprite_index = ShotGoldS;
    with(shot)
        speed += owner.hspeed*hspeed/15;

    // Move shot forward one 30fps step to avoid immediate collision with a wall behind the character
    // delta_factor is left out intentionally!
    shot.x += lengthdir_x(shot.speed, shot.direction);
    shot.y += lengthdir_y(shot.speed, shot.direction);
        
    justShot=true;
    readyToShoot=false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    alarm[7] = alarm[5] * 3 / 5;
');
WEAPON_NORDICGOLD = 74;
Goldassistant = object_add();
object_set_parent(Goldassistant, Weapon);
object_event_add(Goldassistant,ev_create,0,'
    xoffset=-4;
    yoffset=0;
    refireTime=18;
    event_inherited();
    StabreloadTime = 20;
    readyToStab = true;

    stabdirection=0;
    maxAmmo = 6;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 45; //15 when not loading as clip
    reloadBuffer = refireTime;
    idle=true;
    unscopedDamage = 0;
    readyToStab=true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GoldAssistantS.png", 2, 1, 0, -1, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GoldAssistantFS.png", 4, 1, 0, -1, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\GoldAssistantFRS.png", 44, 1, 0, 15, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Goldassistant,ev_destroy,0,'
    with (SapAnimation) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
                
    with (SapMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Goldassistant,ev_alarm,1,'
    { 
        shot = instance_create(x,y,SapMask);
        shot.direction=stabdirection;
        shot.speed=0;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.weapon=DAMAGE_SOURCE_REVOLVER;
        alarm[2] = 20;
        playsound(x,y,KnifeSnd)
    }
');
object_event_add(Goldassistant,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Goldassistant,ev_alarm,5,'
    if (ammoCount < maxAmmo)
    {
        ammoCount = maxAmmo;
        ejected = 0;
    }
    event_inherited();
');
object_event_add(Goldassistant,ev_alarm,7,'
    if (global.particles == PARTICLES_NORMAL && image_alpha > 0.1)
    {
        repeat(maxAmmo-ammoCount-ejected)
        {
            var shell;
            shell = instance_create(x + lengthdir_x(8, owner.aimDirection), y + lengthdir_y(8, owner.aimDirection) - 5, Shell);
            shell.direction = 180 + owner.aimDirection + (70 - random(80)) * image_xscale;
            shell.speed *= 0.7;
            ejected +=1;
        }
    }
');
object_event_add(Goldassistant,ev_other,ev_user1,'
    if(readyToShoot && !owner.cloak && ammoCount > 0)
    {
        if(global.isHost)
        {
            var seed;
            seed = irandom(65535);
            sendEventFireWeapon(ownerPlayer, seed);
            doEventFireWeapon(ownerPlayer, seed);
        }
    }
    else if(readyToStab && owner.cloak && !(owner.keyState & $08))
    {
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,SapAnimation);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = DAMAGE_SOURCE_KNIFE;
        stab.golden = golden;
        
        // BH reward - *B*obble *H*ead
        if(hasClassReward(ownerPlayer, "BH"))
        {
            ds_list_add(stab.overlays, HatBobbleSpyStabS);
        }
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
    }
');
object_event_add(Goldassistant,ev_other,ev_user3,'
    ammoCount = max(0, ammoCount-1);
    playsound(x,y,RevolverSnd);
    var shot;

    shot = createShot(x,y + yoffset + 1,Shot, DAMAGE_SOURCE_REVOLVER, owner.aimDirection, 21);
    shot.hitDamage = 25;
    if(golden)
        shot.sprite_index = ShotGoldS;
    with(shot)
        speed += owner.hspeed*hspeed/15;

    // Move shot forward one 30fps step to avoid immediate collision with a wall behind the character
    // delta_factor is left out intentionally!
    shot.x += lengthdir_x(shot.speed, shot.direction);
    shot.y += lengthdir_y(shot.speed, shot.direction);
        
    justShot=true;
    readyToShoot=false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    alarm[7] = alarm[5] * 3 / 5;
');
WEAPON_KNIFE = 75;
Knife = object_add();
object_set_parent(Knife, Weapon);
object_event_add(Knife,ev_create,0,'
    xoffset=5;
    yoffset=-6;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    damage=10;
    isMelee = true;
    justShot = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\Knife2S.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\Knife2FS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\Knife2S.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Knife,ev_destroy,0,'
    with (StabAnim) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (StabMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Knife,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = damage;
        shot.weapon=WEAPON_KNIFE;

        alarm[2] = 10;
    }
');
object_event_add(Knife,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Knife,ev_alarm,3,'
    { 
        shot = instance_create(x,y,StabMask);
        shot.direction=stabdirection;
        shot.speed=0;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 200;
        shot.weapon=DAMAGE_SOURCE_KNIFE;

        alarm[2] = 18;
    }
');
object_event_add(Knife,ev_alarm,2,'
    ammoCount = 1;
');
object_event_add(Knife,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 > 1 {
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }

    if owner.cloak damage=10;
    else damage = min(35,damage+0.5);

');
object_event_add(Knife,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;
        justShot = true;

        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    } else if(readyToStab && owner.cloak){
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,StabAnim);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = WEAPON_KNIFE;
        stab.golden = golden;
        if owner.stabspeed > 0 {
            owner.stabspeed -= 1;
            stab.animationspeed*=2;
            alarm[3] = 32/2;
        } else alarm[3] = 32;
        readyToStab = false;
    }
');
WEAPON_MEDICHAIN = 76;
ChainStab = object_add();
object_set_parent(ChainStab, Weapon);
object_event_add(ChainStab,ev_create,0,'
    xoffset=5;
    yoffset=-6;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    damage=10;
    isMelee = true;
    justShot = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\Knife2S.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\Knife2FS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\Knife2S.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(ChainStab,ev_destroy,0,'
    with (StabAnim) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (StabMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(ChainStab,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = damage;
        shot.weapon=WEAPON_MEDICHAIN;

        alarm[2] = 10;
    }
');
object_event_add(ChainStab,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(ChainStab,ev_alarm,3,'
    { 
        shot = instance_create(x,y,StabMask);
        shot.direction=stabdirection;
        shot.speed=0;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 200;
        shot.weapon=DAMAGE_SOURCE_KNIFE;

        alarm[2] = 18;
    }
');
object_event_add(ChainStab,ev_alarm,2,'
    ammoCount = 1;
');
object_event_add(ChainStab,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 > 1 {
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }

    if owner.cloak damage=10;
    else damage = min(35,damage+0.5);

');
object_event_add(ChainStab,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;
        justShot = true;

        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    } else if(readyToStab && owner.cloak){
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,StabAnim);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = WEAPON_MEDICHAIN;
        stab.golden = golden;
        if owner.stabspeed > 0 {
            owner.stabspeed -= 1;
            stab.animationspeed*=2;
            alarm[3] = 32/2;
        } else alarm[3] = 32;
        readyToStab = false;
    }
');
WEAPON_BIGEARNER = 77;
BigEarner = object_add();
object_set_parent(BigEarner, Weapon);
object_event_add(BigEarner,ev_create,0,'
    xoffset=5;
    yoffset=-6;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    damage=10;
    isMelee = true;
    justShot = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BigEarnerS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BigEarnerFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BigEarnerS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(BigEarner,ev_destroy,0,'
    with (StabAnim) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (StabMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(BigEarner,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = damage;
        shot.weapon=WEAPON_BIGEARNER;

        alarm[2] = 10;
    }
');
object_event_add(BigEarner,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(BigEarner,ev_alarm,3,'
    { 
        shot = instance_create(x,y,StabMask);
        shot.direction=stabdirection;
        shot.speed=0;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 200;
        shot.weapon=DAMAGE_SOURCE_KNIFE;

        alarm[2] = 18;
    }
');
object_event_add(BigEarner,ev_alarm,2,'
    ammoCount = 1;
');
object_event_add(BigEarner,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 > 1 {
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }

    if owner.cloak damage=10;
    else damage = min(35,damage+0.5);

');
object_event_add(BigEarner,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;
        justShot = true;

        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    } else if(readyToStab && owner.cloak){
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,StabAnim);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = WEAPON_KNIFE;
        stab.golden = golden;
        if owner.stabspeed > 0 {
            owner.stabspeed -= 1;
            stab.animationspeed*=2;
            alarm[3] = 32/2;
        } else alarm[3] = 32;
        readyToStab = false;
    }
');
WEAPON_SPYCICLE = 78;
Spycicle = object_add();
object_set_parent(Spycicle, Weapon);
object_event_add(Spycicle,ev_create,0,'
    xoffset=5;
    yoffset=-6;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    damage=10;
    isMelee = true;
    justShot = false;
    owner.ammo[112] = 15*30;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SpycicleS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SpycicleFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SpycicleS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Spycicle,ev_destroy,0,'
    with (StabAnim) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (StabMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    owner.fireproof = false;
');
object_event_add(Spycicle,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = damage;
        shot.weapon=WEAPON_SPYCICLE;

        alarm[2] = 10;
    }
');
object_event_add(Spycicle,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Spycicle,ev_alarm,3,'
    { 
        shot = instance_create(x,y,StabMask);
        shot.direction=stabdirection;
        shot.speed=0;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 200;
        shot.weapon=DAMAGE_SOURCE_KNIFE;

        alarm[2] = 18;
    }
');
object_event_add(Spycicle,ev_alarm,2,'
    ammoCount = 1;
');
object_event_add(Spycicle,ev_alarm,10,'
    owner.fireproof = false;
');
object_event_add(Spycicle,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 > 1 {
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }

    if owner.cloak damage=10;
    else damage = min(35,damage+0.5);

    if owner.burnDuration > 0 or owner.burnIntensity > 0 && owner.ammo[112] >= 30*15 {
        playsound(x,y,CompressionBlastSnd);
        owner.fireproof = true;
        owner.ammo[112] = 0;
        alarm[10] = 60;
    }
');
object_event_add(Spycicle,ev_other,ev_user1,'
    if owner.ammo[112] < 15*30 exit;
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;
        justShot = true;

        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    } else if(readyToStab && owner.cloak){
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,StabAnim);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = WEAPON_KNIFE;
        stab.golden = golden;
        if owner.stabspeed > 0 {
            owner.stabspeed -= 1;
            stab.animationspeed*=2;
            alarm[3] = 32/2;
        } else alarm[3] = 32;
        readyToStab = false;
    }
');
WEAPON_ZAPPER = 79;
Zapper = object_add();
object_set_parent(Zapper, Weapon);
object_event_add(Zapper,ev_create,0,'
    xoffset=5;
    yoffset=-6;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 45;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    damage=3;
    isMelee = true;
    justShot = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ZapperS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ZapperFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ZapperS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Zapper,ev_destroy,0,'
    with (StabAnim) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    with (StabMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');
object_event_add(Zapper,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = damage;
        shot.weapon=WEAPON_ZAPPER;

        alarm[2] = 10;
    }
');
object_event_add(Zapper,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Zapper,ev_alarm,3,'
    { 
        shot = instance_create(x,y,StabMask);
        shot.direction=stabdirection;
        shot.speed=0;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 66;
        shot.weapon=DAMAGE_SOURCE_KNIFE;

        alarm[2] = 18;
    }
');
object_event_add(Zapper,ev_alarm,2,'
    ammoCount = 1;
');
object_event_add(Zapper,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 > 1 {
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }

    if owner.cloak damage=10;
    else damage = min(11,damage+0.5);

');
object_event_add(Zapper,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;
        justShot = true;

        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    } else if(readyToStab && owner.cloak){
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,StabAnim);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 66;
        stab.weapon = WEAPON_ZAPPER;
        stab.golden = golden;
        stab.animationspeed = 1;
        stab.animationspeed*=1.25;
        if owner.stabspeed > 0 {
            owner.stabspeed -= 1;
            stab.animationspeed*=2;
            alarm[3] = 26/2;
        } else alarm[3] = 26;
        readyToStab = false;
    }
');

global.weapons[WEAPON_REVOLVER] = Revolver;
global.name[WEAPON_REVOLVER] = "Revolver";
global.weapons[WEAPON_ETRANGER] = Etranger;
global.name[WEAPON_ETRANGER] = "l'Etranger (unfinished)"
global.weapons[WEAPON_DIAMONDBACK] = Diamondback;
global.name[WEAPON_DIAMONDBACK] = "Diamondback (unfinished)";
global.weapons[WEAPON_DIPLOMAT] = Diplomat;
global.name[WEAPON_DIPLOMAT] = "The Ambassador (unfinished)";
global.weapons[WEAPON_NORDICGOLD] = Goldassistant;
global.name[WEAPON_NORDICGOLD] = "Nordic Gold (unfinished)";
global.weapons[WEAPON_KNIFE] = Knife;
global.name[WEAPON_KNIFE] = "Knife";
global.weapons[WEAPON_MEDICHAIN] = ChainStab;
global.name[WEAPON_MEDICHAIN] = "Medichain (unfinished)"
global.weapons[WEAPON_BIGEARNER] = BigEarner;
global.name[WEAPON_BIGEARNER] = "Big Earner (unfinished)";
global.weapons[WEAPON_SPYCICLE] = Spycicle;
global.name[WEAPON_SPYCICLE] = "Spycicle (unfinished)";
global.weapons[WEAPON_ZAPPER] = Zapper;
global.name[WEAPON_ZAPPER] = "Zapper (unfinished)";

// Pyro
globalvar WEAPON_FLAMETHROWER, WEAPON_PHLOG, WEAPON_TRANSMUTATOR, WEAPON_FROSTBITE, WEAPON_BACKBURNER, WEAPON_PYROSHOTGUN, WEAPON_FLAREGUN, WEAPON_DETONATOR, WEAPON_NAPALM, WEAPON_WRECKER;
globalvar Phlog, Transmutator, Frostbite, Backburner, PyroShotgun, Flaregun, Detonator, NapalmHand, Axe;
WEAPON_FLAMETHROWER = 80;
WEAPON_PHLOG = 84; //kinda weird
Phlog = object_add();
object_set_parent(Phlog, Weapon);
object_event_add(Phlog,ev_create,0,'
    xoffset = -11;
    yoffset = -2;
    refireTime = 1;
    event_inherited();
    blastDistance = 150;
    blastAngle = 75;
    blastStrength = 28;
    characterBlastStrength = 15;
    blastNoFlameTime = 15;
    blastReloadTime = 35;
    flareReloadTime = 55;
    alarm[1] = blastReloadTime;
    alarm[2] = flareReloadTime / global.delta_factor;
    readyToBlast = false;
    readyToFlare = false;
    justBlast = false;

    hitDamage = 2.4;
    durationIncrease = 30;
    burnIncrease=1;
    shot = false;
    index = 0;
    
    maxAmmo = 200
    ammoCount = maxAmmo;
    soundLoopTime = 30;
    currentTime = 0;
    
    reloadBuffer = 15;
    isRefilling = false;
    unscopedDamage = 0;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PhlogS.png", 2, 1, 0, 8, 2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PhlogFS.png", 2, 1, 0, 8, 2);
    blastSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PhlogS.png", 2, 1, 0, 8, 2);
    dropSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PhlogS.png", 2, 1, 0, 8, 2);
    reloadSprite = -1;

    sprite_index = normalSprite;
    
    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    blastAnimLength = sprite_get_number(blastSprite)/2;
    blastImageSpeed = blastAnimLength/blastNoFlameTime;

    dropTime = 4;
    dropAnimLength = sprite_get_number(dropSprite)/2;
    dropImageSpeed = dropAnimLength/dropTime;
');
object_event_add(Phlog,ev_destroy,0,'
    {
    loopsoundstop(FlamethrowerSnd);
    }
');
object_event_add(Phlog,ev_alarm,1,'
    readyToBlast = true;
');
object_event_add(Phlog,ev_alarm,2,'
    readyToFlare = true;
');
object_event_add(Phlog,ev_alarm,3,'
    {
    loopsoundstop(FlamethrowerSnd);
    }
');
object_event_add(Phlog,ev_alarm,5,'
    isRefilling = true;
');
object_event_add(Phlog,ev_alarm,6,'
    //Override this if we are airblasting
    if (sprite_index != blastSprite) {
        sprite_index = dropSprite;
        image_speed = dropImageSpeed * global.delta_factor;
        image_index = 0;
        alarm[7] = dropTime / global.delta_factor;
    }
');
object_event_add(Phlog,ev_alarm,7,'
    sprite_index = normalSprite;
    image_speed = 0;
');
object_event_add(Phlog,ev_step,ev_step_begin,'
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo and isRefilling)
        ammoCount += 1.8 * global.delta_factor;
');
object_event_add(Phlog,ev_step,ev_step_end,'
    event_inherited();
    if (justBlast)
    {
        justBlast = false;
        //Airblast Recoil Animation
        sprite_index = blastSprite;
        image_index = 0;
        image_speed = blastImageSpeed * global.delta_factor;
        alarm[7] = blastNoFlameTime / global.delta_factor;
        alarm[6] = 0;
    }
');
object_event_add(Phlog,ev_other,ev_user1,'
    {
        if (ammoCount >= 2 && !owner.cloak) {
            if(alarm[3]<=0) {
                loopsoundstart(x,y,FlamethrowerSnd);
            } else {
                loopsoundmaintain(x,y,FlamethrowerSnd);
            }
            alarm[3]=2;
            justShot=true;
            alarm[5] = reloadBuffer;
            isRefilling = false;
            ammoCount-=2;
            if ammoCount > 0 alarm[0]=refireTime;
            else alarm[0]=50;
            
        if !collision_line(x,y,x+lengthdir_x(28,owner.aimDirection),y+lengthdir_y(28,owner.aimDirection),Obstacle,1,0) and !place_meeting(x+lengthdir_x(25,owner.aimDirection),y+lengthdir_y(25,owner.aimDirection),TeamGate) {    
            shot=true;
            
            var x1,y1,xm,ym, len;
            var hitline;
            len=140;
            x1=x+lengthdir_x(25,owner.aimDirection);
            y1=y+lengthdir_y(25,owner.aimDirection);
            x2=x+lengthdir_x(len,owner.aimDirection);
            y2=y+lengthdir_y(len,owner.aimDirection);
            
            while(len>1) {
                xm=(x1+x2)/2;
                ym=(y1+y2)/2;
                
                hitline = false;
                with(owner) {
                    if (collision_line(x1,y1,xm,ym,Generator,true,true)>=0) {
                        hitline = true;
                        if instance_nearest(x1,y1,Generator).team == team hitline = false;
                    }
                    if(collision_line(x1,y1,xm,ym,Obstacle,true,true)>=0) {
                        hitline = true;
                    }/* else if (collision_line(x1,y1,xm,ym,Character,true,true)>=0) {
                        hitline = true;
                    }*/ else if (collision_line(x1,y1,xm,ym,Sentry,true,false)>=0) {
                        hitline = true;
                    } else if (collision_line(x1,y1,xm,ym,TeamGate,true,true)>=0) {
                        hitline = true;
                    } else if (collision_line(x1,y1,xm,ym,IntelGate,true,true)>=0) {
                        hitline = true;
                    } else if (collision_line(x1,y1,xm,ym,ControlPointSetupGate,true,true)>=0) {
                        if ControlPointSetupGate.solid == true hitline = true;
                    } else if (collision_line(x1,y1,xm,ym,BulletWall,true,true)>=0) {
                        hitline = true;
                    }
                }
                
                if(hitline) {
                    x2=xm;
                    y2=ym;
                } else {
                    x1=xm;
                    y1=ym;
                }
                len/=2;
            }
            
            with(Player) {
                if(id != other.ownerPlayer and team != other.owner.team and object != -1) {
                    if(collision_line(other.x,other.y,other.x2,other.y2,object,true,false)>=0) && object.ubered == 0 {
						//other.ownerPlayer.object.phlogDmg+=other.hitDamage*(1+0*0.35)*1; //other.crit
						//if !object.invincible// object.hp -= other.hitDamage*(1+0*0.35)*1; //other.crit
						hitDamage *= (1+0*0.35)*1
						damageCharacter(ownerPlayer.object, other.id, hitDamage);
						//object.hp -= other.hitDamage*(1+0*0.35)*1; //other.crit
						//object.lastDamageCrit=other.crit;
						object.timeUnscathed = 0;
						if (object.lastDamageDealer != other.ownerPlayer && object.lastDamageDealer != object.player){
							object.secondToLastDamageDealer = object.lastDamageDealer;
							object.alarm[4] = object.alarm[3]
						}
						object.alarm[3] = ASSIST_TIME;
						object.lastDamageDealer = other.ownerPlayer;
						object.cloakAlpha = min(object.cloakAlpha + 0.3, 1);
                        /*if(global.gibLevel > 0){
								blood = instance_create(object.x,object.y,Blood);
								blood.direction = other.owner.aimDirection-180;
							}*/
                        //if(!object_is_ancestor(object.object_index, Pyro) && /*!object.invincible*/ ) {
                        if(!object_is_ancestor(object.object_index, Pyro)) {
                            //object.frozen = false;
                            if (object.burnDuration < object.maxDuration) {
                                object.burnDuration += other.durationIncrease; 
                                object.burnDuration = min(object.burnDuration, object.maxDuration);
                            }
                            if (object.burnIntensity < object.maxIntensity) {
                                object.burnIntensity += other.burnIncrease;
                                object.burnIntensity = min(object.burnIntensity, object.maxIntensity);
                            }
                            object.burnedBy = other.ownerPlayer;
                            object.afterburnSource = WEAPON_PHLOG;
                            object.alarm[0] = object.decayDelay;
                        }
                        object.lastDamageSource = WEAPON_PHLOG;
                        }
                        exit;
                }
            }
            
            with(Sentry) {
                if(team != other.owner.team) {
                    if(collision_line(other.x,other.y,other.x2,other.y2,id,false,false)>=0) {
                        hp -= other.hitDamage*1;
                        //lastDamageCrit=other.crit;
                        lastDamageDealer = other.ownerPlayer;
                        lastDamageSource = WEAPON_PHLOG;
                        exit;
                    }
                }
            }
            
            with(Generator) {
                if(team != other.owner.team) {
                    if(collision_line(other.x,other.y,other.x2,other.y2,id,true,false)>=0) {
                        alarm[0] = regenerationBuffer;
                        isShieldRegenerating = false;
                        //allow overkill to be applied directly to the target
                        if (other.hitDamage > shieldHp) {
                            hp -= other.hitDamage*1 - shieldHp;
                            hp -= shieldHp * shieldResistance;
                            shieldHp = 0;
                        }
                        else
                        {
                            hp -= other.hitDamage*1 * shieldResistance;
                            shieldHp -= other.hitDamage;
                        }
                        exit;
                    }
                }
            }
        }
        }
    }
');
globalvar PhlogBeamS;
PhlogBeamS = sprite_add(pluginFilePath + "\randomizer_sprites\PhlogBeamS.png", 4, 1, 0, 0, 20);
object_event_add(Phlog,ev_draw,0,'
    if(owner.taunting)
    exit;
    
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset) + owner.equipmentOffset;
    if (alarm[6] <= 0){
        if (alarm[7] > 0) {
            //if we are not shooting, but airblasting/dropping
            if (sprite_index == dropSprite) {
                imageOffset = floor(image_index mod dropAnimLength) + dropAnimLength*owner.team
            }else if (sprite_index == blastSprite){
                imageOffset = floor(image_index mod blastAnimLength) + blastAnimLength*owner.team
            }
        }else{
            //set the sprite to idle
            imageOffset = owner.team;
        }
    }else{
        //We are shooting, loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }


    if !owner.player.humiliated draw_sprite_ext(sprite_index,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_white, 1);
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }

    if shot {
        len = point_distance(x+lengthdir_x(25,owner.aimDirection),y+lengthdir_y(25,owner.aimDirection),x2,y2);
        draw_sprite_ext(PhlogBeamS,floor(index),x+lengthdir_x(28,owner.aimDirection), y+lengthdir_y(28,owner.aimDirection)+3,len/140,len/140,owner.aimDirection,c_white,0.8)
        if(global.particles == PARTICLES_NORMAL) {
            smoke=random(len)
            effect_create_below(ef_smokeup,x+lengthdir_x(25+smoke,owner.aimDirection),y+lengthdir_y(25+smoke,owner.aimDirection)-8,0,c_gray);    
        }
        shot = false;
    }
');
WEAPON_TRANSMUTATOR = 82;
Transmutator = object_add();
object_set_parent(Transmutator, Weapon);
object_event_add(Transmutator,ev_create,0,'
    xoffset = -3;
    yoffset = 6;
    refireTime = 1;
    event_inherited();
    blastDistance = 150;
    blastAngle = 75;
    blastStrength = 28;
    characterBlastStrength = 15;
    blastNoFlameTime = 15;
    blastReloadTime = 35;
    flareReloadTime = 55;
    alarm[1] = blastReloadTime;
    alarm[2] = flareReloadTime / global.delta_factor;
    readyToBlast = false;
    readyToFlare = false;
    justBlast = false;
    
    maxAmmo = 200
    ammoCount = maxAmmo;
    soundLoopTime = 30;
    currentTime = 0;
    
    reloadBuffer = 15;
    isRefilling = false;
    unscopedDamage = 0;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\TransmutatorS.png", 2, 1, 0, 8, 2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\TransmutatorFS.png", 2, 1, 0, 8, 2);
    blastSprite = sprite_add(pluginFilePath + "\randomizer_sprites\TransmutatorS.png", 2, 1, 0, 8, 2);
    dropSprite = sprite_add(pluginFilePath + "\randomizer_sprites\TransmutatorS.png", 2, 1, 0, 8, 2);
    reloadSprite = -1;

    sprite_index = normalSprite;
    
    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    blastAnimLength = sprite_get_number(blastSprite)/2;
    blastImageSpeed = blastAnimLength/blastNoFlameTime;

    dropTime = 4;
    dropAnimLength = sprite_get_number(dropSprite)/2;
    dropImageSpeed = dropAnimLength/dropTime;
');
object_event_add(Transmutator,ev_destroy,0,'
    {
    loopsoundstop(FlamethrowerSnd);
    }
');
object_event_add(Transmutator,ev_alarm,1,'
    readyToBlast = true;
');
object_event_add(Transmutator,ev_alarm,2,'
    readyToFlare = true;
');
object_event_add(Transmutator,ev_alarm,3,'
    {
    loopsoundstop(FlamethrowerSnd);
    }
');
object_event_add(Transmutator,ev_alarm,5,'
    isRefilling = true;
');
object_event_add(Transmutator,ev_alarm,6,'
    //Override this if we are airblasting
    if (sprite_index != blastSprite) {
        sprite_index = dropSprite;
        image_speed = dropImageSpeed * global.delta_factor;
        image_index = 0;
        alarm[7] = dropTime / global.delta_factor;
    }
');
object_event_add(Transmutator,ev_alarm,7,'
    sprite_index = normalSprite;
    image_speed = 0;
');
object_event_add(Transmutator,ev_step,ev_step_begin,'
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo and isRefilling)
        ammoCount += 1.8 * global.delta_factor;
');
object_event_add(Transmutator,ev_step,ev_step_end,'
    event_inherited();
    if (justBlast)
    {
        justBlast = false;
        //Airblast Recoil Animation
        sprite_index = blastSprite;
        image_index = 0;
        image_speed = blastImageSpeed * global.delta_factor;
        alarm[7] = blastNoFlameTime / global.delta_factor;
        alarm[6] = 0;
    }
');
object_event_add(Transmutator,ev_other,ev_user1,'
    {
        var newx, newy;
        newx = x+lengthdir_x(25,owner.aimDirection);
        newy = y+lengthdir_y(25,owner.aimDirection) + owner.equipmentOffset;
        // prevent sputtering
        if (ammoCount < 1.8)
            ammoCount -= 1.8;
        if (readyToShoot and ammoCount >= 1.8
            and !collision_line_bulletblocking(x,y,newx,newy))
        {
            if(alarm[3] <= 0)
                loopsoundstart(x,y,FlamethrowerSnd);
            else
                loopsoundmaintain(x,y,FlamethrowerSnd);
            alarm[3] = 2 / global.delta_factor;
            
            var shot, calculatedspread;
            randomize();
            calculatedspread = sign(random(2)-1)*power(random(3), 1.8);
            calculatedspread *= 1 - hspeed/owner.basemaxspeed;
            shot = createShot(newx, newy, Flame, DAMAGE_SOURCE_FLAMETHROWER, owner.aimDirection+calculatedspread,6.5+random(3.5));
            with(shot)
                motion_add(owner.direction, owner.speed);
            
            justShot=true;
            readyToShoot=false;
            isRefilling = false;
            ammoCount -= 1.8;
            
            if (ammoCount > 0)
                alarm[0] = refireTime / global.delta_factor;
            else
                alarm[0] = reloadBuffer*2 / global.delta_factor;
            alarm[5] = reloadBuffer / global.delta_factor;
        }
    }
');
object_event_add(Transmutator,ev_other,ev_user2,'
    {
        if (readyToBlast && ammoCount >= 40)
        {
            //Base
            playsound(x,y,CompressionBlastSnd);
            poof = instance_create(x+lengthdir_x(25,owner.aimDirection),y+lengthdir_y(25,owner.aimDirection),AirBlastO);
            if (image_xscale == 1)
            {
                poof.image_xscale = 1;
                poof.image_angle = owner.aimDirection;
            }
            else
            {
                poof.image_xscale = -1;
                poof.image_angle = owner.aimDirection+180;
            }
            poof.owner = owner;
            with(poof)
                motion_add(owner.direction, owner.speed * global.delta_factor);
            
            var shot;
            //Flare
            if (owner.keyState & $10 and ammoCount >= 75 and readyToFlare)
            {
                var newx, newy;
                newx = x+lengthdir_x(25,owner.aimDirection);
                newy = y+lengthdir_y(25,owner.aimDirection);
                if !collision_line_bulletblocking(x, y, newx, newy)
                {
                    shot = createShot(newx,newy,Flare, DAMAGE_SOURCE_FLARE, owner.aimDirection, 15);                
                    justShot=true;
                    readyToFlare=false;
                    ammoCount -= 35;
                    alarm[2] = flareReloadTime / global.delta_factor;
                }
            }
                
            //Reflects
            with(Rocket)
            {
                if(ownerPlayer.team != other.owner.team)
                {
                    dir = point_direction(other.x, other.y, x, y);
                    dist = point_distance(other.x, other.y, x, y);
                    angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                    if collision_circle(x,y,5,other.poof,false,true)
                    {
						instance_destroy();
						other.owner.hp = min(other.owner.maxHp, other.owner.hp+15);
                    }
                }
            }
            with(Flare)
            {
                if(ownerPlayer.team != other.owner.team)
                {
                    dir = point_direction(other.x, other.y, x, y);
                    dist = point_distance(other.x, other.y, x, y);
                    angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                    if collision_circle(x,y,5,other.poof,false,true)
                    {
                        instance_destroy();
						other.owner.hp = min(other.owner.maxHp, other.owner.hp+15);
                    }
                }
            }
			
			with(Arrow)
            {
                if(ownerPlayer.team != other.owner.team && attached == -1)
                {
                    dir = point_direction(other.x, other.y, x, y);
                    dist = point_distance(other.x, other.y, x, y);
                    angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                    if collision_circle(x,y,5,other.poof,false,true)
                    {
                        instance_destroy();
						other.owner.hp = min(other.owner.maxHp, other.owner.hp+speed+10);
                    }
                }
            }
            
            with(Mine)
            {
                if(ownerPlayer.team != other.owner.team)
                {
                    dir = point_direction(other.x, other.y, x, y);
                    dist = point_distance(other.x, other.y, x, y);
                    angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                    if collision_circle(x,y,5,other.poof,false,true)
                    {
						instance_destroy();
						if stickied other.owner.hp = min(other.owner.maxHp, other.owner.hp+5); 
						else other.owner.hp = min(other.owner.maxHp, other.owner.hp+15); 
                    }
                }
            }
            
            with(Character)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if (collision_circle(x,y,25,other.poof,false,true))
                {
                    //Shoves
                    if (team != other.owner.team)
                    {
                        motion_add(other.owner.aimDirection,
                                   -other.characterBlastStrength*(1-dist/other.blastDistance)*1.3);
                        vspeed -= 2;
                        moveStatus = 3;
                        if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player)
                        {
                            secondToLastDamageDealer = lastDamageDealer;
                            alarm[4] = alarm[3];
                        }
                        alarm[3] = ASSIST_TIME / global.delta_factor;
                        lastDamageDealer = other.ownerPlayer;
                        lastDamageSource = -1;
                    } 
                    //Extinguishes
                    else if (burnIntensity > 0 or burnDuration > 0)
                    {
                        for(i = 0; i < realnumflames; i += 1)
                        {
                            var f;
                            f = instance_create(x + flameArray_x[i], y + flameArray_y[i], Flame);
                            f.direction = other.owner.aimDirection;
                            f.speed = 6.5+random(2.5);
                            f.owner = other.owner;
                            f.ownerPlayer = other.ownerPlayer;
                            f.team = other.owner.team;
                            f.weapon = DAMAGE_SOURCE_FLAMETHROWER;
                            with(f)
                                motion_add(direction, speed);
                        }
                        burnIntensity = 0;
                        burnDuration = 0;
                        burnedBy = -1;
                        afterburnSource = -1;
                    }
                }
            }
            
            with(LooseSheet)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if collision_circle(x,y,25,other.poof,false,true)
                {
                    motion_add(other.owner.aimDirection, other.blastStrength*(1-dist/other.blastDistance) );
                }
            }
            
            with(Gib)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if collision_circle(x,y,25,other.poof,false,true)
                {
                    motion_add(other.owner.aimDirection, other.blastStrength*(1-dist/other.blastDistance) );
                }
            }
            
            //Finish
            justBlast = true;
            readyToBlast=false;
            readyToShoot=false;
            alarm[5]=blastReloadTime / global.delta_factor;
            isRefilling = false;
            alarm[1]=blastReloadTime / global.delta_factor;
            alarm[0]=blastNoFlameTime / global.delta_factor;
            ammoCount -= 40;
        }
    }
');
object_event_add(Transmutator,ev_draw,0,'
    if(owner.taunting)
        exit;
        
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset) + owner.equipmentOffset;
    if (alarm[6] <= 0){
        if (alarm[7] > 0) {
            //if we are not shooting but airblasting/dropping
            if (sprite_index == dropSprite) {
                imageOffset = floor(image_index mod dropAnimLength) + dropAnimLength*owner.team
            }else if (sprite_index == blastSprite){
                imageOffset = floor(image_index mod blastAnimLength) + blastAnimLength*owner.team
            }
        }else{
            //set the sprite to idle
            imageOffset = owner.team;
        }
    }else{
        //We are shooting loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }


    if !owner.player.humiliated draw_sprite_ext(sprite_index,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_white, 1);
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }
');
WEAPON_FROSTBITE = 83;
Frostbite = object_add();
object_set_parent(Frostbite, Weapon);
object_event_add(Frostbite,ev_create,0,'
    xoffset = -3;
    yoffset = 6;
    refireTime = 1;
    event_inherited();
    blastDistance = 150;
    blastAngle = 75;
    blastStrength = 28;
    characterBlastStrength = 15;
    blastNoFlameTime = 15;
    blastReloadTime = 35;
    flareReloadTime = 55;
    alarm[1] = blastReloadTime / global.delta_factor;
    alarm[2] = flareReloadTime / global.delta_factor;
    readyToBlast = false;
    readyToFlare = false;
    justBlast = false;
    
    maxAmmo = 200
    ammoCount = maxAmmo;
    soundLoopTime = 30;
    currentTime = 0;
    
    reloadBuffer = 7;
    isRefilling = false;
    unscopedDamage = 0;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FrostbiteS.png", 2, 1, 0, 8, 2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FrostbiteFS.png", 2, 1, 0, 8, 2);
    blastSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FrostbiteS.png", 2, 1, 0, 8, 2);
    dropSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FrostbiteS.png", 2, 1, 0, 8, 2);
    reloadSprite = -1;

    sprite_index = normalSprite;
    
    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    blastAnimLength = sprite_get_number(blastSprite)/2;
    blastImageSpeed = blastAnimLength/blastNoFlameTime;

    dropTime = 4;
    dropAnimLength = sprite_get_number(dropSprite)/2;
    dropImageSpeed = dropAnimLength/dropTime;
');
object_event_add(Frostbite,ev_destroy,0,'
    {
    loopsoundstop(FlamethrowerSnd);
    }
');
object_event_add(Frostbite,ev_alarm,1,'
    readyToBlast = true;
');
object_event_add(Frostbite,ev_alarm,2,'
    readyToFlare = true;
');
object_event_add(Frostbite,ev_alarm,3,'
    {
    loopsoundstop(FlamethrowerSnd);
    }
');
object_event_add(Frostbite,ev_alarm,5,'
    isRefilling = true;
');
object_event_add(Frostbite,ev_alarm,6,'
    //Override this if we are airblasting
    if (sprite_index != blastSprite) {
        sprite_index = dropSprite;
        image_speed = dropImageSpeed * global.delta_factor;
        image_index = 0;
        alarm[7] = dropTime / global.delta_factor;
    }
');
object_event_add(Frostbite,ev_alarm,7,'
    sprite_index = normalSprite;
    image_speed = 0;
');
object_event_add(Frostbite,ev_step,ev_step_begin,'
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo and isRefilling)
        ammoCount += 1.8 * global.delta_factor;
');
object_event_add(Frostbite,ev_step,ev_step_end,'
    event_inherited();
    if (justBlast)
    {
        justBlast = false;
        //Airblast Recoil Animation
        sprite_index = blastSprite;
        image_index = 0;
        image_speed = blastImageSpeed * global.delta_factor;
        alarm[7] = blastNoFlameTime / global.delta_factor;
        alarm[6] = 0;
    }
');
object_event_add(Frostbite,ev_other,ev_user1,'
    {
        var newx, newy;
        newx = x+lengthdir_x(25,owner.aimDirection);
        newy = y+lengthdir_y(25,owner.aimDirection) + owner.equipmentOffset;
        // prevent sputtering
        if (ammoCount < 1.8)
            ammoCount -= 1.8;
        if (readyToShoot and ammoCount >= 1.8
            and !collision_line_bulletblocking(x,y,newx,newy))
        {
            if(alarm[3] <= 0)
                loopsoundstart(x,y,FlamethrowerSnd);
            else
                loopsoundmaintain(x,y,FlamethrowerSnd);
            alarm[3] = 2 / global.delta_factor;
            
            var shot, calculatedspread;
            randomize();
            calculatedspread = sign(random(2)-1)*power(random(3), 1.8);
            calculatedspread *= 1 - hspeed/owner.basemaxspeed;
            shot = createShot(newx, newy, Snowflake, DAMAGE_SOURCE_FLAMETHROWER, owner.aimDirection+calculatedspread,6.5+random(3.5));
            with(shot)
                motion_add(owner.direction, owner.speed);
            
            justShot=true;
            readyToShoot=false;
            isRefilling = false;
            ammoCount -= 1.8;
            
            if (ammoCount > 0)
                alarm[0] = refireTime / global.delta_factor;
            else
                alarm[0] = reloadBuffer*2 / global.delta_factor;
            alarm[5] = reloadBuffer / global.delta_factor;
        }
    }
');
object_event_add(Frostbite,ev_other,ev_user2,'
    {
        if (readyToBlast && ammoCount >= 40)
        {
            //Base
            playsound(x,y,CompressionBlastSnd);
            poof = instance_create(x+lengthdir_x(25,owner.aimDirection),y+lengthdir_y(25,owner.aimDirection),AirBlastO);
            if (image_xscale == 1)
            {
                poof.image_xscale = 1;
                poof.image_angle = owner.aimDirection;
            }
            else
            {
                poof.image_xscale = -1;
                poof.image_angle = owner.aimDirection+180;
            }
            poof.owner = owner;
            with(poof)
                motion_add(owner.direction, owner.speed * global.delta_factor);
            
            var shot;
            //Flare
            if (owner.keyState & $10 and ammoCount >= 75 and readyToFlare)
            {
                var newx, newy;
                newx = x+lengthdir_x(25,owner.aimDirection);
                newy = y+lengthdir_y(25,owner.aimDirection);
                if !collision_line_bulletblocking(x, y, newx, newy)
                {
                    shot = createShot(newx,newy,Flare, DAMAGE_SOURCE_FLARE, owner.aimDirection, 15);                
                    justShot=true;
                    readyToFlare=false;
                    ammoCount -= 35;
                    alarm[2] = flareReloadTime / global.delta_factor;
                }
            }
            
            with(Character)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if (collision_circle(x,y,25,other.poof,false,true))
                {
                    //Shoves
                    if (team != other.owner.team)
                    {
						motion_add(other.owner.aimDirection, other.characterBlastStrength*(1+(cos(degtorad(angle))/2)));
                        vspeed -= 2;
                        moveStatus = 1;
						damageCharacter(ownerPlayer.object, other.id, (15*(1-dist/other.blastDistance))+15);
                        if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player)
                        {
                            secondToLastDamageDealer = lastDamageDealer;
                            alarm[4] = alarm[3];
                        }
                        alarm[3] = ASSIST_TIME / global.delta_factor;
                        lastDamageDealer = other.ownerPlayer;
                        lastDamageSource = -1;
                    } 
                    //Extinguishes
                    else if (burnIntensity > 0 or burnDuration > 0)
                    {
                        for(i = 0; i < realnumflames; i += 1)
                        {
                            var f;
                            f = instance_create(x + flameArray_x[i], y + flameArray_y[i], Flame);
                            f.direction = other.owner.aimDirection;
                            f.speed = 6.5+random(2.5);
                            f.owner = other.owner;
                            f.ownerPlayer = other.ownerPlayer;
                            f.team = other.owner.team;
                            f.weapon = DAMAGE_SOURCE_FLAMETHROWER;
                            with(f)
                                motion_add(direction, speed);
                        }
                        burnIntensity = 0;
                        burnDuration = 0;
                        burnedBy = -1;
                        afterburnSource = -1;
                    }
                }
            }
            
            with(LooseSheet)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if collision_circle(x,y,25,other.poof,false,true)
                {
                    motion_add(other.owner.aimDirection, other.blastStrength*(1-dist/other.blastDistance) );
                }
            }
            
            with(Gib)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if collision_circle(x,y,25,other.poof,false,true)
                {
                    motion_add(other.owner.aimDirection, other.blastStrength*(1-dist/other.blastDistance) );
                }
            }
            
            //Finish
            justBlast = true;
            readyToBlast=false;
            readyToShoot=false;
            alarm[5]=blastReloadTime / global.delta_factor;
            isRefilling = false;
            alarm[1]=blastReloadTime / global.delta_factor;
            alarm[0]=blastNoFlameTime / global.delta_factor;
            ammoCount -= 40;
        }
    }
');
object_event_add(Frostbite,ev_draw,0,'
    if(owner.taunting)
        exit;
        
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset) + owner.equipmentOffset;
    if (alarm[6] <= 0){
        if (alarm[7] > 0) {
            //if we are not shooting but airblasting/dropping
            if (sprite_index == dropSprite) {
                imageOffset = floor(image_index mod dropAnimLength) + dropAnimLength*owner.team
            }else if (sprite_index == blastSprite){
                imageOffset = floor(image_index mod blastAnimLength) + blastAnimLength*owner.team
            }
        }else{
            //set the sprite to idle
            imageOffset = owner.team;
        }
    }else{
        //We are shooting loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }


    if !owner.player.humiliated draw_sprite_ext(sprite_index,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_white, 1);
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }
');
WEAPON_BACKBURNER = 81; //swapped values
Backburner = object_add();
object_set_parent(Backburner, Weapon);
object_event_add(Backburner,ev_create,0,'
    xoffset = -3;
    yoffset = 6;
    refireTime = 1;
    event_inherited();
    blastDistance = 150;
    blastAngle = 75;
    blastStrength = 28;
    characterBlastStrength = 15;
    blastNoFlameTime = 15;
    blastReloadTime = 35;
    flareReloadTime = 55;
    alarm[1] = blastReloadTime / global.delta_factor;
    alarm[2] = flareReloadTime / global.delta_factor;
    readyToBlast = false;
    readyToFlare = false;
    justBlast = false;
    
    maxAmmo = 200
    ammoCount = maxAmmo;
    soundLoopTime = 30;
    currentTime = 0;
    
    reloadBuffer = 7;
    isRefilling = false;
    unscopedDamage = 0;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BackburnerS.png", 2, 1, 0, 8, 2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BackburnerFS.png", 2, 1, 0, 8, 2);
    blastSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BackburnerS.png", 2, 1, 0, 8, 2);
    dropSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BackburnerS.png", 2, 1, 0, 8, 2);
    reloadSprite = -1;

    sprite_index = normalSprite;
    
    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    blastAnimLength = sprite_get_number(blastSprite)/2;
    blastImageSpeed = blastAnimLength/blastNoFlameTime;

    dropTime = 4;
    dropAnimLength = sprite_get_number(dropSprite)/2;
    dropImageSpeed = dropAnimLength/dropTime;
');
object_event_add(Backburner,ev_destroy,0,'
    {
    loopsoundstop(FlamethrowerSnd);
    }
');
object_event_add(Backburner,ev_alarm,1,'
    readyToBlast = true;
');
object_event_add(Backburner,ev_alarm,2,'
    readyToFlare = true;
');
object_event_add(Backburner,ev_alarm,3,'
    {
    loopsoundstop(FlamethrowerSnd);
    }
');
object_event_add(Backburner,ev_alarm,5,'
    isRefilling = true;
');
object_event_add(Backburner,ev_alarm,6,'
    //Override this if we are airblasting
    if (sprite_index != blastSprite) {
        sprite_index = dropSprite;
        image_speed = dropImageSpeed * global.delta_factor;
        image_index = 0;
        alarm[7] = dropTime / global.delta_factor;
    }
');
object_event_add(Backburner,ev_alarm,7,'
    sprite_index = normalSprite;
    image_speed = 0;
');
object_event_add(Backburner,ev_step,ev_step_begin,'
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo and isRefilling)
        ammoCount += 1.8 * global.delta_factor;
');
object_event_add(Backburner,ev_step,ev_step_end,'
    event_inherited();
    if (justBlast)
    {
        justBlast = false;
        //Airblast Recoil Animation
        sprite_index = blastSprite;
        image_index = 0;
        image_speed = blastImageSpeed * global.delta_factor;
        alarm[7] = blastNoFlameTime / global.delta_factor;
        alarm[6] = 0;
    }
');
object_event_add(Backburner,ev_other,ev_user1,'
    {
        var newx, newy;
        newx = x+lengthdir_x(25,owner.aimDirection);
        newy = y+lengthdir_y(25,owner.aimDirection) + owner.equipmentOffset;
        // prevent sputtering
        if (ammoCount < 1.8)
            ammoCount -= 1.8;
        if (readyToShoot and ammoCount >= 1.8
            and !collision_line_bulletblocking(x,y,newx,newy))
        {
            if(alarm[3] <= 0)
                loopsoundstart(x,y,FlamethrowerSnd);
            else
                loopsoundmaintain(x,y,FlamethrowerSnd);
            alarm[3] = 2 / global.delta_factor;
            
            var shot, calculatedspread;
            randomize();
            calculatedspread = sign(random(2)-1)*power(random(3), 1.8);
            calculatedspread *= 1 - hspeed/owner.basemaxspeed;
            shot = createShot(newx, newy, Flame, DAMAGE_SOURCE_FLAMETHROWER, owner.aimDirection+calculatedspread,6.5+random(3.5));
            with(shot)
                motion_add(owner.direction, owner.speed);
            
            justShot=true;
            readyToShoot=false;
            isRefilling = false;
            ammoCount -= 1.8;
            
            if (ammoCount > 0)
                alarm[0] = refireTime / global.delta_factor;
            else
                alarm[0] = reloadBuffer*2 / global.delta_factor;
            alarm[5] = reloadBuffer / global.delta_factor;
        }
    }
');
object_event_add(Backburner,ev_other,ev_user2,'
    {
        if (readyToBlast && ammoCount >= 40)
        {
            //Base
            playsound(x,y,CompressionBlastSnd);
            poof = instance_create(x+lengthdir_x(25,owner.aimDirection),y+lengthdir_y(25,owner.aimDirection),AirBlastO);
            if (image_xscale == 1)
            {
                poof.image_xscale = 1;
                poof.image_angle = owner.aimDirection;
            }
            else
            {
                poof.image_xscale = -1;
                poof.image_angle = owner.aimDirection+180;
            }
            poof.owner = owner;
            with(poof)
                motion_add(owner.direction, owner.speed * global.delta_factor);
            
            var shot;
            //Flare
            if (owner.keyState & $10 and ammoCount >= 75 and readyToFlare)
            {
                var newx, newy;
                newx = x+lengthdir_x(25,owner.aimDirection);
                newy = y+lengthdir_y(25,owner.aimDirection);
                if !collision_line_bulletblocking(x, y, newx, newy)
                {
                    shot = createShot(newx,newy,Flare, DAMAGE_SOURCE_FLARE, owner.aimDirection, 15);                
                    justShot=true;
                    readyToFlare=false;
                    ammoCount -= 35;
                    alarm[2] = flareReloadTime / global.delta_factor;
                }
            }
                
            //Reflects
            with(Rocket)
            {
                if(ownerPlayer.team != other.owner.team)
                {
                    dir = point_direction(other.x, other.y, x, y);
                    dist = point_distance(other.x, other.y, x, y);
                    angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                    if collision_circle(x,y,5,other.poof,false,true)
                    {
                        ownerPlayer = other.ownerPlayer;
                        team = other.owner.team;
                        weapon = DAMAGE_SOURCE_REFLECTED_ROCKET;
                        hitDamage = 25;
                        explosionDamage = 30;
                        knockback = 8;
                        alarm[1] = 40 / global.delta_factor;
                        alarm[2] = 80 / global.delta_factor;
                        motion_set(other.owner.aimDirection, speed);
                    }
                }
            }
            with(Flare)
            {
                if(ownerPlayer.team != other.owner.team)
                {
                    dir = point_direction(other.x, other.y, x, y);
                    dist = point_distance(other.x, other.y, x, y);
                    angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                    if collision_circle(x,y,5,other.poof,false,true)
                    {
                        ownerPlayer = other.ownerPlayer;
                        team = other.owner.team;
                        weapon = DAMAGE_SOURCE_REFLECTED_FLARE;
                        alarm[0]=40 / global.delta_factor;
                        
                        motion_set(other.owner.aimDirection, speed);
                    }
                }
            }
            
            with(Mine)
            {
                if(ownerPlayer.team != other.owner.team)
                {
                    dir = point_direction(other.x, other.y, x, y);
                    dist = point_distance(other.x, other.y, x, y);
                    angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                    if collision_circle(x,y,5,other.poof,false,true)
                    {
                        motion_set(other.owner.aimDirection, max(speed, other.blastStrength / 3));
                        reflector = other.ownerPlayer;
                        if (stickied)
                        {
                            var dx, dy, l;
                            speed *= 0.65;
                            dy = (place_meeting(x,y-3,Obstacle) > 0);
                            dy -= (place_meeting(x,y+3,Obstacle) > 0);
                            dx = (place_meeting(x-3,y,Obstacle) > 0);
                            dx -= (place_meeting(x+3,y,Obstacle) > 0);
                            l = sqrt(dx*dx+dy*dy);
                            if(l>0)
                            {
                                var normalspeed;
                                dx /= l;
                                dy /= l;
                                normalspeed = dx*hspeed + dy*vspeed;
                                if(normalspeed < 0)
                                {
                                    hspeed -= 2*normalspeed*dx;
                                    vspeed -= 2*normalspeed*dy;
                                }
                            }
                            stickied = false;
                        }
                    }
                }
            }
            
            with(Character)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if (collision_circle(x,y,25,other.poof,false,true))
                {
                    //Shoves
                    if (team != other.owner.team)
                    {
                        motion_add(other.owner.aimDirection,
                                   other.characterBlastStrength*(1-dist/other.blastDistance));
                        vspeed -= 2;
                        moveStatus = 3;
                        if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player)
                        {
                            secondToLastDamageDealer = lastDamageDealer;
                            alarm[4] = alarm[3];
                        }
                        alarm[3] = ASSIST_TIME / global.delta_factor;
                        lastDamageDealer = other.ownerPlayer;
                        lastDamageSource = -1;
                    } 
                    //Extinguishes
                    else if (burnIntensity > 0 or burnDuration > 0)
                    {
                        for(i = 0; i < realnumflames; i += 1)
                        {
                            var f;
                            f = instance_create(x + flameArray_x[i], y + flameArray_y[i], Flame);
                            f.direction = other.owner.aimDirection;
                            f.speed = 6.5+random(2.5);
                            f.owner = other.owner;
                            f.ownerPlayer = other.ownerPlayer;
                            f.team = other.owner.team;
                            f.weapon = DAMAGE_SOURCE_FLAMETHROWER;
                            with(f)
                                motion_add(direction, speed);
                        }
                        burnIntensity = 0;
                        burnDuration = 0;
                        burnedBy = -1;
                        afterburnSource = -1;
                    }
                }
            }
            
            with(LooseSheet)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if collision_circle(x,y,25,other.poof,false,true)
                {
                    motion_add(other.owner.aimDirection, other.blastStrength*(1-dist/other.blastDistance) );
                }
            }
            
            with(Gib)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if collision_circle(x,y,25,other.poof,false,true)
                {
                    motion_add(other.owner.aimDirection, other.blastStrength*(1-dist/other.blastDistance) );
                }
            }
            
            //Finish
            justBlast = true;
            readyToBlast=false;
            readyToShoot=false;
            alarm[5]=blastReloadTime / global.delta_factor;
            isRefilling = false;
            alarm[1]=blastReloadTime / global.delta_factor;
            alarm[0]=blastNoFlameTime / global.delta_factor;
            ammoCount -= 40;
        }
    }
');
object_event_add(Backburner,ev_draw,0,'
    if(owner.taunting)
        exit;
        
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset) + owner.equipmentOffset;
    if (alarm[6] <= 0){
        if (alarm[7] > 0) {
            //if we are not shooting but airblasting/dropping
            if (sprite_index == dropSprite) {
                imageOffset = floor(image_index mod dropAnimLength) + dropAnimLength*owner.team
            }else if (sprite_index == blastSprite){
                imageOffset = floor(image_index mod blastAnimLength) + blastAnimLength*owner.team
            }
        }else{
            //set the sprite to idle
            imageOffset = owner.team;
        }
    }else{
        //We are shooting loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }


    if !owner.player.humiliated draw_sprite_ext(sprite_index,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_white, 1);
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }
');
WEAPON_PYROSHOTGUN = 85;
PyroShotgun = object_add();
object_set_parent(PyroShotgun, Weapon);
object_event_add(PyroShotgun,ev_create,0,'
    xoffset=3;
    yoffset=-3;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    shots = 5;
    weaponGrade = UNIQUE;
    weaponType = SHOTGUN;
    idle=true;
    readyToFlare = false;
    
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PyroShotgunS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PyroShotgunFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PyroShotgunFRS.png", 16, 1, 0, 20, 11);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(PyroShotgun,ev_other,ev_user3,'
    shotSpeed[0] = 4;
    shotSpeed[1] = 11;
    shotDir[0] = 11;
    shotDir[1] = 5;
    event_inherited();
');
WEAPON_FLAREGUN = 86;
Flaregun = object_add();
object_set_parent(Flaregun, Weapon);
object_event_add(Flaregun,ev_create,0,'
    xoffset=5;
    yoffset=-3;
    refireTime=45;
    event_inherited();
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 30;
    reloadBuffer = 45;
    idle=true;
    readyToFlare = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FlareGunS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FlareGunFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\FlareGunFRS.png", 18, 1, 0, 14, 7);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Flaregun,ev_alarm,5,'
    ammoCount = maxAmmo;
');
object_event_add(Flaregun,ev_other,ev_user1,'
    if(readyToShoot && ammoCount >0 && !owner.cloak) {
        ammoCount-=1;
            playsound(x,y,FlaregunSnd);
            var shot;
            if !collision_line(x,y,x+lengthdir_x(15,owner.aimDirection),y+lengthdir_y(15,owner.aimDirection),Obstacle,1,0) and !place_meeting(x+lengthdir_x(15,owner.aimDirection),y+lengthdir_y(15,owner.aimDirection),TeamGate) {
                shot = instance_create(x+lengthdir_x(13,owner.aimDirection),y+lengthdir_y(13,owner.aimDirection),Flare);
                shot.direction=owner.aimDirection;
                shot.speed=15;
                //shot.crit=crit;
                shot.owner=owner;
                shot.ownerPlayer=ownerPlayer;
                shot.team=owner.team;
                shot.weapon=WEAPON_FLAREGUN;
            }
        justShot = true;
        readyToShoot = false;
        alarm[0] = refireTime;
        alarm[5] = reloadBuffer + reloadTime;
    }
');
WEAPON_DETONATOR = 87;
Detonator = object_add();
object_set_parent(Detonator, Weapon);
object_event_add(Detonator,ev_create,0,'
    xoffset=5;
    yoffset=-3;
    refireTime=45;
    event_inherited();
    maxAmmo = 16;
    ammoCount = maxAmmo;
    reloadTime = 540;
    reloadBuffer = 20;
    idle=true;
    readyToFlare = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DetonatorS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DetonatorFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DetonatorFRS.png", 18, 1, 0, 14, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Detonator,ev_alarm,5,'
    ammoCount = maxAmmo;
');
object_event_add(Detonator,ev_other,ev_user1,'
    if(readyToShoot && ammoCount >0 && !owner.cloak) {
        ammoCount-=1;
			playsound(x,y,FlaregunSnd);
            var shot;
            if !collision_line(x,y,x+lengthdir_x(15,owner.aimDirection),y+lengthdir_y(15,owner.aimDirection),Obstacle,1,0) and !place_meeting(x+lengthdir_x(15,owner.aimDirection),y+lengthdir_y(15,owner.aimDirection),TeamGate) {
                shot = instance_create(x+lengthdir_x(13,owner.aimDirection),y+lengthdir_y(13,owner.aimDirection),DetonationFlare);
                shot.direction=owner.aimDirection;
                shot.speed=15;
                //shot.crit=crit;
                shot.owner=owner;
                shot.ownerPlayer=ownerPlayer;
                shot.team=owner.team;
                shot.weapon=WEAPON_DETONATOR;
            }
        justShot = true;
        readyToShoot = false;
        alarm[0] = refireTime;
        alarm[5] = reloadBuffer + reloadTime;
    }
');
object_event_add(Detonator,ev_other,ev_user1,'
    /*
    with(DetonationFlare) {
        if ownerPlayer == other.ownerPlayer {
            show_error("bruh", false);
            event_user(5);
            //explosionDamage = 13;
        }
    }
    */
');
object_event_add(Detonator,ev_other,ev_user2,'
    with(DetonationFlare) {
		if ownerPlayer == other.ownerPlayer {
			event_user(5);
		}
    }
');

WEAPON_NAPALM = 88;
NapalmHand = object_add();
object_set_parent(NapalmHand, Weapon);
object_event_add(NapalmHand,ev_create,0,' //do this later
    xoffset=2;
    yoffset=-2;
    refireTime=18;
    event_inherited();
    maxAmmo = 1
    ammoCount = maxAmmo;
    reloadTime = 240;
    reloadBuffer = 18;
    owner.ammo[114] = -1;
    idle=true;
    readyToFlare = false;
    readyToStab=false;
    isMelee = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NapalmHandS.png", 4, 1, 0, -2, -2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NapalmHandS.png", 4, 1, 0, -2, -2);
    //recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NapalmHandFS.png", 4, 1, 0, 0, 11);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\NapalmHandS.png", 4, 1, 0, -2, -2);

    sprite_index = normalSprite;
    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(NapalmHand,ev_destroy,0,'
    if owner != -1 owner.ammo[114] = alarm[5];
');
object_event_add(NapalmHand,ev_alarm,5,'
    ammoCount = maxAmmo;
    owner.ammo[114] = -1;
');
object_event_add(NapalmHand,ev_step,ev_step_normal,'
    if 1 == 1 image_index = owner.team+2*ammoCount;
    else image_index = 4+ammoCount;

    if !variable_local_exists("ammoCheck") {
        ammoCheck = 1;
        alarm[5] = owner.ammo[114];
    }
');
object_event_add(NapalmHand,ev_other,ev_user0,'
    alarm[0]=refireTime;
    if owner.ammo[114] == -1 alarm[5] = reloadBuffer + reloadTime;
    else alarm[5] = reloadBuffer + owner.ammo[114];
');
object_event_add(NapalmHand,ev_other,ev_user1,'
    if(readyToShoot && !owner.cloak && ammoCount > 0) {
        //with(NapalmGrenade) {
            //if ownerPlayer == other.ownerPlayer instance_destroy(); //Lorgan. Why.
			// so that you cant throw 2 napalm grenades that would be bs
        //}
        ammoCount -= 1;  
        shot = instance_create(x,y + yoffset + 1,NapalmGrenade);
        shot.direction=owner.aimDirection+0 //random(7)-4;
        shot.speed=12.5;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        with(shot) {
            hspeed+=owner.hspeed;
            vspeed+=owner.vspeed;
        }
        justShot=true;
        readyToShoot=false;
        alarm[5] = reloadBuffer + reloadTime;
        alarm[0] = refireTime;
        owner.ammo[114] = -1;
    }
');
object_event_add(NapalmHand,ev_draw,0,'
    if (distance_to_point(view_xview + view_wview/2, view_yview + view_hview/2) > 800)
        exit;

    if (!owner.invisible and !owner.taunting and !owner.player.humiliated)
    {
        if (!owner.cloak)
            image_alpha = power(owner.cloakAlpha, 0.5);
        else
            image_alpha = power(owner.cloakAlpha, 2);
        draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        if (owner.ubered)
        {
            if (owner.team == TEAM_RED)
                ubercolour = c_red;
            else if (owner.team == TEAM_BLUE)
                ubercolour = c_blue;
            draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
        }
    }
');

WEAPON_WRECKER = 89;
Axe = object_add();
object_set_parent(Axe, Weapon);
object_event_add(Axe,ev_create,0,'
    xoffset=6;
    yoffset=-8;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    readyToFlare = false;
    owner.ammo[107] = -1;
    isMelee = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AxeS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AxeFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AxeS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;

');
object_event_add(Axe,ev_destroy,0,'
    with (MeleeMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }

    if owner != -1 owner.ammo[107] = alarm[5];
');
object_event_add(Axe,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = 35;
        shot.weapon=WEAPON_WRECKER;
        //Removed crit thing here
        alarm[2] = 10;
    }
');
object_event_add(Axe,ev_alarm,2,'
    {
    readyToStab = true;
    }
');
object_event_add(Axe,ev_alarm,5,'
    ammoCount = 1;
');
object_event_add(Axe,ev_step,ev_step_normal,'
    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }
');
object_event_add(Axe,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    }
');

global.weapons[WEAPON_FLAMETHROWER] = Flamethrower;
global.name[WEAPON_FLAMETHROWER] = "Flamethrower";
global.weapons[WEAPON_PHLOG] = Phlog;
global.name[WEAPON_PHLOG] = "Phlogistinator (unfinished)";
global.weapons[WEAPON_TRANSMUTATOR] = Transmutator;
global.name[WEAPON_TRANSMUTATOR] = "Transmutator";
global.weapons[WEAPON_FROSTBITE] = Frostbite;
global.name[WEAPON_FROSTBITE] = "Frostbite";
global.weapons[WEAPON_BACKBURNER] = Backburner;
global.name[WEAPON_BACKBURNER] = "Backburner";
global.weapons[WEAPON_PYROSHOTGUN] = PyroShotgun;
global.name[WEAPON_PYROSHOTGUN] = "Shotgun";
global.weapons[WEAPON_FLAREGUN] = Flaregun;
global.name[WEAPON_FLAREGUN] = "Flaregun";
global.weapons[WEAPON_DETONATOR] = Detonator;
global.name[WEAPON_DETONATOR] = "Detonator";
global.weapons[WEAPON_NAPALM] = NapalmHand;
global.name[WEAPON_NAPALM] = "Napalm Grenade (unfinished)";
global.weapons[WEAPON_WRECKER] = Axe;
global.name[WEAPON_WRECKER] = "Homewrecker";

// Quote and Curly
globalvar WEAPON_BLADE, WEAPON_MACHINEGUN;
globalvar Machinegun;
WEAPON_BLADE = 90;
WEAPON_MACHINEGUN = 91;
Machinegun = object_add();
object_set_parent(Machinegun, Weapon);
object_event_add(Machinegun,ev_create,0,'
    xoffset = 4;
    yoffset = -1;
    refireTime = 2;
	bubbleCount = 0;
    event_inherited();
    sndlooping = false;
	maxAmmo = 100;
    ammoCount = maxAmmo;
    reloadBuffer = 15;
    isRefilling = false;
    unscopedDamage = 0;
	
	//C type blades (slightly smaller, slightly faster, standard life)
	bladeRefireTime = 8;
	bladeDelay = 0;
    bladesOut = 0;
    bladeLife = 15;
    maxBlades = 1;
    bladeDamage = 12;

	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinegunS.png", 2, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinegunFS.png", 4, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinegunS.png", 2, 1, 0, 0, 0);

    sprite_index = normalSprite;

    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/2;
');

object_event_add(Machinegun,ev_alarm,5,'
	isRefilling = true;
');

object_event_add(Machinegun,ev_step,ev_step_begin,'
	if (ammoCount < 0)
		ammoCount = 0;
	else if (ammoCount <= maxAmmo and isRefilling)
		ammoCount += 1.5 * global.delta_factor;
	if (ammoCount > maxAmmo)
		ammoCount = maxAmmo;
	if(!readyToShoot and alarm[5] < 25 and !isRefilling)
		alarm[5] += 1;
	bladeDelay = min(max(0, bladeDelay - 1), bladeRefireTime / global.delta_factor);
');

object_event_add(Machinegun,ev_other,ev_user1,'
	if(readyToShoot and ammoCount >= 1)
		{
			playsound(x,y,ShotSnd);
			var shot;
			randomize();
			// repeat(2) {
				shot = instance_create(x+lengthdir_x(12+(random(6)-3),owner.aimDirection),y+lengthdir_y(random(10)-5,owner.aimDirection),MGShot);
				shot.hitDamage=6;
				shot.direction=owner.aimDirection;
				shot.speed=17;
				shot.owner=owner;
				shot.ownerPlayer=ownerPlayer;
				shot.team=owner.team;
				shot.weapon=DAMAGE_SOURCE_BUBBLE;
				shot.hspeed += owner.hspeed;
				shot.alarm[0] = 30 / global.delta_factor;
			// }
			justShot=true;
			readyToShoot=false;
			isRefilling = false;
			ammoCount -= 1;
			
			if (instance_exists(owner) && owner.onground == false) {
				with (owner)
					motion_add(aimDirection+180 mod 360, 1.0);
			}			
			
			alarm[0] = refireTime / global.delta_factor;
			alarm[5] = reloadBuffer / global.delta_factor;
		
		}
');

object_event_add(Machinegun,ev_other,ev_user2,'
	if(readyToShoot && bladesOut < maxBlades && bladeDelay <= 0)
		{
			isRefilling = 0;
			playsound(x,y,BladeSnd);
			var shot;
			randomize();
			shot = createShot(x+lengthdir_x(5, owner.aimDirection), y+lengthdir_y(5, owner.aimDirection), BladeB, DAMAGE_SOURCE_BLADE, owner.aimDirection, 12);
			shot.image_angle = 0;
			shot.alarm[0] = bladeLife / global.delta_factor;
			alarm[0] = refireTime / global.delta_factor;
			bladesOut += 1;
			shot.weapon = DAMAGE_SOURCE_BLADE;
			with(shot)
				hspeed += owner.hspeed;
			justShot = true;
			readyToShoot = false;
		}
');

object_event_add(Machinegun,ev_draw,0,'
	if(owner.taunting or owner.omnomnomnom or owner.player.humiliated)
		exit;
	var imageOffset, xdrawpos, ydrawpos;
	imageOffset = owner.team;
	xdrawpos = round(x+xoffset*image_xscale);
	ydrawpos = round(y+yoffset);
	if (alarm[6] <= 0){
		//set the sprite to idle
		imageOffset = owner.team;
	}else{
		//We are shooting, loop the shoot animation
		imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
	}
	draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,c_white,image_alpha);
	if (owner.ubered) {
		if owner.team == TEAM_RED
			ubercolour = c_red;
		else if owner.team == TEAM_BLUE
			ubercolour = c_blue;
		draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
	}
');


global.weapons[WEAPON_BLADE] = Blade;
global.name[WEAPON_BLADE] = "Blade";
global.weapons[WEAPON_MACHINEGUN] = Machinegun;
global.name[WEAPON_MACHINEGUN] = "Machinegun";

//Misc
globalvar WEAPON_FISTS, WEAPON_HAXXY, WEAPON_JETPACK, WEAPON_AXE, WEAPON_RANDOMOOZER, WEAPON_PREDATOR, WEAPON_SNIPEANATURE, WEAPON_SAXTONHALE;
globalvar Fists, Haxxy, Jetpack, Volcanofragment, Randomoozer, Predator, SnipeANature, SaxtonFist;
//add events for each weapon if you want to do these EXCLUDED
WEAPON_FISTS = 92;
WEAPON_HAXXY = 93;
WEAPON_JETPACK = 94;
WEAPON_AXE = 95;
WEAPON_RANDOMOOZER = 96;
WEAPON_PREDATOR = 97;
WEAPON_SNIPEANATURE = 98;
WEAPON_SAXTONHALE = 99;

global.weapons[WEAPON_FISTS] = Fists;
global.name[WEAPON_FISTS] = "Fists";
global.weapons[WEAPON_HAXXY] = Haxxy;
global.name[WEAPON_HAXXY] = "Haxxy";
global.weapons[WEAPON_JETPACK] = Jetpack; 
global.name[WEAPON_JETPACK] = "Jetpack";
global.weapons[WEAPON_AXE] = Volcanofragment;
global.name[WEAPON_AXE] = "Sharpened Volcano Fragment";
global.weapons[WEAPON_RANDOMOOZER] = Randomoozer;
global.name[WEAPON_RANDOMOOZER] = "Betatester's Boomstick"
global.weapons[WEAPON_PREDATOR] = Predator;
global.name[WEAPON_PREDATOR] = "Predator";
global.weapons[WEAPON_SNIPEANATURE] = SnipeANature;
global.name[WEAPON_SNIPEANATURE] = "Snipe-A-Nature"

global.weapons[WEAPON_SAXTONHALE] = SaxtonFist; 
global.name[WEAPON_SAXTONHALE] = "HAXTON SAAAAAAAAALE";

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