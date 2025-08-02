globalvar WEAPON_EYELANDER;
WEAPON_EYELANDER = 37;

globalvar Eyelander;
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
	
    weaponGrade = UNIQUE;
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
	event_inherited();
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
            shot.splashHit = true;
            shot.splashAmount = 3;
            shot.knockBack = true;
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
        playsound(x,y,ChargeSnd);
		if (smashing != 1) readyToStab = true;
		//alarm[10] = 100;
    }
');

global.weapons[WEAPON_EYELANDER] = Eyelander;
global.name[WEAPON_EYELANDER] = "Eyelander";
