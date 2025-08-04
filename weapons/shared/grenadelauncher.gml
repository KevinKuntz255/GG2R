globalvar GrenadeWeapon;
GrenadeWeapon = object_add();
object_set_parent(GrenadeWeapon, Weapon);

object_event_add(GrenadeWeapon, ev_create, 0, '
    xoffset = 5;
    yoffset = 2;
    refireTime = 28;
    event_inherited();
    
    maxMines = 4;
    lobbed = 0;
    reloadTime = 15;
    reloadBuffer = 26;
    maxAmmo = 4;
    ammoCount = maxAmmo;
    idle=true;

    damSource = DAMAGE_SOURCE_MINEGUN;

    weaponGrade = UNIQUE;
    weaponType = GRENADELAUNCHER;
    grenadeSound = MinegunSnd;
    grenadeSpeed = 13;
    specialProjectile = Grenade;

    if (!variable_local_exists("spriteBase")) spriteBase = "GrenadeLauncher";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"S.png", 1, 1, 0, 13, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"FS.png", 1, 1, 0, 13, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"FRS.png", 1, 1, 0, 13, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(GrenadeWeapon, ev_alarm, 5, '
    event_inherited();

    if (ammoCount < maxAmmo)
    {
        ammoCount += 1;
    }
    if ammoCount < maxAmmo {
        alarm[5] = reloadTime / global.delta_factor;
        /*sprite_index = reloadSprite;
        image_index = 0;
        image_speed = reloadImageSpeed * global.delta_factor;*/
    }
');

object_event_add(GrenadeWeapon, ev_destroy, 0, '
    with(Mine) {if ownerPlayer == other.ownerPlayer instance_destroy();}
');

object_event_add(GrenadeWeapon, ev_other, ev_user1, '
    if(readyToShoot and ammoCount > 0 and lobbed < maxMines and global.isHost)
    {
        var seed;
        seed = irandom(65535);
        sendEventFireWeapon(ownerPlayer, seed);
        doEventFireWeapon(ownerPlayer, seed);
    }
    // prevent accidentally charging
    owner.doubleTapped = true;
');

object_event_add(GrenadeWeapon, ev_other, ev_user2, '
    var i, mine;
    with(Mine) {
        if(ownerPlayer == other.ownerPlayer) {
            owner.doubleTapped = true;
            event_user(2);
        }
    }
    lobbed = 0;
');

object_event_add(GrenadeWeapon, ev_other, ev_user3, '
    var oid, newx, newy;
    playsound(x,y,MinegunSnd);
    ammoCount = max(0, ammoCount-1);

    oid = createShot(x+lengthdir_x(10,owner.aimDirection),y+lengthdir_y(10,owner.aimDirection), specialProjectile, DAMAGE_SOURCE_MINEGUN, owner.aimDirection, 15);
    oid.image_angle = 0;
    oid.vspeed-=2.5;
    oid.explosionDamage = 40;
    lobbed += 1;
    justShot=true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
');
