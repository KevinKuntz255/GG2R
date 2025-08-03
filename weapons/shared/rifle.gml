globalvar RifleWeapon;
RifleWeapon = object_add();
object_set_parent(RifleWeapon, Weapon);

object_event_add(RifleWeapon, ev_create, 0, '
    xoffset = -1;
    yoffset = -4;
    refireTime = 40;
    event_inherited();
    reloadTime = 40;
    unscopedDamage = 25;
    baseDamage = 45;
    maxDamage = 75;
    chargeTime = 105;
    hitDamage=baseDamage;
    maxAmmo = 0;
    ammoCount = maxAmmo;
    shot = false;
    t = 0;

    weaponGrade = UNIQUE;
    weaponType = SMG;
    
    damSource = DAMAGE_SOURCE_RIFLE;

    if (!variable_local_exists("spriteBase")) spriteBase = "Rifle";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 4, 4);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 4, 1, 0, 4, 4);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FRS.png", 13, 1, 0, 16, 12);

    sprite_index = normalSprite;

    recoilTime = 15;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    longRecoilTime = 60;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;

    tracerAlpha = 0;
');

object_event_add(RifleWeapon, ev_alarm, 7, '
    if (global.particles == PARTICLES_NORMAL) {
        var shell;
        shell = instance_create(x, y, Shell);
        shell.direction = owner.aimDirection + (100 + random(30)) * image_xscale;
        shell.hspeed -= 1 * image_xscale;
        shell.vspeed -= 1;
        shell.image_index = 2;
    }
');

object_event_add(RifleWeapon, ev_step, ev_step_begin, '
    if(owner.zoomed and readyToShoot)
    {
        t += 1 * global.delta_factor;
        if (t > chargeTime)
            t = chargeTime;
    }
    else
        t = 0;
    if(!owner.zoomed)
        hitDamage = unscopedDamage;
    else
        hitDamage = baseDamage + floor(sqrt(t / chargeTime) * (maxDamage - baseDamage));
');

object_event_add(RifleWeapon, ev_step, ev_step_end, '
    if (justShot)
    {
        justShot = false;
        //Recoil Animation
        if (owner.zoomed)
        {
            if (sprite_index != reloadSprite)
            {
                sprite_index = reloadSprite
                image_index = 0
                image_speed = reloadImageSpeed;
            }
            alarm[6] = longRecoilTime;
        }
        else
        {
            if (sprite_index != recoilSprite)
            {
                sprite_index = recoilSprite
                image_index = 0
                image_speed = recoilImageSpeed;
            }
            alarm[6] = recoilTime;
        }
    }
');

object_event_add(RifleWeapon, ev_other, ev_user1, '
    if(readyToShoot and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');

object_event_add(RifleWeapon, ev_other, ev_user3, '
    playsound(x, y, SniperSnd);
    shot = true;
    justShot = true;
    readyToShoot = false;
    alarm[0] = (reloadTime + 20 * owner.zoomed) / global.delta_factor;
    alarm[7] = (reloadTime / 4 + 10 * owner.zoomed) / global.delta_factor;  // Eject a shell during the animation

    // for drawing:
    tracerAlpha = 0.8;
    shotx = x;
    shoty = y;

    var x1, y1, xm, ym, leftmostX, len;
    len = 1500*(((hitDamage*100)/maxDamage)/100)
    x1 = x;
    y1 = y;
    x2 = x+lengthdir_x(len, owner.aimDirection);
    y2 = y+lengthdir_y(len, owner.aimDirection);
    leftmostX = min(x1, x2);

    gunSetSolids();
    alarm[6] = alarm[0];

    // We do a hitscan test here to figure out how far the rifle shot actually goes before it hits something.
    // This works by binary search through collision_line tests on ever smaller segments of our ray.
    //
    // Unfortunately, collision_line can only check for collision against either *all* instances, or instances of one
    // object, or just a single instance. What we need however is to check against *some* instances of *some* objects.
    // 
    // We could make a list of all instances that should stop the bullet and check each of them individually, but that
    // could be slow.
    // 
    // So here is how we do this instead: We do several collision_line checks, but only on an object basis.
    // Those instances which are instances of those objects, but should not stop the bullets are set to an empty
    // collision mask, and that is reverted after we are done.

    var bulletStoppingObjects, originalMask, hitInstance;
    bulletStoppingObjects = ds_list_create();
    originalMask = ds_map_create();
    hitInstance = noone;

    ds_list_add(bulletStoppingObjects, Obstacle);
    ds_list_add(bulletStoppingObjects, Generator);
    ds_list_add(bulletStoppingObjects, Character);
    ds_list_add(bulletStoppingObjects, Sentry);
    if(!global.mapchanging)
        ds_list_add(bulletStoppingObjects, TeamGate);
    ds_list_add(bulletStoppingObjects, IntelGate);
    if(areSetupGatesClosed())
        ds_list_add(bulletStoppingObjects, ControlPointSetupGate);
    ds_list_add(bulletStoppingObjects, BulletWall);

    // Set the collision mask of all instances which should not collide to an empty one
    with(Generator) {
        if(team == other.owner.team) {
            ds_map_add(originalMask, id, mask_index);
            mask_index = emptyMaskS;
        }
    }

    with(Sentry) {
        if(team == other.owner.team) {
            ds_map_add(originalMask, id, mask_index);
            mask_index = emptyMaskS;
        }
    }

    with(owner) {
        ds_map_add(originalMask, id, mask_index);
        mask_index = emptyMaskS;
    }

    // Find the first instance the ray collides with
    var hit, i;
    while(len>1) {
        xm=(x1+x2)/2;
        ym=(y1+y2)/2;
        
        hit = noone;
        for(i = 0; (i < ds_list_size(bulletStoppingObjects)) and !hit; i += 1) {
            hit = collision_line(x1, y1, xm, ym, ds_list_find_value(bulletStoppingObjects, i), true, true);
        }
        
        if(hit) {
            x2=xm;
            y2=ym;
            hitInstance = hit;
            if (variable_local_exists("target")) target = hitInstance;
        } else {
            x1=xm;
            y1=ym;
        }
        len/=2;
    }

    // Re-assign the original collision masks
    var key, origMask;
    for(key = ds_map_find_first(originalMask); key; key = ds_map_find_next(originalMask, key)) {
        origMask = ds_map_find_value(originalMask, key);
        with(key) {
            mask_index = origMask;
        }
    }

    ds_map_destroy(originalMask);
    ds_list_destroy(bulletStoppingObjects);

    // Apply dramatic effect
    with(hitInstance) {
        if(object_index == Character or object_is_ancestor(object_index, Character)) {
            if(!ubered and !radioactive and team != other.owner.team) {
                damageCharacter(other.ownerPlayer, id, other.hitDamage);
                if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player)
                {
                    secondToLastDamageDealer = lastDamageDealer;
                    alarm[4] = alarm[3]
                }
                alarm[3] = ASSIST_TIME / global.delta_factor;
                lastDamageDealer = other.ownerPlayer;
                dealFlicker(id);
                if(global.gibLevel > 0)
                {
                    blood = instance_create(x, y, Blood);
                    blood.direction = other.owner.aimDirection - 180;
                }
                if (!other.owner.zoomed) {
                    lastDamageSource = DAMAGE_SOURCE_RIFLE;
                } else {
                    lastDamageSource = DAMAGE_SOURCE_RIFLE_CHARGED;
                }
            }
        } else if(object_index == Sentry or object_is_ancestor(object_index, Sentry)) {
            damageSentry(other.ownerPlayer, id, other.hitDamage);
            lastDamageDealer = other.ownerPlayer;
            if (!other.owner.zoomed)
                lastDamageSource = DAMAGE_SOURCE_RIFLE;
            else
                lastDamageSource = DAMAGE_SOURCE_RIFLE_CHARGED;
        } else if(object_index == Generator or object_is_ancestor(object_index, Generator)) {
            damageGenerator(other.ownerPlayer, id, other.hitDamage);
        }
    }

    gunUnsetSolids();
');

object_event_add(RifleWeapon, ev_draw, 0, '
    event_inherited();
    if (tracerAlpha > 0.05)
    {
        shot = false;
        var origdepth;
        origdepth = depth;
        depth = -2;
        
        draw_set_alpha(tracerAlpha);
        if(owner.team == TEAM_RED)
            draw_line_width_color(shotx,shoty,x2,y2,2,c_red,c_red);
        else
            draw_line_width_color(shotx,shoty,x2,y2,2,c_blue,c_blue);
        if(global.particles != PARTICLES_OFF)
            tracerAlpha /= delta_mult(1.75);
        else tracerAlpha = 0;
            
        draw_set_alpha(1);
        depth = origdepth;
    }
    else
        tracerAlpha = 0;

    if (owner.zoomed && owner == global.myself.object)
    {
        if (hitDamage < maxDamage)
        {
            draw_set_alpha(0.25);
            draw_sprite_ext(ChargeS, 0, mouse_x + 15*-image_xscale, mouse_y - 10, -image_xscale, 1, 0, c_white, image_alpha);
            draw_set_alpha(0.8);
        }
        else
            draw_sprite_ext(FullChargeS, 0, mouse_x + 65*-image_xscale, mouse_y, 1, 1, 0, c_white, image_alpha);
            draw_sprite_part_ext(ChargeS, 1, 0, 0, ceil((hitDamage-baseDamage)*40/(maxDamage-baseDamage)), 20, mouse_x + 15*-image_xscale, mouse_y - 10, -image_xscale, 1, c_white, image_alpha);
    }
');