globalvar laserWeapon;
laserWeapon = object_add();
object_set_parent(laserWeapon, Weapon);

object_event_add(laserWeapon, ev_create, 0, '
    xoffset = 5;
    yoffset = 1;
    refireTime = 20;
    event_inherited();
    maxAmmo = 25;
    ammoCount = maxAmmo;
    reloadTime = 45;
    reloadBuffer = 16;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = LASERGUN;
    
    damSource = DAMAGE_SOURCE_SHOTGUN;

    specialShot = -1;
    shots = 5;
    shotSpeed[0] = 13;
    shotSpeed[1] = 4;
    shotDir[0] = 7;
    shotDir[1] = 4;

    shotDamage = 5;
    fullReload = true;

    if (!variable_local_exists("spriteBase")) spriteBase = "RBison";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, 7);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 4, 1, 0, 8, 7);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, 7);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(laserWeapon, ev_alarm, 5, '
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

object_event_add(laserWeapon, ev_other, ev_user1, '
     if(readyToShoot && ammoCount >0 && !owner.cloak) {
        ammoCount -= 1;
        playsound(x, y, LaserShotSnd);
        var shot;
        randomize();
        shot = instance_create(x, y, LaserShot);
        shot.direction = owner.aimDirection + random(3)-1;
        shot.image_angle = direction;
        shot.speed = 22;
        shot.owner = owner;
        shot.ownerPlayer = ownerPlayer;
        shot.team = owner.team;
        shot.weapon = id;
        with(shot) {   
            hspeed += owner.hspeed;
        
            alarm[0] = 35 * ((min(1, abs(cos(degtorad(other.owner.aimDirection))) * 13 / abs(cos(degtorad(other.owner.aimDirection))*13+owner.hspeed))-1)/2+1)
           // motion_add(owner.direction, owner.speed);
        }
        justShot = true;
        readyToShoot = false;
        alarm[0] = refireTime;
        alarm[5] = reloadBuffer + reloadTime;
    }
');