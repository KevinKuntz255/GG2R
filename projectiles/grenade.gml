globalvar Grenade, GrenadeS;
Grenade = object_add();
//GrenadeS = sprite_add(pluginFilePath + "\randomizer_sprites\GrenadeS.png", 2, 1, 0, 10, 6);
GrenadeS = sprite_add(pluginFilePath + "\randomizer_sprites\PipeS.png", 2, 0, 0, 4, 2);
object_set_sprite(Grenade, GrenadeS);
object_set_parent(Grenade, Mine);

// modify variables
object_event_add(Grenade, ev_create, 0, '
    event_inherited();
    {
        blastRadius = 60;
        alarm[2] = 60 / global.delta_factor;
        alarm[3] = 24 / global.delta_factor;
        hfric=0.5;
        rotfric=0.7;
        hitSelf = false;
        rotspeed=random(20)-10;
        image_speed=0;
        used=0;
        perseverant = choose(0, 0, 1); // 1/3 chance
        index = 0;
    }
');

object_event_add(Grenade,ev_alarm,2,'
    event_user(2);
');

object_event_add(Grenade,ev_alarm,3,'
    hitSelf = true; // stop self-damage when shooting under your feet
');

object_event_add(Grenade,ev_collision,Character,'
    if(other.id == ownerPlayer.object && !hitSelf) exit;
    event_user(2);
');

object_event_add(Grenade,ev_collision,Sentry,'
    if (other.team != team) event_user(2);
');

object_event_add(Grenade, ev_step, ev_step_begin, '      
    if (global.particles == PARTICLES_NORMAL && index > 1) {
        effect_create_above(ef_smokeup, x, y, 0, c_gray);
        index = 0;
    }
    index += 0.3 * global.delta_factor;
    
    if(!variable_local_exists("firststep")) firststep = true;
    
    vspeed += 0.6 * global.delta_factor;
    image_angle = direction;
    
    if(!firststep && global.delta_factor != 1) {
        x += hspeed * global.delta_factor;
        y += vspeed * global.delta_factor;
        x -= hspeed;
        y -= vspeed;
    } else {
        firststep = false;
    }
    
    gunSetSolids();
    if (!place_free(x + hspeed, y + vspeed)) {
        if (place_free(x + hspeed, y)) {
            hspeed *= 0.85;
            vspeed *= -0.75;
        } else {
            speed *= -1;
        }
        playsound(x,y,ImpactSnd);
        hitSelf = true;
    }
    gunUnsetSolids();
');

object_event_add(Grenade, ev_draw, 0, '
    draw_sprite_ext(GrenadeS, ownerPlayer.team, x, y, 1, 1, image_angle, c_white, 1);
');
/*
same code cut from Ball, JarOPiss, etc.
object_event_add(Grenade, ev_other, ev_user12, '
    if(global.updateType == QUICK_UPDATE or global.updateType == FULL_UPDATE) {
        write_ushort(global.serializeBuffer, round(x*5));
        write_ushort(global.serializeBuffer, round(y*5));
        write_byte(global.serializeBuffer, round(hspeed*5));
        write_byte(global.serializeBuffer, round(vspeed*5));
    }
');
object_event_add(Grenade, ev_other, ev_user12, '
    if(global.updateType == QUICK_UPDATE or global.updateType == FULL_UPDATE) {
        receiveCompleteMessage(global.serverSocket, 7, global.deserializeBuffer);

        x = read_ushort(global.deserializeBuffer)/5;
        y = read_ushort(global.deserializeBuffer)/5;
        hspeed = read_byte(global.deserializeBuffer)/5;
        vspeed = read_byte(global.deserializeBuffer)/5;
    }
');
*/