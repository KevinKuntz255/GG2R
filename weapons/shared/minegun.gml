globalvar MineWeapon;
MineWeapon = object_add();
object_set_parent(MineWeapon, Weapon);

object_event_add(MineWeapon, ev_create, 0, '
    xoffset = -3;
    yoffset = -2;
    refireTime = 26;
    event_inherited();
    
    maxMines = 8;
    lobbed = 0;
    reloadTime = 15;
    reloadBuffer = 26;
    maxAmmo = 8;
    ammoCount = maxAmmo;
    idle=true;

    damSource = DAMAGE_SOURCE_MINEGUN;

    weaponGrade = UNIQUE;
    weaponType = MINEGUN;

    mineSound = RocketSnd; // direct hit specific
    mineSpeed = 13;
    specialProjectile = Mine; // cow mangler specific;

    if (!variable_local_exists("spriteBase")) spriteBase = "DirectHit";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"S.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"FS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"FRS.png", 2, 1, 0, 10, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(MineWeapon, ev_alarm, 5, '
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

object_event_add(MineWeapon, ev_destroy, 0, '
    with(Mine) {if ownerPlayer == other.ownerPlayer instance_destroy();}
');

object_event_add(MineWeapon, ev_other, ev_user1, '
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

object_event_add(MineWeapon, ev_other, ev_user2, '
    var i, mine;
    with(Mine) {
        if(ownerPlayer == other.ownerPlayer) {
            owner.doubleTapped = true;
            event_user(2);
        }
    }
    lobbed = 0;
');

object_event_add(MineWeapon, ev_other, ev_user3, '
    var oid, newx, newy;
    playsound(x,y,MinegunSnd);
    ammoCount = max(0, ammoCount-1);

    oid = createShot(x+lengthdir_x(10,owner.aimDirection),y+lengthdir_y(10,owner.aimDirection), Mine, DAMAGE_SOURCE_MINEGUN, owner.aimDirection, 12);
    oid.image_angle = 0;
    lobbed += 1;
    justShot=true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
');

object_event_add(MineWeapon, ev_other, ev_user12, '
    event_inherited();

    write_ubyte(global.serializeBuffer, lobbed);
    with(Mine) {
        if(ownerPlayer == other.ownerPlayer) {
            event_user(12);
        }
    }
');
object_event_add(MineWeapon, ev_other, ev_user13, '
    event_inherited();
    
    var i, mine;
    receiveCompleteMessage(global.serverSocket, 1, global.deserializeBuffer);
    lobbed = read_ubyte(global.deserializeBuffer);
    
    with(Mine) {
        if(ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
    
    for(i=0; i<lobbed; i+=1) {
        mine = instance_create(0,0,Mine);
        mine.owner = owner;
        mine.ownerPlayer = ownerPlayer;
        mine.team = owner.team;
        with(mine) {
            event_user(13);
        }
    }
');
