globalvar JumperMine, JumperMineS;
JumperMine = object_add();
//JumperMineS = sprite_add(pluginFilePath + "\randomizer_sprites\JumperMineS.png", 2, 1, 0, 10, 6);
JumperMineS = sprite_add(pluginFilePath + "\randomizer_sprites\JumperMineS.png", 4, 0, 0, 4, 2);
object_set_sprite(JumperMine, JumperMineS);
object_set_parent(JumperMine, Mine);

// modify variables
object_event_add(JumperMine, ev_create, 0, '
    event_inherited();
    explosionDamage = 0;
    splashThreshold = false;
    knockback = 20; // boost knockback
    blastRadius = 60;
');

object_event_add(JumperMine, ev_other, ev_user2, '
    if(exploded == true) {
        exit;
    } else {
        exploded = true;
    }
    var explosion;
    explosion = instance_create(x,y,Explosion);
    explosion.sprite_index = ExplosionSmallS;
    playsound(x,y,ExplosionSnd);

    with (Character) {
        if (distance_to_object(other) < other.blastRadius)
        {
            var rdir, vectorfactor;
            rdir = point_direction(other.x, other.y, x+(left_bound_offset+right_bound_offset)/2, y+(top_bound_offset+bottom_bound_offset)/2);
            vectorfactor = point_distance(0, 0, sin(degtorad(rdir)), cos(degtorad(rdir))*0.8);
            motion_add(rdir, min(15, other.knockback-other.knockback*(distance_to_object(other)/other.blastRadius)) * vectorfactor);
            moveStatus = 4;
        }
    }

    instance_destroy();
');