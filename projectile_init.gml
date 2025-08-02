//Some needed things for weapons
globalvar MeleeHitMapSnd, MeleeHitSnd, JarateSnd, CritHitSnd;
MeleeHitMapSnd = sound_add(directory + '/randomizer_sounds/MeleeHitMapSnd.wav', 0, 1);
MeleeHitSnd = sound_add(directory + '/randomizer_sounds/MeleeHitSnd.wav', 0, 1);
JarateSnd = sound_add(directory + '/randomizer_sounds/JarateSnd.wav', 0, 1);
CritHitSnd = sound_add(directory + '/randomizer_sounds/CritHitSnd.wav', 0, 1);
// create RadioBlur here so that It's in the first file callled in plugin.gml
globalvar MeleeMask, RadioBlur, Text, MissS, CritS, MiniCritS;
RadioBlur=object_add();
Text = object_add();
MissS = sprite_add(pluginFilePath + "\randomizer_sprites\MissS.png", 1, 0, 0, 0, 0);
CritS = sprite_add(pluginFilePath + "\randomizer_sprites\CritS.png", 1, 0, 0, 0, 0);
MiniCritS = sprite_add(pluginFilePath + "\randomizer_sprites\MiniCritS.png", 1, 0, 0, 0, 0);
object_set_depth(RadioBlur, 130000);
object_event_add(RadioBlur,ev_create,0,'
	owner=-1;
	image_alpha=0.5;
');
object_event_add(RadioBlur,ev_draw,0,'
	if !variable_local_exists("old_pos") {
		a = 0
		while a < 12 {
			old_pos[a,0] = x;
			old_pos[a,1] = y;  
			a += 1;
		}
	}
	a = 12-1
	while a > 0 {
		old_pos[a,0] = old_pos[a-1,0]
		old_pos[a,1] = old_pos[a-1,1]        
		a -= 1
	}       
	old_pos[0,0] = x
	old_pos[0,1] = y   
    a = 0
	// fatass copy of Character create/draw
    if (owner != -1) {
    	if(owner.player.class == CLASS_QUOTE)
        {
            spriteRun = owner.sprite_index;
            spriteJump = owner.sprite_index;
            spriteStand = owner.sprite_index;
            spriteLeanR = owner.sprite_index;
            spriteLeanL = owner.sprite_index;
            spriteIntel = owner.sprite_index; // its an underlay
        }
        else
        {
            spriteRun = getCharacterSpriteId(owner.player.class, owner.player.team, "Run");
            spriteJump = getCharacterSpriteId(owner.player.class, owner.player.team, "Jump");
            spriteStand = getCharacterSpriteId(owner.player.class, owner.player.team, "Stand");
            spriteLeanR = getCharacterSpriteId(owner.player.class, owner.player.team, "LeanR");
            spriteLeanL = getCharacterSpriteId(owner.player.class, owner.player.team, "LeanL");
            spriteIntel = getCharacterSpriteId(owner.player.class, owner.player.team, "Intel");
        }
    	
    	var sprite, overlayList, noNewAnim, sprite_tilt_left, sprite_tilt_right, overlays_tilt_left, overlays_tilt_right;
    	noNewAnim = owner.player.class == CLASS_QUOTE or owner.sprite_special or owner.player.humiliated;
    	

    	if (owner.zoomed)
    	{
    		if (owner.team == TEAM_RED)
    			sprite = SniperRedCrouchS;
    		else
    			sprite = SniperBlueCrouchS;
    		overlayList = owner.crouchOverlays;
    		owner.animationImage = animationImage mod 2; // sniper crouch only has two frames, avoid overflow
    	}
    	else if (!noNewAnim)
    	{
    		if(!owner.onground)
    		{
    			sprite = spriteJump;
    			overlayList = owner.jumpOverlays;
    		}
    		else
    		{
    			if(owner.hspeed==0)
    			{
    				// set up vars for slope detection
    				//charSetSolids(); i fucked around and found out thanks to bonk
    				if(owner.image_xscale > 0)
    				{
    					sprite_tilt_left = spriteLeanL;
    					sprite_tilt_right = spriteLeanR;
    					overlays_tilt_left = owner.leanLOverlays;
    					overlays_tilt_right = owner.leanROverlays;
    				}
    				else
    				{
    					sprite_tilt_left = spriteLeanR;
    					sprite_tilt_right = spriteLeanL;
    					overlays_tilt_left = owner.leanROverlays;
    					overlays_tilt_right = owner.leanLOverlays;
    				}
    				
    				// default still sprite
    				sprite = spriteStand;
    				overlayList = owner.stillOverlays;
    				
    				{ // detect slopes
    					var openright, openleft;
    					openright = !collision_point_solid(x+6, y+owner.bottom_bound_offset+2) and !collision_point_solid(x+2, y+owner.bottom_bound_offset+2);
    					openleft = !collision_point_solid(x-7, y+owner.bottom_bound_offset+2) and !collision_point_solid(x-3, y+owner.bottom_bound_offset+2);
    					if (openright)
    					{
    						sprite = sprite_tilt_right;
    						overlayList = owner.leanROverlays;
    					}
    					if (openleft)
    					{
    						sprite = sprite_tilt_left;
    						overlayList = owner.leanLOverlays;
    					}
    					if (openright and openleft)
    					{
    						openright = !collision_point_solid(x+owner.right_bound_offset, y+owner.bottom_bound_offset+2);
    						openleft = !collision_point_solid(x-owner.left_bound_offset, y+owner.bottom_bound_offset+2);
    						if (openright)
    						{
    							sprite = sprite_tilt_right;
    							overlayList = owner.leanROverlays;
    						}
    						if (openleft)
    						{
    							sprite = sprite_tilt_left;
    							overlayList = owner.leanLOverlays;
    						}
    					}
    				}
    					
    				//charUnsetSolids();
    			}
    			else
    			{
    				sprite = spriteRun;
    				overlayList = owner.runOverlays;
    				if (owner.player.class == CLASS_HEAVY and abs(owner.hspeed) < 3) // alternative sprite for extremely slow moving heavies
    				{
    					if (team == TEAM_RED)
    					{
    						sprite = HeavyRedWalkS;
    						overlayList = owner.walkOverlays;
    					}
    					else
    					{
    						sprite = HeavyBlueWalkS;
    						overlayList = owner.walkOverlays;
    					}
    				}
    			}
    		}
    	}
    	else
    	{
    		sprite = sprite_index;
    		overlayList = owner.stillOverlays;
    	}

        // create vars independent of owner to use in draw_sprite
        lastSprite = sprite;
        index = floor(owner.animationImage);
        lastScale = owner.image_xscale;
    }

    while a <= 12-1 
    {
        draw_sprite_ext(lastSprite,index,old_pos[a,0],old_pos[a,1],lastScale,1,0,c_white,image_alpha/((a+2)/2));
        a += 1;
    }
');
object_event_add(RadioBlur,ev_step,ev_step_end,'
	if owner != -1 {
		x=owner.x;
		y=owner.y;
	} else {
        /*if (image_alpha/((clone+2)/2) >= 0.02) {
            playsound(x,y,PickupSnd);
            image_alpha -= 0.055 / global.delta_factor; // target the biggest variable for a smoother fade-out
        }*/
		image_alpha -= 0.1 / global.delta_factor;
		if image_alpha <= 0.01 instance_destroy();
	}
');

object_event_add(Text,ev_create,0,'
	vspeed-=0.5;
');
object_event_add(Text,ev_step,ev_step_normal,'
	image_alpha -= 0.05;
	if image_alpha <= 0.1 instance_destroy();
');
MeleeMask = object_add();
object_set_parent(MeleeMask, StabMask);
object_event_add(MeleeMask,ev_create,0,'
    {
        hitDamage = 8;
        alarm[0]=6;
        crit=0;
        hit = 0;
        flameLife = 15;
        burnIncrease = 1;
        durationIncrease = 30;
        sprite_index = StabMaskS;
        visible = false;
        splashHit = false;
        splashAmount = 0;
        pierced = 1;
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
    if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0)
    {
        if(!collision_line(x,y-12,other.x,other.y,Obstacle,true,true)) and (!collision_line(x,y-12,other.x,other.y,TeamGate,true,true) and (!collision_line(x,y-12,other.x,other.y,BulletWall,true,true)))
        {
            //if weapon == WEAPON_WRECKER && other.burnDuration > 0 hitDamage*= 1;
			hitDamage *= (1+0*0.35)*1;
			damageCharacter(ownerPlayer.object, other.id, hitDamage);
			
			if (crit == 1) {
				var text;
				if (ownerPlayer.object.image_xscale == -1)
					text=instance_create(x-20,y-10,Text);
				else
					text=instance_create(x+20,y-10,Text);
				text.sprite_index = CritS;
				playsound(x,y,CritHitSnd);
			} else if (crit == 2) {
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

            with(other) {motion_add(other.owner.aimDirection,3);}

            /*
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
                    alarm[0] = decayDelay;
                }
            }
            */
            /*
            if (weapon == WEAPON_HAXXY && 1 > 1){ 
                if global.isHost{
                    //doEventBallstun(other.player,0); simply no
                    //sendEventBallStun(other.player,0);
					// righ, have this instead
					speed*= 0.55;
                }
            } else if weapon == WEAPON_FISTS or weapon == WEAPON_SAXTONHALE {
                if other.hp <= 0 with(other) {motion_add(other.owner.aimDirection,25);};
            } else if weapon == WEAPON_SHIV {
                //other.bleeding = true; I will maybe add this at another time
                other.alarm[8] = 120;
    //      } else if weapon == WEAPON_BUFFBANNER{
            } else if weapon == WEAPON_OVERDOSE { //ubersaw
                if (owner.loaded1 >= WEAPON_MEDIGUN && owner.loaded1 <= WEAPON_POTION) or (owner.loaded2 >= WEAPON_MEDIGUN && owner.loaded2 <= WEAPON_POTION){
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
                }
            }
            */

            other.timeUnscathed = 0;
            if (other.lastDamageDealer != ownerPlayer && other.lastDamageDealer != other.player)
            {
                other.secondToLastDamageDealer = other.lastDamageDealer;
                other.alarm[4] = other.alarm[3]
            }
            other.alarm[3] = ASSIST_TIME;
            other.lastDamageDealer = ownerPlayer;
            other.lastDamageCrit = 1;
            other.lastDamageSource = weapon;

            var blood;
            if(global.gibLevel > 0)
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
                alarm[0] = 1;
            }
        }
        else {
            alarm[0] = 1;
        }
    }
');
object_event_add(MeleeMask,ev_collision,Sentry,'
    if(other.team != team)
    {
        if(!collision_line(x,y-12,other.x,other.y,Obstacle,true,true)) and (!collision_line(x,y-12,other.x,other.y,TeamGate,true,true) and (!collision_line(x,y-12,other.x,other.y,BulletWall,true,true)))
        {
            //if weapon == WEAPON_WRECKER  hitDamage = 80; //Enough to 1-hit a mini and 2-hit any other
            other.hp -= hitDamage;
            //if weapon == WEAPON_ZAPPER other.hp -= 35;
            other.lastDamageDealer = ownerPlayer;
            other.lastDamageSource = weapon;
            //other.lastDamageCrit = crit;
            playsound(x,y,MeleeHitMapSnd);
            instance_destroy();
        }
        else
            alarm[0] = 1;
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
        other.alarm[0] = other.regenerationBuffer;
        other.isShieldRegenerating = false;
        //allow overkill to be applied directly to the target
        //if weapon == WEAPON_PAINTRAIN {
            other.hp -= hitDamage;
        if (hitDamage > other.shieldHp) {
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