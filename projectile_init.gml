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
    if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0)
    {
        if(!collision_line(x,y-12,other.x,other.y,Obstacle,true,true)) and (!collision_line(x,y-12,other.x,other.y,TeamGate,true,true) and (!collision_line(x,y-12,other.x,other.y,BulletWall,true,true)))
        {
            if weapon == WEAPON_WRECKER && other.burnDuration > 0 hitDamage*= 1;
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
                    alarm[0] = decayDelay;
                }
            }
            
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

globalvar Snowflake;
Snowflake = object_add();
object_set_sprite(Snowflake, sprite_add(pluginFilePath + "\randomizer_sprites\SnowflakeS.png", 4, 1, 0, 10, 9));
object_set_parent(Snowflake, BurningProjectile);
object_event_add(Snowflake,ev_create,0,'
    hitDamage = 3.3;
    flameLife = 15;
    burnIncrease = 1;
    durationIncrease = 30;
    afterburnFalloff = true;
    isSnowflake = true;
    penetrateCap = 1;
    event_inherited();
');
object_event_add(Snowflake,ev_draw,0,'
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
');

globalvar DetonationFlare;
DetonationFlare = object_add();
object_set_sprite(DetonationFlare, FlareS);
object_set_parent(DetonationFlare, Flare);
object_event_add(DetonationFlare,ev_create,0,'
    explosionDamage = 20;
    knockback = 5;
    flameLife = 40;
    burnIncrease = 8;
    durationIncrease = 60;
    afterburnFalloff = false;

    blastRadius = 30;
    exploded = false;
    reflector = noone;
    event_inherited();
');
object_event_add(DetonationFlare,ev_collision,Character,'
    if team != other.team event_user(5);
');
object_event_add(DetonationFlare,ev_collision,Sentry,'
    if team != other.team event_user(5);
');
object_event_add(DetonationFlare,ev_collision,Generator,'
    if team != other.team event_user(5);
');
object_event_add(DetonationFlare,ev_other,ev_user5,'
    {
        if(exploded == true) {
            exit;
        } else {
            exploded = true;
        }
        instance_create(x,y,Explosion);
        playsound(x,y,ExplosionSnd);
        
        with (Character) {
            if (distance_to_object(other) < other.blastRadius and !(team == other.team and id != other.ownerPlayer.object and place_meeting(x, y+1, Obstacle)))
            {
                var rdir, vectorfactor;
                rdir = point_direction(other.x,other.y,x,y);
                vectorfactor = point_distance(0, 0, power(sin(degtorad(rdir)), 2), power(cos(degtorad(rdir)), 2));
                motion_add(rdir, min(15, other.knockback-other.knockback*(distance_to_object(other)/other.blastRadius)) * vectorfactor);
                if(other.team != team or id==other.ownerPlayer.object) && !ubered and hp > 0 && true
                {
                    bonus = 1;
                    if burnDuration > 0 {
                        //if other.crit == 1 bonus = MINICRIT_FACTOR;
                    }
                    if(!object_is_ancestor(object_index, Pyro) && true) {
                        if (burnDuration < maxDuration) {
                            burnDuration += other.durationIncrease; 
                            burnDuration = min(burnDuration, maxDuration);
                        }
                        if (burnIntensity < maxIntensity) {
                            burnIntensity += other.burnIncrease;
                            burnIntensity = min(burnIntensity, maxIntensity);
                        }
                        burnedBy = other.ownerPlayer;
                        afterburnSource = WEAPON_DETONATOR;
                        alarm[0] = decayDelay;
                    }
					if (player != other.ownerPlayer) damageCharacter(ownerPlayer.object, other.id, other.explosionDamage*sqr((1-(distance_to_object(other)/other.blastRadius)))*(1+0*0.35)*1*bonus);
					else if (player == other.ownerPlayer)
						damageCharacter(ownerPlayer.object, other.id, 10*sqr((1-(distance_to_object(other)/other.blastRadius)))*(1+0*0.35)*1);
                    
					//if true hp -= other.explosionDamage*sqr((1-(distance_to_object(other)/other.blastRadius)))*(1+0*0.35)*1*bonus;
                    //if player == other.ownerPlayer hp-= 10*sqr((1-(distance_to_object(other)/other.blastRadius)))*(1+0*0.35)*1;
                    
					timeUnscathed = 0;
                    if (id == other.ownerPlayer.object and lastDamageDealer != -1 and lastDamageDealer != other.ownerPlayer and other.reflector == noone)
                    {
                        lastDamageSource = DAMAGE_SOURCE_FINISHED_OFF_GIB;
                    }
                    else 
                    {
                        if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player and other.reflector != lastDamageDealer)
                        {
                            secondToLastDamageDealer = lastDamageDealer;
                            alarm[4] = alarm[3]
                        }
                        if (other.ownerPlayer != id or (other.reflector != noone and other.ownerPlayer == id))
                            alarm[3] = ASSIST_TIME;
                        lastDamageDealer = other.ownerPlayer;
                        lastDamageSource = other.weapon;
                        //lastDamageCrit = other.crit;
                        if (id==other.ownerPlayer.object and other.reflector != noone)
                        {
                            lastDamageDealer = other.reflector;
                            lastDamageSource = WEAPON_REFLECTED_FLARE;
                        }
                    }
                    if(global.gibLevel > 0 && !other.radioactive)
                    {
                        repeat(3)
                        {
                            var blood;
                            blood = instance_create(x,y,Blood);
                            blood.direction = point_direction(other.x,other.y,x,y)-180;
                        }
                    }
                    if (id==other.ownerPlayer.object)
                    {
                        moveStatus = 1;
                    }
                    else if (other.team == team)
                    {
                        moveStatus = 2;
                        vspeed*=0.8;
                    }
                    else
                    {
                        moveStatus = 4;
                        vspeed*=0.8
                    }
                } else if false {
                    var text;
                    text=instance_create(x,y,Text);
                    text=sprite_index = MissS;
                }
                cloakAlpha = min(cloakAlpha + 0.2, 1);
            }
        }

        
        with (Sentry){
            if (distance_to_object(other) < other.blastRadius) && (team != other.team) { 
            var thp;
            thp = other.explosionDamage*sqr((1-(distance_to_object(other)/other.blastRadius)))*1;
            if(currentWeapon > -1 and humiliated = 0){if(currentWeapon.wrangled) thp /= 2}
            hp -= thp
            //hp -= other.explosionDamage*sqr((1-(distance_to_object(other)/other.blastRadius)))*other.crit;
            lastDamageDealer = other.ownerPlayer;
            lastDamageSource = other.weapon;
            lastDamageCrit = 1;
            }   
        }    
         
         with (Generator){
            if (distance_to_object(other) < other.blastRadius) && (team != other.team) { 
                alarm[0] = regenerationBuffer;
                isShieldRegenerating = false;
                //allow overkill to be applied directly to the target
                var hitDamage;
                hitDamage = other.explosionDamage*sqr((1-(distance_to_object(other)/other.blastRadius)))*1;
                if (hitDamage > shieldHp) {
                    hp -= hitDamage - shieldHp;
                    hp -= shieldHp * shieldResistance;
                    shieldHp = 0;
                } else {
                    hp -= hitDamage * shieldResistance;
                    shieldHp -= hitDamage;
                }
            }   
        }
        
        with (DeadGuy) {
            if (distance_to_object(other) < other.blastRadius){
                motion_add(point_direction(other.x,other.y,x,y),10-10*(distance_to_object(other)/other.blastRadius));
            }
        }
         
        with (Gib) {
            if (distance_to_object(other) < other.blastRadius){
                motion_add(point_direction(other.x,other.y,x,y),15-15*(distance_to_object(other)/other.blastRadius));
                rotspeed=random(151)-75;
            }
        }
        
        with(LooseSheet) {
            if (distance_to_object(other) < other.blastRadius){
                motion_add(point_direction(other.x,other.y,x,y),10-10*(distance_to_object(other)/other.blastRadius));
            }
        }

        /*with(StickyMine) {
            if (distance_to_object(other) < other.blastRadius) and (other.team == team){
                event_user(2);
            }
        }*/    
        
        instance_destroy();
    }
');
object_event_add(DetonationFlare,ev_draw,0,'
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, direction, c_white, 1);
');

globalvar SapAnimation;
SapAnimation = object_add();
globalvar SpySapRedS, SpySapBlueS;
SpySapRedS = sprite_add(pluginFilePath + "\randomizer_sprites\SpySapRedS.png", 7, 1, 0, 28, 40);
SpySapBlueS = sprite_add(pluginFilePath + "\randomizer_sprites\SpySapBlueS.png", 7, 1, 0, 28, 40);
object_event_add(SapAnimation,ev_create,0,'
    done = false;
    offset=0;
    image_speed = 0;
    alarm[0]=5;
    alpha=0.01;
');
object_event_add(SapAnimation,ev_destroy,0,'
    // Do not re-allow movement if there is another StabAnim running for the same player
    with(SapAnimation)
        if(id != other.id and owner == other.owner)
            exit;

    owner.runPower = 1.08;
    owner.jumpStrength = 8;
    owner.stabbing = 0;
');
object_event_add(SapAnimation,ev_alarm,0,'
    image_speed=0.45;
');
object_event_add(SapAnimation,ev_step,ev_step_normal,'
    if direction >= 90 && direction <=270{ 
        image_xscale=-1;
    }else{ 
        image_xscale = 1;
    } 

    if team==TEAM_RED sprite_index=SpySapRedS;
    else sprite_index=SpySapBlueS;

    //alarm[0] = 43;
    x=owner.x;
    y=owner.y;

    if image_index >= 6 {
        done=1;
        image_speed=0;
    }

    if(not done) {
        if(alpha<0.99) {
            alpha = power(alpha,0.7);
        } else {
            alpha = 0.99;
        }
    } else {
        if(alpha>0.01) {
            alpha = power(alpha,1/0.7);
        } else {

            instance_destroy();
        }
    }
');
object_event_add(SapAnimation,ev_step,ev_step_end,'
    // Make self invisible if behind enemy
    visible = !owner.invisible;
');
object_event_add(SapAnimation,ev_draw,0,'
    if team == TEAM_RED ubercolour = c_red;
    if team == TEAM_BLUE ubercolour = c_blue;
    draw_sprite_ext(sprite_index,image_index,owner.x,owner.y,image_xscale,image_yscale,0,c_white,alpha);
    if owner.ubered == 1 draw_sprite_ext(sprite_index,image_index,owner.x,owner.y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
');

globalvar SapMask;
SapMask = object_add();
object_set_parent(SapMask, StabMask);
object_event_add(SapMask,ev_create,0,'
    {
        hitDamage = 8;
        alarm[0]=6;
        playsound(x,y,KnifeSnd)
    }
');
object_event_add(SapMask,ev_collision,Character,'');
object_event_add(SapMask,ev_collision,Sentry,'
    if(other.team != team)
    {
        if(!collision_line(x,y-12,other.x,other.y,Obstacle,true,true)) and (!collision_line(x,y-12,other.x,other.y,TeamGate,true,true) and (!collision_line(x,y-12,other.x,other.y,BulletWall,true,true)))
        {
            if global.isHost {
                other.sapped = 4;
                write_ubyte(global.eventBuffer, SAP_TOGGLE);
                write_ubyte(global.eventBuffer, ds_list_find_index(global.players,other.ownerPlayer));
            }
            //if owner.weapon_index == WEAPON_DIAMONDBACK owner.sapCrits+=1;
            other.lastDamageDealer = ownerPlayer;
            other.lastDamageSource = weapon;
            if other.ownerPlayer.object != -1 && other.ownerPlayer == global.myself {
                write_ubyte(global.serverSocket, CHAT_BUBBLE);
                write_ubyte(global.serverSocket, 61);
            }
            instance_destroy();
        }
        else
            alarm[0] = 1;
    }
');
object_event_add(SapMask,ev_collision,ControlPointSetupGate,'
    if (global.setupTimer > 0)
        instance_destroy();
');
object_event_add(SapMask,ev_collision,Generator,'
    if (other.team != team) {
        other.alarm[0] = other.regenerationBuffer;
        other.isShieldRegenerating = false;
        //allow overkill to be applied directly to the target
        if (hitDamage/2 > other.shieldHp) {
            other.hp -= hitDamage/2 - other.shieldHp;
            other.hp -= other.shieldHp * other.shieldResistance;
            other.shieldHp = 0;
        } else {
            other.hp -= hitDamage/2 * other.shieldResistance;
            other.shieldHp -= hitDamage/2;
        }
        instance_destroy();
    }
');

globalvar Arrow;
Arrow = object_add();
globalvar ArrowS;
ArrowS = sprite_add(pluginFilePath + "\randomizer_sprites\ArrowS.png", 4, 1, 0, 23, 3);
object_set_sprite(Arrow, ArrowS);
object_set_parent(Arrow, Shot);
object_event_add(Arrow,ev_create,0,'
    {
        hitDamage = 6;
        
        lifetime = 100;
        alarm[0] = lifetime;
        originx=x;
        originy=y;
        used=0;
        attached=-1;
        xoffset=0;
        yoffset=0;
        dir=0;
        burning = false;
        scale=1;
        helper = -1;
        burnIncrease = 1;
        durationIncrease = 30;
        afterburnFalloff = false;
        
        if instance_number(Arrow) > 20 with(Arrow) {
            if attached != -1 {
                instance_destroy();
                break;
            }
        }
    }
');
object_event_add(Arrow,ev_alarm,0,'
    if attached == -1 {
        instance_destroy();
    }
');
object_event_add(Arrow,ev_step,ev_step_normal,'
    {
        if attached == -1 {
        vspeed+=1.5/speed;
        if(global.particles != PARTICLES_OFF) && attached == -1 {
            //We do not want it to be almost invisible if its still active, so
            //we have it as if 0.3 is its lower limit
            image_alpha = (alarm[0]/lifetime)/2+0.5;
        }
        image_angle=direction;
        }
    }
');
object_event_add(Arrow,ev_step,ev_step_end,'
    if attached != -1 {
        if instance_exists(attached) {
            x=round(attached.x)+xoffset*attached.image_xscale*scale;
            y=round(attached.y)+yoffset;
            image_xscale=attached.image_xscale*scale;
            image_angle=dir*attached.image_xscale*scale;
        } else  instance_destroy();
    }
');
object_event_add(Arrow,ev_collision,Obstacle,'
    if attached == -1 {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(Arrow,ev_collision,Character,'
    if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0 && attached == -1) {
        if false {
            var text;
            text=instance_create(x,y,Text);
            text.sprite_index = MissS
            instance_destroy();
            exit;
        }
        if burning >= 1 && true {
            with(other) {
                if(!object_is_ancestor(object_index, Pyro) && true) {
                    if (burnDuration < maxDuration) {
                        burnDuration += 30*6; 
                        burnDuration = min(burnDuration, maxDuration);
                    }
                    if (burnIntensity < maxIntensity) {
                        burnIntensity += other.burnIncrease * 3;
                        burnIntensity = min(burnIntensity, maxIntensity);
                    }
                    burnedBy = other.helper;
                    afterburnSource = WEAPON_FIREARROW;
                    alarm[0] = decayDelay;
                }
            }
        }

            if true other.hp -= hitDamage*(speed/2.55)*(1+0*0.35)*1+burning*8;
            //shot.speed=10+(bonus/10)*2.2; < Can not find bonus
            attached = other.id;
            xoffset=x-other.x;
            yoffset=y-other.y;
            alarm[0]=-1;
            speed=0;
            dir = direction;
            scale=image_xscale*other.image_xscale;
            depth=1;
            other.timeUnscathed = 0;
            if !burning {
                if (other.lastDamageDealer != ownerPlayer && other.lastDamageDealer != other.player){
                    other.secondToLastDamageDealer = other.lastDamageDealer;
                    other.alarm[4] = other.alarm[3]
                }
                other.alarm[3] = ASSIST_TIME;
            } else {
                other.secondToLastDamageDealer = helper;
                other.alarm[4] = other.alarm[3]
                other.alarm[3] = ASSIST_TIME;
            }
            other.lastDamageDealer = ownerPlayer;
            other.lastDamageSource = weapon;
            //other.lastDamageCrit = crit;
            var blood;
            if(global.gibLevel > 0 && !other.radioactive){
                blood = instance_create(x,y,Blood);
                blood.direction = direction-180;
                }
            
            with(other) {
                motion_add(other.direction, other.speed*0.2);
                cloakAlpha = min(cloakAlpha + 0.3, 1);    
                }
        }
');
object_event_add(Arrow,ev_collision,TeamGate,'
    if attached == -1 {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(Arrow,ev_collision,Sentry,'
    if(other.team != team) && attached == -1 {
        var thp;
        thp = hitDamage*1*(speed/2.55)+burning*8;
        if(other.currentWeapon > -1 and other.humiliated = 0){if(false) thp /= 2}
        other.hp -= thp
        // other.hp -= hitDamage*crit*(speed/2.55)+burning*8;
    //new stuff
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        //other.lastDamageCrit = crit;
    //end new stuff
        instance_destroy();
        }
');
object_event_add(Arrow,ev_collision,Bubble,'
    if(team != other.team) && attached == -1
        instance_destroy();
');
object_event_add(Arrow,ev_collision,BulletWall,'
    if attached == -1 {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(Arrow,ev_collision,ControlPointSetupGate,'
    if global.setupTimer >0 && attached = -1{
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(Arrow,ev_collision,Generator,'
    if(other.team != team && attached = -1) {
        other.alarm[0] = other.regenerationBuffer;
        other.isShieldRegenerating = false;
        //allow overkill to be applied directly to the target
        if (hitDamage*speed/2.5 > other.shieldHp) {
            other.hp -= hitDamage*speed/2.5 - other.shieldHp;
            other.hp -= other.shieldHp * other.shieldResistance;
            other.shieldHp = 0;
        } else {
            other.hp -= hitDamage*speed/2.5 * other.shieldResistance;
            other.shieldHp -= hitDamage*speed/2.5;
        }
        instance_destroy();
    }
');
object_event_add(Arrow,ev_draw,0,'
    if 1 > 1 offset = 2
    else offset = 0;

    if attached != -1 && instance_exists(attached) {
        if !attached.invisible draw_sprite_ext(sprite_index,team+offset,x,y,image_xscale,1,image_angle,c_white,attached.cloakAlpha);
    } else if global.particles == PARTICLES_NORMAL {
        if !variable_local_exists("old_pos") {
            a = 0
            while a < 10 {
                old_pos[a,0] = x;
                old_pos[a,1] = y;  
                a += 1;
            }
        }
        a = 10-1
        while a > 0 {
            old_pos[a,0] = old_pos[a-1,0]
            old_pos[a,1] = old_pos[a-1,1]        
            a -= 1
        }      
        
        if 1 > 1 {
            if team == TEAM_RED color = c_orange;
            else color = c_aqua;
        } else {
            if team == TEAM_RED color = c_red;
            else color = c_blue;
        }
         
        old_pos[0,0] = x
        old_pos[0,1] = y   
            a = 0
            while a < 10-1 {
                draw_set_alpha(0.2)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]-2, old_pos[a+1,0], old_pos[a+1,1]-2, 1,color,color);
                draw_set_alpha(0.4)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]-1, old_pos[a+1,0], old_pos[a+1,1]-1, 1,color,color);
                draw_set_alpha(0.6)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]-0, old_pos[a+1,0], old_pos[a+1,1]-0, 1,color,color);
                draw_line_width_color(old_pos[a,0], old_pos[a,1]+1, old_pos[a+1,0], old_pos[a+1,1] +1, 1,color,color);
                draw_set_alpha(0.4)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]+2, old_pos[a+1,0], old_pos[a+1,1] +2, 1,color,color);
                draw_set_alpha(0.2)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]+3, old_pos[a+1,0], old_pos[a+1,1] +3, 1,color,color);
            a += 1;
        }   
    draw_sprite_ext(sprite_index,team,x,y,image_xscale,1,image_angle,c_white,1);
    } else draw_sprite_ext(sprite_index,team,x,y,image_xscale,1,image_angle,c_white,1);

    if burning {
        for(i = 0; i < 2; i += 1)
        {
            draw_sprite_ext(FlameS, random(3), x + i*2, y+i*2, 1, 1, 0, c_white, 0.5);
        }
    } 
');

globalvar LaserShot;
LaserShot = object_add();
globalvar LaserShotS;
LaserShotS = sprite_add(pluginFilePath + "\randomizer_sprites\LaserShotS.png", 4, 1, 0, 19, 5);
object_set_sprite(LaserShot, LaserShotS);
object_set_parent(LaserShot, Shot);
object_event_add(LaserShot,ev_create,0,'
    {
        hitDamage = 16;
        lifetime = 40;
        alarm[0] = lifetime;
        originx=x;
        originy=y;
        used=false;
    }
');
object_event_add(LaserShot,ev_alarm,0,'
    instance_destroy();
');
object_event_add(LaserShot,ev_step,ev_step_normal,'
    {
        //vspeed+=0.1;
        if(global.particles != PARTICLES_OFF) {
            //We do not want it to be almost invisible if its still active, so
            //we have it as if 0.3 is its lower limit
            image_alpha = (alarm[0]/lifetime)/2+0.5;
        }
        image_angle=direction;
    }
');
object_event_add(LaserShot,ev_collision,Obstacle,'
    {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(LaserShot,ev_collision,Character,'
        if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0) {
        if false {
            var text;
            text=instance_create(x,y,Text);
            text.sprite_index = MissS
            exit;
        }
            if weapon == WEAPON_POMSON {
                if !used {
                    used = true;
                    with(other) {
                        if (loaded1 >= WEAPON_MEDIGUN && loaded1 <= WEAPON_POTION) or (loaded2 >= WEAPON_MEDIGUN && loaded2 <= WEAPON_POTION){
                            ammo[WEAPON_MEDIGUN] = max(0,ammo[WEAPON_MEDIGUN]-17.5);
                            ammo[WEAPON_KRITSKRIEG] = max(0,ammo[WEAPON_KRITSKRIEG]-17.5);
                            ammo[WEAPON_OVERHEALER] = max(0,ammo[WEAPON_OVERHEALER]-17.5);
                            ammo[WEAPON_QUICKFIX] = max(0,ammo[WEAPON_QUICKFIX]-17.5);
                            ammo[WEAPON_POTION] = max(0,ammo[WEAPON_POTION]-17.5);
                            ammo[100] = 0;
                        } else if cloak cloakAlpha = 1;
                        else other.used = 0;
                        if (weapon_index >= WEAPON_MEDIGUN && weapon_index <= WEAPON_POTION) {
                            //currentWeapon.ammoCount = max0,currentWeapon.ammoCount-140);
                            currentWeapon.uberCharge =  max(0,currentWeapon.uberCharge-140);
                            currentWeapon.uberReady = false;
                        }
                    }
                }
            }
			hitDamage *= (1+0*0.35)*1;
            damageCharacter(ownerPlayer, other.id, hitDamage);
            other.timeUnscathed = 0;
            if (other.lastDamageDealer != ownerPlayer && other.lastDamageDealer != other.player){
                other.secondToLastDamageDealer = other.lastDamageDealer;
                other.alarm[4] = other.alarm[3]
            }
            other.alarm[3] = ASSIST_TIME;
            other.lastDamageDealer = ownerPlayer;
            other.lastDamageSource = weapon;
            var blood;
            if(global.gibLevel > 0 && !other.radioactive){
                blood = instance_create(x,y,Blood);
                blood.direction = direction-180;
                }
            
            with(other) {
                motion_add(other.direction, other.speed*0.03);
                cloakAlpha = min(cloakAlpha + 0.1, 1);    
                }
        }
');
object_event_add(LaserShot,ev_collision,TeamGate,'
    {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(LaserShot,ev_collision,Sentry,'
    if(other.team != team) {
        /* FALL OFF
        if (distance_to_point(originx,originy)<=(maxdist/2)){
                    hitDamage = ((0.25*baseDamage)*((0.5*maxdist - distance_to_point(originx,originy))/(0.5*maxdist)))+baseDamage;
                    }
                    else hitDamage = (((maxdist - distance_to_point(originx,originy))/(maxdist/2))*(0.75*baseDamage))+(0.25*baseDamage);
                    */
        var thp;
        thp = hitDamage*(1+0*0.35)*1;
        if(other.currentWeapon > -1 and other.humiliated = 0){if(other.currentWeapon.wrangled) thp /= 2}
        other.hp -= thp
            //other.hp -= hitDamage*(1+other.pissed*0.35)*crit*0.2;
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        }
');
object_event_add(LaserShot,ev_collision,Bubble,'
    if(team != other.team)
        instance_destroy();
');
object_event_add(LaserShot,ev_collision,BulletWall,'
    {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(LaserShot,ev_collision,ControlPointSetupGate,'
    if global.setupTimer >0 {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(LaserShot,ev_collision,Generator,'
    if(other.team != team) {
        other.alarm[0] = other.regenerationBuffer;
        other.isShieldRegenerating = false;
        //allow overkill to be applied directly to the target
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
object_event_add(LaserShot,ev_draw,0,'
    if 1 > 1 offset = 2
    else offset = 0;

    draw_sprite_ext(sprite_index,team+offset,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha);
');

globalvar FANShot;
FANShot = object_add();
object_set_sprite(FANShot, ShotS);
object_set_parent(FANShot, Shot);
object_event_add(FANShot,ev_create,0,'
    {
        hitDamage = 4;
        lifetime = 40;
        alarm[0] = lifetime / global.delta_factor;
        originx = x;
        originy = y;
        
        // Controls whether this bullet penetrates bubbles or not
        // Also controls whether this bullet destroys friendly bubbles
        perseverant = choose(0, 0, 1); // 1/3 chance
    }
');
object_event_add(FANShot,ev_alarm,0,'
    instance_destroy();
');
object_event_add(FANShot,ev_collision,Character,'
    gunSetSolids();
    if (!place_free(x, y)) 
    {
        instance_destroy();
        gunUnsetSolids();
        exit;
    }
    gunUnsetSolids();

    if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0 && !other.radioactive)
    {
        damageCharacter(ownerPlayer, other.id, hitDamage);
        if (other.lastDamageDealer != ownerPlayer and other.lastDamageDealer != other.player)
        {
            other.secondToLastDamageDealer = other.lastDamageDealer;
            other.alarm[4] = other.alarm[3]
        }
        other.alarm[3] = ASSIST_TIME / global.delta_factor;
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        
        var blood;
        if(global.gibLevel > 0)
        {
            blood = instance_create(x,y,Blood);
            blood.direction = direction-180;
        }
        dealFlicker(other.id);
        with(other)
        {
			motion_add(other.direction, other.speed*0.1);
			if (!onground) { // make em fly if theyre off ground
				//motion_add(other.direction, other.speed*0.2);
				other.moveStatus = 3;
			} else {
				
			}
		}
        instance_destroy();
    }
');

globalvar Sandvich;
Sandvich = object_add();
object_set_sprite(Sandvich, sprite_add(pluginFilePath + "\randomizer_sprites\Sandvich2S.png", 7, 1, 0, 8, 6));
object_set_parent(Sandvich, Gib);
object_event_add(Sandvich,ev_create,0,'
    image_speed = 0.2;
    bloodchance=99999;
    snd=false;
    hfric=0.4;
    rotfric=0.6;
    direction = 270;
    alarm[0]=210;
    rotspeed=0;
    fadeout = false;
    vis_angle = 0;
    air_friction = power(0.97, global.delta_factor);
    my_gravity = 0.7 * global.delta_factor;
    maxBloodiness = 1;
    bloodiness = maxBloodiness;
');
object_event_add(Sandvich,ev_collision,Character,'
    if other.team=team && other.hp<other.maxHp && other.player != ownerPlayer {
        //other.hp += other.maxHp
        other.burnIntensity = 0;
        other.burnDuration = 0;
        other.hp += 40;
        if other.hp > other.maxHp other.hp = other.maxHp;
        instance_destroy()
    }
');

globalvar Ball;
Ball = object_add();
object_event_add(Ball,ev_create,0,'
    {
        explosionDamage = 50;
        animationState = 1;
        stickied = false;
        blastRadius = 60;
        exploded = false;
        bubbled = false;
        reflector = noone;
        alarm[2]=30*15;
        hfric=0.5;
        rotfric=0.7;
        rotspeed=random(20)-10;
        image_speed=0;
        crit = 1;
        used=0;
        damage=15;
        bounced=0;
        sprite_index = sprite_add(pluginFilePath + "\randomizer_sprites\BallS.png", 3, 1, 0, 3, 3);
        mask_index = sprite_index;
        team = -1;
        intel = 0;
        vis_angle = 0;
    }
');
object_event_add(Ball,ev_alarm,0,'
    reflector = noone;
');
object_event_add(Ball,ev_alarm,2,'
    instance_destroy();
    if owner != -1 && instance_exists(owner) owner.ammo = 1;
');
object_event_add(Ball,ev_step,ev_step_normal,'
    wallSetSolid();
    if 1 > 1 image_index=team+1;
    damage+=0.2;

    if(abs(vspeed)<0.2) {
        vspeed=0;
    }

    if (place_free(x, y+1))
        vspeed += 0.7 * global.delta_factor;
    else
    {
        vspeed = min(vspeed, 0);
        hspeed = hspeed * delta_mult(0.9);
        bounced+=1;
        if bounced > 3 used = 1; 
    }
    if (vspeed > 11)
        vspeed = 11;
        
    if (speed < 0.2)
        speed = 0;
    if (abs(rotspeed) < 0.2)
        rotspeed = 0;
    
    rotspeed *= power(0.97, global.delta_factor);
    
    vis_angle += rotspeed * global.delta_factor;
    //image_angle = vis_angle;
    
    if(!place_free(x+hspeed, y+vspeed)){
        hspeed*=hfric;
        rotspeed*=rotfric;
        collided=true;

        wallSetSolid();

        really_move_contact_solid(point_direction(x,y,x+hspeed,y+vspeed), speed);

        if(!place_free(x,y+sign(vspeed)))
        {
            vspeed *= -0.4;
            if(!place_free(x+hspeed,y))
            {
                really_move_contact_solid(point_direction(x,y,x+hspeed,y+vspeed), speed);
                hspeed *= -0.4;
            }
        }
        if(!place_free(x+sign(hspeed),y))
        {
            hspeed *= -0.4;
            if(!place_free(x,y+vspeed))
            {
                really_move_contact_solid(point_direction(x,y,x+hspeed,y+vspeed), speed);
                vspeed *= -0.4;
            }
        }

        bounced+=1;
        if bounced > 3 used = 1; 
    }
    
    if (speed > 0)
        if (point_distance(x,y,view_xview[0],view_yview[0]) > 2000)
            instance_destroy();
    
    x += hspeed * global.delta_factor;
    y += vspeed * global.delta_factor;
    x -= hspeed;
    y -= vspeed;


    wallUnsetSolid();
');
object_event_add(Ball,ev_collision,Character,'
    if(/*other.id != ownerPlayer.object and*/other.team != team  && other.hp > 0 && other.ubered == 0 && used==0 && speed >= 0.2) && bounced <2 {
        if (other.lastDamageDealer != ownerPlayer && other.lastDamageDealer != other.player){
            other.secondToLastDamageDealer = other.lastDamageDealer;
            other.alarm[4] = other.alarm[3]
        }
        other.alarm[3] = ASSIST_TIME;
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        other.lastDamageCrit = 1;
		
		if bounced < 1
			damage *= (1+0*0.35);
		else
			damage *= (1+0*0.35)*.50;
		
		damageCharacter(ownerPlayer, other.id, damage);
		
		//other.hp -= damage*(1+0*0.35); else other.hp -= damage*(1+0*0.35)*.50;
		
        with(other) {
            motion_add(other.direction, other.speed*0.03);
            cloakAlpha = min(cloakAlpha + 0.1, 1);    
        }
        instance_destroy();
    } else if other.team == team && other.currentWeapon.object_index == Sandman {
        if other.currentWeapon.ammoCount < 1 {
            other.currentWeapon.ammoCount =1;
            other.currentWeapon.alarm[5]=-1;
            other.ammo[107] = -1;
            playsound(x,y,PickupSnd);
            instance_destroy(); 
        }
    }
');
object_event_add(Ball,ev_collision,TeamGate,'
    {
    instance_destroy()
        // speed = 0;
           // stickied = true;
    }
');
object_event_add(Ball,ev_collision,Sentry,'
    if(other.team != team) {
        var thp;
        thp = damage*crit*other.bonus;
        if(other.currentWeapon > -1 and other.humiliated = 0){if(other.currentWeapon.wrangled) thp /= 2}
        other.hp -= thp    
        //other.hp -= damage*crit*other.bonus;
    //new stuff
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        other.lastDamageCrit = crit;
    //end new stuff
        instance_destroy();
    }
');
object_event_add(Ball,ev_other,ev_user12,'

');
object_event_add(Ball,ev_other,ev_user13,'

');
object_event_add(Ball,ev_draw,0,'
    if speed >= 0.2 {
        if !variable_local_exists("old_pos") {
            a = 0
            while a < 10 {
                old_pos[a,0] = x;
                old_pos[a,1] = y;  
                a += 1;
            }
        }
        a = 10-1
        while a > 0 {
            old_pos[a,0] = old_pos[a-1,0]
            old_pos[a,1] = old_pos[a-1,1]        
            a -= 1
        }      
        
        if team == TEAM_RED color = c_red;
        else color = c_blue;
         
        old_pos[0,0] = x
        old_pos[0,1] = y   
            a = 0
            while a < 10-1 {
                draw_set_alpha(0.2)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]-2, old_pos[a+1,0], old_pos[a+1,1]-2, 1,color,color);
                draw_set_alpha(0.4)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]-1, old_pos[a+1,0], old_pos[a+1,1]-1, 1,color,color);
                draw_set_alpha(0.6)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]-0, old_pos[a+1,0], old_pos[a+1,1]-0, 1,color,color);
                draw_line_width_color(old_pos[a,0], old_pos[a,1]+1, old_pos[a+1,0], old_pos[a+1,1] +1, 1,color,color);
                draw_set_alpha(0.4)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]+2, old_pos[a+1,0], old_pos[a+1,1] +2, 1,color,color);
                draw_set_alpha(0.2)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]+3, old_pos[a+1,0], old_pos[a+1,1] +3, 1,color,color);
            a += 1;
        }   
    }
    draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,c_white,image_alpha);
');

globalvar MadMilk, Milk;
MadMilk = object_add();
Milk = object_add();
object_event_add(MadMilk,ev_create,0,'
    {
        explosionDamage = 50;
        animationState = 1;
        stickied = false;
        blastRadius = 60;
        exploded = false;
        bubbled = false;
        reflector = noone;
        alarm[1]=29;
        alarm[2]=60;
        hfric=0.5;
        rotfric=0.7;
        rotspeed=random(20)-10;
        image_speed=0;
        crit = 1;
        used=0;
        damage=15;
        bounced=0;
        sprite_index = sprite_add(pluginFilePath + "\randomizer_sprites\MadMilkS.png", 1, 1, 0, 3, 3);
        mask_index = sprite_index;
        team = -1;
        intel = 0;
        vis_angle = 0;
    }
');
object_event_add(MadMilk,ev_alarm,0,'
    reflector = noone;
');
object_event_add(MadMilk,ev_alarm,2,'
    instance_destroy();
    if owner != -1 && instance_exists(owner) owner.ammo = 1;
');
object_event_add(MadMilk,ev_step,ev_step_normal,'
    image_index=2;

	if(abs(vspeed)<0.2) {
		vspeed=0;
	}
	if(abs(rotspeed) < 0.2) {
		rotspeed=0;
	}
	image_angle += rotspeed;
	if(place_free(x,y+1)) {
		vspeed += 0.7;
	}
	if(vspeed>11) {
		vspeed=11;
	}
	image_angle-=hspeed*2.5;
');
object_event_add(MadMilk,ev_collision,Character,'
	if team != other.team event_user(2);
');
object_event_add(MadMilk,ev_collision,Generator,'
	if team != other.team event_user(2);
');
object_event_add(MadMilk,ev_collision,Obstacle,'
	event_user(2);
');
object_event_add(MadMilk,ev_collision,TeamGate,'
    {
		instance_destroy()
        // speed = 0;
           // stickied = true;
    }
');
object_event_add(MadMilk,ev_collision,Sentry,'
    if other.team != team event_user(2);
');
object_event_add(MadMilk,ev_other,ev_user12,'

');
object_event_add(MadMilk,ev_other,ev_user13,'

');
object_event_add(MadMilk,ev_other,ev_user2,'
	if(exploded == true) {
		exit;
	} else {
		exploded = true;
	}
	//instance_create(x,y,Explosion);
	playsound(x,y,JarateSnd);

	with (Character) {
		if (distance_to_object(other) < other.blastRadius and !(team == other.team and id != other.ownerPlayer.object and place_meeting(x, y+1, Obstacle))){
			if(other.team != team) && !ubered and hp > 0 && !radioactive {
					soaked = true;
                    for(i=0; i<3; i+=1) {
                        if (soakType[i] == -1 && soakType[i] != milked) soakType[i] = milked; // Test later
                    }
					alarm[8]=250-distance_to_object(other);
					cloak=false;     
			}
			if radioactive {
				var text;
				text=instance_create(x,y,Text);
				text.sprite_index=MissS;
			}
			lastDamageDealer = other.ownerPlayer;
			lastDamageSource = -1;
			//lastDamageCrit = other.crit;
			cloakAlpha = min(cloakAlpha + 0.2, 1);
		} if (distance_to_object(other) < other.blastRadius and team == other.team){
			if(other.team == team) && !ubered and hp > 0 {
				burnDuration = 0;
					
			}
		}
	}




	repeat(15*global.gibLevel){
		var blood;
		blood = instance_create(x+random(20)-10,y+random(20)-10,Milk);
		blood.direction = random(360);
		blood.speed=random(5);
	}

	instance_destroy();
');
object_event_add(MadMilk,ev_draw,0,'
    if speed >= 0.2 {
        if !variable_local_exists("old_pos") {
            a = 0
            while a < 10 {
                old_pos[a,0] = x;
                old_pos[a,1] = y;  
                a += 1;
            }
        }
        a = 10-1
        while a > 0 {
            old_pos[a,0] = old_pos[a-1,0]
            old_pos[a,1] = old_pos[a-1,1]        
            a -= 1
        }      
        
        if team == TEAM_RED color = c_red;
        else color = c_blue;
         
        old_pos[0,0] = x
        old_pos[0,1] = y   
            a = 0
            while a < 10-1 {
                draw_set_alpha(0.2)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]-2, old_pos[a+1,0], old_pos[a+1,1]-2, 1,color,color);
                draw_set_alpha(0.4)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]-1, old_pos[a+1,0], old_pos[a+1,1]-1, 1,color,color);
                draw_set_alpha(0.6)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]-0, old_pos[a+1,0], old_pos[a+1,1]-0, 1,color,color);
                draw_line_width_color(old_pos[a,0], old_pos[a,1]+1, old_pos[a+1,0], old_pos[a+1,1] +1, 1,color,color);
                draw_set_alpha(0.4)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]+2, old_pos[a+1,0], old_pos[a+1,1] +2, 1,color,color);
                draw_set_alpha(0.2)
                draw_line_width_color(old_pos[a,0], old_pos[a,1]+3, old_pos[a+1,0], old_pos[a+1,1] +3, 1,color,color);
            a += 1;
        }   
    }
    draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,c_white,image_alpha);
	//if team == TEAM_RED color = c_orange;
	//else color = c_aqua;   
    //draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,color,1);
');
object_event_add(Milk,ev_create,0,'
	lifetime=250;
    alarm[0]=lifetime;
    stick = false;
    ogib=-1;
    odir=0;
    sprite_index=sprite_add(pluginFilePath + "\randomizer_sprites\MilkS.png", 1, 0, 0, 0, 0);
	image_index=sprite_index;
    image_speed=0;
');
object_event_add(Milk,ev_step,ev_step_normal,'
	{
	if(!stick){
		if(place_free(x,y+1)) {
		vspeed += 0.4;
		}
		if(vspeed>11) {
		vspeed=11;
		}
		if(vspeed<-11) {
		vspeed=-11;
		}
		if(hspeed>11) {
		hspeed=11;
		}
		if(hspeed<-11) {
		hspeed=-11;
		}
	}
	   image_alpha -= (2/lifetime);
	}
');
object_event_add(Milk,ev_collision,Obstacle,'
	if(!stick) {
	move_contact_solid(point_direction(x,y,x+hspeed,y+vspeed),-1)
		}
	speed=0;
	stick = true;
');
object_event_add(Milk,ev_alarm,0,'
    instance_destroy();
');
globalvar NapalmGrenade;
NapalmGrenade = object_add();
object_event_add(NapalmGrenade,ev_create,0,'
	{
		explosionDamage = 30;
		animationState = 1;
		alarm[1] = 29;
		stickied = false;
		blastRadius = 60;
		exploded = false;
		bubbled = false;
		reflector = noone;
		alarm[2]=60; //2 seconds to detonate
		hfric=0.9;
		rotfric=0.9;
		rotspeed=random(20)-10;
		image_speed=0;
		crit = 1;
		used=0;
		sprite_index = sprite_add(pluginFilePath + "\randomizer_sprites\NapalmS.png", 1, 1, 0, 3, 3);
        mask_index = sprite_index;
    }
');
object_event_add(NapalmGrenade,ev_alarm,0,'
    reflector = noone;
');
object_event_add(NapalmGrenade,ev_alarm,2,'
    if global.isHost {
		//sendNapalm(ds_list_find_index(global.players,ownerPlayer),x,y);
		//doNapalm(ownerPlayer,x,y);
		// implement later
	} else alarm[3] = 60 //the server has 2 seconds to send the detonation event. if it didnt happen after that just destroy the grenade
');
object_event_add(NapalmGrenade,ev_alarm,3,'
	instance_destroy();
');
object_event_add(NapalmGrenade,ev_step,ev_step_normal,'
    wallSetSolid();
	if(abs(vspeed)<0.2) {
		vspeed=0;
	}
	if(abs(rotspeed) < 0.2) {
		rotspeed=0
	}

	image_angle += rotspeed;

	if(place_free(x,y+1)) {
		vspeed += 0.7 * global.delta_factor;
    } else {
        vspeed = min(vspeed, 0);
        hspeed = hspeed * delta_mult(0.9);
    }
    if (vspeed > 11)
        vspeed = 11;
	image_angle-=hspeed*2.5
	
	if(!place_free(x+hspeed, y+vspeed)){
        hspeed*=hfric;
        rotspeed*=rotfric;
        collided=true;

        wallSetSolid();

        really_move_contact_solid(point_direction(x,y,x+hspeed,y+vspeed), speed);

        if(!place_free(x,y+sign(vspeed)))
        {
            vspeed *= -0.8;
            if(!place_free(x+hspeed,y))
            {
                really_move_contact_solid(point_direction(x,y,x+hspeed,y+vspeed), speed);
                hspeed *= -0.8;
            }
        }
        if(!place_free(x+sign(hspeed),y))
        {
            hspeed *= -0.8;
            if(!place_free(x,y+vspeed))
            {
                really_move_contact_solid(point_direction(x,y,x+hspeed,y+vspeed), speed);
                vspeed *= -0.8;
            }
        }
    }
	
	if (speed > 0)
        if (point_distance(x,y,view_xview[0],view_yview[0]) > 2000)
            instance_destroy();
			
	x += hspeed * global.delta_factor;
    y += vspeed * global.delta_factor;
    x -= hspeed;
    y -= vspeed;
	
	wallUnsetSolid();
');
object_event_add(NapalmGrenade,ev_collision,Character,'
	if(team != other.team) {
		if used == 0 {
			alarm[2]=10;
			used = 1;
		}
	}
');
object_event_add(NapalmGrenade,ev_collision,TeamGate,'
    {
	//instance_destroy()
		speed *= -1;
		   // stickied = true;
	}
');
object_event_add(NapalmGrenade,ev_collision,Sentry,'
    if(team != other.team) {
		if used == 0 {
			alarm[2]=1;
			used = 1;
		}
	}
');
object_event_add(NapalmGrenade,ev_collision,BulletWall,'
    {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(NapalmGrenade,ev_collision,ControlPointSetupGate,'
    if global.setupTimer >0 {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(NapalmGrenade,ev_collision,Generator,'
    if(other.team != team) {
		if used == 0 {
			alarm[2]=1;
			used = 1;
		}
		instance_destroy();
    }
');
object_event_add(NapalmGrenade,ev_draw,0,'
	if team == TEAM_RED color = c_orange;
	else color = c_aqua;   
    draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,color,1);
');
globalvar JarOPiss, Piss;
JarOPiss = object_add();
Piss = object_add();
object_event_add(JarOPiss,ev_create,0,'
	{
    animationState = 1;
    alarm[1] = 29;
    stickied = false;
    blastRadius = 60;
    exploded = false;
    bubbled = false;
    reflector = noone;
    alarm[2]=60;
    hfric=0.5;
    rotfric=0.7;
    rotspeed=random(20)-10;
	sprite_index = sprite_add(pluginFilePath + "\randomizer_sprites\JarateS.png", 1, 1, 0, 3, 3);
	mask_index = sprite_index;
    image_speed=0;
    //crit=1;
	}
');
object_event_add(JarOPiss,ev_alarm,0,'
    reflector = noone;
');
object_event_add(JarOPiss,ev_alarm,2,'
    instance_destroy();
    if owner != -1 && instance_exists(owner) owner.ammo = 1;
');
object_event_add(JarOPiss,ev_step,ev_step_normal,'
    image_index=2;

	if(abs(vspeed)<0.2) {
		vspeed=0;
	}
	if(abs(rotspeed) < 0.2) {
		rotspeed=0;
	}
	image_angle += rotspeed;
	if(place_free(x,y+1)) {
		vspeed += 0.7;
	}
	if(vspeed>11) {
		vspeed=11;
	}
	image_angle-=hspeed*2.5;
');
object_event_add(JarOPiss,ev_collision,BulletWall,'
    {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(JarOPiss,ev_collision,ControlPointSetupGate,'
    if global.setupTimer >0 {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(JarOPiss,ev_collision,Character,'
	if team != other.team event_user(2);
');
object_event_add(JarOPiss,ev_collision,Generator,'
	if team != other.team event_user(2);
');
object_event_add(JarOPiss,ev_collision,Obstacle,'
	event_user(2);
');
object_event_add(JarOPiss,ev_collision,TeamGate,'
    {
		instance_destroy()
        // speed = 0;
           // stickied = true;
    }
');
object_event_add(JarOPiss,ev_collision,Sentry,'
    if other.team != team event_user(2);
');
object_event_add(JarOPiss,ev_other,ev_user12,'

');
object_event_add(JarOPiss,ev_other,ev_user13,'

');
object_event_add(JarOPiss,ev_other,ev_user2,'
	if(exploded == true) {
		exit;
	} else {
		exploded = true;
	}
	//instance_create(x,y,Explosion);
	playsound(x,y,JarateSnd);

	with (Character) {
		if (distance_to_object(other) < other.blastRadius and !(team == other.team and id != other.ownerPlayer.object and place_meeting(x, y+1, Obstacle))){
			if(other.team != team) && !ubered and hp > 0 && !radioactive {
                    soaked = true;
                    for(i=0; i<3; i+=1) {
                        if (soakType[i] == -1 && soakType[i] != piss) soakType[i] = piss; // Test later
                    }
					pissed=1; // in modern context this variable name is making me laugh
					alarm[8]=250-distance_to_object(other);
					cloak=false; 
					if instance_exists(other.ownerPlayer) {
						other.ownerPlayer.object.hp = min(other.ownerPlayer.object.maxHp, other.ownerPlayer.object.hp+20);
					}       
			}
			if radioactive {
				var text;
				text=instance_create(x,y,Text);
				text.sprite_index=MissS;
			}
			lastDamageDealer = other.ownerPlayer;
			lastDamageSource = -1;
			//lastDamageCrit = other.crit;
			cloakAlpha = min(cloakAlpha + 0.2, 1);
		} if (distance_to_object(other) < other.blastRadius and team == other.team){
			if(other.team == team) && !ubered and hp > 0 {
				burnDuration = 0;
					
			}
		}
	}




	repeat(15*global.gibLevel){
		var blood;
		blood = instance_create(x+random(20)-10,y+random(20)-10,Piss);
		blood.direction = random(360);
		blood.speed=random(5);
	}

	instance_destroy();
');
object_event_add(Piss,ev_create,0,'
	lifetime=250;
    alarm[0]=lifetime;
    stick = false;
    ogib=-1;
    odir=0;
    sprite_index=sprite_add(pluginFilePath + "\randomizer_sprites\PissS.png", 1, 0, 0, 0, 0);
	image_index=sprite_index;
    image_speed=0;
');
object_event_add(Piss,ev_step,ev_step_normal,'
	{
	if(!stick){
		if(place_free(x,y+1)) {
		vspeed += 0.4;
		}
		if(vspeed>11) {
		vspeed=11;
		}
		if(vspeed<-11) {
		vspeed=-11;
		}
		if(hspeed>11) {
		hspeed=11;
		}
		if(hspeed<-11) {
		hspeed=-11;
		}
	}
	   image_alpha -= (2/lifetime);
	}
');
object_event_add(Piss,ev_collision,Obstacle,'
	if(!stick) {
	move_contact_solid(point_direction(x,y,x+hspeed,y+vspeed),-1)
		}
	speed=0;
	stick = true;
');
object_event_add(Piss,ev_alarm,0,'
    instance_destroy();
');

globalvar NatachaShot;
NatachaShot = object_add();
object_set_sprite(NatachaShot, ShotS);
object_set_parent(NatachaShot, Shot);
object_event_add(NatachaShot,ev_create,0,'
    {
        hitDamage = 6;
		lifetime = 40;
		alarm[0] = lifetime;
		originx=x;
		originy=y;
			
        // Controls whether this bullet penetrates bubbles or not
        // Also controls whether this bullet destroys friendly bubbles
        perseverant = choose(0, 0, 1); // 1/3 chance
    }
');
object_event_add(NatachaShot,ev_alarm,0,'
    instance_destroy();
');
object_event_add(NatachaShot,ev_collision,Character,'
    gunSetSolids();
    if (!place_free(x, y)) 
    {
        instance_destroy();
        gunUnsetSolids();
        exit;
    }
    gunUnsetSolids();

    if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0)
    {
        damageCharacter(ownerPlayer, other.id, hitDamage);
        if (other.lastDamageDealer != ownerPlayer and other.lastDamageDealer != other.player)
        {
            other.secondToLastDamageDealer = other.lastDamageDealer;
            other.alarm[4] = other.alarm[3]
        }
        other.alarm[3] = ASSIST_TIME / global.delta_factor;
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        
        var blood;
        if(global.gibLevel > 0 && !other.radioactive)
        {
            blood = instance_create(x,y,Blood);
            blood.direction = direction-180;
        }
        dealFlicker(other.id);
        with(other)
        {
            motion_add(other.direction, other.speed*0.1);
			speed*=0.95;
        }
        instance_destroy();
    }
');

// copied from qcwep as made by ZaSpai
globalvar QCShot, MGShot, MGShotS, MGShotMaskS;
QCShot = object_add();
object_event_add(QCShot,ev_create,0,'
    hitDamage = 7;
    lifetime = 35;
    alarm[0] = lifetime / global.delta_factor;
    originx = x;
    originy = y;
    gravity = 0; //defines arcing
	//team = TEAM_SPECTATOR;
    
    // Controls whether this bullet penetrates bubbles or not
    // Also controls whether this bullet destroys friendly bubbles
    // Straight shooters have 2 in 3 chance, arcers have 1 in 3
    perseverant = choose(0, 0, 0); // 0/3 chance
    
    image_speed = 0;
');

object_event_add(QCShot,ev_alarm,0,'
	instance_destroy();
');

object_event_add(QCShot,ev_step,ev_step_begin,'
	gunSetSolids();
	if(!variable_local_exists("firststep"))
        firststep = true;
    
    vspeed += gravity * global.delta_factor;
    
    image_angle = direction;
    
    if(!firststep and global.delta_factor != 1)
    {
        x += hspeed * global.delta_factor;
        y += vspeed * global.delta_factor;
    }
    
    if (!place_free(x, y))
    {
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
    
    if(!firststep and global.delta_factor != 1)
    {
        x -= hspeed;
        y -= vspeed;
    }
    else
        firststep = false;
	
	gunUnsetSolids();
');

object_event_add(QCShot,ev_collision,Obstacle,'
	var imp;
    gunSetSolids();
    really_move_contact_solid(direction, speed);
    gunUnsetSolids();
    imp = instance_create(x,y,Impact);
    imp.image_angle=direction;
    instance_destroy();
');

object_event_add(QCShot,ev_collision,Character,'
    if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0)
    {
        damageCharacter(ownerPlayer, other.id, hitDamage);
        if (other.lastDamageDealer != ownerPlayer and other.lastDamageDealer != other.player)
        {
            other.secondToLastDamageDealer = other.lastDamageDealer;
            other.alarm[4] = other.alarm[3]
        }
        other.alarm[3] = ASSIST_TIME;
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        
        var blood;
        if(global.gibLevel > 0 && !other.radioactive)
        {
            blood = instance_create(x,y,Blood);
            blood.direction = direction-180;
        }
        dealFlicker(other.id);
        with(other)
        {
            motion_add(other.direction, other.speed*0.03);
        }
        instance_destroy();
    }
');

object_event_add(QCShot,ev_collision,TeamGate,'
	if (!global.mapchanging) {
		var imp;
		move_contact_solid(direction, speed);
		imp = instance_create(x,y,Impact);
		imp.image_angle=direction;
		instance_destroy();
	}
');

object_event_add(QCShot,ev_collision,Sentry,'
	if(other.team != team)
	{
		damageSentry(ownerPlayer, other.id, hitDamage);
		other.lastDamageDealer = ownerPlayer;
		other.lastDamageSource = weapon;
		instance_destroy();
	}
');

object_event_add(QCShot,ev_collision,Bubble,'
if(team != other.team and !perseverant)
    instance_destroy();
');

object_event_add(QCShot,ev_collision,BulletWall,'
	var imp;
    move_contact_solid(direction, speed);
    imp = instance_create(x,y,Impact);
    imp.image_angle=direction;
    instance_destroy();
');
	
object_event_add(QCShot,ev_collision,Generator,'
	if(other.team != team) {
		damageGenerator(ownerPlayer, other.id, hitDamage);
		instance_destroy();
	}
');

object_event_add(QCShot,ev_draw,0,'
	draw_sprite_ext(sprite_index,team,x,y,image_xscale,image_yscale,direction,c_white,image_alpha);
');

MGShot = object_add();
MGShotS = sprite_add(directory + '\randomizer_sprites\MGShotS.png', 2, 0, 0, 11, 4);
MGShotMaskS = sprite_add(directory + '\randomizer_sprites\MGShotMaskS.png', 1, 0, 0, 11, 4);
object_set_parent(MGShot,QCShot);
object_set_sprite(MGShot,MGShotS);
object_set_mask(MGShot,MGShotMaskS);
object_event_add(MGShot,ev_create,0,'
	event_inherited();
    gravity = 0.10;
    perseverant = choose(0, 0, 1); // 1/3 chance
');

object_event_clear(Bubble,ev_destroy,0);
object_event_add(Bubble,ev_destroy,0,"
	if(instance_exists(gun) && instance_exists(owner))
		gun.bubbleCount -= 1;
	instance_create(x,y,Pop);
");

// for radioactivity
object_event_clear(Shot,ev_collision,Character);
object_event_add(Shot,ev_collision,Character,'
	gunSetSolids();
    if (!place_free(x, y)) 
    {
        instance_destroy();
        gunUnsetSolids();
        exit;
    }
    gunUnsetSolids();

    if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0 && !other.radioactive)
    {
        switch(weapon.object_index) {
            case Reserveshooter:
                if (!other.onground && other.moveStatus == 1) { // If you've successfully sent an enemy up
                    hitDamage += 15;
                    var text;
                    text=instance_create(x,y,Text);
                    text.sprite_index=MiniCritS;
                }
            break;
        }
        damageCharacter(ownerPlayer, other.id, hitDamage);
        if (other.lastDamageDealer != ownerPlayer and other.lastDamageDealer != other.player)
        {
            other.secondToLastDamageDealer = other.lastDamageDealer;
            other.alarm[4] = other.alarm[3]
        }
        other.alarm[3] = ASSIST_TIME / global.delta_factor;
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        
        var blood;
        if(global.gibLevel > 0)
        {
            blood = instance_create(x,y,Blood);
            blood.direction = direction-180;
        }
        dealFlicker(other.id);
        with(other)
        {
            motion_add(other.direction, other.speed*0.03);
        }
        instance_destroy();
    }
');
// Use the damage API
global.dealDamageFunction += '
	if (object_is_ancestor(argument1.object_index, Character)) {
        if (argument1.radioactive) { // bonk detection
            argument1.hp += argument2;
			var text;
			text=instance_create(x,y,Text);
			text.sprite_index=MissS;
			exit;
        }
        var pissed, milked;
        pissed = false;
        milked = false;
        if (argument1.soaked)
            for(i=0; i<3; i+=1) {
                if (argument1.soakType[i] == piss)
                    pissed = true;
                if (argument1.soakType[i] == milk)
                   milked = true;
            }
		//if (pissed || argument1.object.crit == 2 || (argument0.object.currentWeapon.abilityActive && argument0.object.currentWeapon.ability = MINICRIT)) {
        if (pissed) {
			argument2 += 1*0.35; // add this dmg for healing factors
			argument1.hp -= 1*0.35;
			var text;
			text=instance_create(x,y,Text);
			text.sprite_index=MiniCritS;
		}
		if (argument0 != noone && instance_exists(argument0)) {
			if (argument0.object_index == Player) {
				if (argument0.object != -1 && instance_exists(argument0.object)) {
					if (argument0.object.currentWeapon.object_index == BlackBox && argument1.team != argument0.team) argument0.object.hp += argument2*0.3; // BlackBox heal code
                    if (milked) argument0.object.hp += argument2*0.35; // milk heal code
				}
			}
		}
    }
';