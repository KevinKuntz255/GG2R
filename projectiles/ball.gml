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
        alarm[2]= (30*15) / global.delta_factor;
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
            other.alarm[4] = other.alarm[3];
        }
        other.alarm[3] = ASSIST_TIME / global.delta_factor;
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
            other.currentWeapon.ammoCount = 1;
            other.currentWeapon.alarm[5] =-1;
            other.meter[1] = 1;
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