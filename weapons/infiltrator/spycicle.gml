globalvar WEAPON_SPYCICLE;
WEAPON_SPYCICLE = 78;

globalvar Spycicle;
Spycicle = object_add();
object_set_parent(Spycicle, MeleeWeapon);

object_event_add(Spycicle,ev_create,0,'
    xoffset=5 - 32;
    yoffset=-6 - 32;
    spriteBase = "Spycicle";
    event_inherited();
');

object_event_add(Spycicle,ev_destroy,0,'
    event_inherited();
    owner.fireproof = false;
');

object_event_add(Spycicle,ev_alarm,10,'
    owner.fireproof = false;
');

object_event_add(Spycicle,ev_step,ev_step_normal,'
    event_inherited();

    if owner.burnDuration > 0 or owner.burnIntensity > 0 && owner.ammo[112] >= 30*15 {
        playsound(x,y,CompressionBlastSnd);
        owner.fireproof = true;
        alarm[10] = 60 / global.delta_factor;
    }
');

object_event_add(Spycicle,ev_other,ev_user1,'
    if owner.ammo[112] < 15*30 exit;
');

global.weapons[WEAPON_SPYCICLE] = Spycicle;
global.name[WEAPON_SPYCICLE] = "Spycicle (unfinished)";
