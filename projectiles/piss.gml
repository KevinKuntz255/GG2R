globalvar JarOPiss, Piss;
JarOPiss = object_add();
Piss = object_add();
object_event_add(JarOPiss,ev_create,0,'
	{
	    animationState = 1;
	    alarm[1] = 29 / global.delta_factor;
	    stickied = false;
	    blastRadius = 60;
	    exploded = false;
	    bubbled = false;
	    reflector = noone;
	    alarm[2]= 60 / global.delta_factor;
	    hfric=0.5;
	    rotfric=0.7;
	    rotspeed=random(20)-10;
		sprite_index = sprite_add(pluginFilePath + "\randomizer_sprites\JarateS.png", 1, 1, 0, 3, 3);
		mask_index = sprite_index;
	    image_speed=0;
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
			if(other.team != team) && !ubered and hp > 0 {
                if radioactive {
                    var text;
                    text=instance_create(x,y,Text);
                    text.sprite_index=MissS;
                    exit;
                }
                soaked = true;
                for(i=0; i<4; i+=1) {
                    if (soakType[i] == piss) break;
                    if (soakType[i] != piss) soakType[i] = piss; // Test later
                }
				pissed=1; // in modern context this variable name is making me laugh
				alarm[8]= (250-distance_to_object(other)) / global.delta_factor;
				cloak=false;    
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
    alarm[0] = lifetime / global.delta_factor;
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