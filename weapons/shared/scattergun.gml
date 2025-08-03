globalvar ScattergunWeapon;
ScattergunWeapon = object_add();
object_set_parent(ScattergunWeapon, Weapon);

object_event_add(ScattergunWeapon, ev_create, 0, '
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    weaponGrade = UNIQUE;
    weaponType = SCATTERGUN;
    idle=true;
    
    damSource = DAMAGE_SOURCE_SCATTERGUN;

    specialShot = -1;
    shots = 6;
    shotSpeed[0] = 4;
    shotSpeed[1] = 2;
    shotDir[0] = 15;
    shotDir[1] = 7.5;

    shotDamage = 8;

    fullReload = false;

    spriteBase = "Scattergun";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FRS.png", 16, 1, 0, 20, 11);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(ScattergunWeapon, ev_alarm, 5,'
    event_inherited();

    if (ammoCount < maxAmmo)
    {
        if fullReload ammoCount = maxAmmo; else ammoCount += 1;
    }
     if (global.particles == PARTICLES_NORMAL)
    {
        var shell;
        shell = instance_create(x, y, Shell);
        shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
        shell.image_index = 1;
    }
    if ammoCount < maxAmmo {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');

object_event_add(ScattergunWeapon, ev_other, ev_user1,'
    if(readyToShoot and ammoCount > 0 and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');

object_event_add(ScattergunWeapon, ev_other, ev_user3, '
    playsound(x,y,ShotgunSnd);
    ammoCount = max(0, ammoCount-1);
    var shot;
    repeat(shots) {
        if (specialShot != -1) shot = createShot(x, y, specialShot, damSource, owner.aimDirection, 13); else shot = createShot(x, y, Shot, damSource, owner.aimDirection, 13);
        shot.hitDamage = shotDamage;
        if(golden)
            shot.sprite_index = ShotGoldS;
        shot.hspeed += owner.hspeed;
        shot.speed += random(shotSpeed[0])-shotSpeed[1];
        shot.direction += random(shotDir[0])-shotDir[1];
        // Move shot forward to avoid immediate collision with a wall behind the character
        shot.x += lengthdir_x(15, shot.direction);
        shot.y += lengthdir_y(15, shot.direction);
        shot.alarm[0] = 35 * ((min(1, abs(cos(degtorad(owner.aimDirection)))*13/abs(cos(degtorad(owner.aimDirection))*13+owner.hspeed))-1)/2+1) / global.delta_factor;
    }
    justShot = true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
');