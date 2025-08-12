globalvar FlameWeapon;
FlameWeapon = object_add();
object_set_parent(FlameWeapon, Weapon);

object_event_add(FlameWeapon, ev_create, 0, '
    refireTime = 1;
    event_inherited();

    blastDistance = 150;
    blastAngle = 75;
    blastStrength = 28;
    characterBlastStrength = 15;
    blastNoFlameTime = 15;
    blastReloadTime = 40;
    flareReloadTime = 55;

    with(owner) { // reminder: activeWeapon is modified before Weapon ev_create is called
        with (player)
            if (!variable_local_exists("activeWeapon")) exit;
            if !variable_local_exists("PrimaryRefireTime")  other.alarm[1] = other.blastReloadTime / global.delta_factor;
            if !variable_local_exists("reloadFlare") other.alarm[2] = other.flareReloadTime / global.delta_factor;
    }
    readyToBlast = false;
    readyToFlare = false;
    justBlast = false;
    
    maxAmmo = 200
    ammoCount = maxAmmo;
    soundLoopTime = 30;
    currentTime = 0;
    
    flameDrain = 1.8;
    flameDamage = 3.14;
    blastDrain = 40;

    reloadBuffer = 7;
    isRefilling = false;

    specialFlame = Flame;

    weaponGrade = UNIQUE;
    weaponType = FLAMETHROWER;

    if !variable_local_exists("spriteBase") spriteBase = "Backburner"

    // borrowed from Flame projectile
    flameLife = 15;
    burnIncrease = 1.35;
    durationIncrease = 30; // Transmutator exclusive
    afterburnFalloff = true;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, 2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 2, 1, 0, 8, 2);
    blastSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, 2);
    dropSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, 2);
    reloadSprite = -1;

    sprite_index = normalSprite;

    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    blastAnimLength = sprite_get_number(blastSprite) / 2;
    blastImageSpeed = blastAnimLength / blastNoFlameTime;

    dropTime = 4;
    dropAnimLength = sprite_get_number(dropSprite) / 2;
    dropImageSpeed = dropAnimLength / dropTime;
');

