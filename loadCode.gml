//Swapping out scripts for modified versions
object_event_clear(GameServer,ev_step,ev_step_normal);
object_event_add(GameServer,ev_step,ev_step_normal,'
	execute_file(pluginFilePath + "\move_all_bullets_but_better.gml");
	script_execute(move_all_gore);
');
object_event_clear(Client,ev_step,ev_step_normal);
object_event_add(Client,ev_step,ev_step_normal,'
	execute_file(pluginFilePath + "\move_all_bullets_but_better.gml");
	script_execute(move_all_gore);
');


//Loadout Stuff
globalvar loadout, Back, LoadoutSwitcher, LoadoutMenu;
loadout = room_add();
room_set_width(loadout, 600);
room_set_height(loadout, 600);

Back=object_add();
LoadoutSwitcher=object_add();
LoadoutMenu=object_add();


object_event_add(Back,ev_create,0,'
	BackS = sprite_add(pluginFilePath + "\randomizer_sprites\BackS.png", 2, 0, 0, 0, 0);
	depth = -140000;
	image_speed=0;
	//alarm[0] = 1;
	xoffset = view_xview[0];
	yoffset = view_yview[0];
');
object_event_add(Back,ev_step,ev_step_normal,'
	if mouse_x >xoffset+32 && mouse_x < xoffset+96 && mouse_y > yoffset+544 && mouse_y < yoffset + 576 image_index = 1;
	else image_index = 0;

	/*
	Temporary Workaround
	if(variable_global_exists("myself")){
		if(global.myself.object != -1){
			global.myself.object.keyState = 0;
			global.myself.object.lastKeyState = 0;
		}
	}
	*/
');
object_event_add(Back,ev_mouse,ev_global_left_press,'
	if image_index == 1 {
	    if room = loadout room_goto_fix(Menu);
	    else with(LoadoutMenu) {instance_destroy();};
	}
');
object_event_add(Back,ev_draw,0,'
	xoffset = view_xview[0];
	yoffset = view_yview[0];

	draw_sprite(BackS,image_index,xoffset+32,yoffset+544);
');

object_event_add(LoadoutSwitcher,ev_create,0,'
	SelectionS = sprite_add(pluginFilePath + "\randomizer_sprites\SelectionS.png", 180, 0, 0, 0, 0);
	sprite_index = sprite_add(pluginFilePath + "\randomizer_sprites\ScrollerS.png", 5, 0, 0, 0, 0);
	depth = -140000;
	image_speed=0;
	image_alpha=0;
	image_xscale=2;
	image_yscale=2;

	if room == loadout xoffset = view_xview[0];
	else xoffset = view_xview[0]+100;
	yoffset = view_yview[0];
	xsize = view_wview[0];
	ysize = view_hview[0];

	selection = 0;

	description[0,0] = "";
	description[0,1] = "";
	description[0,2] = "";

	description[1,0] = "";
	description[1,1] = "";
	description[1,2] = "";

	description[2,0] = "";
	description[2,1] = "";
	description[2,2] = "";

	description[3,0] = "";
	description[3,1] = "";
	description[3,2] = "";

	description[4,0] = "";
	description[4,1] = "";
	description[4,2] = "";
');
object_event_add(LoadoutSwitcher,ev_step,ev_step_normal,'
	if room == loadout xoffset = view_xview[0];
	else xoffset = view_xview[0]+100;
	yoffset = view_yview[0];
	xsize = view_wview[0];
	ysize = view_hview[0];


	if mouse_x > x+xoffset && mouse_x <x+48*2+xoffset {
	    if mouse_y > y+yoffset && mouse_y < y+30*2+yoffset {
	        selection = 0;
	        LoadoutMenu.name = global.name[value+selection];
	        LoadoutMenu.description[0] = description[0,0];
	        LoadoutMenu.description[1] = description[0,1];
	        LoadoutMenu.description[2] = description[0,2];
	    } else if mouse_y > y+30*2+yoffset && mouse_y < y+60*2+yoffset {
	        selection = 1;
	        LoadoutMenu.name = global.name[value+selection];
	        LoadoutMenu.description[0] = description[1,0];
	        LoadoutMenu.description[1] = description[1,1];
	        LoadoutMenu.description[2] = description[1,2];
	    }else if mouse_y > y+60*2+yoffset && mouse_y < y+90*2+yoffset {
	        selection = 2;
	        LoadoutMenu.name = global.name[value+selection];
	        LoadoutMenu.description[0] = description[2,0];
	        LoadoutMenu.description[1] = description[2,1];
	        LoadoutMenu.description[2] = description[2,2];
	    } else if mouse_y > y+90*2+yoffset && mouse_y < y+120*2+yoffset {
	        selection = 3;
	        LoadoutMenu.name = global.name[value+selection];
	        LoadoutMenu.description[0] = description[3,0];
	        LoadoutMenu.description[1] = description[3,1];
	        LoadoutMenu.description[2] = description[3,2];
	    } else if mouse_y > y+120*2+yoffset && mouse_y < y+150*2+yoffset {
	        selection = 4;
	        LoadoutMenu.name = global.name[value+selection];
	        LoadoutMenu.description[0] = description[4,0];
	        LoadoutMenu.description[1] = description[4,1];
	        LoadoutMenu.description[2] = description[4,2];
	    } else selection = loaded-value;
	} else selection = loaded-value;

	image_alpha=1;
');
object_event_add(LoadoutSwitcher,ev_mouse,ev_global_left_press,'
	loaded = value + selection;
');
object_event_add(LoadoutSwitcher,ev_draw,0,'
	if room == loadout xoffset = view_xview[0];
	else xoffset = view_xview[0]+100;
	yoffset = view_yview[0];
	xsize = view_wview[0];
	ysize = view_hview[0];

	draw_sprite_ext(sprite_index,loaded-value,x+xoffset,y+yoffset,image_xscale,image_yscale,0,c_white,image_alpha);

	for(i=0;i<5;i+=1) {
	    if selection == i draw_sprite_ext(SelectionS,value+i+90,x+xoffset+8,y+yoffset+56*i+8,image_xscale,image_yscale,0,c_white,image_alpha);
	    else draw_sprite_ext(SelectionS,value+i,x+xoffset+8,y+yoffset+56*i+8,image_xscale,image_yscale,0,c_white,image_alpha);
	}
');

//Loadout Menu stuff
object_set_parent(LoadoutMenu, MenuController);
object_event_add(LoadoutMenu,ev_create,0,'
	INGAMELOADOUTBG = sprite_add(pluginFilePath + "\randomizer_sprites\INGAMELOADOUTBG.png", 1, 0, 0, 0, 0);
	LoadoutSelectS = sprite_add(pluginFilePath + "\randomizer_sprites\LoadoutSelectS.png", 1, 0, 0, 0, 0);
	DescriptionBoardS = sprite_add(pluginFilePath + "\randomizer_sprites\DescriptionBoardS.png", 1, 0, 0, 0, 0);
	LoadoutS = sprite_add(pluginFilePath + "\randomizer_sprites\LoadoutS.png", 10, 0, 0, 26, 26);
	depth = -140000;
    name = "Mouse over weapons to see their#description. Left click them to#add the corresponding weapon #to your loadout.";
    description[0] = "";
    description[1] = "";
    description[2] = "";
    done = false;
    newclass=-1;
    currentclass=-1;
    mousedclass=-1
    xoffset2=88;
    offset=0;
    team=0;
    class = "";
    rotation=1;
    firstX=-1;
    if room == loadout xoffset = view_xview[0];
    else xoffset = view_xview[0]+100;
    yoffset = view_yview[0];
    xsize = view_wview[0];
    ysize = view_hview[0];
    //instance_create(16,416,Back);
    instance_create(0,0,Back);
');
object_event_add(LoadoutMenu,ev_destroy,0,'
	if instance_exists(LoadoutSwitcher) event_user(1);
	if instance_exists(Back) with(Back) {instance_destroy();};

	if room != loadout {
	    if instance_exists(global.myself) && global.myself != -1 {
	        if global.myself.object != -1 && instance_exists(global.myself.object){
	            ClientPlayerChangeclass(global.myself.class, global.serverSocket);
        		socket_send(global.serverSocket);
	        }
	    }
	}
');
object_event_add(LoadoutMenu,ev_step,ev_step_normal,'
	if room == loadout xoffset = view_xview[0];
	else xoffset = view_xview[0]+100;
	yoffset = view_yview[0];
	xsize = view_wview[0];
	ysize = view_hview[0];

	if !instance_exists(Back) instance_create(32+view_xview[0],544+yoffset,Back);

	if mouse_x>xoffset+xoffset2+24 && mouse_x <xoffset+xoffset2+60 && mouse_y<yoffset+60{
	    newclass=0;
	    drawx=24;
	}

	else if mouse_x>xoffset+xoffset2+64 && mouse_x <xoffset+xoffset2+100 && mouse_y<yoffset+60{
	    newclass=1;
	    drawx=64;
	}

	else if mouse_x>xoffset+xoffset2+104 && mouse_x <xoffset+xoffset2+140 && mouse_y<yoffset+60{
	    newclass=2;
	    drawx=104;
	}

	else if mouse_x>xoffset+xoffset2+156 && mouse_x <xoffset+xoffset2+192 && mouse_y<yoffset+60{
	    newclass=3;
	    drawx=156;
	}

	else if mouse_x>xoffset+xoffset2+196 && mouse_x <xoffset+xoffset2+232 && mouse_y<yoffset+60{
	    newclass=4;
	    drawx=196;
	}

	else if mouse_x>xoffset+xoffset2+236 && mouse_x <xoffset+xoffset2+272 && mouse_y<yoffset+60{
	    newclass=5;
	    drawx=236;
	}

	else if mouse_x>xoffset+xoffset2+288 && mouse_x <xoffset+xoffset2+324 && mouse_y<yoffset+60{
	    newclass=6;
	    drawx=288;
	}

	else if mouse_x>xoffset+xoffset2+328 && mouse_x <xoffset+xoffset2+364 && mouse_y<yoffset+60{
	    newclass=7;
	    drawx=328;
	}

	else if mouse_x>xoffset+xoffset2+368 && mouse_x <xoffset+xoffset2+404 && mouse_y<yoffset+60{
	    newclass=8;
	    drawx=368;
	}

	else newclass=-1;  

	if mouse_check_button(mb_left){ 
	    if newclass !=-1{
	        mousedclass = newclass;
	        if(newclass>=0 and newclass<=9) {
	            if instance_exists(LoadoutSwitcher) event_user(1); //get rid of the loadout for the old class and write their loadout to the file
	            event_user(2); //create the loadout for the new class
	        }
	    }else if mouse_y > (250-104)+yoffset && mouse_y < (250+104)+yoffset{
	        if mouse_x > (300-100)+xoffset && mouse_x < (300+100)+xoffset {
	            if firstX == -1 firstX=mouse_x;
	            else if firstX > mouse_x + 10{
	                rotation= -1;
	                firstX=-1;
	            }
	            else if firstX < mouse_x - 10{
	                rotation= 1;
	                firstX=-1;
	            }
	        }
	    }
	} else if firstX != -1 firstX = -1;
')
object_event_add(LoadoutMenu,ev_step,ev_step_begin,'
	name = "Mouse over weapons to see their#description. Left click them to#add the corresponding weapon #to your loadout.";
	description[0] = "";
	description[1] = "";
	description[2] = "";
');
object_event_add(LoadoutMenu,ev_other,ev_user1,'
	ini_open("Loadout.gg2");
	if load1.loaded <=9 load1="0"+string(load1.loaded);
	else load1 = string(load1.loaded);
	if load2.loaded <=9 load2="0"+string(load2.loaded);
	else load2 = string(load2.loaded);

	switch(currentclass){
	    case 0:
	        global.loadout[CLASS_SCOUT]=real(string(1)+load1+load2);
	        ini_write_real("Class","Scout",global.loadout[CLASS_SCOUT]);
	        break;
	    case 1:
	        global.loadout[CLASS_PYRO]=real(string(1)+load1+load2);
	        ini_write_real("Class","Pyro",global.loadout[CLASS_PYRO]);
	        break;
	    case 2:
	        global.loadout[CLASS_SOLDIER]=real(string(1)+load1+load2);
	        ini_write_real("Class","Soldier",global.loadout[CLASS_SOLDIER]);
	        break;
	    case 3:
	        global.loadout[CLASS_HEAVY]=real(string(1)+load1+load2);
	        ini_write_real("Class","heavy",global.loadout[CLASS_HEAVY]);
	        break;
	    case 4:
	        global.loadout[CLASS_DEMOMAN]=real(string(1)+load1+load2);
	        ini_write_real("Class","Demoman",global.loadout[CLASS_DEMOMAN]);
	        break;
	    case 5:
	        global.loadout[CLASS_MEDIC]=real(string(1)+load1+load2);
	        ini_write_real("Class","Medic",global.loadout[CLASS_MEDIC]);
	        break;
	    case 6:
	        global.loadout[CLASS_ENGINEER]=real(string(1)+load1+load2);
	        ini_write_real("Class","Engineer",global.loadout[CLASS_ENGINEER]);
	        break;
	    case 7:
	        global.loadout[CLASS_SPY]=real(string(1)+load1+load2);
	        ini_write_real("Class","Spy",global.loadout[CLASS_SPY]);
	        break;
	    case 8:
	        global.loadout[CLASS_SNIPER]=real(string(1)+load1+load2);
	        ini_write_real("Class","sniper",global.loadout[CLASS_SNIPER]);
	        break;
	}
	ini_close(); 
	
	global.currentLoadout = global.loadout[global.myself.class];

	var coolSendBuffer;
	coolSendBuffer = buffer_create();

	//Send Loadout
    write_ubyte(coolSendBuffer, randomizer.loadoutReceive);
    write_ushort(coolSendBuffer, global.currentLoadout);
    if(global.isHost){
        PluginPacketSendTo(randomizer.packetID, coolSendBuffer, global.myself);
    }else{
        PluginPacketSend(randomizer.packetID, coolSendBuffer);
    }
    buffer_clear(coolSendBuffer);   

	if instance_exists(LoadoutSwitcher) with(LoadoutSwitcher) instance_destroy();
');


// Read the step script from file
var fd, readScript;
readScript = "";
fd = file_text_open_read(pluginFilePath + "\loadout_menu_ev_user2.gml");
while(not file_text_eof(fd)) {
	readScript += file_text_read_string(fd) + "
	";
	file_text_readln(fd);
}
file_text_close(fd);
object_event_add(LoadoutMenu,ev_other,ev_user2, readScript);

object_event_add(LoadoutMenu,ev_other,ev_user3,'
	if(mousedclass>=0 and mousedclass<=8) {
	    if instance_exists(LoadoutSwitcher) event_user(1); //get rid of the loadout for the old class and write their loadout to the file
	    event_user(2); //create the loadout for the new class
	}
');
object_event_add(LoadoutMenu,ev_draw,0,'
	if room == loadout xoffset = view_xview[0];
	else xoffset = view_xview[0]+100;
	yoffset = view_yview[0];
	xsize = view_wview[0];
	ysize = view_hview[0];

	if room != loadout {
	    draw_sprite_ext(INGAMELOADOUTBG,0,xoffset-100,yoffset,80,2.5,0,c_white,0.8); 
	}
	draw_sprite_ext(LoadoutSelectS, 0, 112+xoffset, 16+yoffset, 1, 1, 0, c_white, 1);
	if newclass != -1 draw_sprite_ext(ClassSelectSpritesS,newclass,drawx+xoffset+xoffset2,16+yoffset,1,1,0,c_white, 1);
	    
	draw_sprite(DescriptionBoardS,0,160+xoffset,352+yoffset);
	draw_set_font(global.gg2Font); //Not sure if this is needed
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text_transformed(20+xoffset,96+yoffset,class,3,3,0);


	draw_set_color(c_white);
	draw_text(175+xoffset,390+yoffset,name);    //name
	draw_text(175+xoffset,390+yoffset+13,description[0]);  //info
	draw_set_color(make_color_rgb(10,245,10));
	draw_text(175+xoffset,390+yoffset+string_height(description[0])+13,description[1]);  //good
	draw_set_color(make_color_rgb(220,0,0));
	draw_text(175+xoffset,390+yoffset+string_height(description[0])+string_height(description[1])+13,description[2]);  //bad

	draw_set_halign(fa_center)
	draw_set_color(c_white);
	//draw_text(300+xoffset,144+yoffset,"Currently equipped:"");

	if mousedclass=-1 draw_sprite_ext(LoadoutS,9,300+xoffset,250+yoffset,4*rotation,4,0,c_white,1);
	else  draw_sprite_ext(LoadoutS,mousedclass,300+offset*rotation*4+xoffset,250+yoffset,4*rotation,4,0,c_white,1);
');
object_event_add(LoadoutMenu, ev_keypress, vk_escape,'
	instance_destroy();
	if(room == loadout) {
	    room_goto_fix(Menu);
	} /*else
	    instance_create(0,0,InGameMenuController);*/
');



//Adds loadout to ingame menu
object_event_clear(InGameMenuController,ev_create,0);
object_event_add(InGameMenuController,ev_create,0,'
    cursor_sprite = CrosshairS;
    global.levelchoice = 1

    menu_create(40, 300, 200, 200, 32);
    menu_background(212, 24, 8, 12, 4);
    menu_setdimmed();
    
    menu_addlink("Return to Game", "
        instance_destroy();
    ");
    menu_addback("", "
        instance_destroy();
    ");
    if (global.isHost) {
        menu_addlink("Kick players", "
            if(!instance_exists(ScoreTableController)) instance_create(0,0,ScoreTableController);
            ScoreTableController.showadmin = true;
            instance_destroy();
        ");
    }
    menu_addlink("Options", "
        instance_destroy();
        instance_create(0,0,OptionsController);
    ");
    menu_addlink("Loadout", "
        instance_destroy();
        instance_create(0,0,LoadoutMenu);
    ");
    forcedWorkaroundOne = "Do you really want to leave this match?";
    menu_addlink("Disconnect", "
        // Force dedicated mode to off so you can go to main menu instead of just restarting server
        if (show_question(forcedWorkaroundOne)) {
            if (global.serverPluginsInUse)
            {
                pluginscleanup(true);
            }
            else
            {
                global.dedicatedMode = 0;
                with(Client)
                    instance_destroy();
                    
                with(GameServer)
                    instance_destroy();
            }
        }
    ");
    forcedWorkaroundTwo = "Do you really want to quit?";
    menu_addlink("Quit Game", "
        if (show_question(forcedWorkaroundTwo)) {
            game_end();
        }
    ");
');

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
object_event_clear(Weapon,ev_alarm,6);
object_event_add(Weapon,ev_alarm,6,'
	if (reloadSprite != -1 && object_index != Rifle && object_index != BazaarBargain && object_index != Machina && alarm[5] > 0)
	{
	    sprite_index = reloadSprite;
	    image_index = 0;
	    image_speed = reloadImageSpeed * global.delta_factor;
	} 
	else
	{
	    sprite_index = normalSprite;
	    image_speed = 0;
	}
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
	if ((alarm[6] <= 0 and alarm[5] <= 0) or object_index == Blade) {
	    //if we are not shooting or recoiling
	    imageOffset = owner.team;
	} else {
	    //Play the current animation normally
	    var animLength;
	    if (object_index != Rifle && object_index != BazaarBargain && object_index != Machina && alarm[5] <= 0)
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
	    if (variable_local_exists("charging"))
	    {
	    	if(charging == 1){
		        if (owner.team == TEAM_RED)
		            ubercolour = c_orange;
		        else if (owner.team == TEAM_BLUE)
		            ubercolour = c_aqua;
		        //draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
		        draw_sprite_ext(sprite_index,4+imageOffset/2,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7);
                draw_sprite_ext(Spark2S,spark,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.3);
			}
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

object_event_add(Character,ev_create,0,'
	if(variable_local_exists("player")){
		weapons[0] = global.weapons[real(string_copy(string(global.loadout[player.class]), 2, 2))];
		weapons[1] = global.weapons[real(string_copy(string(global.loadout[player.class]), 4, 2))];
	}
');

//This event sucks
object_event_clear(PlayerControl,ev_step,ev_step_begin);
object_event_add(PlayerControl,ev_step,ev_step_begin,'
	if(instance_exists(MenuController))
	    exit;
	    
	var kickOpen;
	kickOpen = false
	if (instance_exists(ScoreTableController))
	    if (ScoreTableController.showadmin)
	        kickOpen = true;
	    
	if(instance_exists(TeamSelectController) || instance_exists(ClassSelectController) || kickOpen)
	    menuOpen = true;
	else
	    menuOpen = false;

	//Checking for input - Mapped Keys
	if(keyboard_check_pressed(global.changeTeam))
	    inputChangeTeam();
	if(keyboard_check_pressed(global.changeClass))
	    inputChangeClass();

	event_user(8);
	    
	var keybyte;
	keybyte = 0;

	/* KeyByte flags:
	    02 - down
	    
	    08 - primary
	    10 - secondary
	    
	    20 - right
	    40 - left
	    80 - up
	*/

	//character object exists
	if(global.myself.object != -1)
	{
	    if(!menuOpen)
	    {
	        if(keyboard_check(global.left) || keyboard_check(global.left2)) keybyte |= $40;
	        if(keyboard_check(global.right) || keyboard_check(global.right2)) keybyte |= $20;
	        if(keyboard_check(global.jump) || keyboard_check(global.jump2)) keybyte |= $80;
	        if(keyboard_check(global.down) || keyboard_check(global.down2)) keybyte |= $02;
	        if(keyboard_check(global.taunt)) keybyte |= $01;
	        if(keyboard_check_pressed(global.chat1)) inputChat1();
	        if(keyboard_check_pressed(global.chat2)) inputChat2();
	        if(keyboard_check_pressed(global.chat3)) inputChat3();
	        if(keyboard_check_pressed(global.drop)) inputDrop();
	        
	        if(keyboard_check_pressed(global.medic))
	        {
	            inputCallMedic();
	        }
	        
	        if(!global.myself.humiliated)
	        {
	            if(keyboard_check(global.attack)) keybyte |= $10;
	            if(keyboard_check(global.special)) keybyte |= $08;
	            if(keyboard_check_pressed(global.special)) inputSpecial();
	            if(keyboard_check_pressed(global.taunt)) inputTaunt();
	            
	            if(mouse_check_button(mb_left))
	            {
	                if(global.attack == MOUSE_LEFT) keybyte |= $10;
	                if(global.special == MOUSE_LEFT) keybyte |= $08;
	            }
	            if(mouse_check_button_pressed(mb_left) and global.special == MOUSE_LEFT)
	                execute_file(pluginFilePath + "\input_special_but_better.gml");

	            if(mouse_check_button(mb_right))
	            {
	                if(global.attack == MOUSE_RIGHT) keybyte |= $10;
	                if(global.special == MOUSE_RIGHT) keybyte |= $08;
	            }
	            if(mouse_check_button_pressed(mb_right) and global.special == MOUSE_RIGHT)
	                execute_file(pluginFilePath + "\input_special_but_better.gml");
	            
	        }
	    }
	    
	    if(global.run_virtual_ticks)
	        ClientInputstate(global.serverSocket, keybyte);
	    socket_send(global.serverSocket);
	}
	// spectator controls
	else if (instance_exists(Spectator))
	{
	    if(!menuOpen)
	    {
	        if(mouse_check_button_pressed(mb_left))
	            with (Spectator) event_user(7);
	        if(mouse_check_button_pressed(mb_right))
	            with (Spectator) event_user(8);
	    }
	}

	if(keybyte != 0
	        or keyboard_check(global.left) or keyboard_check(global.left2)
	        or keyboard_check(global.right) or keyboard_check(global.right2)
	        or keyboard_check(global.jump) or keyboard_check(global.jump2)
	        or keyboard_check(global.down) or keyboard_check(global.down2)) {
	    afktimer = afktimeout;
	}
');

//Handles swapping out loadout weapons and the active weapon shown
object_event_clear(PlayerControl,ev_step,ev_step_end);
object_event_add(PlayerControl,ev_step,ev_step_end,'
	globalvar AmmoCounterID;
    with(AmmoCounter) AmmoCounterID = id;
    with(Player){
        if(object != -1){
            //Changes the primary and secondary based on the loaded loadout
            if(variable_local_exists("playerLoadout")){
            	if(class == real(string_copy(string(playerLoadout), 2, 1))){
	                if(object.weapons[0] != global.weapons[real(string_copy(string(playerLoadout), 2, 2))]){
	                    object.weapons[0] = global.weapons[real(string_copy(string(playerLoadout), 2, 2))];

	                    with(object.currentWeapon) instance_destroy();
	                    object.currentWeapon = -1;

	                    global.paramOwner = object;
	                    object.currentWeapon = instance_create(object.x,object.y,object.weapons[0]);
	                    global.paramOwner = noone;
	                }
	                if(object.weapons[1] != global.weapons[real(string_copy(string(playerLoadout), 4, 2))]){
	                    object.weapons[1] = global.weapons[real(string_copy(string(playerLoadout), 4, 2))];
	                }
	            }
            }

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
		if(global.myself.class == CLASS_HEAVY and global.myself.object.weapons[1] == SandvichHand)
		{
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
	}
');

//Changes the number telling randomizer what weapon should be shown
object_event_add(PlayerControl, ev_mouse, ev_global_middle_press,'
	if(global.myself.object != -1){
		if(global.myself.activeWeapon == 0){
			global.myself.activeWeapon = 1;
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
');

//Keeps the currentLoadout variable REAL nice and updated
object_event_add(Character,ev_step,ev_step_end,'
	if(player.id == global.myself){
		global.currentLoadout = global.loadout[global.myself.class];
	}
');

//Keeps the currentLoadout variable updated as it should be
object_event_add(ClassSelectController,ev_other,ev_user1,'
	{
		global.myself.activeWeapon = 0;
		global.currentLoadout = global.loadout[global.myself.class];

		var coolSendBuffer;
		coolSendBuffer = buffer_create();


		//Send Loadout
        write_ubyte(coolSendBuffer, randomizer.loadoutReceive);
        write_ushort(coolSendBuffer, global.currentLoadout);
        if(global.isHost){
            PluginPacketSendTo(randomizer.packetID, coolSendBuffer, global.myself);
        }else{
            PluginPacketSend(randomizer.packetID, coolSendBuffer);
        }
        buffer_clear(coolSendBuffer);


	    event_user(0);
	    if((not done) and (class != global.myself.class))
	    {
	        ClientPlayerChangeclass(class, global.serverSocket);
	        socket_send(global.serverSocket);
	    }
	    done=true;
	}
');