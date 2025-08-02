globalvar WEAPON_COWMANGLER;
WEAPON_COWMANGLER = 12;

globalvar CowMangler;
CowMangler = object_add();
object_set_parent(CowMangler, Weapon);

object_event_add(CowMangler,ev_create,0,'
    xoffset = -5;
    yoffset = -4;
    refireTime = 30;
    event_inherited();
    reloadTime = 25;
    reloadBuffer = 30;
    maxAmmo = 100;
    ammoCount = maxAmmo;
    rocketrange=501;
    idle=true;

    weaponGrade = UNIQUE;
    weaponType = ROCKETLAUNCHER;

    //ability = CHARGE_WEAPON;
    abilityVisual = "WEAPON";
    abilityActive = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\CowmanglerS.png", 2, 1, 0, 10, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\CowmanglerFS.png", 4, 1, 0, 10, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\CowmanglerS.png", 2, 1, 0, 10, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(CowMangler,ev_step,ev_step_normal,'
    if abilityActive {
        owner.runPower = 0.6;
        owner.jumpStrength = 6;
        justShot=true;
        ammoCount -= 2;
        if ammoCount <= 0 {
            abilityActive = false;
            ammoCount=25;
            event_user(1);
        }
    } else if readyToShoot {
        if ammoCount < 0 ammoCount = 0;
        else if ammoCount <= maxAmmo ammoCount +=0.9;
    } else {
        owner.runPower = 0.9;
        owner.jumpStrength = 8+(0.6/2);
    }
');

object_event_add(CowMangler,ev_other,ev_user2,'
    if(readyToShoot == true && ammoCount >= maxAmmo && !owner.cloak && !abilityActive) {
        abilityActive = true;
        playsound(x,y,ManglerChargesnd);
    }   
');

global.weapons[WEAPON_COWMANGLER] = CowMangler;
global.name[WEAPON_COWMANGLER] = "Cow Mangler 5000 (unfinished)";
