globalvar MeleeWeapon;
MeleeWeapon = object_add();
object_set_parent(MeleeWeapon, Weapon);

object_event_add(MeleeWeapon, ev_create, 0, '
    refireTime=18;
    event_inherited();

    StabreloadTime = 5;
    if (alarm[2] <= 0) alarm[2] = 15;
    smashing = false;
    isMelee = true;

    ammoCount = 1;
    maxAmmo = 1;
    // todo: replace user_event(12) call with readyToStab call for consistent melee swings between client and host
    stabdirection=0;
    weaponGrade = UNIQUE;
    weaponType = MELEE;

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
    shot.direction=owner.aimDirection;
    shot.speed=owner.speed;
    shot.owner=owner;
    shot.ownerPlayer=ownerPlayer;
    shot.team=owner.team;
    if (shotDamage != -1) shot.hitDamage = shotDamage; else shot.hitDamage = 35; // default dmg
    shot.weapon=id;

    alarm[2] = 10;
');

object_event_add(MeleeWeapon,ev_alarm,2,'
    readyToStab = true;
');

object_event_add(MeleeWeapon,ev_alarm,3,'
    shot = instance_create(x,y,StabMask);
    shot.direction=stabdirection;
    shot.speed=0;
    shot.owner=owner;
    shot.ownerPlayer=ownerPlayer;
    shot.team=owner.team;
    shot.hitDamage = 200;
    shot.weapon=DAMAGE_SOURCE_KNIFE;

    alarm[2] = 18;
');

object_event_add(MeleeWeapon, ev_alarm, 5,'
    event_inherited();

    ammoCount = maxAmmo;
    if meterCount != -1 meterCount = maxMeter;
');

object_event_add(MeleeWeapon,ev_step,ev_step_normal,'
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

object_event_add(MeleeWeapon, ev_other,ev_user1,'
    if(readyToStab && !owner.cloak){
        //owner.runPower = 0;
        //owner.jumpStrength = 0;
        smashing = 1;

        justShot=true;
        readyToStab = false;
        alarm[1] = StabreloadTime / global.delta_factor;
        playsound(x,y,swingSnd);
    }
');