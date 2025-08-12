globalvar SpyShazia;
SpyShazia = object_add();
object_set_parent(SpyShazia, MeleeWeapon);

object_event_add(SpyShazia,ev_create,0,'
    xoffset= 5 - 32;
    yoffset= -6;
    spriteBase = "Knife2";
	event_inherited();
	line = false;
	linex = 0;
	liney = 0;

	weaponGrade = FUN;
');

global.lerp = '
{
    return (argument0 + argument2 * (argument1 - argument0));
}';

object_event_add(SpyShazia,ev_step,ev_step_normal,'
	if (line) {
		linex = execute_string(global.lerp, linex, mouse_x + (1*-image_xscale), 0.5*global.delta_factor);
		liney = execute_string(global.lerp, liney, mouse_y, 0.5*global.delta_factor);
	} else {
		linex = execute_string(global.lerp, linex, x+xoffset*image_xscale, 0.8*global.delta_factor);
		liney = execute_string(global.lerp, liney, y+yoffset, 0.8*global.delta_factor);
	}
	
	stopspot = mouse_x + (1*-image_xscale);
	if (linex = stopspot) line = false;
    
  /*if (place_meeting(linex,liney, Character))
		implement vampiric sucking
	if (place_meeting(linex,liney, Obstacle))
		implement motion_add*/
');

object_event_add(SpyShazia,ev_other,ev_user1,'
	if (owner.pressedKeys) {
		line = !line;
		if (line) {
			linex = x;
			liney = y;
		}
	}
');

object_event_add(SpyShazia,ev_draw,0,'
	var color, xdrawpos, ydrawpos;
    if(owner.team == TEAM_RED) color = c_red;
    else color = c_blue;
    xdrawpos = round(x+xoffset*image_xscale);
    ydrawpos = round(y+yoffset);
    draw_set_alpha(0.3);

	if (line)
		draw_line_width_color(xdrawpos+lengthdir_x(20,owner.aimDirection),ydrawpos+lengthdir_y(20,owner.aimDirection), linex, liney, 5, color, color);
');

/*
object_event_add(Eyelander,ev_other,ev_user2,'
    if (!owner.abilityActive && !owner.cloak && owner.meter[1] >= owner.maxMeter[1]) {
        owner.abilityActive = true;
		owner.accel = 0;
		owner.moveStatus = 0;
        // jerry-rigging consistency in charging by makin u slightly jumped
		if (owner.onground) owner.vspeed -= 0.15; else owner.vspeed += 0.5; 
        // as suggested by Cat Al Ghul, start off FAST.
        if (owner.onground) {
            if (owner.image_xscale == -1) {
                    owner.hspeed -= 12;
            } else if (owner.image_xscale == 1) {
                owner.hspeed += 12;
            }
        }
        playsound(x,y,ChargeSnd);
		readyToStab = true;
    }
');*/
/*
global.weapons[WEAPON_SHAZIA] = SpyShazia;
global.name[WEAPON_SHAZIA] = "Lock-On";
