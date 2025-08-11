globalvar WEAPON_BONK;
WEAPON_BONK = 6;

globalvar BonkHand;
BonkHand = object_add();
object_set_parent(BonkHand, ConsumableWeapon);
object_set_sprite(BonkHand, sprite_add(pluginFilePath + "\randomizer_sprites\BonkHandS.png", 4, 0, 1, 21, 25));

globalvar ScoutBuffS; 
ScoutBuffS = sprite_add(pluginFilePath + "\randomizer_sprites\ScoutBuffS.png", 22, 0, 0, 30, 40);

object_event_add(BonkHand,ev_create,0,'
    xoffset=-3;
    yoffset=-2;
    event_inherited();
    isMetered = true;

	maxMeter = 1;
    meter = maxMeter;

    abilityActive = false;
    abilityVisual = "BLUR";

	normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BonkHandS.png", 4, 0, 0, 21, 25);
	recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BonkHandS.png", 4, 0, 1, 21, 25);
	reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\BonkHandS.png", 4, 0, 1, 21, 25);
	
	sprite_index = normalSprite;
	image_speed = 0;
	
    isThrowable = false;
    
	recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;

    if (!owner.radioactive) {
        if (owner.team == TEAM_BLUE) owner._oldTauntSprite = ScoutBlueTauntS; else owner._oldTauntSprite = ScoutRedTauntS;
        owner.tauntsprite = ScoutBuffS;
        owner.tauntlength = sprite_get_number(owner.tauntsprite)/2;
        owner.tauntindex=owner.tauntlength * owner.player.team;
        owner.tauntend=owner.tauntlength * (1 + owner.player.team) - 1;
        owner.tauntspeed = 4;
    }
');

object_event_add(BonkHand,ev_destroy,0,'
    owner.tauntsprite = owner._oldTauntSprite;
    owner.tauntlength = sprite_get_number(owner.tauntsprite)/2;
    owner.tauntindex=owner.tauntlength * owner.player.team;
    owner.tauntend=owner.tauntlength * (1 + owner.player.team) - 1;
    owner.tauntspeed = 3;
');

object_event_add(BonkHand,ev_step,ev_step_normal,'
    event_inherited();

	if (owner.taunting && owner.tauntsprite == ScoutBuffS) {
		//if (owner.tauntindex >= sprite_get_number(owner.tauntsprite) && !abilityActive) {
            //owner.inheritAbility = true;

        if (owner.team = TEAM_BLUE && owner.tauntindex <= 10) owner.tauntindex += sprite_get_number(owner.tauntsprite)/2; // its called we do a little jerry-rigging
        if (owner.tauntindex >= owner.tauntend && !owner.radioactive) {
			owner.radioactive = true;
			playsound(x,y,BallSnd);
			owner.tauntsprite = owner._oldTauntSprite;
            owner.tauntlength = sprite_get_number(owner.tauntsprite)/2;
            owner.tauntspeed = 3;
		}
	}
');

object_event_add(BonkHand,ev_other,ev_user0,'
    alarm[0]=refireTime / global.delta_factor;
    if owner.ammo[105] == -1 alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
    else alarm[5] = (reloadBuffer + owner.ammo[105]) / global.delta_factor;
');

object_event_add(BonkHand,ev_other,ev_user1,'
	if(!owner.player.humiliated && ammoCount >= 1)  {
		owner.taunting=true;
        owner.tauntindex=0;
        owner.image_speed=owner.tauntspeed;
		ammoCount = max(0, ammoCount-1);
		playsound(x,y,PickupSnd);
		alarm[5] = (reloadBuffer + reloadTime) / global.delta_factor;
		owner.alarm[10] = 150 / global.delta_factor;
    }
');

global.weapons[WEAPON_BONK] = BonkHand;
global.name[WEAPON_BONK] = "Bonk! Atomic punch";
