globalvar Sandvich;
Sandvich = object_add();
object_set_sprite(Sandvich, sprite_add(pluginFilePath + "\randomizer_sprites\Sandvich2S.png", 7, 1, 0, 8, 6));
object_set_parent(Sandvich, Gib);
object_event_add(Sandvich,ev_create,0,'
    image_speed = 0.2;
    bloodchance=99999;
    snd=false;
    hfric=0.4;
    rotfric=0.6;
    direction = 270;
    alarm[0]=210 / global.delta_factor;
    rotspeed=0;
    fadeout = false;
    vis_angle = 0;
    air_friction = power(0.97, global.delta_factor);
    my_gravity = 0.7 * global.delta_factor;
    maxBloodiness = 1;
    bloodiness = maxBloodiness;
');
object_event_add(Sandvich,ev_collision,Character,'
    if other.team=team && other.hp<other.maxHp && other.player != ownerPlayer {
        //other.hp += other.maxHp
        other.burnIntensity = 0;
        other.burnDuration = 0;
        other.hp += 40;
        if other.hp > other.maxHp other.hp = other.maxHp;
        instance_destroy()
    }
');