globalvar SapAnimation;
SapAnimation = object_add();
globalvar SpySapRedS, SpySapBlueS;
SpySapRedS = sprite_add(pluginFilePath + "\randomizer_sprites\SpySapRedS.png", 7, 1, 0, 28, 40);
SpySapBlueS = sprite_add(pluginFilePath + "\randomizer_sprites\SpySapBlueS.png", 7, 1, 0, 28, 40);
object_event_add(SapAnimation,ev_create,0,'
    done = false;
    offset=0;
    image_speed = 0;
    alarm[0]=5 / global.delta_factor;
    alpha=0.01;
');
object_event_add(SapAnimation,ev_destroy,0,'
    // Do not re-allow movement if there is another StabAnim running for the same player
    with(SapAnimation)
        if(id != other.id and owner == other.owner)
            exit;

    owner.runPower = 1.08;
    owner.jumpStrength = 8;
    owner.stabbing = 0;
');
object_event_add(SapAnimation,ev_alarm,0,'
    image_speed=0.45;
');
object_event_add(SapAnimation,ev_step,ev_step_normal,'
    if direction >= 90 && direction <=270{ 
        image_xscale=-1;
    }else{ 
        image_xscale = 1;
    } 

    if team==TEAM_RED sprite_index=SpySapRedS;
    else sprite_index=SpySapBlueS;


    x=owner.x;
    y=owner.y;

    if image_index >= 6 {
        done=1;
        image_speed=0;
    }

    if(not done) {
        if(alpha<0.99) {
            alpha = power(alpha,0.7);
        } else {
            alpha = 0.99;
        }
    } else {
        if(alpha>0.01) {
            alpha = power(alpha,1/0.7);
        } else {

            instance_destroy();
        }
    }
');
object_event_add(SapAnimation,ev_step,ev_step_end,'
    // Make self invisible if behind enemy
    visible = !owner.invisible;
');
object_event_add(SapAnimation,ev_draw,0,'
    if team == TEAM_RED ubercolour = c_red;
    if team == TEAM_BLUE ubercolour = c_blue;
    draw_sprite_ext(sprite_index,image_index,owner.x,owner.y,image_xscale,image_yscale,0,c_white,alpha);
    if owner.ubered == 1 draw_sprite_ext(sprite_index,image_index,owner.x,owner.y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
');

globalvar SapMask;
SapMask = object_add();
object_set_parent(SapMask, StabMask);
object_event_add(SapMask,ev_create,0,'
    {
        hitDamage = 8;
        alarm[0]=6 / global.delta_factor;
        playsound(x,y,KnifeSnd)
    }
');
object_event_add(SapMask,ev_collision,Character,'');
object_event_add(SapMask,ev_collision,Sentry,'
    if(other.team != team)
    {
        if(!collision_line(x,y-12,other.x,other.y,Obstacle,true,true)) and (!collision_line(x,y-12,other.x,other.y,TeamGate,true,true) and (!collision_line(x,y-12,other.x,other.y,BulletWall,true,true)))
        {
            if global.isHost {
                other.sapped = 4;
                write_ubyte(global.eventBuffer, SAP_TOGGLE);
                write_ubyte(global.eventBuffer, ds_list_find_index(global.players,other.ownerPlayer));
            }
            //if owner.weapon_index == WEAPON_DIAMONDBACK owner.sapCrits+=1;
            other.lastDamageDealer = ownerPlayer;
            other.lastDamageSource = weapon;
            if other.ownerPlayer.object != -1 && other.ownerPlayer == global.myself {
                write_ubyte(global.serverSocket, CHAT_BUBBLE);
                write_ubyte(global.serverSocket, 61);
            }
            instance_destroy();
        }
        else
            alarm[0] = 1 / global.delta_factor;
    }
');
object_event_add(SapMask,ev_collision,ControlPointSetupGate,'
    if (global.setupTimer > 0)
        instance_destroy();
');
object_event_add(SapMask,ev_collision,Generator,'
    if (other.team != team) {
        other.alarm[0] = other.regenerationBuffer / global.delta_factor;
        other.isShieldRegenerating = false;
        //allow overkill to be applied directly to the target
        if (hitDamage/2 > other.shieldHp) {
            other.hp -= hitDamage/2 - other.shieldHp;
            other.hp -= other.shieldHp * other.shieldResistance;
            other.shieldHp = 0;
        } else {
            other.hp -= hitDamage/2 * other.shieldResistance;
            other.shieldHp -= hitDamage/2;
        }
        instance_destroy();
    }
');