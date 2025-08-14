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
        alarm[0] = lifetime / global.delta_factor;
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

        if (variable_local_exists("owner")) {
            if (!variable_local_exists("critMade")){
                critMult = owner.currentWeapon.crit;
                hitDamage *= critMult;
                if (critMult > 1) playsound(x,y,CritSnd);
                critMade = 1;
            }
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
                    alarm[0] = decayDelay / global.delta_factor;
                }
            }
        }

            if true other.hp -= hitDamage*(speed/2.55)*(1+0*0.35)*1+burning*8;
            //shot.speed=10+(bonus/10)*2.2; < Can not find bonus
            attached = other.id;
            xoffset=x-other.x;
            yoffset=y-other.y;
            alarm[0]= -1 / global.delta_factor;
            speed=0;
            dir = direction;
            scale=image_xscale*other.image_xscale;
            depth=1;
            if !burning {
                if (other.lastDamageDealer != ownerPlayer && other.lastDamageDealer != other.player){
                    other.secondToLastDamageDealer = other.lastDamageDealer;
                    other.alarm[4] = other.alarm[3]
                }
                other.alarm[3] = ASSIST_TIME / global.delta_factor;
            } else {
                other.secondToLastDamageDealer = helper;
                other.alarm[4] = other.alarm[3];
                other.alarm[3] = ASSIST_TIME / global.delta_factor;
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
        other.alarm[0] = other.regenerationBuffer / global.delta_factor;
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

    if (variable_local_exists("critMult")) {
        if (critMult > 1) {
            if (owner.team == TEAM_RED)
                    ubercolour = c_orange;
                else if (owner.team == TEAM_BLUE)
                    ubercolour = c_aqua;
                //draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
                draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
                draw_sprite_ext(Spark2S,owner.currentWeapon.spark,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
        }
    }

    if burning {
        for(i = 0; i < 2; i += 1)
        {
            draw_sprite_ext(FlameS, random(3), x + i*2, y+i*2, 1, 1, 0, c_white, 0.5);
        }
    } 
');