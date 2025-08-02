//***************alt_weapons******************* 
//the first 5 are primaries and the last 6 are secondaries for the classes
//PS: This was A LOT of work. A LOT.

// WeaponTypes
globalvar KNIFE, MELEE;
KNIFE = 0;
MELEE = 1;

global.weaponTypes = ds_map_create();

ds_map_add(global.weaponTypes, MELEE, MELEE);
ds_map_add(global.weaponTypes, KNIFE, KNIFE);

//Updating this for modern gg2 was a LOT LOT of work

// Sounds
globalvar SwitchSnd, FlashlightSnd, swingSnd, BallSnd, DirecthitSnd, ManglerChargesnd, LaserShotSnd, BowSnd, ChargeSnd1, ChargeSnd2, ChargeSnd3, FlaregunSnd, BuffbannerSnd, CritSnd, ShotSnd;
SwitchSnd = sound_add(directory + '/randomizer_sounds/switchSnd.wav', 0, 1);
swingSnd = sound_add(directory + '/randomizer_sounds/swingSnd.wav', 0, 1);
ChargeSnd1 = sound_add(directory + '/randomizer_sounds/DetoCharge1Snd.wav', 0, 1);
ChargeSnd2 = sound_add(directory + '/randomizer_sounds/DetoCharge2Snd.wav', 0, 1);
ChargeSnd3 = sound_add(directory + '/randomizer_sounds/DetoCharge3Snd.wav', 0, 1);
CritSnd = sound_add(directory + '/randomizer_sounds/CritSnd.wav', 0, 1);
object_event_add(Weapon,ev_create,0,'
    owner.expectedWeaponBytes = 2;
	readyToStab=false;
    t=0;

    // weaponType for each weapon
    weaponType = -1;

    isMelee = false;
	
	hasMeter = false; // introducing meters
	meterName = "";
	maxMeter=-1;
	meterCount=-1;
    
    abilityActive = false;
    abilityVisual = "";

    shotDamage = -1;
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
            if (shotDamage != -1) shot.hitDamage = shotDamage; else shot.hitDamage = 35;
            shot.weapon=DAMAGE_SOURCE_KNIFE;

            alarm[2] = 10;
        break;
    }
