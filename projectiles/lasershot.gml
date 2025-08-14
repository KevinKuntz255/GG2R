globalvar LaserShot;
LaserShot = object_add();
globalvar LaserShotS;
LaserShotS = sprite_add(pluginFilePath + "\randomizer_sprites\LaserShotS.png", 4, 1, 0, 19, 5);
object_set_sprite(LaserShot, LaserShotS);
object_set_parent(LaserShot, Shot);
object_event_add(LaserShot,ev_create,0,'
    {
        hitDamage = 16;
        lifetime = 40;
        alarm[0] = lifetime / global.delta_factor;
        originx=x;
        originy=y;
        used=false;
    }
');
object_event_add(LaserShot,ev_alarm,0,'
    instance_destroy();
');
object_event_add(LaserShot,ev_step,ev_step_normal,'
    {
        //vspeed+=0.1;
        if(global.particles != PARTICLES_OFF) {
            //We do not want it to be almost invisible if its still active, so
            //we have it as if 0.3 is its lower limit
            image_alpha = (alarm[0]/lifetime)/2+0.5;
        }
        image_angle=direction;
    }
');
object_event_add(LaserShot,ev_collision,Obstacle,'
    {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(LaserShot,ev_collision,Character,'
        if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0) {
            if weapon == WEAPON_POMSON {
                if !used {
                    used = true;
                    with(other) {
                        if (loaded1 >= WEAPON_MEDIGUN && loaded1 <= WEAPON_POTION) or (loaded2 >= WEAPON_MEDIGUN && loaded2 <= WEAPON_POTION){
                            ammo[WEAPON_MEDIGUN] = max(0,ammo[WEAPON_MEDIGUN]-17.5);
                            ammo[WEAPON_KRITSKRIEG] = max(0,ammo[WEAPON_KRITSKRIEG]-17.5);
                            ammo[WEAPON_OVERHEALER] = max(0,ammo[WEAPON_OVERHEALER]-17.5);
                            ammo[WEAPON_QUICKFIX] = max(0,ammo[WEAPON_QUICKFIX]-17.5);
                            ammo[WEAPON_POTION] = max(0,ammo[WEAPON_POTION]-17.5);
                            ammo[100] = 0;
                        } else if cloak cloakAlpha = 1;
                        else other.used = 0;
                        if (weapon_index >= WEAPON_MEDIGUN && weapon_index <= WEAPON_POTION) {
                            //currentWeapon.ammoCount = max0,currentWeapon.ammoCount-140);
                            currentWeapon.uberCharge =  max(0,currentWeapon.uberCharge-140);
                            currentWeapon.uberReady = false;
                        }
                    }
                }
            }
			hitDamage *= (1+0*0.35)*1;
            damageCharacter(ownerPlayer, other.id, hitDamage);

            if (other.lastDamageDealer != ownerPlayer && other.lastDamageDealer != other.player){
                other.secondToLastDamageDealer = other.lastDamageDealer;
                other.alarm[4] = other.alarm[3];
            }
            other.alarm[3] = ASSIST_TIME / global.delta_factor;
            other.lastDamageDealer = ownerPlayer;
            other.lastDamageSource = weapon;
            var blood;
            if(global.gibLevel > 0 && !other.radioactive){
                blood = instance_create(x,y,Blood);
                blood.direction = direction-180;
                }
            
            with(other) {
                motion_add(other.direction, other.speed*0.03);
                cloakAlpha = min(cloakAlpha + 0.1, 1);    
                }
        }
');
object_event_add(LaserShot,ev_collision,TeamGate,'
    {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(LaserShot,ev_collision,Sentry,'
    if(other.team != team) {
        /* FALL OFF
        if (distance_to_point(originx,originy)<=(maxdist/2)){
                    hitDamage = ((0.25*baseDamage)*((0.5*maxdist - distance_to_point(originx,originy))/(0.5*maxdist)))+baseDamage;
                    }
                    else hitDamage = (((maxdist - distance_to_point(originx,originy))/(maxdist/2))*(0.75*baseDamage))+(0.25*baseDamage);
                    */
        var thp;
        thp = hitDamage*(1+0*0.35)*1;
        if(other.currentWeapon > -1 and other.humiliated = 0){if(other.currentWeapon.wrangled) thp /= 2}
        other.hp -= thp
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        }
');
object_event_add(LaserShot,ev_collision,Bubble,'
    if(team != other.team)
        instance_destroy();
');
object_event_add(LaserShot,ev_collision,BulletWall,'
    {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(LaserShot,ev_collision,ControlPointSetupGate,'
    if global.setupTimer >0 {
        var imp;
        move_contact_solid(direction, speed);
        imp = instance_create(x,y,Impact);
        imp.image_angle=direction;
        instance_destroy();
    }
');
object_event_add(LaserShot,ev_collision,Generator,'
    if(other.team != team) {
        other.alarm[0] = other.regenerationBuffer / global.delta_factor;
        other.isShieldRegenerating = false;
        //allow overkill to be applied directly to the target
        if (hitDamage > other.shieldHp) {
            other.hp -= hitDamage - other.shieldHp;
            other.hp -= other.shieldHp * other.shieldResistance;
            other.shieldHp = 0;
        } else {
            other.hp -= hitDamage * other.shieldResistance;
            other.shieldHp -= hitDamage;
        }
        instance_destroy();
    }
');
object_event_add(LaserShot,ev_draw,0,'
    if 1 > 1 offset = 2
    else offset = 0;

    draw_sprite_ext(sprite_index,team+offset,x,y,image_xscale,image_yscale,image_angle,c_white,image_alpha);
');