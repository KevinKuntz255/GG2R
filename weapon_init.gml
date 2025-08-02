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
globalvar SwitchSnd, FlashlightSnd, swingSnd, BallSnd, DirecthitSnd, ManglerChargesnd, LaserShotSnd, BowSnd, ChargeSnd, FlaregunSnd, BuffbannerSnd, CritSnd, ShotSnd;
SwitchSnd = sound_add(directory + '/randomizer_sounds/switchSnd.wav', 0, 1);
FlashlightSnd = sound_add(directory + '/randomizer_sounds/FlashlightSnd.wav', 0, 1);
swingSnd = sound_add(directory + '/randomizer_sounds/swingSnd.wav', 0, 1);
BallSnd = sound_add(directory + '/randomizer_sounds/BallSnd.wav', 0, 1);
DirecthitSnd = sound_add(directory + '/randomizer_sounds/DirecthitSnd.wav', 0, 1);
ManglerChargesnd = sound_add(directory + '/randomizer_sounds/ManglerchargeSnd.wav', 0, 1);
LaserShotSnd = sound_add(directory + '/randomizer_sounds/LaserShotSnd.wav', 0, 1);
BowSnd = sound_add(directory + '/randomizer_sounds/BowSnd.wav', 0, 1);
ChargeSnd = sound_add(directory + '/randomizer_sounds/DetoChargeSnd.wav', 0, 1);
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
	baseDamage=-1; // stops crashing when youre zooming in

    abilityActive = false;
    abilityVisual = "";
    abilityType= -1;

    // weaponGrade for Unique/Stock/Special
    weaponGrade = STOCK;
    // weaponType for each weapon
    weaponType = SHOTGUN;

    damSource = DAMAGE_SOURCE_SHOTGUN;
    // do not name it Dee Mage. do not even comment it. Compilation Error. Game Maker 8 was made by Satan.
	
    isMelee = false;
	
	hasMeter = false; // introducing meters
	meterName = "";
	maxMeter=-1;
	meterCount=-1;
    
    //Scattergun/Shotgun/minigun variables
    shots = 1;
    specialShot = -1;
    shotDamage = -1;
    shotSpeed[0] = -1;
    shotSpeed[1] = -1;
    shotDir[0] = -1;
    shotDir[1] = -1;
    fullReload = false; // reload entire clip

    //Rocket Launcher variables
    rocketSound = RocketSnd; // direct hit specific
    rocketSpeed = -1;
    specialProjectile = -1;  // cow mangler specific

    // Throwable variables
    throwProjectile = -1;
    projectileSpeed = 13;
    randomDir = false;
    projectileDir[0] = 7;
    projectileDir[1] = 4;

    // minigun variables

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
        case LASERGUN:
        case SMG:
            if (ammoCount < maxAmmo)
            {
                if fullReload ammoCount = maxAmmo; else ammoCount += 1;
            }
            if (ammoCount < maxAmmo)
            {
                if variable_local_exists("reloadTime") alarm[5] = reloadTime / global.delta_factor;
                if (reloadSprite != -1) sprite_index = reloadSprite;
                image_index = 0;
                if variable_local_exists("reloadImageSpeed") image_speed = reloadImageSpeed * global.delta_factor;
            }
        break;
        case MINIGUN:
        case FLAMETHROWER:
        case BLADE:
        case MACHINEGUN:
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
        case THROWABLE:
        case CONSUMABLE:
        case MELEE:
            ammoCount = maxAmmo;
            if variable_local_exists("meterCount") meterCount = maxMeter;
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
        case THROWABLE:
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
    switch(weaponType)
    {
        case SHOTGUN:
            if (global.particles == PARTICLES_NORMAL) {
                var shell;
                shell = instance_create(x, y, Shell);
                shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
                shell.image_index = 1;
            }
        break;
        case RIFLE:
            if (global.particles == PARTICLES_NORMAL) {
                var shell;
                shell = instance_create(x, y, Shell);
                shell.direction = owner.aimDirection + (100 + random(30)) * image_xscale;
                shell.hspeed -= 1 * image_xscale;
                shell.vspeed -= 1;
                shell.image_index = 2;
            }
        break;
        case REVOLVER:
            if !variable_local_exists("ejected") break;
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
        break;
        case FLAMETHROWER:
            sprite_index = normalSprite;
            image_speed = 0;
        break;
    }
