globalvar WEAPON_SANDMAN;
WEAPON_SANDMAN = 7;

globalvar Sandman;
Sandman = object_add();
object_set_parent(Sandman, MeleeWeapon);

object_event_add(Sandman,ev_create,0,'
    xoffset=-15;
    yoffset=-25;
    spriteBase = "Sandman";
    event_inherited();
    depth = 1;
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
        readyToStab = false;
        alarm[2]= 20 / global.delta_factor;
        alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    }
');

global.weapons[WEAPON_SANDMAN] = Sandman;
global.name[WEAPON_SANDMAN] = "Sandman (Unfinished)";
