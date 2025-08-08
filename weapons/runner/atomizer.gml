globalvar WEAPON_ATOMIZER;
WEAPON_ATOMIZER = 9;

globalvar Atomizer;
Atomizer = object_add();
object_set_parent(Atomizer, MeleeWeapon);

globalvar ScoutTKillS; 
ScoutTKillS = sprite_add(pluginFilePath + "\randomizer_sprites\ScoutTKillS.png", 58, 0, 0, 29, 40);

object_event_add(Atomizer,ev_create,0,'
    xoffset=-15;
    yoffset=-25;
    spriteBase = "Atomizer";
    event_inherited();
    depth = 1;

    team = owner.team;

    TK = false;
    if (team == TEAM_BLUE) TKF = 47 else TKF = 18;
    if (team == TEAM_BLUE) owner._oldTauntSprite = ScoutBlueTauntS; else owner._oldTauntSprite = ScoutRedTauntS;
    owner.tauntsprite = ScoutTKillS;
    owner.tauntlength = 28;
    owner.tauntend = 28;
    owner.tauntindex=owner.tauntlength * owner.player.team;
    owner.tauntspeed = 4;
');

object_event_add(Atomizer,ev_destroy,0,'
    owner.tauntsprite = owner._oldTauntSprite;
    owner.tauntlength = sprite_get_number(owner.tauntsprite)/2;
    owner.tauntindex=owner.tauntlength * owner.player.team;
    owner.tauntspeed = 3;
');

// todo: move trip to owner as done in haxxy_melee_only
object_event_add(Atomizer,ev_step,ev_step_normal,'
	if (owner.doublejumpUsed && !owner.tripleJumpUsed){
		owner.doublejumpUsed = false;
        owner.tripleJumpUsed = true;
	}
	if (owner.onground)
		owner.tripleJumpUsed = false;

	if (owner.taunting && owner.tauntsprite == ScoutTKillS) {
		//if (owner.tauntindex >= sprite_get_number(owner.tauntsprite) && !abilityActive) {
            //owner.inheritAbility = true;

        if (owner.team == TEAM_BLUE && owner.tauntindex <= 29) owner.tauntindex += sprite_get_number(owner.tauntsprite)/2; // its called we do a little jerry-rigging
        if (owner.tauntindex >= TKF && !TK) {
        	shot = instance_create(x,y,MeleeMask);
		    shot.direction = owner.aimDirection;
		    shot.speed = owner.speed;
		    shot.owner = owner;
		    shot.ownerPlayer = ownerPlayer;
		    shot.team = owner.team;
		    shot.hitDamage = 200;
		    shot.weapon=DAMAGE_SOURCE_KNIFE;
			playsound(x,y,BallSnd);
            TK = true;
		}
		if (owner.tauntindex >= owner.tauntend && team == TEAM_RED) {
			owner.taunting = false;
		}
	} else {
		TK = false;
	}

    event_inherited();
');

global.weapons[WEAPON_ATOMIZER] = Atomizer;
global.name[WEAPON_ATOMIZER] = "Atomizer";