');
object_event_add(Weapon,ev_alarm,2,'
    switch(weaponType)
    {
        case MELEE:
            readyToStab = true;
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
    }
');
object_event_add(Weapon,ev_alarm,5,'
    switch(weaponType)
    {
        case MELEE:
            ammoCount = maxAmmo;
        break;
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
object_event_add(Weapon,ev_other,ev_user1,'
    switch(weaponType) {
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
    }
');
// Scout
globalvar Atomizer;
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

    weaponType = MELEE;
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
	if (owner.doublejumpUsed && !owner.tripleJumpUsed){
		owner.doublejumpUsed = false;
        owner.tripleJumpUsed = true;
	}
	if (owner.onground)
		owner.tripleJumpUsed = false;
    event_inherited();
');

// Soldier
globalvar Shovel;
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

    weaponType = MELEE;
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShovelS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShovelFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ShovelS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
	
');
object_event_add(Shovel,ev_destroy,0,'
	owner.runPower = owner.baseRunPower;
	owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
    event_inherited();
');
object_event_add(Shovel,ev_step,ev_step_normal,'
    event_inherited();

    // if (global.altMechanics)
	if (owner.hp != owner.maxHp){
		owner.runPower = owner.baseRunPower + (owner.maxHp + 40) / (owner.hp + 40) * 0.1;
		owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
	} else {
		owner.runPower = owner.baseRunPower;
		owner.basemaxspeed = abs(owner.runPower * owner.baseControl / (owner.baseFriction-1));
	}
');

// Sniper
globalvar Kukri;
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

    weaponType = MELEE;
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

// Demoman
object_event_clear(Mine,ev_destroy,0);
object_event_add(Mine,ev_destroy,0,'
    if(instance_exists(ownerPlayer)){
        if(ownerPlayer.object != -1){
            if(instance_exists(ownerPlayer.object.currentWeapon)){
                if(ownerPlayer.class == CLASS_DEMOMAN){
                    ownerPlayer.object.currentWeapon.lobbed -= 1;
                }
            }
        }
    }
');
object_event_add(Mine,ev_step,ev_step_normal,'
    if(instance_exists(ownerPlayer)){
        if(ownerPlayer.class != CLASS_DEMOMAN or ownerPlayer.team != team){
            instance_destroy();
        }
    }else{
        instance_destroy();
    }
');


object_event_clear(Minegun,ev_destroy,0);
object_event_add(Minegun,ev_destroy,0,'
    with(Mine) {
        if(ownerPlayer == other.ownerPlayer and (ownerPlayer.class != CLASS_DEMOMAN or ownerPlayer.object.hp <= 0)){
            instance_destroy();
        }
    }
');
object_event_clear(Minegun,ev_other,ev_user1);
object_event_add(Minegun,ev_other,ev_user1,'
    var mine_count;
    mine_count = 0;
    with(Mine){
        if(ownerPlayer == other.ownerPlayer){
            mine_count += 1;
        }
    }
    if(readyToShoot and ammoCount >0 and mine_count<maxMines and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');
object_event_clear(Minegun,ev_other,ev_user12);
object_event_add(Minegun,ev_other,ev_user12,'
    event_inherited();
    {
        var mine_count;
        mine_count = 0;
        with(Mine){
            if(ownerPlayer == other.ownerPlayer){
                mine_count += 1;
            }
        }
        write_ubyte(global.serializeBuffer, mine_count);
        with(Mine) {
            if(ownerPlayer == other.ownerPlayer) {
                event_user(12);
            }
        }
    }
');
object_event_clear(StickyCounter,ev_draw,0);
object_event_add(StickyCounter,ev_draw,0,'
    if (global.myself.team == TEAM_RED)
        image_index = 0;
    else
        image_index = 1;

    var xoffset, yoffset, xsize, ysize;
        
    xoffset = view_xview[0];
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(217, 217, 183));
    draw_set_valign(fa_center);
    draw_set_halign(fa_left);
        
    if (global.myself.object != -1 and global.myself.class == CLASS_DEMOMAN)
    {    
        draw_sprite_ext(sprite_index, image_index, xoffset+xsize-65, yoffset+ysize-78, 3, 3, 0, c_white, 1);
        if (instance_exists(global.myself.object.currentWeapon))
        {
            var mine_count;
            mine_count = 0;
            with(Mine){
                if(ownerPlayer == global.myself){
                    mine_count += 1;
                }
            }
            draw_text_transformed(xoffset+xsize-83, yoffset+ysize-76, mine_count, 1.5, 1.5, 0);
            draw_text_transformed(xoffset+xsize-70, yoffset+ysize-76, "/8", 1.5, 1.5, 0);
        }
    }
');

globalvar Eyelander; // my favorite!
Eyelander = object_add();
object_set_parent(Eyelander, Weapon);
object_event_add(Eyelander,ev_create,0,'
    xoffset=-15;
    yoffset=-40;
    refireTime=18;
	event_inherited();
	maxMines = 8;
    lobbed = 0;
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
	
    weaponType = MELEE;

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
    with(Mine) {
        if(ownerPlayer == other.ownerPlayer and (ownerPlayer.class != CLASS_DEMOMAN or ownerPlayer.object.hp <= 0)){
            instance_destroy();
        }
    }
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
        shot.weapon=DAMAGE_SOURCE_KNIFE;
        shot.splashHit = true;
        shot.splashAmount = 3;
        //Removed crit thing here
        alarm[2] = 10;
    }
');
object_event_add(Eyelander,ev_alarm,5,'
    meterCount = 100;
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
                owner.hspeed -= 1.8 + (owner.accel * 0.1);
            } else if (owner.image_xscale == 1) {
                owner.hspeed += 1.8 + (owner.accel * 0.1);
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

object_event_add(Eyelander,ev_other,ev_user2,'
    if (!abilityActive && !owner.cloak && meterCount >= maxMeter) {
        abilityActive = true;
        owner.accel = 0;
        owner.moveStatus = 0;
        // jerry-rigging consistency in charging by makin u slightly jumped
        if (owner.onground) owner.vspeed -= 0.15; else owner.vspeed += 0.5; 
        // as suggested by Cat Al Ghul, start off FAST.
        if (owner.onground) {
            if (owner.image_xscale == -1) {
                    owner.hspeed -= 12;
            } else if (owner.image_xscale == 1) {
                owner.hspeed += 12;
            }
        }
        playsound(x,y,choose(ChargeSnd1, ChargeSnd2,ChargeSnd3));
        if (smashing != 1) readyToStab = true;
    }
');

object_event_add(Eyelander,ev_other,ev_user12,'
    event_inherited();
    {
        var mine_count;
        mine_count = 0;
        with(Mine){
            if(ownerPlayer == other.ownerPlayer){
                mine_count += 1;
            }
        }
        write_ubyte(global.serializeBuffer, mine_count);
        with(Mine) {
            if(ownerPlayer == other.ownerPlayer) {
                event_user(12);
            }
        }
    }
');
object_event_add(Eyelander,ev_other,ev_user13,'
    event_inherited();
    {
        var i, mine;
        receiveCompleteMessage(global.serverSocket, 1, global.deserializeBuffer);
        lobbed = read_ubyte(global.deserializeBuffer);
        
        with(Mine) {
            if(ownerPlayer == other.ownerPlayer) {
                instance_destroy();
            }
        }
        
        for(i=0; i<lobbed; i+=1) {
            mine = instance_create(0,0,Mine);
            mine.owner = owner;
            mine.ownerPlayer = ownerPlayer;
            mine.team = owner.team;
            with(mine) {
                event_user(13);
            }
        }
    }
');

// Medic
globalvar Ubersaw;
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

    weaponType = MELEE;
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

// Engineer
globalvar Wrench;
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
	
	isMelee = true;
    weaponType = MELEE;
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

// Heavy
globalvar KGOB;
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
    isMelee = true;

    weaponType = MELEE;
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


// Spy
globalvar Knife;
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

    weaponType = MELEE;
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
object_event_add(Knife,ev_alarm,1,'
    { 
        shot = instance_create(x,y,MeleeMask);
        shot.direction=owner.aimDirection;
        shot.speed=owner.speed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        shot.hitDamage = damage;
        shot.weapon=DAMAGE_SOURCE_KNIFE;

        alarm[2] = 10;
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
        //stab.weapon = WEAPON_KNIFE;
        stab.golden = golden;
        if owner.stabspeed > 0 {
            owner.stabspeed -= 1;
            stab.animationspeed*=2;
            alarm[3] = 32/2;
        } else alarm[3] = 32;
        readyToStab = false;
    }
');
globalvar Axe;
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

    weaponType = MELEE;
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