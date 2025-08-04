if(global.myself.class == CLASS_ENGINEER)
{
    if(global.myself.sentry)
    {
        write_ubyte(global.serverSocket, DESTROY_SENTRY);
        socket_send(global.serverSocket);
    }
    else if(global.myself.object.nutsNBolts < 100)
    {
        with(NoticeO)
            instance_destroy();
        instance_create(0,0,NoticeO);
        NoticeO.notice = NOTICE_NUTSNBOLTS;
    }
    else if(collision_circle(global.myself.object.x,global.myself.object.y,50,Sentry,false,true)>=0)
    {
        with(NoticeO)
            instance_destroy();
        instance_create(0,0,NoticeO);
        NoticeO.notice = NOTICE_TOOCLOSE;
    }
    else if(collision_point(global.myself.object.x,global.myself.object.y,SpawnRoom,0,0) < 0)
    {
        write_ubyte(global.serverSocket, BUILD_SENTRY);
        socket_send(global.serverSocket);
    }
//} else if global.myself.object.taunting==false && global.myself.object.omnomnomnom==false && global.myself.class==CLASS_HEAVY {
//    write_ubyte(global.serverSocket, OMNOMNOMNOM);
} else if global.myself.class == CLASS_SNIPER {
    if (global.myself.activeWeapon == 0) write_ubyte(global.serverSocket, TOGGLE_ZOOM);
    //if (global.myself.object.currentWeapon.weaponType == RIFLE) write_ubyte(global.serverSocket, TOGGLE_ZOOM);
} else if global.myself.object.ability == DASH {
    global.myself.object.doubleTapped = !global.myself.object.doubleTapped;
        if (global.myself.object.abilityActive) {
            global.myself.object.abilityActive = false;
            global.myself.object.meter[1] = 0;
        } // stop, no matter what
    if ((global.myself.object.currentWeapon.weaponType == MINEGUN || global.myself.object.currentWeapon.isThrowable) && !global.myself.object.doubleTapped) exit; // a sort of buffer for weapons like SandvichHand and Minegun
    if (!global.myself.object.abilityActive && !global.myself.object.cloak && global.myself.object.meter[1] >= global.myself.object.maxMeter[1]) {
        global.myself.object.abilityActive = true;
        global.myself.object.accel = 0;
        global.myself.object.moveStatus = 0;
        // jerry-rigging consistency in charging by makin u slightly jumped
        if (global.myself.object.onground) global.myself.object.vspeed -= 0.15; else global.myself.object.vspeed += 0.5; 
        // as suggested by Cat Al Ghul, start off FAST.
        if (global.myself.object.onground) {
            if (global.myself.object.image_xscale == -1) {
                    global.myself.object.hspeed -= 12;
            } else if (global.myself.object.image_xscale == 1) {
                global.myself.object.hspeed += 12;
            }
        }
        playsound(global.myself.object.x,global.myself.object.y,ChargeSnd);
        if (global.myself.object.currentWeapon.weaponType == MELEE) global.myself.object.currentWeapon.readyToStab = true;
    }
}