globalvar WEAPON_SANDMAN;
WEAPON_SANDMAN = 7;

globalvar Sandman;
Sandman = object_add();
object_set_parent(Sandman, Weapon);

object_event_add(Sandman,ev_create,0,'
    xoffset=6;
    yoffset=0;
    refireTime=18;
    event_inherited();

    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = MELEE;
    shotDamage = 25;

    StabreloadTime = 5; 
    readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    
    owner.ammo[107] = -1;
    depth = 1;
    isMelee = true;
    
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandmanS.png", 2, 1, 0, 21, 25);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandmanFS.png", 8, 1, 0, 21, 25);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandmanS.png", 2, 1, 0, 21, 25);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(Sandman,ev_other,ev_user2,'
    if (readyToStab && !owner.cloak && ammoCount>=1) {
        var oid, newx, newy;
        playsound(x,y,BallSnd);
        ammoCount -= 1;

        oid = instance_create(x+lengthdir_x(10,owner.aimDirection),y+lengthdir_y(10,owner.aimDirection), Ball);
        
        oid.direction=owner.aimDirection;
        oid.speed=15;
        oid.vspeed-=2.5
        oid.crit=1;
        oid.owner=owner;
        oid.ownerPlayer=ownerPlayer;
        oid.team=owner.team;
        oid.weapon=DAMAGE_SOURCE_SCATTERGUN; //temp change
        justShot=true;
        readyToShoot = false;
        //alarm[0] = refireTime;
        readyToStab = false;
        alarm[2]=20;
        alarm[5] = reloadBuffer + reloadTime;
    }
');

global.weapons[WEAPON_SANDMAN] = Sandman;
global.name[WEAPON_SANDMAN] = "Sandman (Unfinished)";
