globalvar WEAPON_SYDNEYSLEEPER;
WEAPON_SYDNEYSLEEPER = 24;

globalvar SydneySleeper;
SydneySleeper = object_add();
object_set_parent(SydneySleeper, RifleWeapon);

object_event_add(SydneySleeper,ev_create,0,'
    spriteBase = "SydneySleeper";
    event_inherited();
    unscopedDamage = 30;
    baseDamage = 40;
    maxDamage = 65;

    target = noone;

    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\SydneySleeperS.png", 2, 1, 0, 4, 4);

    reloadAnimLength = sprite_get_number(reloadSprite)/2
    reloadImageSpeed = reloadAnimLength/(longRecoilTime);
');

object_event_add(SydneySleeper,ev_other,ev_user3,'
    event_inherited();
    // Apply Piss.
    with(target) 
    {
        if(object_index == Character or object_is_ancestor(object_index, Character)) {
            if(!ubered and !radioactive and team != other.owner.team) {
                if other.hitDamage == other.maxDamage {
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
global.name[WEAPON_SYDNEYSLEEPER] = "Sydney Sleeper";
