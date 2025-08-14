globalvar MeleeHitMapSnd, MeleeHitSnd, JarateSnd, CritHitSnd;
MeleeHitMapSnd = sound_add(pluginFilePath + '/randomizer_sounds/MeleeHitMapSnd.wav', 0, 1);
MeleeHitSnd = sound_add(pluginFilePath + '/randomizer_sounds/MeleeHitSnd.wav', 0, 1);
JarateSnd = sound_add(pluginFilePath + '/randomizer_sounds/JarateSnd.wav', 0, 1);
CritHitSnd = sound_add(pluginFilePath + '/randomizer_sounds/CritHitSnd.wav', 0, 1);

//Some needed mods for existing projectiles
// modify the projectiles cuz it's cleaner than adding this line on every weapon's ev_user3 and ev_user2 and overriding default weapon events
// im not touching burningProjectile yet

object_event_add(Rocket,ev_create,0,'
    travelDistance=0; // prevent crashes for airstrike
');

object_event_add(Flare,ev_step,ev_step_begin,'
    if (variable_local_exists("owner")) {
        if (!variable_local_exists("critMade")){
            critMult = owner.currentWeapon.crit;
            hitDamage *= critMult;
            if (critMult > 1) playsound(x,y,CritSnd);
            critMade = 1;
        }
    }
');

object_event_add(Mine,ev_step,ev_step_begin,'
    if (variable_local_exists("owner")) {
        if (!variable_local_exists("critMade")){
            critMult = owner.currentWeapon.crit;
            explosionDamage *= critMult;
            if (critMult > 1) playsound(x,y,CritSnd);
            critMade = 1;
        }
    }
');

object_event_add(Needle,ev_step,ev_step_begin,'
    if (variable_local_exists("owner")) {
        if (!variable_local_exists("critMade")){
            critMult = owner.currentWeapon.crit;
            hitDamage *= critMult;
            if (critMult > 1) playsound(x,y,CritSnd);
            critMade = 1;
        }
    }
');

object_event_add(Rocket,ev_step,ev_step_begin,'
    if (variable_local_exists("owner")) {
        if (!variable_local_exists("critMade")){
            critMult = owner.currentWeapon.crit;
            hitDamage *= critMult;
            if (critMult > 1) playsound(x,y,CritSnd);
            critMade = 1;
        }
    }
');

object_event_add(Shot,ev_step,ev_step_begin,'
    if (variable_local_exists("owner")) {
        if (!variable_local_exists("critMade")){
            critMult = owner.currentWeapon.crit;
            hitDamage *= critMult;
            if (critMult > 1) playsound(x,y,CritSnd);
            critMade = 1;
        }
    }
');

object_event_add(Flare,ev_draw,0,'
    if (variable_local_exists("critMult")) {
        if (critMult > 1) {
            if (owner.team == TEAM_RED)
                    ubercolour = c_orange;
                else if (owner.team == TEAM_BLUE)
                    ubercolour = c_aqua;
                //draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
                draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
                draw_sprite_ext(Spark2S,owner.currentWeapon.spark,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
        }
    }
');

object_event_add(Mine,ev_draw,0,'
    if (variable_local_exists("critMult")) {
        if (critMult > 1) {
            if (owner.team == TEAM_RED)
                    ubercolour = c_orange;
                else if (owner.team == TEAM_BLUE)
                    ubercolour = c_aqua;
                //draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
                draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
                draw_sprite_ext(Spark2S,owner.currentWeapon.spark,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
        }
    }
');

object_event_add(Needle,ev_draw,0,'
    if (variable_local_exists("critMult")) {
        if (critMult > 1) {
            if (owner.team == TEAM_RED)
                    ubercolour = c_orange;
                else if (owner.team == TEAM_BLUE)
                    ubercolour = c_aqua;
                //draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
                draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
                draw_sprite_ext(Spark2S,owner.currentWeapon.spark,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
        }
    }
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
');

object_event_add(Rocket,ev_draw,0,'
    if (variable_local_exists("critMult")) {
        if (critMult > 1) {
            if (owner.team == TEAM_RED)
                    ubercolour = c_orange;
                else if (owner.team == TEAM_BLUE)
                    ubercolour = c_aqua;
                //draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
                draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
                draw_sprite_ext(Spark2S,owner.currentWeapon.spark,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
        }
    }
');

object_event_add(Shot,ev_draw,0,'
    if (variable_local_exists("critMult")) {
        if (critMult > 1) {
            if (owner.team == TEAM_RED)
                    ubercolour = c_orange;
                else if (owner.team == TEAM_BLUE)
                    ubercolour = c_aqua;
                //draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
                draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
                draw_sprite_ext(Spark2S,owner.currentWeapon.spark,x,y,image_xscale,image_yscale,image_angle,ubercolour,0.7);
        }
    }
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
');

// for radioactivity
object_event_clear(Shot,ev_collision,Character);
object_event_add(Shot,ev_collision,Character,'
	gunSetSolids();
    if (!place_free(x, y)) 
    {
        instance_destroy();
        gunUnsetSolids();
        exit;
    }
    gunUnsetSolids();

    if(other.id != ownerPlayer.object and other.team != team  && other.hp > 0 && other.ubered == 0)
    {
        with(weapon) {
            if variable_local_exists("object_index") {
                switch(object_index) {
                    case Reserveshooter:
                        if (!other.onground && other.moveStatus == 2) {
                            hitDamage += 6;
                            var text;
                            text=instance_create(x,y,Text);
                            text.sprite_index=MiniCritS;
                        }
                    break;
                    /*case Widowmaker:
                        owner.nutsnbolts += 20;
                    */
                }
            }
        }
        damageCharacter(ownerPlayer, other.id, hitDamage);
        if (other.lastDamageDealer != ownerPlayer and other.lastDamageDealer != other.player)
        {
            other.secondToLastDamageDealer = other.lastDamageDealer;
            other.alarm[4] = other.alarm[3]
        }
        other.alarm[3] = ASSIST_TIME / global.delta_factor;
        other.lastDamageDealer = ownerPlayer;
        other.lastDamageSource = weapon;
        
        var blood;
        if(global.gibLevel > 0 && !other.radioactive)
        {
            blood = instance_create(x,y,Blood);
            blood.direction = direction-180;
        }
        dealFlicker(other.id);
        with(other)
        {
            motion_add(other.direction, other.speed*0.03);
        }
        instance_destroy();
    }
');

// Use the damage API
global.dealDamageFunction += '
	if (object_is_ancestor(argument1.object_index, Character)) {
        if (argument1.radioactive) { // bonk detection
            argument1.hp += argument2;
			var text;
			text=instance_create(x,y,Text);
			text.sprite_index=MissS;
			exit;
        }
        var pissed, milked;
        pissed = false;
        milked = false;
        if (argument1.soaked) {
            for(i=0; i<4; i+=1) {
                if (argument1.soakType[i] == piss)
                    pissed = true;
                if (argument1.soakType[i] == milk)
                   milked = true;
            }
        }
		//if (pissed || argument1.object.crit == 2 || (argument0.object.currentWeapon.abilityActive && argument0.object.currentWeapon.ability = MINICRIT)) {
        if (pissed && argument0.currentWeapon.crit <= 1) {
			argument2 += 1*0.35; // add this dmg for healing factors
			argument1.hp -= 1*0.35;
			var text;
			text=instance_create(x,y,Text);
			text.sprite_index=MiniCritS;
		}
		if (argument0 != noone && instance_exists(argument0)) {
			if (argument0.object_index == Player) {
				if (argument0.object != -1 && instance_exists(argument0.object)) {
					if (argument0.object.currentWeapon.object_index == BlackBox && argument1.team != argument0.team) argument0.object.hp += argument2*0.3; // todo: move BlackBox heal code to Rocket instead of dealDamage, does not account for switching weapons
                    if (milked) argument0.object.hp += argument2*0.35; // milk heal code
				}
			}
		}
    }
';