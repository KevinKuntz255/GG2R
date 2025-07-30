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
Page=object_add();
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

object_event_add(Page,ev_create,0,'
	PageS = sprite_add(pluginFilePath + "\randomizer_sprites\PageS.png", 2, 0, 0, 0, 0);
	depth = -140000;
	image_speed=0;
	//alarm[0] = 1;
	xoffset = view_xview[0];
	yoffset = view_yview[0];
');
object_event_add(Page,ev_step,ev_step_normal,'
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
object_event_add(Page,ev_mouse,ev_global_left_press,'
	if image_index == 1 {
	    if room = loadout room_goto_fix(Menu);
	    else with(LoadoutMenu) {instance_destroy();};
	}
');
object_event_add(Page,ev_draw,0,'
	xoffset = view_xview[0];
	yoffset = view_yview[0];

	draw_sprite(PageS,image_index,xoffset+32,yoffset+544);
');

object_event_add(LoadoutSwitcher,ev_create,0,'
	SelectionS = sprite_add(pluginFilePath + "\randomizer_sprites\SelectionS.png", 180, 0, 0, 0, 0);
	SelectionS2 = sprite_add(pluginFilePath + "\randomizer_sprites\SelectionS2.png", 2, 0, 0, 0, 0); // Expand later.
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
	page=0;
	
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
	    if (page==0) {
			if selection == i draw_sprite_ext(SelectionS,value+i+90,x+xoffset+8,y+yoffset+56*i+8,image_xscale,image_yscale,0,c_white,image_alpha);
				else draw_sprite_ext(SelectionS,value+i,x+xoffset+8,y+yoffset+56*i+8,image_xscale,image_yscale,0,c_white,image_alpha);
		} else {
			if selection == i draw_sprite_ext(SelectionS2,value+i+90,x+xoffset+8,y+yoffset+56*i+8,image_xscale,image_yscale,0,c_white,image_alpha);
				else draw_sprite_ext(SelectionS2,value+i,x+xoffset+8,y+yoffset+56*i+8,image_xscale,image_yscale,0,c_white,image_alpha);
		}
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
	        global.scoutLoadout=real(string(1)+load1+load2);
	        ini_write_real("Class","Scout",global.scoutLoadout);
	        break;
	    case 1:
	        global.pyroLoadout=real(string(1)+load1+load2);
	        ini_write_real("Class","Pyro",global.pyroLoadout);
	        break;
	    case 2:
	        global.soldierLoadout=real(string(1)+load1+load2);
	        ini_write_real("Class","Soldier",global.soldierLoadout);
	        break;
	    case 3:
	        global.heavyLoadout=real(string(1)+load1+load2);
	        ini_write_real("Class","heavy",global.heavyLoadout);
	        break;
	    case 4:
	        global.demomanLoadout=real(string(1)+load1+load2);
	        ini_write_real("Class","Demoman",global.demomanLoadout);
	        break;
	    case 5:
	        global.medicLoadout=real(string(1)+load1+load2);
	        ini_write_real("Class","Medic",global.medicLoadout);
	        break;
	    case 6:
	        global.engineerLoadout=real(string(1)+load1+load2);
	        ini_write_real("Class","Engineer",global.engineerLoadout);
	        break;
	    case 7:
	        global.spyLoadout=real(string(1)+load1+load2);
	        ini_write_real("Class","Spy",global.spyLoadout);
	        break;
	    case 8:
	        global.sniperLoadout=real(string(1)+load1+load2);
	        ini_write_real("Class","sniper",global.sniperLoadout);
	        break;
	}
	ini_close(); 

	switch (global.myself.class)
	{
	case CLASS_SCOUT:
		global.currentLoadout = global.scoutLoadout;
		break;

	case CLASS_PYRO:
		global.currentLoadout = global.pyroLoadout;
		break;

	case CLASS_SOLDIER:
		global.currentLoadout = global.soldierLoadout;
		break;

	case CLASS_HEAVY:
		global.currentLoadout = global.heavyLoadout;
		break;

	case CLASS_DEMOMAN:
		global.currentLoadout = global.demomanLoadout;
		break;

	case CLASS_MEDIC:
		global.currentLoadout = global.medicLoadout;
		break;

	case CLASS_ENGINEER:
		global.currentLoadout = global.engineerLoadout;
		break;

	case CLASS_SPY:
		global.currentLoadout = global.spyLoadout;
		break;

	case CLASS_SNIPER:
		global.currentLoadout = global.sniperLoadout;
		break;
	}

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

//Adds loadout to ingame menu
object_event_add(InGameMenuController,ev_create,0,'
    menu_addlink("Loadout", "
        instance_destroy();
        instance_create(0,0,LoadoutMenu);
    ");
');

//object_event_add(Character, ev_draw, 0, '
//	if (currentWeapon.charging == 1 && player.class == CLASS_DEMO)  {
//		for (i=0; i<6; i+=1) {
//			draw_sprite_ext(sprite_index, 0 + team, x-hspeed*1.2, y-vspeed*1.2, image_xscale, 1, 0, c_white, 0.2);
//						}
//	}
//');

object_event_add(Character,ev_create,0,'
	accel = 0;
	blurs = 0;
	player.activeWeapon=0;
	player.playerLoadout=-1;
	expectedWeaponBytes = 0;
	flight = 0;
	
	loaded1 = 0;
	loaded2 = 0;
	
	overheal = 0;
    isSaxtonHale = false;
    raged=false;
    canSwitch = true;
	
	//stuff from alt weapons
    pissed=0;
    milked = 0;
    bleeding = 0;
    buffing=false;
    buffbanner=false;
    critting=0;
    critzed = 0;
    invisibeam = false;
    megaHealed=false;
    stunned=0;
    radioactive=false;
    bonus=1;
    charge=false;
    speedboost=0;
    cooldown=0;
    revengeCrits = 0;
    sapCrits = 0;
    active = false;
    regenRate = 2;
    invincible = false;
    stabspeed = 0;
    highJump = 0;
    fireproof = 0;
    currentKills = 0;
    drCharge=0;
    frozen = 0;
    phlogDmg = 0;
    phlogCrit = 0;
    glowindex = 0;
	
	//passive effects
    hasDangershield = false;
    hasOverdose = false;
    stomping = false;
    hasOverdose = false;
    hasRazorback = false;
    hasBootlegger = false;
    hasBoots = false;
    bootfuel = 150;
    floating = false;
    
    //for picking up sentries
    sentryhp=0;
    sentryupgraded=0;
    sentrylevel=0;
    carrySentry=0;
    
	meter0=-1;
	meter1=-1;
	
	// could try using the above later?
    //Things lorgan also prefers saved
    ammo[100] = false;  //uberReady
    ammo[101] = 0;      //lobbed (scottish resistance)
    ammo[102] = -1;     //Bonk timer
    ammo[103] = 0;      //lobbed (minegun)
    ammo[104] = -1;     //Jarate timer
    ammo[105] = -1;     //Sandvich timer
    ammo[106] = 0;      //bazaar bargain bonus
    ammo[107] = -1;     //Ball timer
    ammo[108] = 0;      //Lobbed (tiger uppercut)   
    ammo[109] = 0;      //hyve amount
    ammo[110] = 0;      //lobbed (stickyjumper)
    ammo[111] = -1;     //chocolate timer
    ammo[112] = 15*30;  //spycicle timer
    ammo[113] = -1;     //Milk timer
    ammo[114] = -1;     //napalm grenade timer
    ammo[115] = 0;      //lobbed (sticky sticker)
    // damn that is alot of work
');

object_event_add(Character,ev_destroy,0,'
	with(RadioBlur) {
		if (owner == other.id) {
            instance_destroy();
        }
	}
	loopsoundstop(DetoFlySnd);
');

object_event_add(Character,ev_alarm,8,'
	milked = 0;
	bleeding = 0;
	pissed = 0;
');

object_event_add(Character,ev_step,ev_step_normal,'
	/*if (currentWeapon.charging == 1 and currentWeapon.object_index == Eyelander)
	{
		if (moveStatus != 4) {
			if (image_xscale = -1) {
				hspeed -= 3;
			} else if (image_xscale = 1) {
				hspeed += 3;
			}
		} else {
			if (image_xscale == -1) {
				hspeed -= 1.8;
			} else if (image_xscale == 1) {
				hspeed += 1.8;
			}
		}
	}*/// the trimping becomes permadisabled when used on ev_step_normal
	
	blur = radioactive or (currentWeapon.charging == 1 and currentWeapon.object_index == Eyelander);
	if (blur) {
		while (blurs <= 15) {
			blur=instance_create(x,y,RadioBlur);
			blur.owner=id;
			blurs+=1;
		}
	} else {
		blurs = 0;
	}
');
globalvar DetoTrimpSnd, DetoFlyStartSnd, DetoFlySnd;
DetoTrimpSnd = sound_add(directory + '/randomizer_sounds/DetoTrimpSnd.wav', 0, 1);
DetoFlyStartSnd = sound_add(directory + '/randomizer_sounds/DetoFlyStartSnd.wav', 0, 1);
DetoFlySnd = sound_add(directory + '/randomizer_sounds/DetoFlySnd.wav', 0, 1);
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
	
	if(currentWeapon.charging == 1 and currentWeapon.object_index == Eyelander) {
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
		if (moveStatus == 4 && !flight)
		{
			if(alarm[11] <= 0)
				loopsoundstart(x,y,DetoFlySnd);
			else
				loopsoundmaintain(x,y,DetoFlySnd);
			alarm[11] = 2 / global.delta_factor;
		}
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
	
	if(currentWeapon.object_index == SodaPopper && (hspeed != 0 || vspeed != 0)) {
		if (!instance_exists("currentWeapon.hype")) break;
		if (!currentWeapon.hype)
			currentWeapon.meterCount += 1/16 * speed;
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
	
	// or pissed or milked or bleeding thats 3 variables in one place
	// ykno that could be simplified into a single one
	// like soaked and a soakType
	if !invisibeam
		if /*!(weapon_index > WEAPON_REVOLVER && weapon_index <= WEAPON_ZAPPER or weapon_index == WEAPON_PREDATOR) or*/ pissed or milked or bleeding cloak = false;
	    
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
	
	//dripping piss
	if pissed {
		repeat(random(floor(2))) instance_create(x+random(32)-16,y+random(32)-16,Piss);
	}
	//dripping milk
	if milked {
		repeat(random(floor(2))) instance_create(x+random(32)-16,y+random(32)-16,Milk);
	}
	//bleeding
	if bleeding {
		hp-=0.15;
		repeat(random(floor(2))) instance_create(x+random(32)-16,y+random(32)-16,BloodDrop);
		lastDamageSource = WEAPON_SHIV;
	}
	//unpissing/unmilking if ubered
	if ubered or megaHealed or critting {
		pissed=0;
		milked=0;
		bleeding=0;
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
object_event_add(Character,ev_alarm,11,'
	{
    loopsoundstop(DetoFlySnd);
    }
');
object_event_add(Character,ev_alarm,10,'
	buffbanner = false;
	stunned = false;
	radioactive = false;
	playsound(x,y,BowSnd);
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
			if(charging == 1 || hype){
				if (owner.team == TEAM_RED)
					ubercolour = c_orange;
				else if (owner.team == TEAM_BLUE)
					ubercolour = c_aqua;
				//draw_sprite_ext(sprite_index, imageOffset, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
				draw_sprite_ext(sprite_index,4+imageOffset/2,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7);
				if (charging == 1) {
					if (!isMelee) 
						draw_sprite_ext(Spark2S,spark,round(x+xoffset*image_xscale),round(y+yoffset) + owner.equipmentOffset ,image_xscale,image_yscale,image_angle,ubercolour,0.3);
					else
						draw_sprite_ext(Spark2S,spark,round(x+xoffset*image_xscale),round(y+yoffset+40) + owner.equipmentOffset ,image_xscale,image_yscale,image_angle,ubercolour,0.3);
				}
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

object_event_clear(Scout,ev_create,0);
object_event_add(Scout,ev_create,0,'
	baseRunPower = 1.4;
	maxHp = 100;
	weapons[0] = global.weapons[real(string_copy(string(global.scoutLoadout), 2, 2))];
	weapons[1] = global.weapons[real(string_copy(string(global.scoutLoadout), 4, 2))];
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
	weapons[0] = global.weapons[real(string_copy(string(global.heavyLoadout), 2, 2))];
	weapons[1] = global.weapons[real(string_copy(string(global.heavyLoadout), 4, 2))];
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
	weapon = global.myself.object.currentWeapon.object_index;
	if(minigun) {
		if (weapon == Tomislav) {
			runPower = 0.55;
		} else if (weapon == BrassBeast) {
			runPower = 0;
			jumpStrength = 0;
		} else {
			runPower = 0.3;
		}
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
	weapons[0] = global.weapons[real(string_copy(string(global.demomanLoadout), 2, 2))];
	weapons[1] = global.weapons[real(string_copy(string(global.demomanLoadout), 4, 2))];
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
	weapons[0] = global.weapons[real(string_copy(string(global.engineerLoadout), 2, 2))];
	weapons[1] = global.weapons[real(string_copy(string(global.engineerLoadout), 4, 2))];
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
	weapons[0] = global.weapons[real(string_copy(string(global.pyroLoadout), 2, 2))];
	weapons[1] = global.weapons[real(string_copy(string(global.pyroLoadout), 4, 2))];
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
	weapons[0] = global.weapons[real(string_copy(string(global.spyLoadout), 2, 2))];
	weapons[1] = global.weapons[real(string_copy(string(global.spyLoadout), 4, 2))];
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
	weapons[0] = global.weapons[real(string_copy(string(global.sniperLoadout), 2, 2))];
	weapons[1] = global.weapons[real(string_copy(string(global.sniperLoadout), 4, 2))];
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
	baseRunPower = 0.9;
	weapons[0] = global.weapons[real(string_copy(string(global.soldierLoadout), 2, 2))];
	weapons[1] = global.weapons[real(string_copy(string(global.soldierLoadout), 4, 2))];
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

	// Override defaults
	numFlames = 4;
');
object_event_clear(Medic,ev_create,0);
object_event_add(Medic,ev_create,0,'
	maxHp = 120;
	baseRunPower = 1.09;
	weapons[0] = global.weapons[real(string_copy(string(global.medicLoadout), 2, 2))];
	weapons[1] = global.weapons[real(string_copy(string(global.medicLoadout), 4, 2))];
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
object_event_clear(Quote,ev_create,0);
object_event_add(Quote,ev_create,0,'
	maxHp = 140;
	baseRunPower = 1.07;
	weapons[0] = Blade;
	weapons[1] = Machinegun;

	if (global.paramPlayer.team == TEAM_RED)
	{
		sprite_index = QuerlyRedS;
		haxxyStatue = QuoteHaxxyStatueS;
	}
	else if (global.paramPlayer.team == TEAM_BLUE)
	{
		sprite_index = QuerlyBlueS;
		haxxyStatue = CurlyHaxxyStatueS;
	}

	event_inherited();

	// Override defaults
	numFlames = 3;
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
	            if(keyboard_check(global.attack) && !global.myself.object.radioactive) keybyte |= $10;
	            if(keyboard_check(global.special)) keybyte |= $08;
	            if(keyboard_check_pressed(global.special)) inputSpecial();
	            if(keyboard_check_pressed(global.taunt)) inputTaunt();
	            
	            if(mouse_check_button(mb_left))
	            {
	                if(global.attack == MOUSE_LEFT && !global.myself.object.radioactive) keybyte |= $10;
	                if(global.special == MOUSE_LEFT) keybyte |= $08;
	            }
	            if(mouse_check_button_pressed(mb_left) and global.special == MOUSE_LEFT)
	                execute_file(pluginFilePath + "\input_special_but_better.gml");

	            if(mouse_check_button(mb_right))
	            {
	                if(global.attack == MOUSE_RIGHT && !global.myself.object.radioactive) keybyte |= $10;
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
			canSwitch = !global.myself.object.taunting /*or */;
			if (!canSwitch) exit;
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
		if(global.myself.class == CLASS_HEAVY) {
			if (global.myself.object.weapons[1] == SandvichHand) // fix q/c
			{
				if(!instance_exists(SandwichHud))
					instance_create(0,0,SandwichHud);
			}
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

object_event_clear(AmmoCounter,ev_draw,0);
object_event_add(AmmoCounter,ev_draw,0,'
	var xoffset, yoffset, xsize, ysize;
	xoffset = view_xview[0]-800+view_wview[0]; // im not going to fix this the proper way for EVERY SINGLE WEAPON HHNGNGH GOD
	yoffset = view_yview[0]-600+view_hview[0];
	xsize = 800;
	ysize = 600;
	draw_set_alpha(1);

	if global.myself.object != -1 {
		if instance_exists(global.myself.object.currentWeapon) {
			var weapon;
			weapon = global.myself.object.currentWeapon;
			if (weapon.isMelee) exit;
			barcolor = make_color_rgb(217,217,183);
			draw_set_color(barcolor);
		
			//set team offset here - but rocketmans is different because
			//of the little rockets that are drawn
			if global.myself.team == TEAM_BLUE toffset = 1;
			else toffset = 0;
			
			if global.myself.class==CLASS_SOLDIER {
				if global.myself.team == TEAM_BLUE toffset = 5;
				else toffset = 0;
				reloadscalar = 100-global.myself.object.currentWeapon.alarm[5]*global.delta_factor/global.myself.object.currentWeapon.reloadTime*100;
				draw_sprite_ext(Rocketclip,global.myself.object.currentWeapon.ammoCount+toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
				draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
			}
			else if global.myself.class==CLASS_DEMOMAN{        
				reloadscalar = 100-global.myself.object.currentWeapon.alarm[5]*global.delta_factor/global.myself.object.currentWeapon.reloadTime*100;
				draw_sprite_ext(MinegunAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
				draw_text(xoffset+765,yoffset+ysize/1.26+95,global.myself.object.currentWeapon.ammoCount);
				draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
			}
			else if global.myself.class==CLASS_SCOUT {
				reloadscalar = 100-global.myself.object.currentWeapon.alarm[5]*global.delta_factor/global.myself.object.currentWeapon.reloadTime*100;
				draw_sprite_ext(ScattergunAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
				draw_text(xoffset+765,yoffset+ysize/1.26+95,global.myself.object.currentWeapon.ammoCount);
				draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
			}
			else if global.myself.class==CLASS_ENGINEER {
				reloadscalar = 100-global.myself.object.currentWeapon.alarm[5]*global.delta_factor/global.myself.object.currentWeapon.reloadTime*100;
				draw_sprite_ext(ShotgunAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
				draw_text(xoffset+765,yoffset+ysize/1.26+95,global.myself.object.currentWeapon.ammoCount);
				draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
			}
			else if global.myself.class == CLASS_SPY {
				reloadscalar = 100-global.myself.object.currentWeapon.alarm[5]*global.delta_factor/global.myself.object.currentWeapon.reloadTime*100;
				draw_sprite_ext(RevolverAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
				draw_text(xoffset+765,yoffset+ysize/1.26+95,global.myself.object.currentWeapon.ammoCount);
				draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
			}
			else if global.myself.class == CLASS_MEDIC {
				reloadscalar = 100-global.myself.object.currentWeapon.alarm[5]*global.delta_factor/global.myself.object.currentWeapon.reloadTime*100;
				draw_sprite_ext(NeedleAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
				draw_text(xoffset+765,yoffset+ysize/1.26+95,global.myself.object.currentWeapon.ammoCount);
				draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
			}
			else if global.myself.class == CLASS_PYRO {    
				draw_sprite_ext(GasAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
				if (global.myself.object.currentWeapon.ammoCount <= 1/4 * global.myself.object.currentWeapon.maxAmmo) { barcolor = make_color_rgb(255,0,0); }
				draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,global.myself.object.currentWeapon.ammoCount/2,c_black,barcolor,barcolor,0,true,false);
				offset = 0;
				with(global.myself.object.currentWeapon)
				{
					var offset, flarecolor;
					
					if(readyToFlare)
						flarecolor = c_white;
					else
						flarecolor = c_gray;
					offset = 0;
						
					for (i = 1; i <= ammoCount/75; i += 1)
					{
						draw_sprite_ext(FlareS,other.toffset,
										xoffset+760+offset,yoffset+ysize/1.26+93,
										1,1,0,flarecolor,100);
						offset -= 20;
					}
				}
			}
			else if global.myself.class == CLASS_HEAVY {       
				draw_sprite_ext(MinigunAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
				barcolor = merge_color(barcolor, make_color_rgb(255,0,0), 1-(weapon.ammoCount/weapon.maxAmmo));
				barcolor = merge_color(barcolor, make_color_rgb(50,50,50), max(0,weapon.alarm[5]*global.delta_factor)/25);
				draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,
							   weapon.ammoCount/weapon.maxAmmo*100,c_black,barcolor,barcolor,0,true,false);
			}
			else if global.myself.class == CLASS_QUOTE {       
				draw_sprite_ext(BladeAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
				draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,global.myself.object.currentWeapon.ammoCount/global.myself.object.currentWeapon.maxAmmo*100,c_black,barcolor,barcolor,0,true,false);
			}
		}
	}
');

//Keeps the currentLoadout variable REAL nice and updated
object_event_add(Character,ev_step,ev_step_end,'
	if(player.id == global.myself){
		switch (player.class)
		{
		case CLASS_SCOUT:
			global.currentLoadout = global.scoutLoadout;
			break;

		case CLASS_PYRO:
			global.currentLoadout = global.pyroLoadout;
			break;

		case CLASS_SOLDIER:
			global.currentLoadout = global.soldierLoadout;
			break;

		case CLASS_HEAVY:
			global.currentLoadout = global.heavyLoadout;
			break;

		case CLASS_DEMOMAN:
			global.currentLoadout = global.demomanLoadout;
			break;

		case CLASS_MEDIC:
			global.currentLoadout = global.medicLoadout;
			break;

		case CLASS_ENGINEER:
			global.currentLoadout = global.engineerLoadout;
			break;

		case CLASS_SPY:
			global.currentLoadout = global.spyLoadout;
			break;

		case CLASS_SNIPER:
			global.currentLoadout = global.sniperLoadout;
			break;
		}
	}
');

//Keeps the currentLoadout variable updated as it should be
object_event_add(ClassSelectController,ev_other,ev_user1,'
	{
		global.myself.activeWeapon = 0;
		switch (class)
		{
		case CLASS_SCOUT:
			global.currentLoadout = global.scoutLoadout;
			break;

		case CLASS_PYRO:
			global.currentLoadout = global.pyroLoadout;
			break;

		case CLASS_SOLDIER:
			global.currentLoadout = global.soldierLoadout;
			break;

		case CLASS_HEAVY:
			global.currentLoadout = global.heavyLoadout;
			break;

		case CLASS_DEMOMAN:
			global.currentLoadout = global.demomanLoadout;
			break;

		case CLASS_MEDIC:
			global.currentLoadout = global.medicLoadout;
			break;

		case CLASS_ENGINEER:
			global.currentLoadout = global.engineerLoadout;
			break;

		case CLASS_SPY:
			global.currentLoadout = global.spyLoadout;
			break;

		case CLASS_SNIPER:
			global.currentLoadout = global.sniperLoadout;
			break;
		}

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