globalvar WEAPON_DIAMONDBACK;
WEAPON_DIAMONDBACK = 72;

globalvar Diamondback;
Diamondback = object_add();
object_set_parent(Diamondback, Weapon);

object_event_add(Diamondback,ev_create,0,'
    xoffset=-4;
    yoffset=0;
    refireTime=18;
    event_inherited();
    StabreloadTime = 20;
    readyToStab = true;

    stabdirection=0;
    maxAmmo = 6;
    ammoCount = maxAmmo;
    ejected = 0;
    reloadTime = 45; //15 when not loading as clip
    reloadBuffer = refireTime;
    idle=true;
    unscopedDamage = 0;
    readyToStab=true;

    weaponGrade = UNIQUE;
    weaponType = REVOLVER;
    shotDamage = 24;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DiamondbackS.png", 2, 1, 0, -1, 6);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DiamondbackFS.png", 4, 1, 0, -1, 6);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DiamondbackFRS.png", 44, 1, 0, 15, 18);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;
    
    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(Diamondback,ev_other,ev_user1,'
    if(readyToShoot && !owner.cloak && ammoCount > 0)
    {
        if(global.isHost)
        {
            var seed;
            seed = irandom(65535);
            sendEventFireWeapon(ownerPlayer, seed);
            doEventFireWeapon(ownerPlayer, seed);
        }
    }
    else if(readyToStab && owner.cloak && !(owner.keyState & $08))
    {
        owner.runPower = 0;
        owner.jumpStrength = 0;
        owner.stabbing = 1;
        
        stabdirection = owner.aimDirection;
        stab = instance_create(x,y,SapAnimation);
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
        alarm[1] = StabreloadTime / global.delta_factor;
    }
');

global.weapons[WEAPON_DIAMONDBACK] = Diamondback;
global.name[WEAPON_DIAMONDBACK] = "Diamondback (unfinished)";
