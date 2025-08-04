globalvar WEAPON_EYELANDER;
WEAPON_EYELANDER = 37;

globalvar Eyelander;
Eyelander = object_add();
object_set_parent(Eyelander, MeleeWeapon);

object_event_add(Eyelander,ev_create,0,'
    xoffset=-15;
    yoffset=-40;
    spriteBase = "Eyelander";
	event_inherited();
	maxMines = 8;
    lobbed = 0;

    abilityVisual = "WEAPON BLUR";
    ability = DASH;
    //owner.ability = DASH;

	hasMeter = true;
    hasAbility = true;
	meterName = "CHARGE";
	meterCount = 100;
	maxMeter = 100;
    rechargeMeter = true;
');

object_event_add(Eyelander,ev_destroy,0,'
	event_inherited();
	abilityActive = false;
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
/*
object_event_add(Eyelander,ev_step,ev_step_normal,'
	if (abilityActive) {
        owner.jumpStrength = 0;
        if (owner.moveStatus != 4) meterCount -= 2; else if (owner.moveStatus == 4) meterCount -= 0.8; // lol, I am crazy for this one
        /*if meterCount <= 0 {
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
	
    event_inherited();
');*/

/*
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
		readyToStab = true;
    }
');*/

global.weapons[WEAPON_EYELANDER] = Eyelander;
global.name[WEAPON_EYELANDER] = "Eyelander";
