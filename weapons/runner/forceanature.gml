globalvar WEAPON_FAN;
WEAPON_FAN = 1;

globalvar ForceANature;
ForceANature = object_add();
object_set_parent(ForceANature, ScattergunWeapon);
object_set_sprite(ForceANature, sprite_add(pluginFilePath + "\randomizer_sprites\ForceANatureS.png", 2, 1, 0, 8, -2));

object_event_add(ForceANature,ev_create,0,'
    xoffset=-5;
    yoffset=-4;
    refireTime=20;
    spriteBase = "ForceANature";
    event_inherited();
    maxAmmo = 3;
    ammoCount = maxAmmo;
    reloadTime = 90;
    reloadBuffer = 20;

    //damSource = DAMAGE_SOURCE_FAN;

    specialShot = FANShot;
    fullReload = true;
    shotSpeed[0] = 6+10;
    shotSpeed[1] = 10;
    shotDir[0] = 15;

    // broken reloadSpeed

    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "FRS.png", 16, 1, 0, 12, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(ForceANature,ev_other,ev_user3,'
    event_inherited();
    with(owner){
        motion_add(aimDirection, -3);
        vspeed*=0.9;
        vspeed -= 2;
        //moveStatus = 3;
        if abs(sin(aimDirection)) > abs(cos(aimDirection)) speed*=0.8;
    }
');

global.weapons[WEAPON_FAN] = ForceANature;
global.name[WEAPON_FAN] = "Force A Nature";
