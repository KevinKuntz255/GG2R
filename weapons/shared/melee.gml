globalvar MeleeWeapon;
MeleeWeapon = object_add();
object_set_parent(MeleeWeapon, Weapon);

object_event_add(MeleeWeapon, ev_create, 0, '
    refireTime = 18;
    event_inherited();

    SwingreloadTime = 5;
    StabreloadTime = 5;
    if (alarm[2] <= 0) alarm[2] = 5;
    smashing = false;
    isMelee = true;

    ammoCount = 1;
    maxAmmo = 1;
    // todo: replace user_event(12) call with readyToStab call for consistent melee swings between client and host
    stabdirection = 0;
    weaponGrade = UNIQUE;
    weaponType = MELEE;

    shotDamage = 35; // default damage

    reloadTime = 300;
    reloadBuffer = refireTime;

    if (!variable_local_exists("spriteBase")) spriteBase = "Knife2";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FS.png", 8, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 2, 1, 0, 0, 0);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(MeleeWeapon, ev_destroy, 0, '
    with (MeleeMask) if (ownerPlayer == other.ownerPlayer) instance_destroy();
    with (StabMask) if (ownerPlayer == other.ownerPlayer) instance_destroy();
    with (StabAnim) if (ownerPlayer == other.ownerPlayer) instance_destroy();
');

object_event_add(MeleeWeapon, ev_alarm, 1, '
    shot = instance_create(x,y,MeleeMask);
    if (owner.abilityActive && owner.ability == DASH) {
        shot.splashHit = true;
        shot.splashAmount = 3;
        shot.knockBack = true;
        if (owner.meter[1] <= 50 || owner.moveStatus == 4 && owner.meter[1] <= 60) { // give grace since youre flying
            shotDamage = 50; 
            playsound(x,y,CritSnd);
            shot.crit=1;
        } else if (owner.meter[1] <= 70 || owner.moveStatus == 4 && owner.meter[1] <= 80) {
            shotDamage = 40; 
            playsound(x,y,CritSnd);
            shot.crit=2;
        }
        owner.abilityActive = false;
        owner.meter[1] = 0;
    }
    shot.direction = owner.aimDirection;
    shot.speed = owner.speed;
    shot.owner = owner;
    shot.ownerPlayer = ownerPlayer;
    shot.team = owner.team;
    shot.hitDamage = shotDamage;
    shot.weapon = id;

    alarm[2] = 10;
');

object_event_add(MeleeWeapon, ev_alarm, 2, '
    readyToStab = true;
');

object_event_add(MeleeWeapon, ev_alarm, 3, '
    shot = instance_create(x,y,StabMask);
    shot.direction = stabdirection;
    shot.speed = 0;
    shot.owner = owner;
    shot.ownerPlayer = ownerPlayer;
    shot.team = owner.team;
    shot.hitDamage = 200;
    shot.weapon=DAMAGE_SOURCE_KNIFE;

    alarm[2] = 18;
');

object_event_add(MeleeWeapon, ev_alarm, 5, '
    event_inherited();

    ammoCount = maxAmmo;
    if meter != -1 meter = maxMeter;
');

object_event_add(MeleeWeapon, ev_step, ev_step_normal, '
    if owner.cloak shotDamage = 10;
    else shotDamage = min(35, shotDamage + 0.5);

    if smashing {
        image_speed=0.3;
        if 1 != 1 { //Removed crit here
            if image_index >= 11{
                image_speed=0;
                image_index=8;
                stabbing = false;
            } 
        } else if image_index >= 4*owner.team+3 {
            image_speed=0;
            image_index=4*owner.team;
            stabbing = false;
        }    
    } else {
        if 1 <= 1  image_index=4*owner.team;
        else image_index = 8;
    }
');

object_event_add(MeleeWeapon, ev_other, ev_user1, '
    if(readyToStab && !owner.cloak) {
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = SwingreloadTime / global.delta_factor;
        playsound(x, y, swingSnd);
    } else if (readyToStab && owner.cloak){
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
        stab.weapon = DAMAGE_SOURCE_KNIFE;
        stab.golden = golden;
        
        // BH reward - *B*obble *H*ead
        if(hasClassReward(ownerPlayer, "BH"))
        {
            ds_list_add(stab.overlays, HatBobbleSpyStabS);
        }
        readyToStab = false;
        /*if owner.stabspeed > 0 {
            owner.stabspeed -= 1;
            stab.animationspeed*=2;
            alarm[3] = 32/2;
        } else*/alarm[1] = StabreloadTime / global.delta_factor;

    }
');