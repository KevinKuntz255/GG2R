globalvar WEAPON_DOUBLETROUBLE;
WEAPON_DOUBLETROUBLE = 36;

globalvar DoubleTrouble;
DoubleTrouble = object_add();
object_set_parent(DoubleTrouble, GrenadeWeapon);

object_event_add(DoubleTrouble,ev_create,0,'
    xoffset = 0;
    yoffset = 2;
    refireTime = 26;
    spriteBase = "DoubleTrouble";
    event_inherited();
    reloadTime = 20;
    maxAmmo = 2;
    ammoCount = maxAmmo;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"S.png", 1, 1, 0, 10, 7);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"FS.png", 1, 1, 0, 10, 7);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\"+ spriteBase +"FS.png", 1, 1, 0, 10, 7);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');

object_event_add(DoubleTrouble, ev_other, ev_user3, '
    var oid, newx, newy;
    playsound(x,y,MinegunSnd);
    lobbed = min(maxMines, lobbed + ammoCount);

    oid = createShot(x+lengthdir_x(10,owner.aimDirection),y+lengthdir_y(10,owner.aimDirection), specialProjectile, DAMAGE_SOURCE_MINEGUN, owner.aimDirection, grenadeSpeed);
    oid.direction=owner.aimDirection+5;
    oid.vspeed-=3;
    oid.owner=owner;
    oid.ownerPlayer=ownerPlayer;
    oid.team=owner.team;
    oid.weapon=id;

    if (ammoCount >= maxAmmo) {
        oid = createShot(x+lengthdir_x(10,owner.aimDirection),y+lengthdir_y(10,owner.aimDirection), specialProjectile, DAMAGE_SOURCE_MINEGUN, owner.aimDirection, grenadeSpeed + 1);
        oid.direction=owner.aimDirection-5;
        oid.vspeed-=1;
        oid.owner=owner;
        oid.ownerPlayer=ownerPlayer;
        oid.team=owner.team;
        oid.weapon=id;
        ammoCount = max(0, ammoCount-1);
    }
    ammoCount = max(0, ammoCount-1);
    justShot=true;
    readyToShoot = false;
    alarm[0] = refireTime / global.delta_factor;
    alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    
');

global.weapons[WEAPON_DOUBLETROUBLE] = DoubleTrouble;
global.name[WEAPON_DOUBLETROUBLE] = "Double Trouble";
