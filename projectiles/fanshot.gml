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
            other.alarm[4] = other.alarm[3];
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