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
MGShotS = sprite_add(pluginFilePath + '\randomizer_sprites\MGShotS.png', 2, 0, 0, 11, 4);
MGShotMaskS = sprite_add(pluginFilePath + '\randomizer_sprites\MGShotMaskS.png', 1, 0, 0, 11, 4);
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