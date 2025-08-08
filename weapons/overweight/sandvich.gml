globalvar WEAPON_SANDVICH;
WEAPON_SANDVICH = 66;

globalvar SandvichHand;
SandvichHand = object_add();
object_set_parent(SandvichHand, ConsumableWeapon);

// take out base vars when comfortable, This one uses networking so i tread lightly
object_event_add(SandvichHand,ev_create,0,'
    xoffset = -12;
    yoffset = 3;
    event_inherited();
    owner.expectedWeaponBytes = 3;
');

// if implementing randomizerMode, remove that ownerPlayer.class call
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

// maybe should add a check for isThrowable
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
        //owner.doubleTapped = true;
    }
');

// It's inheriting from the parent of the parent object, does that work in gm8? Get MCBoss on the call!
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

global.weapons[WEAPON_SANDVICH] = SandvichHand;
global.name[WEAPON_SANDVICH] = "Sandvich";
