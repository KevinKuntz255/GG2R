globalvar FlareWeapon;
FlareWeapon = object_add();
object_set_parent(FlareWeapon, Weapon);

object_event_add(FlareWeapon, ev_create, 0, '
    xoffset = 5;
    yoffset = -3;
    refireTime = 45;
    event_inherited();
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 30;
    reloadBuffer = refireTime;

    specialProjectile = Flare;
    weaponGrade = UNIQUE;
    weaponType = FLAREGUN;

    if (!variable_local_exists("spriteBase")) spriteBase = "FlareGun";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FRS.png", 18, 1, 0, 14, 7);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(FlareWeapon, ev_alarm, 5, '
    ammoCount = maxAmmo;
');

object_event_add(FlareWeapon, ev_other, ev_user1, '
    if(readyToShoot && ammoCount >0 && !owner.cloak) {
        ammoCount -= 1;
        playsound(x, y, FlaregunSnd);
        var shot;
        if !collision_line(x,y,x+lengthdir_x(15,owner.aimDirection),y+lengthdir_y(15,owner.aimDirection),Obstacle,1,0) and !place_meeting(x+lengthdir_x(15,owner.aimDirection),y+lengthdir_y(15,owner.aimDirection),TeamGate) {
            shot = instance_create(x + lengthdir_x(13, owner.aimDirection), y + lengthdir_y(13, owner.aimDirection),specialProjectile);
            shot.direction = owner.aimDirection;
            shot.speed = 15;
            //shot.crit=crit;
            shot.owner = owner;
            shot.ownerPlayer = ownerPlayer;
            shot.team = owner.team;
            shot.weapon = id;
        }
        justShot = true;
        readyToShoot = false;
        alarm[0] = refireTime / global.delta_factor;
        alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    }
');
