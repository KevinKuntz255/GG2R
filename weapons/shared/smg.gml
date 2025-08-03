globalvar smgWeapon;
smgWeapon = object_add();
object_set_parent(smgWeapon, Weapon);

object_event_add(smgWeapon, ev_create, 0, '
    xoffset = 5;
    yoffset = -1;
    refireTime = 3;
    event_inherited();
    maxAmmo = 25;
    ammoCount = maxAmmo;
    reloadTime = 45;
    reloadBuffer = 16;
    idle = true;

    weaponGrade = UNIQUE;
    weaponType = SMG;
    
    damSource = DAMAGE_SOURCE_SHOTGUN;

    specialShot = -1;
    shots = 5;
    shotSpeed[0] = 13;
    shotSpeed[1] = 4;
    shotDir[0] = 7;
    shotDir[1] = 4;

    shotDamage = 5;
    fullReload = true;

    if (!variable_local_exists("spriteBase")) spriteBase = "Smg";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, 5);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 4, 1, 0, 8, 5);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FRS.png", 16, 1, 0, 12, 13);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(smgWeapon, ev_alarm, 5, '
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

object_event_add(smgWeapon, ev_other, ev_user1, '
    if(readyToShoot && !owner.cloak && ammoCount > 0) {
        ammoCount -= 1;
        playsound(x, y, chaingunSnd);
        var shot;
        randomize();
        
        shot = instance_create(x,y + yoffset + 1,Shot);
        shot.direction = owner.aimDirection + random(shotDir[0]) - shotDir[1];
        shot.speed = shotSpeed[0];
        shot.owner = owner;
        shot.ownerPlayer = ownerPlayer;
        shot.team = owner.team;
        shot.hitDamage = shotDamage;
        shot.weapon = id;
        with(shot)
            hspeed += owner.hspeed;
        justShot = true;
        readyToShoot = false;
        alarm[0] = refireTime;
        alarm[5] = reloadBuffer + reloadTime;
    }
');