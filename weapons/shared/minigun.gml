globalvar MinigunWeapon;
MinigunWeapon = object_add();
object_set_parent(MinigunWeapon, Weapon);

object_event_add(MinigunWeapon, ev_create, 0, '
    event_inherited();

    sndlooping = false;
    maxAmmo = 200;
    ammoCount = maxAmmo;
    reloadBuffer = 15;
    weaponGrade = UNIQUE;
    weaponType = MINIGUN;
    idle = true;
    depth = -1;

    damSource = DAMAGE_SOURCE_MINIGUN;

    specialShot = -1;
    shotDamage = -1;
    shotSpeed[0] = -1;
    shotSpeed[1] = -1;
    shotDir[0] = 14;
    shotDir[1] = 7;

    shotDamage = 7;
    isRefilling = true;

    if (!variable_local_exists("spriteBase")) spriteBase = "Minigun";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 4, 1, 0, 8, -1);
    reloadSprite = -1;

    sprite_index = normalSprite;

    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;
');

object_event_add(MinigunWeapon, ev_alarm, 5, '
    isRefilling = true;
');

object_event_add(MinigunWeapon, ev_alarm, 6, '
    //Reset the sprite
    sprite_index = normalSprite;
    image_speed = 0;
');

object_event_add(MinigunWeapon, ev_step, ev_step_begin, '
    if (ammoCount < 0)
        ammoCount = 0;
    else if (ammoCount <= maxAmmo and isRefilling)
        ammoCount += 1 * global.delta_factor;
    if(!readyToShoot and alarm[5] < (25 / global.delta_factor) and !isRefilling)
        alarm[5] += 1;
');

object_event_add(MinigunWeapon, ev_other, ev_user1,'
    // prevent sputtering
            if (ammoCount < 2)
                ammoCount -= 2;
            if(readyToShoot and ammoCount >= 2)
            {
                playsound(x,y,ChaingunSnd);
                var shot, shotx, shoty;
                randomize();
                
                shotx = x+lengthdir_x(20,owner.aimDirection);
                shoty = y+12+lengthdir_y(20,owner.aimDirection);
                if(!collision_line_bulletblocking(x, y, shotx, shoty))
                {
                    if (specialShot != -1) shot = createShot(shotx, shoty, specialShot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(shotDir[0])-shotDir[1]), 12+random(1)); else shot = createShot(shotx, shoty, Shot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(shotDir[0])-shotDir[1]), 12+random(1));
                    shot.hspeed += owner.hspeed;
                    shot.alarm[0] = 30 / global.delta_factor;
                    shot.weapon = id;
                    if shotDamage != -1 shot.hitDamage = shotDamage;
                }
                else
                {
                    var imp;
                    imp = instance_create(shotx, shoty, Impact);
                    imp.image_angle = owner.aimDirection;
                }

                
                justShot=true;
                readyToShoot=false;
                isRefilling = false;
                ammoCount -= 3;
                
                var reloadBufferFactor;
                if(ammoCount < 3)
                    reloadBufferFactor = 2.5;
                else
                    //reloadBufferFactor = 1+(cos((ammoCount+2.2)/maxAmmo*pi)+1)/2; // spline from (full ammo = 1*) to (empty ammo = 2*)
                    reloadBufferFactor = 1;
                
                alarm[0] = refireTime / global.delta_factor;
                alarm[5] = reloadBuffer*reloadBufferFactor / global.delta_factor;
                
                if (global.particles == PARTICLES_NORMAL)
                {
                    var shell;
                    shell = instance_create(x, y+4, Shell);
                    shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
                }
            }
');

object_event_add(MinigunWeapon, ev_draw, 0, '
    if(owner.taunting or owner.omnomnomnom or owner.player.humiliated)
        exit;
    var imageOffset, xdrawpos, ydrawpos;
    imageOffset = owner.team;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset);
    if (alarm[6] <= 0){
        //set the sprite to idle
        imageOffset = owner.team;
    }else{
        //We are shooting, loop the shoot animation
        imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
    }
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,c_white,image_alpha);
        /*if (sprite_index == normalSprite) {
             draw_sprite_ext(overlaySprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }else if (sprite_index == recoilSprite) {
            draw_sprite_ext(overlayFiringSprite,imageOffset, xdrawpos, ydrawpos, image_xscale, image_yscale, image_angle, c_red,0.5*(1-(ammoCount/maxAmmo)));
        }*/
        
    if (owner.ubered) {
        if owner.team == TEAM_RED
            ubercolour = c_red;
        else if owner.team == TEAM_BLUE
            ubercolour = c_blue;
        draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
    }
');