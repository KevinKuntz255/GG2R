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
object_event_add(LoadoutMenu,ev_other,ev_user2,'
	switch(mousedclass){
	    case 0:
	        class = "RUNNER";
	        load1 = instance_create(40, 192, LoadoutSwitcher);
	        load1.value = 0;
	        load1.loaded = real(string_copy(string(global.scoutLoadout),2,2));
	        load1.description[0,0] = " •6 Ammo# •6 Bullets per Shot# •.66 Second Refire Rate# •8 Damage per Bullet";
	        load1.description[1,0] = " •Causes knockback";
	        load1.description[1,1] = " +100% bullets per shot"
	        load1.description[1,2] = " -50% damage per bullet# -50% clip size# -10 max hp# •Reloads entire clip at once";
	        load1.description[2,0] = "";
	        load1.description[2,1] = " +40% accuracy# +40% refire speed# +30% bullet damage";
	        load1.description[2,2] = " -33% clip size# -50% bullets per shot";
	        load1.description[3,0] = " •Running & jumping fills hype";
	        load1.description[3,1] = " •Deals minicrits when hyped# +50% firing speed# +25% Reload Speed";
	        load1.description[3,2] = " -66% ammo loaded"
	        load1.description[4,0] = " •Fires a blast of laserbeams"
	        load1.description[4,1] = " •Crits against sentries"
	        load1.description[4,2] = " -33% ammo loaded"
	        load2 = instance_create(464, 192, LoadoutSwitcher);
	        load2.value = 5;
	        load2.loaded = real(string_copy(string(global.scoutLoadout),4,2));
	        load2.description[0,0] = " •12 Ammo# •.16 Second Refire Rate# •8 Damage";
	        load2.description[1,0] = " •Invincible while active# •Cannot shoot, pick up intel,#  or capture points when active";
	        load2.description[2,0] = " •Secondary fire shoots a ball# •Headshots stun enemies# •Bodyshots deal 15 damage# •Each bounce weakens effects# •Can Tauntkill";
	        load2.description[2,2] = " -28% melee damage";
	        load2.description[3,0] = " •Soaking enemies heals 20 hp# •Extinguishes fire# •Reveals spies";
	        load2.description[4,1] = " •Grants triple jump# •Can Tauntkill";
	        load2.description[4,2] = " -20 max hp# -28% melee damage";
	        offset = 0;
	        break;
	    case 1:
	        class = "FIREBUG";
	        load1 = instance_create(40, 192, LoadoutSwitcher);
	        load1.value = 80;
	        load1.loaded = real(string_copy(string(global.pyroLoadout),2,2));
	        load1.description[0,0] = " •Secondary Fire: Airblast# •200 Ammo# •3.3 Damage per Flame# -50 Ammo per Airblast";
	        load1.description[1,1] = " +20% flame damage";
	        load1.description[1,2] = " +30 airblast cost";
	        load1.description[2,0] = " •Converts projectiles into hp# •Sucks players";
	        load1.description[2,2] = " -66% afterburn duration";
	        load1.description[3,0] = " •Airblast damages enemies";
	        load1.description[3,1] = " •Slows down frozen enemies# •Extra strong airblast";
	        load1.description[3,2] = " -50% afterburn damage";
	        load1.description[3,2] = " •Airblast does not reflect";
	        load1.description[4,0] = " •Fill Mmph by dealing damage# •Secondary Fire: Start Mmph";
	        load1.description[4,1] = " •While Mmph is active...#   •Damage deals crits#   +50 Overheal";
	        load1.description[4,2] = " •Cannot airblast# -30% damage";
	        load2 = instance_create(464, 192, LoadoutSwitcher);
	        load2.value = 85;
	        load2.loaded = real(string_copy(string(global.pyroLoadout),4,2));
	        load2.description[0,0] = " •6 Ammo# •5 Bullets per Shot# •.66 Second Refire Rate# •7 Damage per Bullet";
	        load2.description[1,0] = " •Sets enemies on fire when hit";
	        load2.description[1,1] = " •Crits burning targets";
	        load2.description[2,0] = " •Sets enemies on fire when hit# •Secondary fire detonates flare";
	        load2.description[3,0] = " •Erupts into a ring of flames"
	        load2.description[3,1] = " +Recharges while not equipped"
	        load2.description[3,2] = " -30% flame damage vs sentries"
	        load2.description[4,1] = " +50% against burning players# •80 damage against sentries";
	        load2.description[4,2] = " -40% damage penalty# •No random critical hits"
	        offset = 10;
	        break;
	    case 2:
	        class = "ROCKETMAN";
	        load1 = instance_create(40, 192, LoadoutSwitcher);
	        load1.value = 10;
	        load1.loaded = real(string_copy(string(global.soldierLoadout),2,2));
	        load1.description[0,0] = " •4 Ammo# •.5 Second Refire Rate# •45 Damage per Rocket";
	        load1.description[1,0] = "";
	        load1.description[1,1] = " +80% rocket speed# +20% damage";
	        load1.description[1,2] = " -80% blast radius# -30% refire rate # •Bad for rocket jumping";
	        load1.description[2,0] = " •Crits light enemies on fire# •Secondary fire charges shot";
	        load1.description[2,2] = " -80% damage against sentries# -10% damage";
	        load1.description[3,0] = "";
	        load1.description[3,1] = " +15 hp on direct hit";
	        load1.description[3,2] = " -1 rocket loaded";
	        load1.description[4,0] = " •Secondary fire bends trajectory";
	        load1.description[4,2] = " •Shoots only 1 rocket at a time";
	        load2 = instance_create(464, 192, LoadoutSwitcher);
	        load2.value = 15;
	        load2.loaded = real(string_copy(string(global.soldierLoadout),4,2));
	        load2.description[0,0] = " •6 Ammo# •5 Bullets per Shot# •.66 Second Refire Rate# •7 Damage per Bullet";
	        load2.description[1,0] = " •Kills charge rage meter";
	        load2.description[1,1] = " •Teammates minicrit while active";
	        load2.description[2,0] = " •May hit target multiple times";
	        load2.description[2,1] = " •Projectiles penetrate enemies";
	        load2.description[2,2] = " -80% damage against sentries";
	        load2.description[3,0] = " •Low hp increases damage/speed";
	        load2.description[3,2] = " •No random minicrits# -28% melee damage if hp full";
	        load2.description[4,1] = " •Minicrits airborne targets# •Fires instantly";
	        load2.description[4,2] = " -33% ammo loaded# •Must reload to switch weapons";
	        offset = 2;
	        break;
	    case 3:
	        class = "OVERWEIGHT";
	        load1 = instance_create(40, 192, LoadoutSwitcher);
	        load1.value = 60;
	        load1.loaded = real(string_copy(string(global.heavyLoadout),2,2));
	        load1.description[0,0] = " •200 Ammo# •.06 Second Refire Rate# •8 Damage per Bullet";
	        load1.description[1,0] = "";
	        load1.description[1,1] = " -100% bullet spread# +10% run speed# +100% speed while shooting";
	        load1.description[1,2] = " -50% firing speed";
	        load1.description[2,1] = " •Slows down players on hit";
	        load1.description[2,2] = " -25% damage";
	        load1.description[3,1] = " +20% damage";
	        load1.description[3,2] = " -20% run speed# -80% speed while shooting# •Cannot jump while shooting";
	        load1.description[4,0] = " •Maximum 300 ammo";
	        load1.description[4,1] = " •Each kill ups max ammo by 20# +70 ammo reloaded per kill# +35 ammo reloaded per assist";
	        load1.description[4,2] = " •Starts with 100 ammo# -50% reload time for base ammo# -75% reload for extra ammo";
	        load2 = instance_create(464, 192, LoadoutSwitcher);
	        load2.value = 65;
	        load2.loaded = real(string_copy(string(global.heavyLoadout),4,2));
	        load2.description[0,0] = " •6 Ammo# •5 Bullets per Shot# •.66 Second Refire Rate# •7 Damage per Bullet";
	        load2.description[1,0] = " •Heals 50 hp# •Secondary fire drops sandvich";
	        load2.description[2,1] = " +33% clip size# +15% refire speed";
	        load2.description[2,2] = " -15% damage penalty";
	        load2.description[3,0] = " •Heals 40 hp";
	        load2.description[3,1] = " •Can overheal user";
	        load2.description[3,2] = " •Cant be dropped";
	        load2.description[4,1] = " •On kill deals crits# +30% damage";
	        load2.description[4,2] = " •Slower swing speed";
	        offset = 8;
	        break;
	    case 4:
	        class = "DETONATOR";
	        load1 = instance_create(40,192,LoadoutSwitcher);
	        load1.value = 30;
	        load1.loaded = real(string_copy(string(global.demomanLoadout),2,2));
	        load1.description[0,0] = " •Secondary Fire: Detonate# •8 Ammo# •.86 Second Refire Rate# •45 Damage per Sticky";
	        load1.description[1,0] = "";
	        load1.description[1,1] = " •Faster refire & reload speed# •Invisible mines# +38 damage on airborne targets";
	        load1.description[1,2] = " -46% damage# •Can place 5 stickies";
	        load1.description[2,0] = " •Can detonate individual stickies";
	        load1.description[2,1] = " •Can place up to 14 stickies";
	        load1.description[3,0] = " •Stickies deal no damage";
	        load1.description[3,1] = " +50% ammo";
	        load1.description[3,2] = " -20 max hp";
	        load1.description[4,0] = " •Stickies stick to players";
	        load1.description[4,1] = " +10% damage";
	        load1.description[4,2] = " •Stickies only stick to players# •Stickies cannot be detonated# •Stickies only damage targets";
	        load2 = instance_create(464, 192, LoadoutSwitcher);
	        load2.value = 35;
	        load2.loaded = real(string_copy(string(global.demomanLoadout),4,2));
	        load2.description[0,0] = " •4 Ammo# •.73 Second Refire Rate# •40 Damage per Grenade ";
	        load2.description[0,1] = " •Can Tauntkill";
	        load2.description[1,0] = "";
	        load2.description[1,1] = " •Fires 2 grenades at once# •Can Tauntkill";
	        load2.description[1,2] = " -50% ammo loaded";
	        load2.description[2,0] = " •Secondary fire charges# •Deals minicrits while charging";
	        load2.description[3,1] = " •Double capspeed# +30 max hp on ctf# •Pierces generator shield";
	        load2.description[4,0] = " •Hold fire to delay throw";
	        load2.description[4,1] = " +10% blast radius# +50% damage# •Can Tauntkill";
	        offset = -4;
	        break;
	    case 5:
	        class = "HEALER";
	        load1 = instance_create(40, 192, LoadoutSwitcher);
	        load1.value = 40;
	        load1.loaded = real(string_copy(string(global.medicLoadout),2,2));
	        load1.description[0,0] = " •40 Ammo# •.1 Second Refire Rate# •4 Damage per Bullet";
	        load1.description[1,0] = "";
	        load1.description[1,1] = " +2 hp on hit";
	        load1.description[1,2] = " -40% health regen speed";
	        load1.description[2,0] = " •If killed with 75% ubercharge#  all teammates are healed";
	        load1.description[2,2] = " -20 max hp"
	        load1.description[3,0] = " •Heals allies on hit";
	        load1.description[3,1] = " •Long range shots";
	        load1.description[3,2] = " •Shots dont penetrate allies";
	        load1.description[4,0] = " •Secondary fire heals nearby#  teammates";
	        load1.description[4,1] = " •Damage increases uber# •Can taunt kill";
	        load1.description[4,2] = " •No random melee crits";
	        load2 = instance_create(464, 192, LoadoutSwitcher);
	        load2.value = 45;
	        load2.loaded = real(string_copy(string(global.medicLoadout),4,2));
	        load2.description[0,0] = " •Ubercharge grants #  invincibility";
	        load2.description[1,0] = "";
	        load2.description[1,1] = " +25% ubercharge speed# •Ubercharge grants crits";
	        load2.description[1,2] = " •Not invincible while ubering";
	        load2.description[2,0] = ""
	        load2.description[2,1] = " +40% heal rate# •3x heal rate while ubering";
	        load2.description[2,2] = " •Doesnt refill ammo# •Not invincible while ubering";
	        load2.description[3,0] = "";
	        load2.description[3,1] = " •Overheals teammates";
	        load2.description[3,2] = " -25% ubercharge speed";
	        load2.description[4,0] = " •Shoots one potion per second# •Unlimited ammo";
	        load2.description[4,1] = " •Can heal multiple teammates# •Damages enemies when ubered";
	        load2.description[4,2] = "";
	        offset = 3;
	        break;
	    case 6:
	        class = "CONSTRUCTOR";
	        load1 = instance_create(40, 192, LoadoutSwitcher);
	        load1.value = 50;
	        load1.loaded = real(string_copy(string(global.engineerLoadout),2,2));
	        load1.description[0,0] = " •6 Ammo# •5 Bullets per Shot# •.66 Second Refire Rate# •7 Damage per Bullet";
	        load1.description[1,0] = "";
	        load1.description[1,1] = " •Gain 2 revenge crits for#  each sentry kill when your#  sentry is destroyed.";
	        load1.description[1,2] = " -50% clip size";
	        load1.description[2,0] = "";
	        load1.description[2,1] = " +40% damage";
	        load1.description[2,2] = " -50% clip size# •Buildings destroyed on death";
	        load1.description[3,0] = "";
	        load1.description[3,1] = " •Shots penetrate enemies# •Takes 7% uber from medics# •Spies strobe into view";
	        load1.description[3,2] = " -60% damage"
	        load1.description[4,0] = " •Uses nuts n bolts for ammo";
	        load1.description[4,1] = " +20 per enemy shot";
	        load1.description[4,2] = " -20 per enemy missed";
	        load2 = instance_create(464, 192, LoadoutSwitcher);
	        load2.value = 55;
	        load2.loaded = real(string_copy(string(global.engineerLoadout),4,2));
	        load2.description[0,0] = " •Builds mini-sentries# -2 Nuts N Bolts per Shot# •.2 Second Refire Rate# •7 Damage";
	        load2.description[0,1] = " •Destroys sappers# •User can build dispensers";
	        load2.description[1,0] = " •Builds mini-sentries# •Stuns tagets on hit";
	        load2.description[2,0] = " •Builds upgradable sentries";
	        load2.description[2,1] = " •User can move sentries# •User can repair sentries";
	        load2.description[3,0] = " •Builds mini-sentries# •Can fire 100 shots per sentry";
	        load2.description[3,1] = " •Can directly control sentry# •Wrangled sentry has a shield# •Shield is 50% resistant#  against everything but...";
	        load2.description[3,2] = "   •Potions#   •Melee weapons";
	        load2.description[4,0] = " •Builds upgradable sentries# •Taunt to teleport to sentry#  (uses 60 nuts n bolts)";
	        load2.description[4,1] = " •User can repair sentries";
	        offset = 3;
	        break;
	    case 7:
	        class = "INFILTRATOR";
	        load1 = instance_create(40, 192, LoadoutSwitcher);
	        load1.value = 70;
	        load1.loaded = real(string_copy(string(global.spyLoadout),2,2));
	        load1.description[0,0] = " •Secondary Fire: Cloak# •Cloaked Primary: Sapper# •6 Ammo# •.6 Refire Rate# •28 Damage per Bullet";
	        load1.description[1,0] = "";
	        load1.description[1,1] = " +2 seconds of ubercloak on kill# •Ubercloak is resistant to#  everything but melee weapons";
	        load1.description[1,2] = " -20% damage"
	        load1.description[2,0] = "";
	        load1.description[2,1] = " •Gains a crit shot for each#  player backstabbed";
	        load1.description[2,2] = " -15% damage# •Incompatible with the Zapper";
	        load1.description[3,0] = "";
	        load1.description[3,1] = " +50% damage on headshot";
	        load1.description[3,2] = " -25% damage on bodyshot# -30% refire speed";
	        load1.description[4,1] = " •Drops health kits on kill";
	        load1.description[4,2] = " •Slower movement speed# -10% damage";
	        load2 = instance_create(464,192,LoadoutSwitcher);
	        load2.value = 75;
	        load2.loaded = real(string_copy(string(global.spyLoadout),4,2));
	        load2.description[0,0] = " •While uncloaked, damage#  increases with each#  consecutive hit# •While cloaked...#  •200 damage against players#  •40 damage against sentries#  •50 dmg against generators";
	        load2.description[1,0] = "";
	        load2.description[1,1] = " •On kill also kills enemys#  patient";
	        load2.description[1,2] = " -10 hp on missed stab";
	        load2.description[2,0] = "";
	        load2.description[2,1] = " +100% backstab speed on#  successful backstab"
	        load2.description[2,2] = " -20% max health# •Cant stab multiple enemies";
	        load2.description[3,0] = " •Turns people into icicles.";
	        load2.description[3,1] = " •Puts out fires by melting";
	        load2.description[3,2] = " •Cant be used for 15 seconds#  after melting";
	        load2.description[4,1] = " +25% backstab speed# •Backstab stuns# +300% dmg against sentries";
	        load2.description[4,2] = " -66% damage# •Cant stab multiple enemies";
	        offset = 4;
	        break;
	    case 8:
	        class = "RIFLEMAN";
	        load1 = instance_create(40,192,LoadoutSwitcher);
	        load1.value = 20;
	        load1.loaded = real(string_copy(string(global.sniperLoadout),2,2));
	        load1.description[0,0] = " •Secondary Fire: Scope# •2.66 Second Refire Rate# •Min Damage: 35# •Max Damage: 75";
	        load1.description[0,2] = " •No bonus damage on headshots";
	        load1.description[1,0] = " •Each headshot decreases#  charge time";
	        load1.description[1,1] = " •Headshots cause extra damage";
	        load1.description[1,2] = " -40% unscoped damage";
	        load1.description[2,1] = " •Headshots cause extra damage# •Faster reload# •Can Tauntkill";
	        load1.description[2,2] = " •Cannot scope";
	        load1.description[3,1] = " +22% damage on fully charged#  headshot (110 damage total)";
	        load1.description[3,2] = " •Cant shoot while unscoped# +75% reload time";
	        load1.description[4,0] = " •Charged shots shoot Jarate";
	        load1.description[4,1] = " •Soaked enemies take crits";
	        load1.description[4,2] = " -15% damage# •No bonus damage on headshots";
	        load2 = instance_create(464, 192, LoadoutSwitcher);
	        load2.value = 25;
	        load2.loaded = real(string_copy(string(global.sniperLoadout),4,2));
	        load2.description[0,0] = " •25 Ammo# •.1 Second Refire Rate# •5 Damage per Bullet";
	        load2.description[1,0] = " •Soaks enemies in piss";
	        load2.description[1,1] = " •Soaked enemies take crits# •Puts out fire# •Reveals spies";
	        load2.description[2,0] = " ";
	        load2.description[2,1] = " +20 max health";
	        load2.description[3,0] = " •Causes bleed damage for 3s# •Blocks 1 backstab attempt";
	        load2.description[3,2] = " -33% dmg";
	        load2.description[4,0] = " •Allows user to float# •Drops intel when floating";
	        offset = 10;
	        break;
	}
	currentclass = mousedclass;
');
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

//Handles swapping out loadout weapons and the active weapon shown
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