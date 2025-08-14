globalvar MeleeMask;
MeleeMask = object_add();
object_set_parent(MeleeMask, StabMask);
object_event_add(MeleeMask,ev_create,0,'
    {
        hitDamage = 8;
        alarm[0]=6 / global.delta_factor;
        crit=1;
        hit = 0;
        flameLife = 15;
        burnIncrease = 1;
        durationIncrease = 30;
        sprite_index = StabMaskS;
        visible = false;
        splashHit = false;
        splashAmount = 0;
        pierced = 1;
        knockBack = false;
        knockBackForce = 3.2;
    }
');
object_event_add(MeleeMask,ev_destroy,0,'
    event_inherited();
    owner.currentWeapon.smashing = false;
');
object_event_add(MeleeMask,ev_collision,Obstacle,'
    if hit == 0 {
        playsound(x,y,MeleeHitMapSnd);
        hit = 1;
    }
');
object_event_add(MeleeMask,ev_collision,Character,'
    if (ownerPlayer.object == -1) exit;
    if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0)
    {
        if(!collision_line(x,y-12,other.x,other.y,Obstacle,true,true)) and (!collision_line(x,y-12,other.x,other.y,TeamGate,true,true) and (!collision_line(x,y-12,other.x,other.y,BulletWall,true,true)))
        {
            if weapon == WEAPON_WRECKER && other.burnDuration > 0 hitDamage*= 1;
			hitDamage *= (1+0*0.35)*crit;
			damageCharacter(ownerPlayer.object, other.id, hitDamage);
			
			if (crit == 1.43) {
				var text;
				if (ownerPlayer.object.image_xscale == -1)
					text=instance_create(x-20,y-10,Text);
				else
					text=instance_create(x+20,y-10,Text);
				text.sprite_index = CritS;
				playsound(x,y,CritHitSnd);
			} else if (crit == 1.15) {
				var text;
				if (ownerPlayer.object.image_xscale == -1)
					text=instance_create(x-20,y-10,Text);
				else
					text=instance_create(x+20,y-10,Text);
				text.sprite_index = MiniCritS;
			}
			
			playsound(x,y,MeleeHitSnd);
			//other.hp -= hitDamage*(1+0*0.35)*1;
            //if weapon == WEAPON_WRENCH && other.hp <= 0 && instance_exists(owner) owner.nutsNBolts = min(100,owner.nutsNBolts+25);

            with(other) {
                if (!other.knockBack) { motion_add(other.owner.aimDirection,3); } else {
                    motion_add(other.owner.aimDirection,3 * other.knockBackForce+random(5));
                    //if (onground) vspeed -= other.knockBackForce;
                    moveStatus = 4;
                }
            }

            if(!object_is_ancestor(other.object_index, Pyro) && true && weapon = WEAPON_AXE) { //Removed thing here
                with(other) {
                    if (burnDuration < maxDuration) {
                        burnDuration += 30*6; 
                        burnDuration = min(burnDuration, maxDuration);
                    }
                    if (burnIntensity < maxIntensity) {
                        burnIntensity += other.burnIncrease * 3;
                        burnIntensity = min(burnIntensity, maxIntensity);
                    }
                    burnedBy = other.ownerPlayer;
                    afterburnSource = WEAPON_AXE;
                    alarm[0] = decayDelay / global.delta_factor;
                }
            }
            
            if (weapon == WEAPON_HAXXY && 1 > 1){ 
                if global.isHost{
                    //doEventBallstun(other.player,0); simply no
                    //sendEventBallStun(other.player,0);
					// righ, have this instead
					speed *= 0.55;
                }
            } else if weapon == WEAPON_FISTS or weapon == WEAPON_SAXTONHALE {
                if other.hp <= 0 with(other) {motion_add(other.owner.aimDirection,25);};
            } else if weapon == WEAPON_SHIV {
                for(i=0; i<4; i+=1) 
                {
                    if (soakType[i] == bleed) break;
                    if (soakType[i] != bleed) soakType[i] = bleed; // Test later
                }
                other.alarm[8] = 120 / global.delta_factor;
    //      } else if weapon == WEAPON_BUFFBANNER{
            } else if weapon == WEAPON_OVERDOSE { //ubersaw
                /*if (owner.loaded1 >= WEAPON_MEDIGUN && owner.loaded1 <= WEAPON_POTION) or (owner.loaded2 >= WEAPON_MEDIGUN && owner.loaded2 <= WEAPON_POTION){
                    with(owner) {
                        ammo[WEAPON_MEDIGUN] = min(250,ammo[WEAPON_MEDIGUN]+50);
                        ammo[WEAPON_KRITSKRIEG] = min(250,ammo[WEAPON_KRITSKRIEG]+50);
                        ammo[WEAPON_OVERHEALER] = min(250,ammo[WEAPON_OVERHEALER]+50);
                        ammo[WEAPON_QUICKFIX] = min(250,ammo[WEAPON_QUICKFIX]+50);
                        ammo[WEAPON_POTION] = min(250,ammo[WEAPON_POTION]+50);
                        if ammo[WEAPON_MEDIGUN] == 250 or 
                        ammo[WEAPON_KRITSKRIEG] == 250 or 
                        ammo[WEAPON_OVERHEALER] == 250 or 
                        ammo[WEAPON_QUICKFIX] == 250 or 
                        ammo[WEAPON_POTION] == 250 ammo[100] = true;
                    }
                }*/
                // owner.uberCharge = min(250,owner.uberCharge+50);
                // if (owner.uberCharge == 250) canUber = true;
                // todo: replace all that with the single uberCharge call above
            }

            if (other.lastDamageDealer != ownerPlayer && other.lastDamageDealer != other.player)
            {
                other.secondToLastDamageDealer = other.lastDamageDealer;
                other.alarm[4] = other.alarm[3];
            }
            other.alarm[3] = ASSIST_TIME / global.delta_factor;
            other.lastDamageDealer = ownerPlayer;
            other.lastDamageCrit = 1;
            other.lastDamageSource = weapon;

            var blood;
            if(global.gibLevel > 0 && !other.radioactive)
            {
                repeat(10)
                {
                    blood = instance_create(x,y,Blood);
                    blood.direction = direction-180;
                }
            }
            if (!splashHit) {
                instance_destroy(); 
            } else {
                splashAmount -= 1;
                hitDamage -= 13 * pierced;
                pierced += 1;
                if (splashAmount <= 0)
                {
                    splashHit = false;
                }
                alarm[0] = 1 / global.delta_factor;
            }
        }
        else {
            alarm[0] = 1 / global.delta_factor;
        }
    }
');
object_event_add(MeleeMask,ev_collision,Sentry,'
    if(other.team != team)
    {
        if(!collision_line(x,y-12,other.x,other.y,Obstacle,true,true)) and (!collision_line(x,y-12,other.x,other.y,TeamGate,true,true) and (!collision_line(x,y-12,other.x,other.y,BulletWall,true,true)))
        {
            if weapon == WEAPON_WRECKER  hitDamage = 80; //Enough to 1-hit a mini and 2-hit any other
            other.hp -= hitDamage;
            if weapon == WEAPON_ZAPPER other.hp -= 35;
            other.lastDamageDealer = ownerPlayer;
            other.lastDamageSource = weapon;
            other.lastDamageCrit = crit;
            playsound(x,y,MeleeHitMapSnd);
            instance_destroy();
        }
        else
            alarm[0] = 1 / global.delta_factor;
    } else if weapon == WEAPON_WRENCH or weapon == WEAPON_EUREKAEFFECT {
        /*if other.sapped > 0 {
            if global.isHost {
                other.sapped-=2*crit;
                if other.sapped <= 0 {
                    other.sapped = 0;
                    write_ubyte(global.eventBuffer, SAP_TOGGLE);
                    write_ubyte(global.eventBuffer, ds_list_find_index(global.players,other.ownerPlayer));
                }
            }
            playsound(x,y,MeleeHitMapSnd);
        } else if other.level != 3 {
            if other.built == 0 {
                var amount;
                other.buildspeed += 0.25;
                playsound(x,y,MeleeHitMapSnd);
            } else if other.hp < other.maxHp {
                var amount;
                amount = min(other.maxHp-other.hp,10);
                if owner.nutsNBolts >= amount {
                    other.hp += amount;
                    owner.nutsNBolts-=amount;
                } else {
                    other.hp += owner.nutsNBolts;
                    owner.nutsNBolts=0;
                }
                playsound(x,y,MeleeHitMapSnd);
            } else if other.upgraded < 100 && other.level < 2{
                var amount;
                amount = min(100-other.upgraded,20);
                if owner.nutsNBolts >= amount {
                    owner.nutsNBolts-=amount;
                    other.upgraded += amount;
                } else {
                    other.upgraded += owner.nutsNBolts;
                    owner.nutsNBolts=0;
                }
                playsound(x,y,MeleeHitMapSnd);
            } else playsound(x,y,WrenchFailSnd);
        } else playsound(x,y,WrenchFailSnd);
        instance_destroy();*/
    }/* else if weapon == WEAPON_WRECKER && other.sapped > 0 {
        if global.isHost {
            other.sapped-=2*crit;
            if other.sapped <= 0 {
                other.sapped = 0;
                write_ubyte(global.eventBuffer, SAP_TOGGLE);
                write_ubyte(global.eventBuffer, ds_list_find_index(global.players,other.ownerPlayer));
            }
        }
        playsound(x,y,MeleeHitMapSnd);
    }*/
');
object_event_add(MeleeMask,ev_collision,Generator,'
    if (other.team != team) {
        other.alarm[0] = other.regenerationBuffer / global.delta_factor;
        other.isShieldRegenerating = false;
        //allow overkill to be applied directly to the target
        if weapon == WEAPON_PAINTRAIN {
            other.hp -= hitDamage;
        } else if (hitDamage > other.shieldHp) {
            other.hp -= hitDamage - other.shieldHp;
            other.hp -= other.shieldHp * other.shieldResistance;
            other.shieldHp = 0;
        } else {
            other.hp -= hitDamage * other.shieldResistance;
            other.shieldHp -= hitDamage;
        }
        instance_destroy();
    }
');