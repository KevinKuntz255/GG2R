globalvar WEAPON_DIPLOMAT;
WEAPON_DIPLOMAT = 73;

globalvar Diplomat;
Diplomat = object_add();
object_set_parent(Diplomat, RevolverWeapon);

object_event_add(Diplomat,ev_create,0,'
    xoffset=-4;
    yoffset=0;
    refireTime=23.4;
    spriteBase = "Diplomat";
    event_inherited();
    
    shotDamage = 21;
');
// todo: head hitbox or create a new gimmick
global.weapons[WEAPON_DIPLOMAT] = Diplomat;
global.name[WEAPON_DIPLOMAT] = "The Ambassador (unfinished)";
