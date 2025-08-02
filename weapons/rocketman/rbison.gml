globalvar WEAPON_RBISON;
WEAPON_RBISON = 17;

globalvar RBison;
RBison = object_add();
object_set_parent(RBison, Weapon);

object_event_add(RBison,ev_create,0,'
    xoffset=5;
    yoffset=1;
    refireTime=20;
    event_inherited();
    maxAmmo = 6;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    
    weaponGrade = UNIQUE;
    weaponType = LASERGUN;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\RBisonS.png", 2, 1, 0, 8, 7);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\RBisonFS.png", 4, 1, 0, 8, 7);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\RBisonS.png", 2, 1, 0, 8, 7);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(RBison,ev_other,ev_user1,'
    if(readyToShoot && ammoCount >0 && !owner.cloak) {
        ammoCount-=1;
        playsound(x,y,LaserShotSnd);
        var shot;
        randomize();
        shot = instance_create(x,y,LaserShot);
        shot.direction=owner.aimDirection+ random(3)-1;
        shot.image_angle = direction;
        shot.speed = 22;
        shot.owner = owner;
        shot.ownerPlayer = ownerPlayer;
        shot.team = owner.team;
        shot.weapon = WEAPON_RBISON;
        with(shot) {   
            hspeed += owner.hspeed;
        
            alarm[0] = 35 * ((min(1, abs(cos(degtorad(other.owner.aimDirection)))*13 / abs(cos(degtorad(other.owner.aimDirection))*13+owner.hspeed))-1)/2+1)
           // motion_add(owner.direction, owner.speed);
        }
        justShot = true;
        readyToShoot = false;
        alarm[0] = refireTime;
        alarm[5] = reloadBuffer + reloadTime;
    }
');

global.weapons[WEAPON_RBISON] = RBison;
global.name[WEAPON_RBISON] = "Righteous Bison";
