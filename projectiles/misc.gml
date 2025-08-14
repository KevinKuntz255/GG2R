globalvar RadioBlur, Text, MissS, CritS, MiniCritS;
RadioBlur=object_add();
Text = object_add();
MissS = sprite_add(pluginFilePath + "\randomizer_sprites\MissS.png", 1, 0, 0, 0, 0);
CritS = sprite_add(pluginFilePath + "\randomizer_sprites\CritS.png", 1, 0, 0, 0, 0);
MiniCritS = sprite_add(pluginFilePath + "\randomizer_sprites\MiniCritS.png", 1, 0, 0, 0, 0);
object_set_depth(RadioBlur, 130000);
object_event_add(RadioBlur,ev_create,0,'
	owner=-1;
	image_alpha=0.5;
');
object_event_add(RadioBlur,ev_draw,0,'
	if !variable_local_exists("old_pos") {
		a = 0
		while a < 12 {
			old_pos[a,0] = x;
			old_pos[a,1] = y;
			a += 1;
		}
	}
	a = 12-1
	while a > 0 {
		old_pos[a,0] = old_pos[a-1,0]
		old_pos[a,1] = old_pos[a-1,1]        
		a -= 1
	}       
	old_pos[0,0] = x
	old_pos[0,1] = y   
    a = 0
	// fatass copy of Character create/draw
    if (owner != -1) {
    	if(owner.player.class == CLASS_QUOTE)
        {
            spriteRun = owner.sprite_index;
            spriteJump = owner.sprite_index;
            spriteStand = owner.sprite_index;
            spriteLeanR = owner.sprite_index;
            spriteLeanL = owner.sprite_index;
            spriteIntel = owner.sprite_index; // its an underlay
        }
        else
        {
            spriteRun = getCharacterSpriteId(owner.player.class, owner.player.team, "Run");
            spriteJump = getCharacterSpriteId(owner.player.class, owner.player.team, "Jump");
            spriteStand = getCharacterSpriteId(owner.player.class, owner.player.team, "Stand");
            spriteLeanR = getCharacterSpriteId(owner.player.class, owner.player.team, "LeanR");
            spriteLeanL = getCharacterSpriteId(owner.player.class, owner.player.team, "LeanL");
            spriteIntel = getCharacterSpriteId(owner.player.class, owner.player.team, "Intel");
        }
    	
    	var sprite, overlayList, noNewAnim, sprite_tilt_left, sprite_tilt_right, overlays_tilt_left, overlays_tilt_right;
    	noNewAnim = owner.player.class == CLASS_QUOTE or owner.sprite_special or owner.player.humiliated;
    	

    	if (owner.zoomed)
    	{
    		if (owner.team == TEAM_RED)
    			sprite = SniperRedCrouchS;
    		else
    			sprite = SniperBlueCrouchS;
    		overlayList = owner.crouchOverlays;
    		owner.animationImage = animationImage mod 2; // sniper crouch only has two frames, avoid overflow
    	}
    	else if (!noNewAnim)
    	{
    		if(!owner.onground)
    		{
    			sprite = spriteJump;
    			overlayList = owner.jumpOverlays;
    		}
    		else
    		{
    			if(owner.hspeed==0)
    			{
    				// set up vars for slope detection
    				//charSetSolids(); i fucked around and found out thanks to bonk
    				if(owner.image_xscale > 0)
    				{
    					sprite_tilt_left = spriteLeanL;
    					sprite_tilt_right = spriteLeanR;
    					overlays_tilt_left = owner.leanLOverlays;
    					overlays_tilt_right = owner.leanROverlays;
    				}
    				else
    				{
    					sprite_tilt_left = spriteLeanR;
    					sprite_tilt_right = spriteLeanL;
    					overlays_tilt_left = owner.leanROverlays;
    					overlays_tilt_right = owner.leanLOverlays;
    				}
    				
    				// default still sprite
    				sprite = spriteStand;
    				overlayList = owner.stillOverlays;
    				
    				{ // detect slopes
    					var openright, openleft;
    					openright = !collision_point_solid(x+6, y+owner.bottom_bound_offset+2) and !collision_point_solid(x+2, y+owner.bottom_bound_offset+2);
    					openleft = !collision_point_solid(x-7, y+owner.bottom_bound_offset+2) and !collision_point_solid(x-3, y+owner.bottom_bound_offset+2);
    					if (openright)
    					{
    						sprite = sprite_tilt_right;
    						overlayList = owner.leanROverlays;
    					}
    					if (openleft)
    					{
    						sprite = sprite_tilt_left;
    						overlayList = owner.leanLOverlays;
    					}
    					if (openright and openleft)
    					{
    						openright = !collision_point_solid(x+owner.right_bound_offset, y+owner.bottom_bound_offset+2);
    						openleft = !collision_point_solid(x-owner.left_bound_offset, y+owner.bottom_bound_offset+2);
    						if (openright)
    						{
    							sprite = sprite_tilt_right;
    							overlayList = owner.leanROverlays;
    						}
    						if (openleft)
    						{
    							sprite = sprite_tilt_left;
    							overlayList = owner.leanLOverlays;
    						}
    					}
    				}
    					
    				//charUnsetSolids();
    			}
    			else
    			{
    				sprite = spriteRun;
    				overlayList = owner.runOverlays;
    				if (owner.player.class == CLASS_HEAVY and abs(owner.hspeed) < 3) // alternative sprite for extremely slow moving heavies
    				{
    					if (team == TEAM_RED)
    					{
    						sprite = HeavyRedWalkS;
    						overlayList = owner.walkOverlays;
    					}
    					else
    					{
    						sprite = HeavyBlueWalkS;
    						overlayList = owner.walkOverlays;
    					}
    				}
    			}
    		}
    	}
    	else
    	{
    		sprite = sprite_index;
    		overlayList = owner.stillOverlays;
    	}

        // create vars independent of owner to use in draw_sprite
        lastSprite = sprite;
        index = floor(owner.animationImage);
        lastScale = owner.image_xscale;
    }

    while a <= 12-1 
    {
        draw_sprite_ext(lastSprite,index,old_pos[a,0],old_pos[a,1],lastScale,1,0,c_white,image_alpha/((a+2)/2));
        a += 1;
    }
');
object_event_add(RadioBlur,ev_step,ev_step_end,'
	if owner != -1 {
		x=owner.x;
		y=owner.y;
	} else {
        /*if (image_alpha/((clone+2)/2) >= 0.02) {
            playsound(x,y,PickupSnd);
            image_alpha -= 0.055 / global.delta_factor; // target the biggest variable for a smoother fade-out
        }*/
		image_alpha -= 0.1 / global.delta_factor;
		if image_alpha <= 0.01 instance_destroy();
	}
');

object_event_add(Text,ev_create,0,'
	vspeed-=0.5;
');
object_event_add(Text,ev_step,ev_step_normal,'
	image_alpha -= 0.05;
	if image_alpha <= 0.1 instance_destroy();
');