globalvar RevolverWeapon;
RevolverWeapon = object_add();
object_set_parent(RevolverWeapon, Weapon);

object_event_add(RevolverWeapon, ev_create, 0, '
    event_inherited();

    stabdirection = 0;
    maxAmmo = 6;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 45;
    reloadBuffer = refireTime;
    idle = true;

    stabdirection = 0;

    damSource = DAMAGE_SOURCE_REVOLVER;

    specialShot = -1;
    shots = 5;
    shotSpeed[0] = 4;
    shotSpeed[1] = 2;
    shotDir[0] = 11;
    shotDir[1] = 5;

    shotDamage = 28;
    fullReload = true;

    if !variable_local_exists("spriteBase") spriteBase = "Etranger";
    
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, -1, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 4, 1, 0, -1, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FRS.png", 44, 1, 0, 15, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(RevolverWeapon,ev_destroy,0,'
    with (SapAnimation) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
                
    with (SapMask) {
        if (ownerPlayer == other.ownerPlayer) {
            instance_destroy();
        }
    }
');

object_event_add(RevolverWeapon, ev_alarm, 1, '
    shot = instance_create(x,y,SapMask);
    shot.direction = stabdirection;
    shot.speed = 0;
    shot.owner = owner;
    shot.ownerPlayer = ownerPlayer;
    shot.team = owner.team;
    shot.weapon = id;
    alarm[2] = 20 / global.delta_factor;
    playsound(x,y,KnifeSnd);
');

object_event_add(RevolverWeapon, ev_alarm, 2, '
    readyToStab = true;
');

object_event_add(RevolverWeapon, ev_alarm, 5, '
    if (ammoCount < maxAmmo)
    {
        ammoCount = maxAmmo;
        ejected = 0;
    }
    event_inherited();
');

object_event_add(RevolverWeapon, ev_alarm, 7, '
    if (global.particles == PARTICLES_NORMAL && image_alpha > 0.1)
    {
        repeat(maxAmmo-ammoCount-ejected)
        {
            var shell;
            shell = instance_create(x + lengthdir_x(8, owner.aimDirection), y + lengthdir_y(8, owner.aimDirection) - 5, Shell);
            shell.direction = 180 + owner.aimDirection + (70 - random(80)) * image_xscale;
            shell.speed *= 0.7;
            ejected +=1;
        }
    }
');

object_event_add(RevolverWeapon, ev_other, ev_user1, '
    if(readyToShoot && !owner.cloak && ammoCount > 0)
    {
        if(global.isHost)
        {
            var seed;
            seed = irandom(65535);
            sendEventFireWeapon(ownerPlayer, seed);
            doEventFireWeapon(ownerPlayer, seed);
        }
    }
    else if(readyToStab && owner.cloak && !(owner.keyState & $08))
    {
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,SapAnimation);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = DAMAGE_SOURCE_KNIFE;
        stab.golden = golden;

        // BH reward - *B*obble *H*ead
        if(hasClassReward(ownerPlayer, "BH"))
        {
            ds_list_add(stab.overlays, HatBobbleSpyStabS);
        }
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
    }
');

object_event_add(RevolverWeapon, ev_other, ev_user3, '
    ammoCount = max(0, ammoCount-1);
    playsound(x, y, RevolverSnd);
    var shot;

    shot = createShot(x, y + yoffset + 1, Shot, damSource, owner.aimDirection, 21);
    shot.hitDamage = shotDamage;
    
    if(golden)
        shot.sprite_index = ShotGoldS;
    with(shot)
        speed += owner.hspeed * hspeed / 15;

    shot.weapon = id;
    // Move shot forward one 30fps step to avoid immediate collision with a wall behind the character
    // delta_factor is left out intentionally!
    shot.x += lengthdir_x(shot.speed, shot.direction);
    shot.y += lengthdir_y(shot.speed, shot.direction);
        
    justShot = true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    alarm[7] = alarm[5] * 3 / 5;
');