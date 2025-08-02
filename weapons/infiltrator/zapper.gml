globalvar WEAPON_ZAPPER;
WEAPON_ZAPPER = 79;

globalvar Zapper;
Zapper = object_add();
object_set_parent(Zapper, Weapon);

object_event_add(Zapper,ev_create,0,'
    xoffset=5;
    yoffset=-6;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 45;
    smashing = false;

    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    damage=3;
    isMelee = true;
    justShot = false;

    weaponGrade = UNIQUE;
    weaponType = MELEE;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ZapperS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ZapperFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\ZapperS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(Zapper,ev_step,ev_step_normal,'
    if owner.cloak shotDamage=10;
    else shotDamage = min(35,damage+0.5);

    event_inherited();
');

object_event_add(Zapper,ev_other,ev_user1,'
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
        stab.hitDamage = 66;
        stab.weapon = WEAPON_ZAPPER;
        stab.golden = golden;
        stab.animationspeed = 1;
        stab.animationspeed*=1.25;
        if owner.stabspeed > 0 {
            owner.stabspeed -= 1;
            stab.animationspeed*=2;
            alarm[3] = 26/2;
        } else alarm[3] = 26;
        readyToStab = false;
    }
');

global.weapons[WEAPON_ZAPPER] = Zapper;
global.name[WEAPON_ZAPPER] = "Zapper (unfinished)";
