globalvar NatachaShot;
NatachaShot = object_add();
object_set_sprite(NatachaShot, ShotS);
object_set_parent(NatachaShot, Shot);
object_event_add(NatachaShot,ev_create,0,'
    {
        hitDamage = 6;
        lifetime = 40;
        alarm[0] = lifetime / global.delta_factor;
        originx=x;
        originy=y;
            
        // Controls whether this bullet penetrates bubbles or not
        // Also controls whether this bullet destroys friendly bubbles
        perseverant = choose(0, 0, 1); // 1/3 chance
    }
');
object_event_add(NatachaShot,ev_alarm,0,'
    instance_destroy();
');
object_event_add(NatachaShot,ev_collision,Character,'
    gunSetSolids();
    if (!place_free(x, y)) 
    {
        instance_destroy();
        gunUnsetSolids();
        exit;
    }
    gunUnsetSolids();

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
            motion_add(other.direction, other.speed*0.1);
            speed*=0.95;
        }
        instance_destroy();
    }
');