globalvar ThrowableWeapon;
ThrowableWeapon = object_add();
object_set_parent(ThrowableWeapon, Weapon);

object_event_add(ThrowableWeapon, ev_create, 0, '
    refireTime=18;
    spriteBase = "NapalmHand";
    event_inherited();

    isMelee = true;

    maxAmmo = 1;
    ammoCount = maxAmmo;

    weaponGrade = UNIQUE;
    weaponType = THROWABLE;

    reloadTime = 300;
    reloadBuffer = refireTime;

    shotSpeed = 13;

    throwProjectile = -1;
    projectileSpeed = 13;
    randomDir = true;
    projectileDir[0] = 7;
    projectileDir[1] = 4;

    if (!variable_local_exists("spriteBase")) spriteBase = "JarateHand";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 4, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 4, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 4, 1, 0, 0, 0);

    sprite_index = normalSprite;

    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');


object_event_add(ThrowableWeapon, ev_alarm, 5,'
    event_inherited();

    ammoCount = maxAmmo;
    if meterCount != -1 meterCount = maxMeter;
');

object_event_add(ThrowableWeapon,ev_step,ev_step_normal,'
    image_index = owner.team+2*real(ammoCount);
');

object_event_add(ThrowableWeapon, ev_other, ev_user1,'
    if(ammoCount >= 1 && readyToShoot) {
        playsound(x,y,swingSnd);
        ammoCount -= max(0, ammoCount-1); 
        shot = instance_create(x,y + yoffset + 1,throwProjectile);
        if (randomDir) shot.direction=owner.aimDirection+ random(projectileDir[0])-projectileDir[1]; else shot.direction=owner.aimDirection;
        shot.speed=projectileSpeed;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        with(shot)
            hspeed+=owner.hspeed;
        ammoCount = max(0, ammoCount-1);
        
        alarm[5] = reloadBuffer + reloadTime;
        readyToShoot = false;
        alarm[0] = refireTime;
    }
');

object_event_add(ThrowableWeapon,ev_draw,0,'
    if (distance_to_point(view_xview + view_wview/2, view_yview + view_hview/2) > 800)
        exit;

    if (!owner.invisible and !owner.taunting and !owner.player.humiliated)
    {
        if (!owner.cloak)
            image_alpha = power(owner.cloakAlpha, 0.5);
        else
            image_alpha = power(owner.cloakAlpha, 2);
        draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        if (owner.ubered)
        {
            if (owner.team == TEAM_RED)
                ubercolour = c_red;
            else if (owner.team == TEAM_BLUE)
                ubercolour = c_blue;
            draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
        }
    }
');


// todo: move couple events around and globalize em