');
object_event_add(Weapon,ev_step,ev_step_begin,'
    switch(weaponType)
    {
        case MINIGUN:
            if !variable_local_exists("isRefilling") break;
            if (ammoCount < 0)
                ammoCount = 0;
            else if (ammoCount <= maxAmmo and isRefilling)
                ammoCount += 1 * global.delta_factor;
            if(!readyToShoot and alarm[5] < (25 / global.delta_factor) and !isRefilling)
                alarm[5] += 1;
        break;
        case FLAMETHROWER:
            if !variable_local_exists("isRefilling") break;
            if (ammoCount < 0)
                ammoCount = 0;
            else if (ammoCount <= maxAmmo and isRefilling)
                ammoCount += 1.8 * global.delta_factor;
        case RIFLE:
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
        break;
    }
');
object_event_add(Weapon,ev_step,ev_step_normal,'
    switch(weaponType)
    {
        case MELEE:
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
        case THROWABLE:
        case BANNER:
            image_index = owner.team+2*real(ammoCount);
        break;
        case CONSUMABLE:
            image_index = owner.team+2*real(owner.canEat);
        break;
    }
');
object_event_add(Weapon,ev_step,ev_step_end,'
    switch(weaponType)
    {
        case FLAMETHROWER:
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
        break;
        case RIFLE:
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
                    if (shotDir[0] != -1) shot = createShot(shotx, shoty, Shot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(shotDir[0])-shotDir[1]), 12+random(1)); else shot = createShot(shotx, shoty, Shot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(14)-7), 12+random(1));
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
        case FLAREGUN:
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
        break;
        case SMG:
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
                shot.hitDamage = shotDamage;
                shot.weapon=WEAPON_SMG;
                with(shot)
                    hspeed+=owner.hspeed;
                justShot=true;
                readyToShoot=false;
                alarm[0]=refireTime;
                alarm[5] = reloadBuffer + reloadTime;
            }
        break;
        case THROWABLE:
            if(ammoCount >= 1 && readyToShoot) {
                playsound(x,y,swingSnd);
                ammoCount -= max(0, ammoCount-1); 
                shot = instance_create(x,y + yoffset + 1,thrownProjectile);
                if (randomDir) shot.direction=owner.aimDirection+ random(projectileDir[0])-projectileDir[1]; else shot.direction=owner.aimDirection;
                shot.speed=projectileSpeed;
                shot.owner=owner;
                shot.ownerPlayer=ownerPlayer;
                shot.team=owner.team;
                with(shot)
                    hspeed+=owner.hspeed;
                ammoCount = max(0, ammoCount-1);
                
                alarm[5] = reloadBuffer + reloadTime;
                owner.ammo[105] = -1;
                readyToShoot = false;
                alarm[0] = refireTime;
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
        case PISTOL:
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
        case FLASHLIGHT:
            // didnt work when i tested it, made the laser invisible + damage broken
        break;
        case ROCKETLAUNCHER:
            ammoCount = max(0, ammoCount-1);    
            playsound(x,y,rocketSound);
            var oid, newx, newy;
            newx = x+lengthdir_x(20,owner.aimDirection);
            newy = y+lengthdir_y(20,owner.aimDirection);
            if (rocketSpeed != -1) oid = createShot(newx, newy, Rocket, DAMAGE_SOURCE_ROCKETLAUNCHER, owner.aimDirection, rocketSpeed); else oid = createShot(newx, newy, Rocket, DAMAGE_SOURCE_ROCKETLAUNCHER, owner.aimDirection, 13);
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
        break;
        case RIFLE: // thats big.
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
                    if (variable_local_exists("target")) target = hitInstance;
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
                    if(!ubered and !radioactive and team != other.owner.team) {
                        damageCharacter(other.ownerPlayer, id, other.hitDamage);
                        if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player)
                        {
                            secondToLastDamageDealer = lastDamageDealer;
                            alarm[4] = alarm[3]
                        }
                        alarm[3] = ASSIST_TIME / global.delta_factor;
                        lastDamageDealer = other.ownerPlayer;
                        dealFlicker(id);
                        if(global.gibLevel > 0)
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
            break;
        case REVOLVER:
            ammoCount = max(0, ammoCount-1);
            playsound(x,y,RevolverSnd);
            var shot;

            shot = createShot(x,y + yoffset + 1,Shot, DAMAGE_SOURCE_REVOLVER, owner.aimDirection, 21);
            if (shotDamage != -1) shot.hitDamage = shotDamage; else shot.hitDamage = 28;
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
    }
');
// check loadCode for ev_draw

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
