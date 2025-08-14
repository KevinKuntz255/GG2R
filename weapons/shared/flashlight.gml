globalvar FlashlightWeapon;
FlashlightWeapon = object_add();
object_set_parent(FlashlightWeapon, Weapon);

object_event_add(FlashlightWeapon,ev_create,0, '
    xoffset = 3;
    yoffset = -6;
    refireTime= 10;
    event_inherited();
    maxAmmo = 4;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 10;
    idle=true;
    shot = 0;
    hitDamage = 12;

    fullReload = false;

    weaponGrade = UNIQUE;
    weaponType = FLASHLIGHT;
    shotDamage = 12;

    if (!variable_local_exists("spriteBase")) spriteBase = "Lasergun";
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, -2);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 4, 1, 0, 8, -2);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, -2);

    sprite_index = normalSprite;
    
    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(FlashlightWeapon, ev_alarm, 5, '
    event_inherited();

    if (ammoCount < maxAmmo)
    {
        if fullReload ammoCount = maxAmmo; else ammoCount += 1;
    }
    if (ammoCount < maxAmmo)
    {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');

object_event_add(FlashlightWeapon, ev_other, ev_user1, '
    if(readyToShoot and ammoCount > 0 and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');

object_event_add(FlashlightWeapon,ev_other,ev_user3, '
    playsound(x,y,FlashlightSnd);
    shot = true;
    justShot = true;        
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    ammoCount=max(0, ammoCount-1);
    
    var hit i;
    
    for(i=0;i<3;i+=1) {
        var x1,y1,xm,ym, len;
        var hitline;
        len=400;
        x1=x;
        y1=y;
        a[i]=x+lengthdir_x(len,owner.aimDirection-3+i*3);
        b[i]=y+lengthdir_y(len,owner.aimDirection-3+i*3);
        
        while(len>1) {
            xm=(x1+a[i])/2;
            ym=(y1+b[i])/2;
            
            hitline = false;
            with(owner) {
                if (collision_line(x1,y1,xm,ym,Generator,true,true)>=0) {
                    hitline = true;
                    if instance_nearest(x1,y1,Generator).team == team hitline = false;
                }
                if(collision_line(x1,y1,xm,ym,Obstacle,true,true)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,Character,true,true)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,Sentry,true,false)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,TeamGate,true,true)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,IntelGate,true,true)>=0) {
                    hitline = true;
                } else if (collision_line(x1,y1,xm,ym,ControlPointSetupGate,true,true)>=0) {
                    if ControlPointSetupGate.solid == true hitline = true;
                } else if (collision_line(x1,y1,xm,ym,BulletWall,true,true)>=0) {
                    hitline = true;
                }
            }
            
            if(hitline) {
                a[i]=xm;
                b[i]=ym;
            } else {
                x1=xm;
                y1=ym;
            }
            len/=2;
        }
        
        with(Player) {
            if(id != other.ownerPlayer and team != other.owner.team and object != -1) {
                if(collision_line(other.x,other.y,other.a[i],other.b[i],object,true,false)>=0) && object.ubered == 0 {
                    other.hitDamage *= (1+0*0.35); // re-add crits? done!
                    damageCharacter(other.ownerPlayer, object, other.hitDamage);
                    //if true == true object.hp -= other.hitDamage*(1+0*0.35)*1; //Yeah MCBoss removed crits here
                    //object.lastDamageCrit=other.crit; // not sure if this should be readded, I think its for crit kill log
                    if (object.lastDamageDealer != other.ownerPlayer && object.lastDamageDealer != object.player){
                        object.secondToLastDamageDealer = object.lastDamageDealer;
                        object.alarm[4] = object.alarm[3]
                    }
                    object.alarm[3] = ASSIST_TIME / global.delta_factor;
                    object.lastDamageDealer = other.ownerPlayer;
                    object.cloakAlpha = min(object.cloakAlpha + 0.3, 1);
                    if(global.gibLevel > 0 && !object.radioactive){
                        blood = instance_create(object.x,object.y,Blood);
                        blood.direction = other.owner.aimDirection-180;
                    }
                    object.lastDamageSource = WEAPON_FLASHLIGHT;
                }
            }
        }
        
        with(Sentry) {
            if(team != other.owner.team) {
                if(collision_line(other.x,other.y,other.a[i],other.b[i],id,false,false)>=0) {
                    hp -= other.hitDamage*1; //Removed crap everywhere for crits
                    //lastDamageCrit=CRIT_FACTOR;
                    lastDamageDealer = other.ownerPlayer;
                    lastDamageSource = WEAPON_FLASHLIGHT;
                }
            }
        }
        
        with(Generator) {
            if(team != other.owner.team) {
                if(collision_line(other.x,other.y,other.a[i],other.b[i],id,true,false)>=0) {
                    alarm[0] = regenerationBuffer / global.delta_factor;
                    isShieldRegenerating = false;
                    //allow overkill to be applied directly to the target
                    if (other.hitDamage > shieldHp) {
                        hp -= other.hitDamage - shieldHp;
                        hp -= shieldHp * shieldResistance;
                        shieldHp = 0;
                    }
                    else
                    {
                        hp -= other.hitDamage * shieldResistance;
                        shieldHp -= other.hitDamage;
                    }
                    //exit;
                }
            }
        }
    }
');

object_event_add(FlashlightWeapon, ev_draw, 0, '
    event_inherited();
    {
        if(shot) {
            var origdepth;
            shot = false;
            draw_set_alpha(0.8);
            origdepth = depth;
            depth = -2;
            for(i=0;i<3;i+=1) draw_line_width_color(x,y,a[i],b[i],2,c_yellow,c_black);
            depth = origdepth;
        }
    }
');
