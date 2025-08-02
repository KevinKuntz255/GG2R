globalvar WEAPON_SPYCICLE;
WEAPON_SPYCICLE = 78;

globalvar Spycicle;
Spycicle = object_add();
object_set_parent(Spycicle, Weapon);

object_event_add(Spycicle,ev_create,0,'
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

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SpycicleS.png", 2, 1, 0, 32, 32);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SpycicleFS.png", 8, 1, 0, 32, 32);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SpycicleS.png", 2, 1, 0, 32, 32);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(Spycicle,ev_destroy,0,'
    event_inherited();
    owner.fireproof = false;
');

object_event_add(Spycicle,ev_alarm,10,'
    owner.fireproof = false;
');

object_event_add(Spycicle,ev_step,ev_step_normal,'
    if owner.cloak shotDamage=10;
    else shotDamage = min(35,damage+0.5);

    event_inherited();

    if owner.burnDuration > 0 or owner.burnIntensity > 0 && owner.ammo[112] >= 30*15 {
        playsound(x,y,CompressionBlastSnd);
        owner.fireproof = true;
        alarm[10] = 60;
    }
');

object_event_add(Spycicle,ev_other,ev_user1,'
    if owner.ammo[112] < 15*30 exit;
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

global.weapons[WEAPON_SPYCICLE] = Spycicle;
global.name[WEAPON_SPYCICLE] = "Spycicle (unfinished)";
