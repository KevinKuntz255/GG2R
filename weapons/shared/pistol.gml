globalvar PistolWeapon;
PistolWeapon = object_add();
object_set_parent(PistolWeapon, Weapon);

object_event_add(PistolWeapon, ev_create, 0, '
    xoffset = 0;
    yoffset = 2;
    refireTime = 5;
    event_inherited();
    maxAmmo = 12;
    ammoCount = maxAmmo;
    reloadTime = 20;
    reloadBuffer = 5;
    weaponGrade = UNIQUE;
    weaponType = PISTOL;
    idle = true;

    damSource = DAMAGE_SOURCE_SHOTGUN;

    specialShot = -1;
    shots = 5;
    shotSpeed[0] = 7;
    shotSpeed[1] = 4;
    shotDir[0] = 7;
    shotDir[1] = 4;

    shotDamage = 7;
    fullReload = true;

    if (!variable_local_exists("spriteBase")) spriteBase = "Pistol";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, 7);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 4, 1, 0, 8, 7);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FRS.png", 16, 1, 0, 10, 12);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(PistolWeapon, ev_alarm, 5, '
    event_inherited();

    if (ammoCount < maxAmmo)
    {
        if fullReload ammoCount = maxAmmo; else ammoCount += 1;

        if (global.particles == PARTICLES_NORMAL)
        {
            var shell;
            shell = instance_create(x, y, Shell);
            shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
            shell.image_index = 1;
        }
    }
    if (ammoCount < maxAmmo)
    {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');

object_event_add(PistolWeapon, ev_other, ev_user1, '
    if(readyToShoot and ammoCount > 0 and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');

object_event_add(PistolWeapon, ev_other, ev_user3, '
    ammoCount = max(0, ammoCount-1);
    playsound(x, y, pistolSnd);
    var shot;

        if (specialShot != -1) shot = createShot(x, y, specialShot, damSource, owner.aimDirection, 13); else shot = createShot(x, y, Shot, damSource, owner.aimDirection, 13);
        shot.hitDamage = shotDamage;
        shot.hspeed += owner.hspeed;
        shot.speed = 13;
        shot.direction += random(shotDir[0])-shotDir[1];
        shot.weapon = id;
        // Move shot forward to avoid immediate collision with a wall behind the character
        shot.x += lengthdir_x(15, shot.direction);
        shot.y += lengthdir_y(15, shot.direction);
        shot.alarm[0] = 35 * ((min(1, abs(cos(degtorad(owner.aimDirection)))*13
                          /abs(cos(degtorad(owner.aimDirection))*13+owner.hspeed))-1)/2+1)
                    / global.delta_factor;
        shot.weapon = id;
    justShot = true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    alarm[7] = alarm[0] / 2;
');