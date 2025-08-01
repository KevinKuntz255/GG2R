globalvar AmmoHUDsS, TemplateS, BlackBoxClipS, DirectHitClipS;
AmmoHUDsS = sprite_add(pluginFilePath + "\randomizer_sprites\AmmoHUDsS.png", 99, 1, 0, 25, 14);
TemplateS = sprite_add(pluginFilePath + "\randomizer_sprites\TemplateS.png", 2, 1, 0, 25, 8);
BlackBoxClipS = sprite_add(pluginFilePath + "\randomizer_sprites\BlackBoxClipS.png", 10, 1, 0, 25, 9);
DirectHitClipS = sprite_add(pluginFilePath + "\randomizer_sprites\DirectHitClipS.png", 10, 1, 0, 25, 8);

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

			var weapon_index;
			if(global.myself.activeWeapon == 1){
				weapon_index = real(string_copy(string(global.myself.playerLoadout), 4, 2));
			}else{
				weapon_index = real(string_copy(string(global.myself.playerLoadout), 2, 2));
			}
			
			switch(weapon.object_index) {
				case Wrench: 
	            case Eeffect:
	            case Sandman:
	            case Kukri:
	            case Eyelander:
	            case Knife:
	            case BigEarner:
	            case Spycicle:
	            case Axe:
	            case Haxxy:
	            case Fists:
	            case ChocolateHand:
	            case Volcanofragment:
	            case Rifle:
	            case HuntsMan:
	            case SydneySleeper:
	            case BonkHand:
	            case BuffBanner:
	            case JarateHand: 
	            //case Invisibeam: ???
	            case Kritzieg:
	            case QuickFix:
	            case Widowmaker:
	            case Stungun:
	            case SandvichHand:
	            case Wrangler:
	            case MadmilkHand:
	            case Shiv:
	            case Shovel:
	            case Machina:
	            case Nailgun:
	            case SaxtonFist:
	            case Overhealer:
	            case Paintrain:
	            case Pumson:
	            case ChainStab:
	            case BazaarBargain:
	            case Jetpack:
	            case Randomoozer:
	            case CowMangler:
	            case NapalmHand:
	            case Brewinggun:
	            case KGOB:
	            case Zapper: 
	            case Atomizer:
	            case Tomislav:
	            case Natacha:
	            case BrassBeast:
	            case Backburner:
	            case Frostbite:
	            case Machinegun:
	            case Phlog:
	            case Ubersaw:
	            	break;

				case Rocketlauncher:
					if global.myself.team == TEAM_BLUE toffset = 5;
					else toffset = 0;
					reloadscalar = 100-weapon.alarm[5]*global.delta_factor/weapon.reloadTime*100;
					draw_sprite_ext(Rocketclip,weapon.ammoCount+toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
					break;

				case BlackBox:
	            	if global.myself.team == TEAM_BLUE toffset = 5;
	                else toffset = 0;
	                reloadscalar = 100-weapon.alarm[5]*global.delta_factor/weapon.reloadTime*100;
	                draw_sprite_ext(BlackBoxClipS,weapon.ammoCount+toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
	                draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
	                break;

	            case DirectHit:
	                if global.myself.team == TEAM_BLUE toffset = 5;
	                else toffset = 0;
	                reloadscalar = 100-weapon.alarm[5]*global.delta_factor/weapon.reloadTime*100;
	                draw_sprite_ext(DirectHitClipS,weapon.ammoCount+toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
	                draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
	                break;
	                
				case Minegun:        
					reloadscalar = 100-weapon.alarm[5]*global.delta_factor/weapon.reloadTime*100;
					draw_sprite_ext(MinegunAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					draw_text(xoffset+765,yoffset+ysize/1.26+95,weapon.ammoCount);
					draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
					break;

				case Scattergun:
					reloadscalar = 100-weapon.alarm[5]*global.delta_factor/weapon.reloadTime*100;
					draw_sprite_ext(ScattergunAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					draw_text(xoffset+765,yoffset+ysize/1.26+95,weapon.ammoCount);
					draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
					break;

				case Shotgun:
					reloadscalar = 100-weapon.alarm[5]*global.delta_factor/weapon.reloadTime*100;
					draw_sprite_ext(ShotgunAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					draw_text(xoffset+765,yoffset+ysize/1.26+95,weapon.ammoCount);
					draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
					break;

				case Revolver:
					reloadscalar = 100-weapon.alarm[5]*global.delta_factor/weapon.reloadTime*100;
					draw_sprite_ext(RevolverAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					draw_text(xoffset+765,yoffset+ysize/1.26+95,weapon.ammoCount);
					draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
					break;

				case Medigun:
					reloadscalar = 100-weapon.alarm[5]*global.delta_factor/weapon.reloadTime*100;
					draw_sprite_ext(NeedleAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					draw_text(xoffset+765,yoffset+ysize/1.26+95,weapon.ammoCount);
					draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
					break;

				case Flamethrower:  
					draw_sprite_ext(GasAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					if (weapon.ammoCount <= 1/4 * weapon.maxAmmo) { barcolor = make_color_rgb(255,0,0); }
					draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,weapon.ammoCount/2,c_black,barcolor,barcolor,0,true,false);
					offset = 0;
					with(weapon)
					{
						var offset, flarecolor;
						
						if(readyToFlare)
							flarecolor = c_white;
						else
							flarecolor = c_gray;
						offset = 0;
							
						for (i = 1; i <= ammoCount/75; i += 1)
						{
							draw_sprite_ext(FlareS,other.toffset,xoffset+760+offset,yoffset+ysize/1.26+93,1,1,0,flarecolor,100);
							offset -= 20;
						}
					}
					break;

				case Transmutator :
	                draw_sprite_ext(TemplateS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
	                draw_sprite_ext(AmmoHUDsS,weapon_index,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
	                if (weapon.ammoCount <= 1/4 * weapon.maxAmmo) { barcolor = make_color_rgb(255,0,0); }
	                draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,weapon.ammoCount/2,c_black,barcolor,barcolor,0,true,false);
	                break;

				case Minigun:    
					draw_sprite_ext(MinigunAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					barcolor = merge_color(barcolor, make_color_rgb(255,0,0), 1-(weapon.ammoCount/weapon.maxAmmo));
					barcolor = merge_color(barcolor, make_color_rgb(50,50,50), max(0,weapon.alarm[5]*global.delta_factor)/25);
					draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,
								   weapon.ammoCount/weapon.maxAmmo*100,c_black,barcolor,barcolor,0,true,false);
					break;

				case IronMaiden:
	                draw_sprite_ext(TemplateS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
	                draw_sprite_ext(AmmoHUDsS,weapon_index,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
	                if (weapon.ammoCount <= 1/4 * weapon.maxAmmo) { barcolor = make_color_rgb(255,0,0); } //ammoCount*1.111
	                draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,
	                	           weapon.ammoCount/3,c_black,barcolor,barcolor,0,true,false);
	                break;

				case Blade:     
					draw_sprite_ext(BladeAmmoS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					draw_healthbar(xoffset+689,yoffset+ysize/1.26+90,xoffset+723,yoffset+ysize/1.26+98,weapon.ammoCount/weapon.maxAmmo*100,c_black,barcolor,barcolor,0,true,false);
					break;

				default:
					draw_sprite_ext(TemplateS,toffset,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					draw_sprite_ext(AmmoHUDsS,weapon_index,xoffset+728,yoffset+ysize/1.26+86,2.4,2.4,0,c_white,100);
					reloadscalar = 100-weapon.alarm[5]/weapon.reloadTime*100;
					draw_text(xoffset+765,yoffset+ysize/1.26+95,weapon.ammoCount);
                	draw_healthbar(xoffset+700,yoffset+ysize/1.26+90,xoffset+750,yoffset+ysize/1.26+98,reloadscalar,c_black,barcolor,barcolor,0,true,false);
			}
		}
	}
');