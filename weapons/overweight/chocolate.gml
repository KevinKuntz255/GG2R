globalvar WEAPON_CHOCOLATE;
WEAPON_CHOCOLATE = 68;

globalvar ChocolateHand;
ChocolateHand = object_add();
object_set_parent(ChocolateHand, ConsumableWeapon);

object_event_add(ChocolateHand,ev_create,0,'
    xoffset = -12;
    yoffset = 3;
    spriteBase = "ChocolateHand";
    event_inherited();
    owner.expectedWeaponBytes = 3;
    owner.eatCooldown = 750;
    if (owner.oldmaxHp == -1) {
        owner.oldmaxHp = owner.maxHp;
        owner.newmaxHp = owner.maxHp + 40;
    }    
    owner.nomRate = 0.85;
');

object_event_add(ChocolateHand,ev_other,ev_user1,'
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

object_event_add(ChocolateHand,ev_other,ev_user12,'
    event_inherited();
    {
        write_ubyte(global.serializeBuffer, real(owner.canEat));
    }
');

object_event_add(ChocolateHand,ev_other,ev_user13,'
    event_inherited();
    {
        receiveCompleteMessage(global.serverSocket, 1, global.deserializeBuffer); 
        owner.canEat = read_ubyte(global.deserializeBuffer); 
    }
');

global.weapons[WEAPON_CHOCOLATE] = ChocolateHand;
global.name[WEAPON_CHOCOLATE] = "Dalokohs Bar"
