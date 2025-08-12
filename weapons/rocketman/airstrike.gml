globalvar WEAPON_AIRSTRIKE;
WEAPON_AIRSTRIKE = 14;

globalvar Airstrike;
Airstrike = object_add();
object_set_parent(Airstrike, RocketWeapon);

object_event_add(Airstrike,ev_create,0,'
    spriteBase = "Airstrike";
    event_inherited();

    weaponGrade = UNIQUE;
    weaponType = ROCKETLAUNCHER;

    // ok this error is gonna be common isnt it
    
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AirstrikeFRS.png", 24, 1, 0, 16, 14);


    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(Airstrike,ev_other,ev_user3,'
    with(Rocket) {
        if ownerPlayer = other.ownerPlayer event_user(5);
    }
    event_inherited();
');

object_event_add(Airstrike,ev_other,ev_user2,'
    with(Rocket) {
        if (travelDistance >= 260) {
            if ownerPlayer = other.ownerPlayer && direction != 270 {
            direction = 270;
            image_angle = 270;
            speed -= 2;
            travelDistance=0;
            other.alarm[0] = other.refireTime / global.delta_factor;
            }
        }
    }
');

global.weapons[WEAPON_AIRSTRIKE] = Airstrike;
global.name[WEAPON_AIRSTRIKE] = "Airstrike";
