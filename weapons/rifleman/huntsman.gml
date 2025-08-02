globalvar WEAPON_HUNTSMAN;
WEAPON_HUNTSMAN = 22;

globalvar HuntsMan;
HuntsMan = object_add();
object_set_parent(HuntsMan, Weapon);

object_event_add(HuntsMan,ev_create,0,'
    xoffset=4;
    yoffset=1;
    refireTime = 40;
    event_inherited();
    reloadTime = 40;
    unscopedDamage = 35;
    baseDamage = 45;
    maxDamage = 75;
    chargeTime = 105;
    hitDamage=baseDamage;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    shot=false;
    t=0;
    
    bonus=0;
    //abilityType = CHARGING;
    abilityActive = false;
    abilityVisual = "WEAPON";
    overheat=0;
    burning = false;
    helper = -1;

    weaponGrade = UNIQUE;
    weaponType = BOW;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HuntsmanS.png", 2, 1, 0, 9, 15);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HuntsmanFS.png", 4, 1, 0, 9, 15);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\HuntsmanS.png", 2, 1, 0, 9, 15);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(HuntsMan,ev_step,ev_step_begin,'
    if bonus > 0 && !abilityActive {
            playsound(x,y,BowSnd);
            var shot;
            randomize();
            
            shot = instance_create(x,y + yoffset + 1,Arrow);
            shot.direction=owner.aimDirection;
            shot.speed=10+(bonus/10)*2.2;
            shot.owner=owner;
            //shot.crit=crit;
            shot.ownerPlayer=ownerPlayer;
            shot.team=owner.team;
            if burning {
                shot.burning = true;
                shot.helper = helper;
                shot.weapon = WEAPON_FIREARROW;
            } else shot.weapon=WEAPON_HUNTSMAN;
            with(shot)
                hspeed+=owner.hspeed;
            justShot=true;
            readyToShoot=false;
            alarm[0]=refireTime;
            bonus=0;
            overheat=0;
            owner.runPower = 0.9;
            owner.jumpStrength = 8+(0.6/2);
            burning = false;
    }

    if burning && random(5) > 3.5 effect_create_above(ef_smokeup,x,y,0,c_gray);
');

object_event_add(HuntsMan,ev_collision,BurningProjectile,'
    if other.team == owner.team {
        burning = true;
        helper = other.ownerPlayer;
    }
');

/*
object_event_add(HuntsMan,ev_collision,LaserShot,'
    if other.team == owner.team {
        burning = true;
        helper = other.ownerPlayer;
    }
');
*/

object_event_add(HuntsMan,ev_other,ev_user1,'
    {
        if(readyToShoot && !owner.cloak) {
            owner.runPower = 0.6;
            owner.jumpStrength = 6;
            abilityActive = true;
            alarm[1] = 2;
            if bonus < 100 bonus+=1.2;
            else if overheat < (30*4) overheat+=1;
            else {
                bonus = 0;
                readyToShoot=false;
                alarm[0]=refireTime;
                overheat = 0;
            }
        }
    }
');

object_event_add(HuntsMan,ev_other,ev_user2,'
    abilityActive = false;
    bonus = 0;
    owner.runPower = 0.9;
    owner.jumpStrength = 8+(0.6/2);
');

global.weapons[WEAPON_HUNTSMAN] = HuntsMan;
global.name[WEAPON_HUNTSMAN] = "Huntsman";
