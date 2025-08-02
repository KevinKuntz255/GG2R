globalvar WEAPON_SYDNEYSLEEPER;
WEAPON_SYDNEYSLEEPER = 24;

globalvar SydneySleeper;
SydneySleeper = object_add();
object_set_parent(SydneySleeper, Weapon);

object_event_add(SydneySleeper,ev_create,0,'
    xoffset = -1;
    yoffset = -4;
    refireTime = 40;
    event_inherited();
    reloadTime = 40;
    unscopedDamage = 30;
    baseDamage = 40;
    maxDamage = 65;
    chargeTime = 105;
    hitDamage=baseDamage;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    shot=false;
    t=0;
    bonus = 0;

    target = noone;

    weaponGrade = UNIQUE;
    weaponType = RIFLE;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SydneySleeperS.png", 2, 1, 0, 4, 4);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SydneySleeperFS.png", 4, 1, 0, 4, 4);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SydneySleeperS.png", 2, 1, 0, 4, 4);

    sprite_index = normalSprite;

    recoilTime = 15;
    recoilAnimLength = sprite_get_number(recoilSprite)/2
    recoilImageSpeed = recoilAnimLength/recoilTime

    longRecoilTime = 60;
    reloadAnimLength = sprite_get_number(reloadSprite)/2
    reloadImageSpeed = reloadAnimLength/(longRecoilTime);
    
    tracerAlpha = 0;
');

object_event_add(SydneySleeper,ev_other,ev_user3,'
    event_inherited();
    // Apply Piss.
    with(target) 
    {
        if(object_index == Character or object_is_ancestor(object_index, Character)) {
            if(!ubered and !radioactive and team != other.owner.team) {
                if other.hitDamage == other.maxDamage {
                    playsound(x,y,PickupSnd);
                    soaked = true;
                        for(i=0; i<3; i+=1) {
                            if (soakType[i] == -1 && soakType[i] != piss) soakType[i] = piss; // Test later
                        }
                }
            }
        }
    }
');

global.weapons[WEAPON_SYDNEYSLEEPER] = SydneySleeper;
global.name[WEAPON_SYDNEYSLEEPER] = "Sydney Sleeper (unfinished)";
