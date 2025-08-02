globalvar WEAPON_TOMISLAV;
WEAPON_TOMISLAV = 61;

globalvar Tomislav;
Tomislav = object_add();
object_set_parent(Tomislav, Weapon);

object_event_add(Tomislav,ev_create,0,'
    xoffset = 3;
    yoffset = 3;
    refireTime = 3;
    event_inherited();
    sndlooping = false;
    maxAmmo = 200;
    ammoCount = maxAmmo;
    reloadBuffer = 15;
    isRefilling = false;
    depth = -1;

    weaponGrade = UNIQUE;
    weaponType = MINIGUN;
    specialShot = NatachaShot;
    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\TomislavS.png", 2, 1, 0, 14, 3);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\TomislavFS.png", 4, 1, 0, 14, 3);
    reloadSprite = -1;

    sprite_index = normalSprite;

    //play at least 2 frames
    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    //Overlays for the overheat
    overlaySprite = MinigunOverlayS;
    overlayFiringSprite = MinigunOverlayFS;
');

object_event_add(Tomislav,ev_other,ev_user1,'
    {
        // prevent sputtering
        if (ammoCount < 2)
            ammoCount -= 2;
        if(readyToShoot and ammoCount >= 2)
        {
            playsound(x,y,ChaingunSnd);
            var shot, shotx, shoty;
            randomize();
            
            shotx = x+lengthdir_x(20,owner.aimDirection);
            shoty = y+12+lengthdir_y(20,owner.aimDirection);
            if(!collision_line_bulletblocking(x, y, shotx, shoty))
            {
                shot = createShot(shotx, shoty, Shot, DAMAGE_SOURCE_MINIGUN, owner.aimDirection+(random(7)-3.5), 12+random(1));
                if(golden)
                    shot.sprite_index = ShotGoldS;
                shot.hspeed += owner.hspeed;
                shot.alarm[0] = 30 / global.delta_factor;
            }
            else
            {
                var imp;
                imp = instance_create(shotx, shoty, Impact);
                imp.image_angle = owner.aimDirection;
            }
            
            justShot=true;
            readyToShoot=false;
            isRefilling = false;
            ammoCount -= 3;
            
            var reloadBufferFactor;
            if(ammoCount < 3)
                reloadBufferFactor = 2.5;
            else
                //reloadBufferFactor = 1+(cos((ammoCount+2.2)/maxAmmo*pi)+1)/2; // spline from (full ammo = 1*) to (empty ammo = 2*)
                reloadBufferFactor = 1;
            
            alarm[0] = refireTime / global.delta_factor;
            alarm[5] = reloadBuffer*reloadBufferFactor / global.delta_factor;
            
            if (global.particles == PARTICLES_NORMAL)
            {
                var shell;
                shell = instance_create(x, y+4, Shell);
                shell.direction = owner.aimDirection + (140 - random(40)) * image_xscale;
            }
        }
    }
');

global.weapons[WEAPON_TOMISLAV] = Tomislav;
global.name[WEAPON_TOMISLAV] = "Tomislav";
