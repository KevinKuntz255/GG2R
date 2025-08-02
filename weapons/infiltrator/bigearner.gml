globalvar WEAPON_BIGEARNER;
WEAPON_BIGEARNER = 77;

globalvar BigEarner;
BigEarner = object_add();
object_set_parent(BigEarner, Weapon);

object_event_add(BigEarner,ev_create,0,'
    xoffset=5;
    yoffset=-6;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    damage=10;
    isMelee = true;
    justShot = false;

    weaponGrade = UNIQUE;
    weaponType = MELEE;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BigEarnerS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BigEarnerFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BigEarnerS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(BigEarner,ev_step,ev_step_normal,'
    if owner.cloak shotDamage=10;
    else shotDamage = min(35,damage+0.5);

    event_inherited();

');

object_event_add(BigEarner,ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;
        justShot = true;

        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    } else if(readyToStab && owner.cloak){
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,StabAnim);
        stab.direction = owner.aimDirection;
        stab.speed = 0;
        stab.owner = owner;
        stab.ownerPlayer = ownerPlayer;
        stab.team = owner.team;
        stab.hitDamage = 0;
        stab.weapon = WEAPON_KNIFE;
        stab.golden = golden;
        if owner.stabspeed > 0 {
            owner.stabspeed -= 1;
            stab.animationspeed*=2;
            alarm[3] = 32/2;
        } else alarm[3] = 32;
        readyToStab = false;
    }
');

global.weapons[WEAPON_BIGEARNER] = BigEarner;
global.name[WEAPON_BIGEARNER] = "Big Earner (unfinished)";
