globalvar SpyShazia;
SpyShazia = object_add();
object_set_parent(SpyShazia, MeleeWeapon);

object_event_add(SpyShazia,ev_create,0,'
    xoffset= 5 - 32;
    yoffset= -6;
	event_inherited();
	line = false;
	linex = 0;
	liney = 0;

	stopspotX = 0;
	stopspotY = 0;
	weaponGrade = FUN;
	motionAdd = 0;
');

global.lerp = '
{
    return (argument0 + argument2 * (argument1 - argument0));
}';

object_event_add(SpyShazia,ev_step,ev_step_normal,'
	if (line) {
		linex = execute_string(global.lerp, linex, stopspotX, 0.4);
		liney = execute_string(global.lerp, liney, stopspotY, 0.4);
		gunSetSolids();
	    //if (!place_free(linex, liney)) 
	    //if (place_meeting(linex, liney, Obstacle)) 
	    if collision_line(x, y, linex, liney, Obstacle, true, true) 
	    {
	    	with(owner) {
		    	motion_add(other.motionAdd, 8);
		        //vspeed*= (liney * 0.1);
		        //hspeed *= (linex * 0.1);
		        moveStatus = 4;
	        }
	        line = false;
	    }
	    gunUnsetSolids();
	} else {
		linex = execute_string(global.lerp, linex, owner.x, 0.85);
		liney = execute_string(global.lerp, liney, owner.y, 0.85);
	}
    
  /*if (place_meeting(linex,liney, Character))
		implement vampiric sucking
	*/
');

object_event_add(SpyShazia,ev_other,ev_user1,'
	if (owner.pressedKeys) {
		line = !line;
		if (line) {
			motionAdd = owner.aimDirection;
			stopspotX = round(owner.x) + cos(degtorad(owner.aimDirection))*owner.aimDistance;
			stopspotY = round(owner.y) - sin(degtorad(owner.aimDirection))*owner.aimDistance;
		}
	}
');

object_event_add(SpyShazia,ev_draw,0,'
	var color, xdrawpos, ydrawpos;
    if(owner.team == TEAM_RED) color = c_red;
    else color = c_blue;
    xdrawpos = round(owner.x+xoffset*image_xscale);
    ydrawpos = round(owner.y+yoffset);
    draw_set_alpha(0.3);

    if (!line)
	draw_line_width_color(xdrawpos+lengthdir_x(64,owner.aimDirection),ydrawpos+lengthdir_y(64,owner.aimDirection), linex, liney, 3, color, color);
	else
		draw_line_width_color(xdrawpos+lengthdir_x(12,owner.aimDirection),ydrawpos+lengthdir_y(-64,owner.aimDirection), linex, liney, 3, color, color);
');

/*
global.weapons[WEAPON_SHAZIA] = SpyShazia;
global.name[WEAPON_SHAZIA] = "Lock-On";
*/