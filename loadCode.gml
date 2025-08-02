ini_open("gg2.ini");
global.switchWeapon = ini_read_real("RM","switch_weapon",ord('Q'));
ini_close();
// Make a new menu for plugin options.
if !variable_global_exists("pluginOptions") {
    global.pluginOptions = object_add();
    object_set_parent(global.pluginOptions, OptionsController);
    object_set_depth(global.pluginOptions, -130000);
    object_event_add(global.pluginOptions, ev_create, 0, '
        menu_create(40, 140, 300, 200, 30);

        if room != Options {
            menu_setdimmed();
        }

        menu_addback("Back", "
            instance_destroy();
            if(room == Options)
                instance_create(0,0,MainMenuController);
            else
                instance_create(0,0,InGameMenuController);
        ");
    ');

    object_event_add(InGameMenuController, ev_create, 0, '
        menu_addlink("Randomizer Options", "
            instance_destroy();
            instance_create(0,0,global.pluginOptions);
        ");
    ');
}

object_event_add(global.pluginOptions, ev_create, 0, '
    menu_addedit_keyormouse("Switch Weapon:", "global.switchWeapon","");
');

object_event_add(global.pluginOptions, ev_destroy, 0, '
    ini_open("gg2.ini");
    ini_write_real("RM", "switch_weapon", global.switchWeapon);
    ini_close();
');


object_event_add(Character,ev_create,0,'
	accel = 0;
	blurs = 0;
	player.activeWeapon=0;
	//player.playerLoadout=-1;
	expectedWeaponBytes = 0;
	flight = 0;

    canSwitch = true;
	
	tripleJumpUsed = false;

	placedMines = 0;
	crit = -1;
');

object_event_add(Character,ev_destroy,0,'
	with(RadioBlur) {
		if (owner == other.id) {
            instance_destroy();
        }
	}
');


object_event_add(Character,ev_step,ev_step_normal,'
	abilityActive = currentWeapon.abilityActive;
	makeBlur = abilityActive && string_count("BLUR",currentWeapon.abilityVisual) != 0;
	blur = (currentWeapon.abilityActive && string_count("BLUR",currentWeapon.abilityVisual) != 0);
	if (blur) {
		with(RadioBlur)
			if (owner == other.id) exit;
		blur=instance_create(x,y,RadioBlur);
		blur.owner=id;
	} else {
		with(RadioBlur)
			if (owner == other.id) {
				owner = -1;
			}
	}
');
globalvar DetoTrimpSnd, DetoFlyStartSnd, DetoFlySnd;
DetoTrimpSnd = sound_add(directory + '/randomizer_sounds/DetoTrimpSnd.wav', 0, 1);
DetoFlyStartSnd = sound_add(directory + '/randomizer_sounds/DetoFlyStartSnd.wav', 0, 1);
//DetoFlySnd = sound_add(directory + '/randomizer_sounds/DetoFlySnd.wav', 0, 1); honestly irritating, and the flames are indicator enough
object_event_clear(Character,ev_step,ev_step_end);
object_event_add(Character,ev_step,ev_step_end,'
	charSetSolids();


	// Climbing down stairs
	// if we are not falling this frame, and we are not on a dropdown platform
	if(vspeed == 0 and ((keyState & $02) or !place_meeting(x, y+1, DropdownPlatform) or place_meeting(x, y, DropdownPlatform)))
	{
	    if(place_free(x,y+6))
	        if(!place_free(x,y+7))
	            y += 6;
	        else if(speed > 6) if(place_free(x,y+12)) if(!place_free(x,y+13))
	            y += 12;
	}
	xprevious = x;
	yprevious = y;
	
	if (player.class != CLASS_QUOTE) {
		if(currentWeapon.abilityActive and weapons[1] == Eyelander) {
			// the hspeed mod is a light buff to detect more slopes	
			if(!place_free(x + sign(hspeed*0.5), y)) { // we hit a wall on the left or right
				if(place_free(x + sign(hspeed*0.5), y - 6)) // if we could just walk up the step
				{
					playsound(x,y,DetoTrimpSnd);
					if (keyState & $80) {
						vspeed -= 7.3 * accel; // hold W to fly
					}
					//effect_create_below(ef_smoke,x-hspeed*1.2,y-vspeed*1.2+40,0,c_gray);
					if !variable_local_exists("jumpFlameParticleType")
					{
						jumpFlameParticleType = part_type_create();
						part_type_sprite(jumpFlameParticleType,FlameS,true,false,true);
						part_type_alpha2(jumpFlameParticleType,1,0.3);
						part_type_life(jumpFlameParticleType,2/global.delta_factor,5/global.delta_factor);
						part_type_scale(jumpFlameParticleType,0.7,-0.65);
					}
					
					if !variable_global_exists("jumpFlameParticleSystem")
					{
						global.jumpFlameParticleSystem = part_system_create();
						part_system_depth(global.jumpFlameParticleSystem, 10);
					}
					
					if(global.particles == PARTICLES_NORMAL or global.particles == PARTICLES_ALTERNATIVE)
					{
						part_particles_create(global.jumpFlameParticleSystem,x,y+19,jumpFlameParticleType,1);
					}
					//hspeed -= 5;
					accel += 0.5;
				} else {
					accel = 0;
				}
			}
			/*if (moveStatus == 4 && !flight)
			{
				if(alarm[11] <= 0)
					loopsoundstart(x,y,DetoFlySnd);
				else
					loopsoundmaintain(x,y,DetoFlySnd);
				alarm[11] = 2 / global.delta_factor;
			}*/
			if (keyState & $80) {
				if (accel > 1.3 && !onground) {
					moveStatus = 4; // bork it so youre always flyin
					if (flight) {
						playsound(x,y,DetoFlyStartSnd);
						flight = false;
					}
				} else {
					flight = true;
				}
			}
		} //detected upwards slope, Fly!
	}
	charUnsetSolids();

	if(global.isHost && hp<=0) {
	    var assistant;
	    assistant = secondToLastDamageDealer;
	    with(lastDamageDealer)
	        if (object)
	            if (object.healer)
	                assistant = object.healer;
	                
	    sendEventPlayerDeath(player, lastDamageDealer, assistant, lastDamageSource);
	    doEventPlayerDeath(player, lastDamageDealer, assistant, lastDamageSource);
	    
	    with(GameServer) {
	        ServerBalanceTeams();
	    }
	    exit;
	}
	    
	if(hp>maxHp) {
	    hp=maxHp;
	}
	    
	if(((aimDirection+270) mod 360)>180) {
	    image_xscale=1;
	    currentWeapon.image_xscale=1;
	    if(currentWeapon.isMelee == true){
	    	currentWeapon.image_angle = 0;
	    }else{
	    	currentWeapon.image_angle = aimDirection;
	    }
	} else {
	    image_xscale=-1;
	    currentWeapon.image_xscale=-1;
	    if(currentWeapon.isMelee == true){
	    	currentWeapon.image_angle = 0;
	    }else{
	    	currentWeapon.image_angle = aimDirection+180;
	    }
	}
	    
	currentWeapon.x=round(x);
	currentWeapon.y=round(y);
	    
	// Limit people to the area of the room to prevent the
	// Falling through the floors issue.
	if(x<0) {
	    x=0;
	}
	if(x>map_width()){
	    x = map_width();
	}
	if(y<0) {
	    y = 0;
	}
	if(y>map_height()){
	    y = map_height();
	}
	    
	// Cloak
	if (cloak and cloakAlpha > 0 and !cloakFlicker)
	    cloakAlpha = max(cloakAlpha - 0.05, 0);
	else if (!cloak and cloakAlpha < 1)
	    cloakAlpha = min(cloakAlpha + 0.05, 1);
	    
	// Taunts
	if (taunting)
	{
	    tauntindex += tauntspeed*0.1 * global.delta_factor;
	    if (tauntindex >= sprite_get_number(tauntsprite))
	        taunting = false;
	    if (hasClassReward(player, "TauntMoney_"))
	    {
	        if (tauntindex == 0.30)
	            instance_create(x, y, Money);
	    }
	}
	    
	//sandvich
	if (omnomnomnom)
	{
	    omnomnomnomindex += 0.25 * global.delta_factor;
	    image_xscale=xscale;
	    if(hp < maxHp) // This should prevent the ate and got hit but didnt refresh cooldown bug
	    { // Also cooldown is now reset continually until fully healed or finished eating
	        canEat = false;
	        alarm[6] = eatCooldown / global.delta_factor;
	    }
	    if (hp <= maxHp)
	        hp += 1.6 * global.delta_factor;
	    if (omnomnomnomindex >= omnomnomnomend)
	        omnomnomnom=false;
	}

	//for things polling whether the character is on a medcabinet
	onCabinet = place_meeting(x, y, HealingCabinet);

	// Last x/y position for death cam if player is dead
	player.lastKnownx=x;
	player.lastKnowny=y;

	// Here the view is set
	if (player == global.myself)
	{
	    if (global.myself.class == CLASS_SNIPER and zoomed)
	    {
	        var relxmouse, relymouse;
	        relxmouse = min(max(window_views_mouse_get_x()-view_xview[0], 0), view_wview);
	        relymouse = min(max(window_views_mouse_get_y()-view_yview[0], 0), view_hview);
	        
	        view_xview[0] = x+relxmouse-view_wview[0];
	        view_yview[0] = y+relymouse-view_hview[0];
	    }
	    else
	    {
	        view_xview[0] = x-view_wview[0]/2;
	        view_yview[0] = y-view_hview[0]/2;
	    }
	}

	realnumflames = numFlames * burnDuration / maxDuration;

	// Decay deathmatch invulnerability if needed
	if(deathmatch_invulnerable > 0)
	    deathmatch_invulnerable -= global.delta_factor * deathmatch_invuln_decay;
	if(deathmatch_invulnerable <= 0)
	    deathmatch_invulnerable = 0;
');

object_event_add(Weapon,ev_create,0,'
	spark = 0;
    alarm[9]=2;
');
object_event_add(Weapon,ev_alarm,9,'
	alarm[9] = 2;
	spark += 1;
	if spark > 3 spark = 0;
');
globalvar Spark2S;
Spark2S = sprite_add(pluginFilePath + "\randomizer_sprites\Spark2S.png", 4, 1, 0, 10, 10);
object_event_clear(Weapon,ev_draw,0);
object_event_add(Weapon,ev_draw,0,'
	if (distance_to_point(view_xview + view_wview/2, view_yview + view_hview/2) > 800)
	    exit;
	    
	var imageOffset;

	//var abilityVisual = string(currentWeapon.abilityVisual);

	if ((alarm[6] <= 0 and alarm[5] <= 0) or object_index == Blade) {
	    //if we are not shooting or recoiling
	    imageOffset = owner.team;
	} else {
	    //Play the current animation normally
	    var animLength;
	    if (object_index != Rifle && alarm[5] <= 0)
	        animLength = recoilAnimLength;
	    else if (sprite_index == recoilSprite)
	        animLength = recoilAnimLength;
	    else
	        animLength = reloadAnimLength;
	        
	    imageOffset = floor(image_index mod animLength) + animLength*owner.team;
	}
	if (!owner.invisible and !owner.taunting and !owner.omnomnomnom and !owner.player.humiliated)
	{
	    if (!owner.cloak)
	        image_alpha = power(owner.cloakAlpha, 0.5);
	    else
	        image_alpha = power(owner.cloakAlpha, 2);
	    draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, c_white, image_alpha);
	    if (abilityActive && string_count("WEAPON", abilityVisual) > 0) 
	    {
				if (owner.team == TEAM_RED)
					ubercolour = c_orange;
				else if (owner.team == TEAM_BLUE)
					ubercolour = c_aqua;
				//draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
				draw_sprite_ext(sprite_index,4+imageOffset/2,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7);
				if (!isMelee) 
					draw_sprite_ext(Spark2S,spark,round(x+xoffset*image_xscale),round(y+yoffset) + owner.equipmentOffset ,image_xscale,image_yscale,image_angle,ubercolour,0.3);
				else
					draw_sprite_ext(Spark2S,spark,round(x+xoffset*image_xscale),round(y+yoffset+40) + owner.equipmentOffset ,image_xscale,image_yscale,image_angle,ubercolour,0.3);
	
	    }
	    if (owner.ubered)
	    {
	        if (owner.team == TEAM_RED)
	            ubercolour = c_red;
	        else if (owner.team == TEAM_BLUE)
	            ubercolour = c_blue;
	        draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
	    }
	}
');

object_event_clear(Scout,ev_create,0);
object_event_add(Scout,ev_create,0,'
	baseRunPower = 1.4;
	maxHp = 100;
	weapons[0] = Scattergun;
	weapons[1] = Atomizer;
	haxxyStatue = ScoutHaxxyStatueS;

	if (global.paramPlayer.team == TEAM_RED)
	{
	    sprite_index = ScoutRedS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
	    sprite_index = ScoutBlueS;
	}

	event_inherited();

	// Override defaults
	capStrength = 2;
	canDoublejump = 1;
	numFlames = 3;
');
object_event_clear(Heavy,ev_create,0);
object_event_add(Heavy,ev_create,0,'
	baseRunPower = 0.8;
	maxHp = 200;
	weapons[0] = Minigun;
	weapons[1] = KGOB;
	haxxyStatue = HeavyHaxxyStatueS;

	if (global.paramPlayer.team == TEAM_RED)
	{
	    sprite_index = HeavyRedS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
	    sprite_index = HeavyBlueS;
	}

	event_inherited();

	// Override defaults
	numFlames = 5;
');
object_event_clear(Heavy,ev_step,ev_step_normal);
object_event_add(Heavy,ev_step,ev_step_normal,'
	minigun = keyState & $10 && player.activeWeapon == 0;
	if(minigun) {
			runPower = 0.3;
    } else {
        runPower = 0.8;
		jumpStrength = baseJumpStrength;
    }
	event_inherited();
');
object_event_clear(Demoman,ev_create,0);
object_event_add(Demoman,ev_create,0,'
	baseRunPower = 1;
	maxHp = 120;
	weapons[0] = Minegun;
	weapons[1] = Eyelander; // ohohohohoho
	haxxyStatue = DemomanHaxxyStatueS;

	if (global.paramPlayer.team == TEAM_RED)
	{
	    sprite_index = DemomanRedS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
	    sprite_index = DemomanBlueS;
	}

	event_inherited();

	numFlames = 3;
');
object_event_clear(Engineer,ev_create,0);
object_event_add(Engineer,ev_create,0,'
	baseRunPower = 1;
	maxHp = 120;
	weapons[0] = Shotgun;
	weapons[1] = Wrench;
	haxxyStatue = EngineerHaxxyStatueS;

	if (global.paramPlayer.team == TEAM_RED)
	{
		sprite_index = EngineerRedS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
		sprite_index = EngineerBlueS;
	}

	event_inherited();

	numFlames = 3;
');
object_event_clear(Pyro,ev_create,0);
object_event_add(Pyro,ev_create,0,'
	baseRunPower = 1.1;
	maxHp = 120;
	weapons[0] = Flamethrower;
	weapons[1] = Axe;
	haxxyStatue = PyroHaxxyStatueS;

	if (global.paramPlayer.team == TEAM_RED)
	{
	    sprite_index = PyroRedS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
	    sprite_index = PyroBlueS;
	}

	event_inherited();

	numFlames = 3;
	maxDuration = 10;
');
object_event_clear(Spy,ev_create,0);
object_event_add(Spy,ev_create,0,'
	maxHp = 100;
	baseRunPower = 1.08;
	weapons[0] = Revolver;
	weapons[1] = Knife;
	haxxyStatue = SpyHaxxyStatueS;

	if (global.paramPlayer.team == TEAM_RED)
	{
	    sprite_index = SpyRedS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
	    sprite_index = SpyBlueS;
	}

	event_inherited();

	// Override defaults
	canCloak = 1;
	numFlames = 4;

	stabspeed = 0;
');
object_event_clear(Sniper,ev_create,0);
object_event_add(Sniper,ev_create,0,'
	maxHp = 120;
	baseRunPower = 0.9;
	weapons[0] = Rifle;
	weapons[1] = Kukri;
	haxxyStatue = SniperHaxxyStatueS;

	if (global.paramPlayer.team == TEAM_RED)
	{
	    sprite_index = SniperRedS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
	    sprite_index = SniperBlueS;
	}

	event_inherited();

	// Override defaults
	numFlames = 4;
');
object_event_clear(Soldier,ev_create,0);
object_event_add(Soldier,ev_create,0,'
	maxHp = 160;
	baseRunPower = .9;
	weapons[0] = Rocketlauncher;
	weapons[1] = Shovel;
	
	haxxyStatue = SoldierHaxxyStatueS;

	if (global.paramPlayer.team == TEAM_RED)
	{
	    sprite_index = SoldierRedS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
	    sprite_index = SoldierBlueS;
	}

	event_inherited();

	numFlames = 4;
');
object_event_clear(Medic,ev_create,0);
object_event_add(Medic,ev_create,0,'
	maxHp = 120;
	baseRunPower = 1.09;
	weapons[0] = Medigun;
	weapons[1] = Ubersaw;
	haxxyStatue = MedicHaxxyStatueS;

	alarm[11] = 30 / global.delta_factor;

	if (global.paramPlayer.team == TEAM_RED)
	{
	    sprite_index = MedicRedS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
	    sprite_index = MedicBlueS;
	}

	event_inherited();

	// Override defaults
	numFlames = 4;
');

globalvar SpecialHud;
SpecialHud = object_add();
object_event_add(SpecialHud,ev_step,ev_step_begin,'
	if global.myself.object == -1 instance_destroy();
');
object_event_add(SpecialHud,ev_draw,0,'
	if global.myself.object = -1 exit;
	
	xoffset = view_xview[0];
    yoffset = view_yview[0];
    ysize = view_hview[0];
    if global.myself.team == TEAM_BLUE uberoffset=1;
    else uberoffset=0;
    
    draw_set_valign(fa_center);
    draw_set_halign(fa_center);
    draw_set_alpha(1);
    message1 = -1;
    message2 = -1;
    title1 = "";
    title2 = "";
	
	var weapon;
	weapon = global.myself.object.currentWeapon;
	weaponType = weapon.weaponType;
	//if weaponType == 
	if global.myself.class == CLASS_DEMOMAN
		yoffset += 50;
	if weapon.hasMeter {
		message1 = (weapon.meterCount / weapon.maxMeter) * 100;
		//message1 = weapon.meterCount;
		title1 = weapon.meterName;
	}
	if message1 != -1 {
        draw_healthbar(xoffset+665, yoffset+500, xoffset+785, yoffset+532,message1,c_black,c_white,c_white,0,true,true);
        draw_sprite_ext(UberHudS,uberoffset,xoffset+720,yoffset+515,2,2,0,c_white,1);
        draw_text_color(xoffset+730,yoffset+510,title1,c_white,c_white,c_white,c_white,1);
        if message2 != -1 {
            draw_healthbar(xoffset+665-140, yoffset+500, xoffset+785-140, yoffset+532,message2,c_black,c_white,c_white,0,true,true);
           draw_sprite_ext(UberHudS,uberoffset,xoffset+720-140,yoffset+515,2,2,0,c_white,1);
            draw_text_color(xoffset+730-140,yoffset+510,title2,c_white,c_white,c_white,c_white,1);
        }
    }
');

//Handles swapping out loadout weapons and the active weapon shown
object_event_clear(PlayerControl,ev_step,ev_step_end);
object_event_add(PlayerControl,ev_step,ev_step_end,'
	//Changes the number telling randomizer what weapon should be shown
	if (keyboard_check_pressed(global.switchWeapon)) {
		if(global.myself.object != -1){
			//canSwitch = !global.myself.object.taunting or !global.myself.object.canSwitch or global.myself.class != CLASS_QUOTE; // prevent switching when taunting or eyelander charging or quote
			if (global.myself.object.taunting or !global.myself.object.canSwitch or global.myself.class == CLASS_QUOTE) break;
			if(global.myself.activeWeapon == 0){
				global.myself.activeWeapon = 1;
				if (global.myself.object.zoomed) {
					write_ubyte(global.serverSocket, TOGGLE_ZOOM);
				}
			}else{
				global.myself.activeWeapon = 0;
			}

			var coolSendBuffer;
			coolSendBuffer = buffer_create();

			//Sends the active weapon to the server
			write_ubyte(coolSendBuffer, randomizer.activeWeapon);
			write_ubyte(coolSendBuffer, global.myself.activeWeapon);
			if(global.isHost){
				PluginPacketSendTo(randomizer.packetID, coolSendBuffer, global.myself);
			}else{
				PluginPacketSend(randomizer.packetID, coolSendBuffer);
			}
			buffer_clear(coolSendBuffer);
		}
	}
	globalvar AmmoCounterID;
    with(AmmoCounter) AmmoCounterID = id;
    with(Player){
        if(object != -1){
        	if (class == CLASS_QUOTE) break;
            //Swaps the primary and secondary based on the active weapon
            if(variable_local_exists("activeWeapon")){
                if(activeWeapon == 0){
                    if(object.currentWeapon.object_index != object.weapons[0]){
                        with(object.currentWeapon) instance_destroy();

                        object.currentWeapon = -1;

                        global.paramOwner = object;
                        object.currentWeapon = instance_create(object.x,object.y,object.weapons[0]);
                        global.paramOwner = noone;
                    }
                }else if(activeWeapon == 1){
                    if(object.currentWeapon.object_index != object.weapons[1]){
                        with(object.currentWeapon) instance_destroy();

                        object.currentWeapon = -1;

                        global.paramOwner = object;
                        object.currentWeapon = instance_create(object.x,object.y,object.weapons[1]);
                        global.paramOwner = noone;
                    }
                }
            }
        }
    }

	if(global.myself.object != -1){
		//AFK Check -- double length for server host
		if(global.isHost)
		    afktimer -= 0.5 * global.delta_factor
		else
		    afktimer -= 1 * global.delta_factor;

		if ((afktimer <= 0) and !global.myself.object.afk)
		{
		    global.myself.object.afk = true;
		    if !instance_exists(TeamSelectController)
		        instance_create(0,0,TeamSelectController);
		    with(TeamSelectController)
		        afk = true;
		}
		   
		if(global.myself.class == CLASS_ENGINEER)
		{
		    if(global.myself.sentry and !instance_exists(SentryHealthHud))
		        instance_create(0,0,SentryHealthHud);

		    if(!instance_exists(NutsNBoltsHud))
		        instance_create(0,0,NutsNBoltsHud);
		}
		if(global.myself.class == CLASS_HEAVY) {
			if(!instance_exists(SandwichHud))
				instance_create(0,0,SandwichHud);
		}

		// Sticky HUD. Because real men let computers count for them.
		else if (global.myself.class == CLASS_DEMOMAN) && !instance_exists(StickyCounter) instance_create(0,0,StickyCounter);
		  
		else if global.myself.class == CLASS_MEDIC {
		    //Uber HUD
		    if !instance_exists(UberHud) instance_create(0,0,UberHud);
		    //Healing Hud
		    if !instance_exists(HealingHud) && global.showHealing = 1 instance_create(0,0,HealingHud);
		    //Medic Radar
		    if global.medicRadar == 1 && !instance_exists(MedicRadar) instance_create(0,0,MedicRadar);
		}
		        
		// Health HUD
		if  !instance_exists(HealthHud) instance_create(0,0,HealthHud);
	
		// Healed HUD
		if !instance_exists(HealedHud) && global.showHealer = 1 instance_create(0,0,HealedHud);
		
		//this hud does most of the special displays (cooldown & charge timers)
		if !instance_exists(SpecialHud) instance_create(0,0,SpecialHud);
	}
');


// Skips received bytes if too many or too little are received for a certain weapon
object_event_clear(Character,ev_other,ev_user12);
object_event_add(Character,ev_other,ev_user12,'
	{
	    var temp;
	    write_ubyte(global.serializeBuffer, keyState);
	    write_ushort(global.serializeBuffer, netAimDirection);
	    write_ubyte(global.serializeBuffer, aimDistance/2);

	    if(global.updateType == QUICK_UPDATE or global.updateType == FULL_UPDATE) {
	        write_ushort(global.serializeBuffer, x*5);
	        write_ushort(global.serializeBuffer, y*5);
	        write_byte(global.serializeBuffer, hspeed*8.5);
	        write_byte(global.serializeBuffer, vspeed*8.5);
	        write_ubyte(global.serializeBuffer, ceil(hp));
	        write_ubyte(global.serializeBuffer, currentWeapon.ammoCount);
	        
	        temp = 0;
	        if(cloak) temp |= $01;
	        //allocate the next three bits of the byte for movestatus sync
	        temp |= (moveStatus & $07) << 1;
	        write_ubyte(global.serializeBuffer, temp);               
	    }
	   

	if(global.updateType == FULL_UPDATE){
	    write_ubyte(global.serializeBuffer, animationOffset);
	    
	    //class specific syncs
	    switch(player.class)
	    {
	    case CLASS_SPY:
	        write_ubyte(global.serializeBuffer, cloakAlpha*255);
	        break;
	    case CLASS_MEDIC:
	        write_ubyte(global.serializeBuffer, currentWeapon.uberCharge*255/2000);
	        break;
	    case CLASS_ENGINEER:
	        write_ubyte(global.serializeBuffer, nutsNBolts);
	        break;
	    case CLASS_SNIPER:
	        write_ubyte(global.serializeBuffer, currentWeapon.t);
	        break;
	    default:
	        write_ubyte(global.serializeBuffer, 0);
	    }
	    write_short(global.serializeBuffer, alarm[1]*global.delta_factor);
	    write_ubyte(global.serializeBuffer, intel);
	    write_short(global.serializeBuffer, intelRecharge);
	    
	    if(currentWeapon.object_index == Minegun or currentWeapon.object_index == Eyelander){
	    	expectedWeaponBytes = 3;
		    with(Mine){
		        if(ownerPlayer == other.player){
		            other.expectedWeaponBytes += 7;
		        }
		    }
		    //show_error(string(expectedWeaponBytes), false);
	    }
	    write_ubyte(global.serializeBuffer, expectedWeaponBytes);
	    with(currentWeapon) {
	        event_user(12);
	    }
	    }
	}
');
object_event_clear(Character,ev_other,ev_user13);
object_event_add(Character,ev_other,ev_user13,'
	{
	    receiveCompleteMessage(global.serverSocket,4,global.deserializeBuffer);
	    keyState = read_ubyte(global.deserializeBuffer);
	    aimDirection = read_ushort(global.deserializeBuffer)*360/65536;
	    aimDistance = read_ubyte(global.deserializeBuffer)*2;
	    
	    var temp, newIntel;
	    if(global.updateType == QUICK_UPDATE) or (global.updateType == FULL_UPDATE) {
	        receiveCompleteMessage(global.serverSocket,9,global.deserializeBuffer);
	        x = read_ushort(global.deserializeBuffer)/5;
	        y = read_ushort(global.deserializeBuffer)/5;
	        hspeed = read_byte(global.deserializeBuffer)/8.5;
	        vspeed = read_byte(global.deserializeBuffer)/8.5;
	        xprevious = x;
	        yprevious = y;
	        
	        hp = read_ubyte(global.deserializeBuffer);
	        currentWeapon.ammoCount = read_ubyte(global.deserializeBuffer);
	        
	        temp = read_ubyte(global.deserializeBuffer);
	        cloak = (temp & $01 != 0);
	        moveStatus = (temp >> 1) & $07;
	    }
	    
	if(global.updateType == FULL_UPDATE){
	        receiveCompleteMessage(global.serverSocket,8,global.deserializeBuffer);
	        animationOffset = read_ubyte(global.deserializeBuffer);
	        //class specific syncs
	        switch(player.class)
	        {
	        case CLASS_SPY:
	            cloakAlpha = read_ubyte(global.deserializeBuffer)/255;
	            break;
	        case CLASS_MEDIC:
	            currentWeapon.uberCharge = read_ubyte(global.deserializeBuffer)*2000/255;
	            break;
	        case CLASS_ENGINEER:
	            nutsNBolts = read_ubyte(global.deserializeBuffer);
	            break;
	        case CLASS_SNIPER:
	            currentWeapon.t = read_ubyte(global.deserializeBuffer);
	            if(currentWeapon.t) zoomed = true; // Quick hack
	            break;
	        default:
	            read_ubyte(global.deserializeBuffer)
	        }
	        alarm[1] = read_short(global.deserializeBuffer)/global.delta_factor; 
	        if (alarm[1] != 0)
	            canGrabIntel = false;
	        intel = read_ubyte(global.deserializeBuffer);
	        intelRecharge = read_short(global.deserializeBuffer);

	        actualWeaponBytes = read_ubyte(global.deserializeBuffer);
	        if(actualWeaponBytes == expectedWeaponBytes){
		        with(currentWeapon) {
		            event_user(13);
		        }
		    }else{
		    	receiveCompleteMessage(global.serverSocket,actualWeaponBytes,global.deserializeBuffer);
		    	buffer_clear(global.deserializeBuffer);
		    }
	    }
	    event_user(1);
	}
');