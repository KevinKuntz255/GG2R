globalvar WEAPON_TRANSMUTATOR;
WEAPON_TRANSMUTATOR = 82;

globalvar Transmutator;
Transmutator = object_add();
object_set_parent(Transmutator, FlameWeapon);

object_event_add(Transmutator,ev_create,0,'
    xoffset = -3;
    yoffset = 6;
    spriteBase = "Transmutator";
    event_inherited();
    durationIncrease = 10.2;
');

object_event_add(Transmutator,ev_other,ev_user2,'
    {
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
						instance_destroy();
						other.owner.hp = min(other.owner.maxHp, other.owner.hp+15);
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
                        instance_destroy();
						other.owner.hp = min(other.owner.maxHp, other.owner.hp+15);
                    }
                }
            }
			
			with(Arrow)
            {
                if(ownerPlayer.team != other.owner.team && attached == -1)
                {
                    dir = point_direction(other.x, other.y, x, y);
                    dist = point_distance(other.x, other.y, x, y);
                    angle = abs((dir-other.owner.aimDirection)+720) mod 360;
                    if collision_circle(x,y,5,other.poof,false,true)
                    {
                        instance_destroy();
						other.owner.hp = min(other.owner.maxHp, other.owner.hp+speed+10);
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
						instance_destroy();
						if stickied other.owner.hp = min(other.owner.maxHp, other.owner.hp+5); 
						else other.owner.hp = min(other.owner.maxHp, other.owner.hp+15); 
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
                                   -other.characterBlastStrength*(1-dist/other.blastDistance)*1.3);
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
            ammoCount -= 40;
        }
    }
');

global.weapons[WEAPON_TRANSMUTATOR] = Transmutator;
global.name[WEAPON_TRANSMUTATOR] = "Transmutator";