object_event_add(FlameWeapon, ev_destroy, 0, '
    loopsoundstop(FlamethrowerSnd);
');

object_event_add(FlameWeapon, ev_alarm, 1, '
    readyToBlast = true;
');

object_event_add(FlameWeapon, ev_alarm, 2, '
    readyToFlare = true;
');

object_event_add(FlameWeapon, ev_alarm, 3, '
    loopsoundstop(FlamethrowerSnd);
');

object_event_add(FlameWeapon, ev_alarm, 5, '
    isRefilling = true;
');

object_event_add(FlameWeapon, ev_alarm, 6, '
    //Override this if we are airblasting
    if (sprite_index != blastSprite) {
        sprite_index = dropSprite;
        image_speed = dropImageSpeed * global.delta_factor;
        image_index = 0;
        alarm[7] = dropTime / global.delta_factor;
    }
');

object_event_add(FlameWeapon, ev_alarm, 7, '
    sprite_index = normalSprite;
    image_speed = 0;
');

object_event_add(FlameWeapon, ev_step, ev_step_begin, '
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo and isRefilling)
        ammoCount += 1.8 * global.delta_factor;
');

object_event_add(FlameWeapon, ev_step, ev_step_end, '
    event_inherited();
    if (justBlast)
    {
        justBlast = false;
        //Airblast Recoil Animation
        sprite_index = blastSprite;
        image_index = 0;
        image_speed = blastImageSpeed * global.delta_factor;
        alarm[7] = blastNoFlameTime / global.delta_factor;
        alarm[6] = 0;
    }
');

object_event_add(FlameWeapon, ev_other, ev_user1, '
    var newx, newy;
    newx = x+lengthdir_x(25,owner.aimDirection);
    newy = y+lengthdir_y(25,owner.aimDirection) + owner.equipmentOffset;
    // prevent sputtering
    if (ammoCount < flameDrain)
        ammoCount -= flameDrain;
    if (readyToShoot and ammoCount >= 1.8
        and !collision_line_bulletblocking(x,y,newx,newy))
    {
        if(alarm[3] <= 0)
            loopsoundstart(x,y,FlamethrowerSnd);
        else
            loopsoundmaintain(x,y,FlamethrowerSnd);
        alarm[3] = 2 / global.delta_factor;
        
        var shot, calculatedspread;
        randomize();
        calculatedspread = sign(random(2)-1)*power(random(3), 1.8);
        calculatedspread *= 1 - hspeed/owner.basemaxspeed;
        shot = createShot(newx, newy, specialFlame, DAMAGE_SOURCE_FLAMETHROWER, owner.aimDirection+calculatedspread,6.5+random(3.5));
        with(shot) {
            motion_add(owner.direction, owner.speed);
            durationIncrease  = other.durationIncrease;
        }
        
        justShot=true;
        readyToShoot=false;
        isRefilling = false;
        ammoCount -= flameDrain;
        
        if (ammoCount > 0)
            alarm[0] = refireTime / global.delta_factor;
        else
            alarm[0] = reloadBuffer*2 / global.delta_factor;
        alarm[5] = reloadBuffer / global.delta_factor;
    }
');

object_event_add(FlameWeapon, ev_other, ev_user2, '
    if (readyToBlast && ammoCount >= 40) {
        //Base
        playsound(x,y,CompressionBlastSnd);
        poof = instance_create(x+lengthdir_x(25,owner.aimDirection),y+lengthdir_y(25,owner.aimDirection),AirBlastO);
        if (image_xscale == 1)
        {
            poof.image_xscale = 1;
            poof.image_angle = owner.aimDirection;
        }
        else
        {
            poof.image_xscale = -1;
            poof.image_angle = owner.aimDirection+180;
        }
        poof.owner = owner;
        with(poof)
            motion_add(owner.direction, owner.speed * global.delta_factor);
        
        var shot;
        //Flare
        if (owner.keyState & $10 and ammoCount >= 75 and readyToFlare)
        {
            var newx, newy;
            newx = x+lengthdir_x(25,owner.aimDirection);
            newy = y+lengthdir_y(25,owner.aimDirection);
            if !collision_line_bulletblocking(x, y, newx, newy)
            {
                shot = createShot(newx,newy,Flare, DAMAGE_SOURCE_FLARE, owner.aimDirection, 15);                
                justShot=true;
                readyToFlare=false;
                ammoCount -= 35;
                alarm[2] = flareReloadTime / global.delta_factor;
            }
        }
            
        //Reflects
        with(Rocket)
        {
            if(ownerPlayer.team != other.owner.team)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if collision_circle(x,y,5,other.poof,false,true)
                {
                    ownerPlayer = other.ownerPlayer;
                    team = other.owner.team;
                    weapon = DAMAGE_SOURCE_REFLECTED_ROCKET;
                    hitDamage = 25;
                    explosionDamage = 30;
                    knockback = 8;
                    alarm[1] = 40 / global.delta_factor;
                    alarm[2] = 80 / global.delta_factor;
                    motion_set(other.owner.aimDirection, speed);
                }
            }
        }
        with(Flare)
        {
            if(ownerPlayer.team != other.owner.team)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if collision_circle(x,y,5,other.poof,false,true)
                {
                    ownerPlayer = other.ownerPlayer;
                    team = other.owner.team;
                    weapon = DAMAGE_SOURCE_REFLECTED_FLARE;
                    alarm[0]=40 / global.delta_factor;
                    
                    motion_set(other.owner.aimDirection, speed);
                }
            }
        }
        
        with(Mine)
        {
            if(ownerPlayer.team != other.owner.team)
            {
                dir = point_direction(other.x, other.y, x, y);
                dist = point_distance(other.x, other.y, x, y);
                angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                if collision_circle(x,y,5,other.poof,false,true)
                {
                    motion_set(other.owner.aimDirection, max(speed, other.blastStrength / 3));
                    reflector = other.ownerPlayer;
                    if (stickied)
                    {
                        var dx, dy, l;
                        speed *= 0.65;
                        dy = (place_meeting(x,y-3,Obstacle) > 0);
                        dy -= (place_meeting(x,y+3,Obstacle) > 0);
                        dx = (place_meeting(x-3,y,Obstacle) > 0);
                        dx -= (place_meeting(x+3,y,Obstacle) > 0);
                        l = sqrt(dx*dx+dy*dy);
                        if(l>0)
                        {
                            var normalspeed;
                            dx /= l;
                            dy /= l;
                            normalspeed = dx*hspeed + dy*vspeed;
                            if(normalspeed < 0)
                            {
                                hspeed -= 2*normalspeed*dx;
                                vspeed -= 2*normalspeed*dy;
                            }
                        }
                        stickied = false;
                    }
                }
            }
        }
        
        with(Character)
        {
            dir = point_direction(other.x, other.y, x, y);
            dist = point_distance(other.x, other.y, x, y);
            angle = abs((dir-other.owner.aimDirection)+720) mod 360;
            if (collision_circle(x,y,25,other.poof,false,true))
            {
                //Shoves
                if (team != other.owner.team)
                {
                    motion_add(other.owner.aimDirection,
                               other.characterBlastStrength*(1-dist/other.blastDistance));
                    vspeed -= 2;
                    moveStatus = 3;
                    if (lastDamageDealer != other.ownerPlayer and lastDamageDealer != player)
                    {
                        secondToLastDamageDealer = lastDamageDealer;
                        alarm[4] = alarm[3];
                    }
                    alarm[3] = ASSIST_TIME / global.delta_factor;
                    lastDamageDealer = other.ownerPlayer;
                    lastDamageSource = -1;
                } 
                //Extinguishes
                else if (burnIntensity > 0 or burnDuration > 0)
                {
                    for(i = 0; i < realnumflames; i += 1)
                    {
                        var f;
                        f = instance_create(x + flameArray_x[i], y + flameArray_y[i], Flame);
                        f.direction = other.owner.aimDirection;
                        f.speed = 6.5+random(2.5);
                        f.owner = other.owner;
                        f.ownerPlayer = other.ownerPlayer;
                        f.team = other.owner.team;
                        f.weapon = DAMAGE_SOURCE_FLAMETHROWER;
                        with(f)
                            motion_add(direction, speed);
                    }
                    burnIntensity = 0;
                    burnDuration = 0;
                    burnedBy = -1;
                    afterburnSource = -1;
                }
            }
        }
        
        with(LooseSheet)
        {
            dir = point_direction(other.x, other.y, x, y);
            dist = point_distance(other.x, other.y, x, y);
            angle = abs((dir-other.owner.aimDirection)+720) mod 360;
            if collision_circle(x,y,25,other.poof,false,true)
            {
                motion_add(other.owner.aimDirection, other.blastStrength*(1-dist/other.blastDistance) );
            }
        }
        
        with(Gib)
        {
            dir = point_direction(other.x, other.y, x, y);
            dist = point_distance(other.x, other.y, x, y);
            angle = abs((dir-other.owner.aimDirection)+720) mod 360;
            if collision_circle(x,y,25,other.poof,false,true)
            {
                motion_add(other.owner.aimDirection, other.blastStrength*(1-dist/other.blastDistance) );
            }
        }
        
        //Finish
        justBlast = true;
        readyToBlast=false;
        readyToShoot=false;
        alarm[5]=blastReloadTime / global.delta_factor;
        isRefilling = false;
        alarm[1]=blastReloadTime / global.delta_factor;
        alarm[0]=blastNoFlameTime / global.delta_factor;
        ammoCount -= blastDrain;
    }
');

object_event_add(FlameWeapon, ev_draw, 0, '
    if(owner.taunting)
        exit;
        
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset) + owner.equipmentOffset;
    if (alarm[6] <= 0){
        if (alarm[7] > 0) {
            //if we are not shooting but airblasting/dropping
            if (sprite_index == dropSprite) {
                imageOffset = floor(image_index mod dropAnimLength) + dropAnimLength*owner.team
            }else if (sprite_index == blastSprite){
                imageOffset = floor(image_index mod blastAnimLength) + blastAnimLength*owner.team
            }
        }else{
            //set the sprite to idle
            imageOffset = owner.team;
        }
    }else{
        //We are shooting loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }


    if !owner.player.humiliated draw_sprite_ext(sprite_index,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_white, 1);
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }
');
