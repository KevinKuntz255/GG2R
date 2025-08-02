globalvar WEAPON_SANDVICH;
WEAPON_SANDVICH = 66;

globalvar SandvichHand;
SandvichHand = object_add();
object_set_parent(SandvichHand, Weapon);

object_event_add(SandvichHand,ev_create,0,'
    xoffset=-12;
    yoffset=3;
    refireTime=18;
    event_inherited();
    owner.expectedWeaponBytes = 3;
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    owner.ammo[105] = -1;
    isMelee = true;

    weaponGrade = UNIQUE;
    weaponType = CONSUMABLE;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandvichHandS.png", 4, 1, 0, 0, 11);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandvichHandS.png", 4, 1, 0, 0, 11);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SandvichHandS.png", 4, 1, 0, 0, 11);

    sprite_index = normalSprite;
    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(SandvichHand,ev_other,ev_user1,'
    if(global.isHost){
        if(owner != -1) {
            if(!ownerPlayer.humiliated
                and !owner.taunting
                and !owner.omnomnomnom
                and owner.canEat
                and ownerPlayer.class==CLASS_HEAVY)
            {                            
                write_ubyte(global.sendBuffer, OMNOMNOMNOM);
                write_ubyte(global.sendBuffer, ds_list_find_index(global.players, ownerPlayer));
                with(owner)
                {
                    omnomnomnom = true;
                    omnomnomnomindex=0;
                    omnomnomnomend=32;
                    xscale=image_xscale;
                }             
            }
        }
    }
');

object_event_add(SandvichHand,ev_other,ev_user2,'
    if(owner.canEat && !owner.cloak) {
        with(Sandvich) {
            if ownerPlayer == other.ownerPlayer instance_destroy();
        }
        ammoCount -= 1; 
        shot = instance_create(x,y + yoffset + 1,Sandvich);
        shot.direction=owner.aimDirection+ random(7)-4;
        shot.speed=5;
        shot.owner=owner;
        shot.ownerPlayer=ownerPlayer;
        shot.team=owner.team;
        with(shot)
            hspeed+=owner.hspeed;
        owner.alarm[6] = owner.eatCooldown / global.delta_factor;
        owner.canEat = false;
        owner.ammo[105] = -1;
    }
');

object_event_add(SandvichHand,ev_other,ev_user12,'
    event_inherited();
    {
        write_ubyte(global.serializeBuffer, real(owner.canEat));
    }
');

object_event_add(SandvichHand,ev_other,ev_user13,'
    event_inherited();
    {
        receiveCompleteMessage(global.serverSocket, 1, global.deserializeBuffer); 
        owner.canEat = read_ubyte(global.deserializeBuffer); 
    }
');

object_event_add(SandvichHand,ev_draw,0,'
    if (distance_to_point(view_xview + view_wview/2, view_yview + view_hview/2) > 800)
        exit;

    if (!owner.invisible and !owner.taunting and !owner.omnomnomnom and !owner.player.humiliated)
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

global.weapons[WEAPON_SANDVICH] = SandvichHand;
global.name[WEAPON_SANDVICH] = "Sandvich";
