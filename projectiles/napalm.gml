globalvar NapalmGrenade, NapalmFlame;
NapalmGrenade = object_add();
NapalmFlame = object_add();
object_set_sprite(NapalmFlame, FlameS);
object_set_parent(NapalmFlame, BurningProjectile);
object_event_add(NapalmGrenade,ev_create,0,'
	{
		explosionDamage = 30;
		animationState = 1;
		alarm[1] = 29 / global.delta_factor;
		stickied = false;
		blastRadius = 60;
		exploded = false;
		bubbled = false;
		reflector = noone;
		alarm[2]=60 / global.delta_factor; //2 seconds to detonate
		hfric=0.9;
		rotfric=0.9;
		rotspeed=random(20)-10;
		image_speed=0;
		used=0;
        vis_angle = 0;
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
        event_user(2);
	} else alarm[3] = 60 / global.delta_factor //the server has 2 seconds to send the detonation event. if it didnt happen after that just destroy the grenade
');
object_event_add(NapalmGrenade,ev_alarm,3,'
	instance_destroy();
');
object_event_add(NapalmGrenade,ev_step,ev_step_normal,'
    wallSetSolid();
    if(abs(vspeed)<0.2) {
        vspeed=0;
    }

    if (place_free(x, y+1))
        vspeed += 0.7 * global.delta_factor;
    else
    {
        vspeed = min(vspeed, 0);
        hspeed = hspeed * delta_mult(0.9);
    }
    if (vspeed > 11)
        vspeed = 11;
        
    if (speed < 0.2)
        speed = 0;
    if (abs(rotspeed) < 0.2)
        rotspeed = 0;
    
    //rotspeed *= power(0.97, global.delta_factor);
    
    vis_angle += rotspeed * global.delta_factor;
    //image_angle = vis_angle;
    
    if(!place_free(x+hspeed, y+vspeed)){
        hspeed *= hfric;
        rotspeed *= rotfric;
        collided = true;

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
			alarm[2]=10 / global.delta_factor;
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
			alarm[2]= 1 / global.delta_factor;
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
			alarm[2]=1 / global.delta_factor;
			used = 1;
		}
		instance_destroy();
    }
');
object_event_add(NapalmGrenade,ev_other,ev_user2,'
    instance_create(x,y,Explosion);
    playsound(x,y,ExplosionSnd);
    for(i=0;i<60;i+=1){
        shot = instance_create(x,y,NapalmFlame);
        shot.direction=i*3;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=team;
        shot.weapon= NapalmGrenade;
        with(shot) motion_add(direction, 2);
    }
    instance_destroy();
');

object_event_add(NapalmGrenade,ev_draw,0,'
	if team == TEAM_RED color = c_orange;
	else color = c_aqua;   
    draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,vis_angle,color,1);
');

object_event_add(NapalmFlame,ev_create,0,'
    hitDamage = 4;
    flameLife = 15;
    burnIncrease = 3.33;
    durationIncrease = 60;
    afterburnFalloff = true;

    dying=false;

    hspeed=3+random(2);
    vspeed=2+random(2);

    event_inherited();
    alarm[0] = 2000; // otherwise they randomly disappear
');
object_event_add(NapalmFlame,ev_step,ev_step_normal,'
    wallSetSolid();
    if hspeed > 0.1 hspeed-=0.1;
    else if hspeed < -0.1 hspeed+=0.1;
    if vspeed < 0 vspeed+=0.2;
    else vspeed += 0.05;
        
    if(global.particles == PARTICLES_NORMAL) {
        if(random(5)<1) effect_create_below(ef_smokeup,x,y-8,0,c_black);
    } else if(global.particles == PARTICLES_ALTERNATIVE) {
        if(not variable_global_exists("flameParticleType")) {
            global.flameParticleType = part_type_create();
            part_type_sprite(global.flameParticleType,FlameS,true,false,true);
            part_type_alpha2(global.flameParticleType,1,0.3);
            part_type_life(global.flameParticleType,4,7);
        }
        
        if(not variable_global_exists("flameParticleSystem")) {
            global.flameParticleSystem = part_system_create();
            part_system_depth(global.flameParticleSystem, 10);
        }
        if(random(8)<1) {
            part_particles_create(global.flameParticleSystem,x,y,global.flameParticleType,1);
        }
    }
    if(!place_free(x+hspeed, y+vspeed)){
        vspeed=0;

        if !dying alarm[0] = flameLife / global.delta_factor;
        dying = true;      
    }
    wallUnsetSolid();
');
object_event_add(NapalmFlame,ev_collision,Sentry,'
    if(other.team != team) {
        damageSentry(ownerPlayer, other.id, hitDamage*0.7);
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        instance_destroy();
    }
');
object_event_add(NapalmFlame,ev_draw,0,'
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
');