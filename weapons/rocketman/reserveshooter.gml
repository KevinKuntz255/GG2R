globalvar WEAPON_RESERVESHOOTER;
WEAPON_RESERVESHOOTER = 19;

globalvar Reserveshooter;
Reserveshooter = object_add();
object_set_parent(Reserveshooter, Weapon);

object_event_add(Reserveshooter,ev_create,0,'
    xoffset=1;
    yoffset=4;
    refireTime=20;
    event_inherited();
    maxAmmo = 4;
    ammoCount = maxAmmo;
    reloadTime = 15;
    reloadBuffer = 20;
    idle=true;
    // cooldown = refireTime; [A typo?]
    couldSwitch = false;
    readyToShoot=true;

    weaponGrade = UNIQUE;
    weaponType = SHOTGUN;
    
    shotDamage = 7;
    shots = 5;
    shotSpeed[0] = 11;
    shotSpeed[1] = 4;
    shotDir[0] = 11;
    shotDir[1] = 5;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\reserveshooterS.png", 2, 1, 0, 6, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\reserveshooterFS.png", 4, 1, 0, 6, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\reserveshooterFRS.png", 16, 1, 0, 18, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(Reserveshooter,ev_alarm,5,'
    event_inherited();

    if ammoCount >= maxAmmo owner.canSwitch = true;
');

object_event_add(Reserveshooter,ev_step,ev_step_normal,'
    if(ammoCount >= maxAmmo){
        owner.canSwitch = true;
    }else{
        owner.canSwitch = false;
    }
');

global.weapons[WEAPON_RESERVESHOOTER] = Reserveshooter;
global.name[WEAPON_RESERVESHOOTER] = "Reserve Shooter (unfinished)";
