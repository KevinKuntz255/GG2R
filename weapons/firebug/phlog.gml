globalvar WEAPON_PHLOG;
WEAPON_PHLOG = 84; //kinda weird

globalvar Phlog;
Phlog = object_add();
object_set_parent(Phlog, FlameWeapon);

object_event_add(Phlog,ev_create,0,'
    xoffset = -5;
    yoffset = 3;
    spriteBase = "Phlog";
    event_inherited();

    flameDamage = 2.4;
    burnIncrease=1;
    shot = false;
    index = 0;

    abilityActive = false;
    //ability = CRIT; 
    //owner.overhealMax = 40;
');
// TODO: Implement mmph + crit

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
            alarm[5] = reloadBuffer / global.delta_factor;
            isRefilling = false;
            ammoCount-=2;
            if ammoCount > 0 alarm[0]=refireTime / global.delta_factor;
            else alarm[0]=50 / global.delta_factor;
            
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

object_event_clear(Phlog,ev_other, ev_user2);

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

global.weapons[WEAPON_PHLOG] = Phlog;
global.name[WEAPON_PHLOG] = "Phlogistinator (unfinished)";
