globalvar WEAPON_PAINTRAIN;
WEAPON_PAINTRAIN = 38;

globalvar Paintrain;
Paintrain = object_add();
object_set_parent(Paintrain, Weapon);

object_event_add(Paintrain,ev_create,0,'
	{
		xoffset=-9;
		yoffset=-40;
		refireTime=24;
		event_inherited();	
		maxMines = 14;
		lobbed = 0;
		unscopedDamage = 0;
		StabreloadTime = 5;
		//readyToStab = false;
		alarm[2] = 15;
		smashing = false;
		
		stabdirection=0;
		maxAmmo = 1;
		ammoCount = maxAmmo;
		reloadTime = 300;
		reloadBuffer = 24;
		idle=true;
		isMelee = true;
		
		normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PainTrainS.png", 2, 1, 0, 0, 0);
		recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PainTrainFS.png", 2, 1, 0, 0, 0);
		reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\PainTrainS.png", 2, 1, 0, 0, 0);

		sprite_index = normalSprite;

		recoilTime = refireTime;
		recoilAnimLength = sprite_get_number(recoilSprite)/2;
		recoilImageSpeed = recoilAnimLength/recoilTime;

		reloadAnimLength = sprite_get_number(reloadSprite)/2;
		reloadImageSpeed = reloadAnimLength/reloadTime;
		
		//owner.runPower = 5;
		owner.capStrength = 2;
	}
');
object_event_add(Paintrain,ev_destroy,0,'
    event_inherited();
	owner.capStrength = 1;
');

global.weapons[WEAPON_PAINTRAIN] = Paintrain;
global.name[WEAPON_PAINTRAIN] = "Paintrain";
