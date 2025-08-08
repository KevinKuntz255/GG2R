globalvar RocketWeapon;
RocketWeapon = object_add();
object_set_parent(RocketWeapon, Weapon);

object_event_add(RocketWeapon, ev_create, 0, '
    xoffset = -5;
    yoffset = -4;
    refireTime = 30;
    event_inherited();
    
    reloadTime = 22;
    reloadBuffer = 30;
    maxAmmo = 4;
    ammoCount = maxAmmo;
    rocketrange = 501;
    idle = true;

    damSource = DAMAGE_SOURCE_ROCKETLAUNCHER; // todo: add damage sources coinciding with kill log implementation

    weaponGrade = UNIQUE;
    weaponType = ROCKETLAUNCHER;
    rocketSound = RocketSnd; // direct hit specific
    rocketSpeed = 13;
    specialProjectile = Rocket; // cow mangler specific;

    if (!variable_local_exists("spriteBase")) spriteBase = "DirectHit";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"S.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"FS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"FRS.png", 24, 1, 0, 10, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(RocketWeapon, ev_alarm, 5, '
    event_inherited();

    if (ammoCount < maxAmmo)
    {
        ammoCount += 1;
    }
    if ammoCount < maxAmmo {
        alarm[5] = reloadTime / global.delta_factor;
        sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;
    }
');

object_event_add(RocketWeapon, ev_other, ev_user1, '
    if(readyToShoot and ammoCount > 0 and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
');

object_event_add(RocketWeapon, ev_other, ev_user3, '
    ammoCount = max(0, ammoCount-1);    
    playsound(x, y, rocketSound);
    var oid, newx, newy;
    newx = x+lengthdir_x(20,owner.aimDirection);
    newy = y+lengthdir_y(20,owner.aimDirection);
    oid = createShot(newx, newy, specialProjectile, DAMAGE_SOURCE_ROCKETLAUNCHER, owner.aimDirection, rocketSpeed);
    oid.gun=id;
    with (oid)
    {
        if (collision_line_bulletblocking(other.x, other.y, newx, newy))
        {
            // Delay explosion to make same-frame rocketjumping work reliably
            explodeImmediately = true;
        }
    }
    oid.lastknownx = owner.x;
    oid.lastknowny = owner.y;
    justShot=true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
');