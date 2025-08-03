globalvar WEAPON_FROSTBITE;
WEAPON_FROSTBITE = 83;

globalvar Frostbite;
Frostbite = object_add();
object_set_parent(Frostbite, FlameWeapon);

object_event_add(Frostbite,ev_create,0,'
    xoffset = -3;
    yoffset = 6;
    spriteBase = "Frostbite";
    event_inherited();
    specialFlame = Snowflake;
');

object_event_add(Frostbite,ev_other,ev_user2,'
    if (readyToBlast && ammoCount >= 40)
    {
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
					motion_add(other.owner.aimDirection, other.characterBlastStrength*(1+(cos(degtorad(angle))/2)));
                    vspeed -= 2;
                    moveStatus = 1;
					damageCharacter(ownerPlayer.object, other.id, (15*(1-dist/other.blastDistance))+15);
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

object_event_add(Frostbite,ev_draw,0,'
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

global.weapons[WEAPON_FROSTBITE] = Frostbite;
global.name[WEAPON_FROSTBITE] = "Frostbite";
