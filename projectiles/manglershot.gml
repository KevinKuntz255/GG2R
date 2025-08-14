globalvar ManglerShot;
ManglerShot = object_add();
object_set_parent(ManglerShot, Rocket);
object_event_add(ManglerShot,ev_create,0,'
    event_inherited();
    {
        travelDistance=0;
        firstx=x;
        firsty=y;
        
        sprite_index = sprite_add(pluginFilePath + "\randomizer_sprites\ManglerShotS.png", 2, 1, 0, 3, 3);
        
        flameLife = 15;
        burnIncrease = 1;
        durationIncrease = 30;
        
        ubercolor=c_orange;
        critMult = 1;
    }
');

object_event_add(ManglerShot, ev_other, ev_user5, '
    {  
        if(characterHit.id != ownerPlayer.object)
        {
            if(exploded)
                exit;
            else
                exploded = true;

            if(characterHit != -1) {
                if(characterHit.team != team || characterHit.id == ownerPlayer.object and !characterHit.ubered )
                {
                    damageAuto( ownerPlayer, characterHit, hitDamage );
                    if object_is_ancestor(characterHit.object_index, Character)
                    {
                        if (characterHit.lastDamageDealer != ownerPlayer and characterHit.lastDamageDealer != characterHit.player)
                        {
                            characterHit.secondToLastDamageDealer = characterHit.lastDamageDealer;
                            characterHit.alarm[4] = characterHit.alarm[3]
                        }
                        characterHit.alarm[3] = ASSIST_TIME / global.delta_factor;
                    }
                    characterHit.lastDamageDealer = ownerPlayer;
                    characterHit.lastDamageSource = weapon;
                }
            }
            instance_create(x,y,Explosion);
            playsound(x,y,ExplosionSnd);
            
            with (Character) {
                if (distance_to_object(other) < other.blastRadius and !(team == other.team and id != other.ownerPlayer.object and place_meeting(x, y+1, Obstacle))){
                    var rdir, vectorfactor;
                    rdir = point_direction(other.x, other.y, x+(left_bound_offset+right_bound_offset)/2, y+(top_bound_offset+bottom_bound_offset)/2);
                    vectorfactor = point_distance(0, 0, power(sin(degtorad(rdir)), 2), power(cos(degtorad(rdir)), 2));
                    var fake_distance;
                    fake_distance = distance_to_object(other);

                    if(fake_distance < 1) fake_distance = 0;

                    if (1 - fake_distance/other.blastRadius <= 0.25)
                        continue;
                    motion_add(rdir, min(15, other.knockback-other.knockback*(fake_distance/other.blastRadius)) * vectorfactor);
                    if(!ubered and hp > 0)
                    {
                        if (other.team != team) or (id==other.ownerPlayer.object)
                        {
                            if other.critMult >= 1.43 { // original number was 2.15 crit_factor, nott doing that
                                if(!object_is_ancestor(object_index, Pyro) && !invincible) {
                                    if (burnDuration < maxDuration) {
                                        burnDuration += 30*6; 
                                        burnDuration = min(burnDuration, maxDuration);
                                    }
                                    if (burnIntensity < maxIntensity) {
                                        burnIntensity += other.burnIncrease * 3;
                                        burnIntensity = min(burnIntensity, maxIntensity);
                                    }
                                    burnedBy = other.ownerPlayer;
                                    afterburnSource = WEAPON_COWMANGLERFIRE;
                                    alarm[0] = decayDelay;
                                }
                            }
                            damageCharacter( other.ownerPlayer, id, other.explosionDamage*(1-(fake_distance/other.blastRadius)) );
                            
                            if(id == other.ownerPlayer.object and instance_exists(lastDamageDealer) and lastDamageDealer != other.ownerPlayer)
                                lastDamageSource = DAMAGE_SOURCE_FINISHED_OFF_GIB;
                            else 
                            {
                                if (lastDamageDealer != other.ownerPlayer && lastDamageDealer != player){
                                    secondToLastDamageDealer = lastDamageDealer;
                                    alarm[4] = alarm[3]
                                }
                                if (other.ownerPlayer != id)
                                    alarm[3] = ASSIST_TIME / global.delta_factor;
                                lastDamageDealer = other.ownerPlayer;
                                lastDamageSource = other.weapon;
                            }
                            dealFlicker(id);
                        }
                        if id==other.ownerPlayer.object and other.team == team {
                            moveStatus = 1;
                            speed*=1.06;
                        }else if other.team == team and (id!=other.ownerPlayer.object){
                            moveStatus = 4;
                                if point_direction(x,y+5,other.x,other.y-5)>210 and point_direction(x,y,other.x,other.y)<330 {
                                vspeed-=4*(1-(fake_distance/other.blastRadius));
                                speed*=1.3;
                            }
                        } else {
                            moveStatus = 2;
                            if point_direction(x,y+5,other.x,other.y-5)>210 and point_direction(x,y,other.x,other.y)<330 {
                                vspeed-=4*(1-(fake_distance/other.blastRadius));
                                speed*=1.3;
                            }
                        }
                        if(global.gibLevel > 0 && !radioactive) {
                            if (id==other.ownerPlayer.object) or (other.team!=team) {
                                repeat(3) {
                                    var blood;
                                    blood = instance_create(x,y,Blood);
                                    blood.direction = point_direction(other.x,other.y,x,y)-180;
                                }
                            }
                        }
                    } else {
                        if hp > 0 and id==other.ownerPlayer.object and other.team == team and ubered{ //just in case
                            moveStatus = 1;
                            speed*=1.055; //slight nerf to compensate for uber
                        }
                    }
                }
            }

            with (Sentry) {
                if (distance_to_object(other) < other.blastRadius){
                    if(other.team != team)
                    {
                        damageSentry( other.ownerPlayer, id, other.explosionDamage*(1-(distance_to_object(other)/other.blastRadius)) );
                        
                        lastDamageDealer = other.ownerPlayer;
                        lastDamageSource = other.weapon;
                    }
                }
            }        
            
            with (Generator) {
                if (distance_to_object(other) < other.blastRadius){
                    if(other.team != team)
                    {
                        damageGenerator( other.ownerPlayer, id, other.explosionDamage*(1-(distance_to_object(other)/other.blastRadius)) );
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
        
            with(Mine) {
                if (distance_to_object(other) < other.blastRadius*0.66 and (other.team != team or other.ownerPlayer == ownerPlayer)){
                    event_user(2);
                }
            }
            
            with(LooseSheet) {
                if (distance_to_object(other) < other.blastRadius){
                    motion_add(point_direction(other.x,other.y,x,y),10-10*(distance_to_object(other)/other.blastRadius));
                }
            }
            
            with(Bubble) {
                if (distance_to_object(other) < other.blastRadius*0.66){
                    instance_destroy();
                }    
            }

            instance_destroy();
        }
    }
');

object_event_add(ManglerShot,ev_draw,0,'
    if critMult > 1 { 
        drawoffset=1;
        if owner.team == TEAM_RED {
            ubercolor = make_color_rgb(207,146,0);
            ubercolour = c_orange;
        } else {
         ubercolor = make_color_rgb(32,143,180);
         ubercolour = c_aqua;
        }
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
        draw_sprite_ext(Spark2S,owner.currentWeapon.spark,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
    } else {
        drawoffset=0;
        if owner.team == TEAM_RED ubercolor = make_color_rgb(208,0,0);
        else ubercolor = make_color_rgb(32,47,180);
    }
    draw_set_alpha(0.7);
    draw_line_width_color(firstx,firsty,x,y,2,ubercolor,ubercolor);
    draw_set_alpha(1);
    draw_sprite_ext(sprite_index,owner.team*2+drawoffset,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha);
');