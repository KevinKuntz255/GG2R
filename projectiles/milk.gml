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
        alarm[1]=29 / global.delta_factor;
        alarm[2]=60 / global.delta_factor;
        hfric=0.5;
        rotfric=0.7;
        rotspeed=random(20)-10;
        image_speed=0;
        crit = 1; // what? its a jar of milk. Is the glass gonna bleed you?
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
                    for(i=0; i<4; i+=1) {
                        if (soakType[i] == milk) break;
                        if (soakType[i] != milk) soakType[i] = milk; // Test later
                    }
					alarm[8]= (250-distance_to_object(other)) / global.delta_factor;
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
    alarm[0]=lifetime / global.delta_factor;
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