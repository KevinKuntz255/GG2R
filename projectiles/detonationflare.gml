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
                if(other.team != team or id==other.ownerPlayer.object) && !ubered and hp > 0
                {
                    bonus = 1;
                    if burnDuration > 0 {
                        //if other.crit == 1 bonus = MINICRIT_FACTOR;
                    }
                    if(!object_is_ancestor(object_index, Pyro) && !radioactive) {
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
                        alarm[0] = decayDelay / global.delta_factor;
                    }
					if (player != other.ownerPlayer) damageCharacter(other.ownerPlayer, id, other.explosionDamage*sqr((1-(distance_to_object(other)/other.blastRadius)))*(1+0*0.35)*1*bonus);
					else if (player == other.ownerPlayer)
						damageCharacter(other.ownerPlayer, other.ownerPlayer.object, 10*sqr((1-(distance_to_object(other)/other.blastRadius)))*(1+0*0.35)*1);
                    // todo: ownerPlayer gets afterburn for a lil while, fix that

					//if true hp -= other.explosionDamage*sqr((1-(distance_to_object(other)/other.blastRadius)))*(1+0*0.35)*1*bonus;
                    //if player == other.ownerPlayer hp-= 10*sqr((1-(distance_to_object(other)/other.blastRadius)))*(1+0*0.35)*1;
                    if (id == other.ownerPlayer.object and lastDamageDealer != -1 and lastDamageDealer != other.ownerPlayer and other.reflector == noone)
                    {
                        lastDamageSource = DAMAGE_SOURCE_FINISHED_OFF_GIB;
                    }
                    else 
                    {
                        if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player and other.reflector != lastDamageDealer)
                        {
                            secondToLastDamageDealer = lastDamageDealer;
                            alarm[4] = alarm[3];
                        }
                        if (other.ownerPlayer != id or (other.reflector != noone and other.ownerPlayer == id))
                            alarm[3] = ASSIST_TIME / global.delta_factor;
                        lastDamageDealer = other.ownerPlayer;
                        lastDamageSource = other.weapon;
                        //lastDamageCrit = other.crit;
                        if (id==other.ownerPlayer.object and other.reflector != noone)
                        {
                            lastDamageDealer = other.reflector;
                            lastDamageSource = WEAPON_REFLECTED_FLARE;
                        }
                    }
                    if(global.gibLevel > 0 && !radioactive)
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
                    }
                    else
                    {
                        moveStatus = 4;
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
                alarm[0] = regenerationBuffer / global.delta_factor;
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