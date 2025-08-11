globalvar WEAPON_MACHINEGUN;
WEAPON_MACHINEGUN = 91;

globalvar Machinegun;
Machinegun = object_add();
object_set_parent(Machinegun, Weapon);

object_event_add(Machinegun,ev_create,0,'
    xoffset = 4;
    yoffset = -1;
    refireTime = 2;
	bubbleCount = 0;
    event_inherited();
    sndlooping = false;
	maxAmmo = 100;
    ammoCount = maxAmmo;
    reloadBuffer = 15;
    isRefilling = false;
	
	//C type blades (slightly smaller, slightly faster, standard life)
	bladeRefireTime = 8;
	bladeDelay = 0;
    bladesOut = 0;
    bladeLife = 15;
    maxBlades = 1;
    bladeDamage = 12;

    weaponGrade = UNIQUE;
    weaponType = MACHINEGUN;

	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinegunS.png", 2, 1, 0, 0, 0);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinegunFS.png", 4, 1, 0, 0, 0);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\MachinegunS.png", 2, 1, 0, 0, 0);

    sprite_index = normalSprite;

    recoilTime = 3;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/2;
');

object_event_add(Machinegun,ev_alarm,5,'
	isRefilling = true;
');

object_event_add(Machinegun,ev_step,ev_step_begin,'
	if (ammoCount < 0)
		ammoCount = 0;
	else if (ammoCount <= maxAmmo and isRefilling)
		ammoCount += 1.5 * global.delta_factor;
	if (ammoCount > maxAmmo)
		ammoCount = maxAmmo;
	if(!readyToShoot and alarm[5] < 25 and !isRefilling)
		alarm[5] += 1;
	bladeDelay = min(max(0, bladeDelay - 1), bladeRefireTime / global.delta_factor);
');

object_event_add(Machinegun,ev_other,ev_user1,'
	if(readyToShoot and ammoCount >= 1)
		{
			playsound(x,y,ShotSnd);
			var shot;
			randomize();
			// repeat(2) {
				shot = instance_create(x+lengthdir_x(12+(random(6)-3),owner.aimDirection),y+lengthdir_y(random(10)-5,owner.aimDirection),MGShot);
				shot.hitDamage=6;
				shot.direction=owner.aimDirection;
				shot.speed=17;
				shot.owner=owner;
				shot.ownerPlayer=ownerPlayer;
				shot.team=owner.team;
				shot.weapon=DAMAGE_SOURCE_BUBBLE;
				shot.hspeed += owner.hspeed;
				shot.alarm[0] = 30 / global.delta_factor;
			// }
			justShot=true;
			readyToShoot=false;
			isRefilling = false;
			ammoCount -= 1;
			
			if (instance_exists(owner) && owner.onground == false) {
				with (owner)
					motion_add(aimDirection+180 mod 360, 1.0);
			}			
			
			alarm[0] = refireTime / global.delta_factor;
			alarm[5] = reloadBuffer / global.delta_factor;
		
		}
');

object_event_add(Machinegun,ev_other,ev_user2,'
	if(readyToShoot && bladesOut < maxBlades && bladeDelay <= 0)
		{
			isRefilling = 0;
			playsound(x,y,BladeSnd);
			var shot;
			randomize();
			shot = createShot(x+lengthdir_x(5, owner.aimDirection), y+lengthdir_y(5, owner.aimDirection), BladeB, DAMAGE_SOURCE_BLADE, owner.aimDirection, 12);
			shot.image_angle = 0;
			shot.alarm[0] = bladeLife / global.delta_factor;
			alarm[0] = refireTime / global.delta_factor;
			bladesOut += 1;
			shot.weapon = DAMAGE_SOURCE_BLADE;
			with(shot)
				hspeed += owner.hspeed;
			justShot = true;
			readyToShoot = false;
		}
');

object_event_add(Machinegun,ev_draw,0,'
	if(owner.taunting or owner.omnomnomnom or owner.player.humiliated)
		exit;
	var imageOffset, xdrawpos, ydrawpos;
	imageOffset = owner.team;
	xdrawpos = round(x+xoffset*image_xscale);
	ydrawpos = round(y+yoffset);
	if (alarm[6] <= 0){
		//set the sprite to idle
		imageOffset = owner.team;
	}else{
		//We are shooting, loop the shoot animation
		imageOffset = floor(image_index mod recoilAnimLength) + recoilAnimLength*owner.team
	}
	draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,c_white,image_alpha);
	if (owner.ubered) {
		if owner.team == TEAM_RED
			ubercolour = c_red;
		else if owner.team == TEAM_BLUE
			ubercolour = c_blue;
		draw_sprite_ext(sprite_index,imageOffset,round(x+xoffset*image_xscale),round(y+yoffset),image_xscale,image_yscale,image_angle,ubercolour,0.7*image_alpha);
	}
');

global.weapons[WEAPON_MACHINEGUN] = Machinegun;
global.name[WEAPON_MACHINEGUN] = "Machinegun";
