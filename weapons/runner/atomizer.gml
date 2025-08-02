globalvar WEAPON_ATOMIZER;
WEAPON_ATOMIZER = 9;

globalvar Atomizer;
Atomizer = object_add();
object_set_parent(Atomizer, Weapon);

object_event_add(Atomizer,ev_create,0,'
    xoffset=6;
    yoffset=0;
    refireTime=18;
    event_inherited();
    StabreloadTime = 5;
    //readyToStab = false;
    alarm[2] = 15;
    smashing = false;

    weaponGrade = UNIQUE;
    weaponType = MELEE;
    stabdirection=0;
    maxAmmo = 1;
    ammoCount = maxAmmo;
    reloadTime = 300;
    reloadBuffer = refireTime;
    idle=true;
    owner.ammo[107] = -1;
    depth = 1;
    isMelee = true;
	trip = false;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AtomizerS.png", 2, 1, 0, 21, 25);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AtomizerFS.png", 8, 1, 0, 21, 25);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\AtomizerS.png", 2, 1, 0, 21, 25);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');

object_event_add(Atomizer,ev_step,ev_step_normal,'
	if (owner.doublejumpUsed and !trip){
		owner.doublejumpUsed = false;
		trip = true;
	}
	if (owner.onground)
		trip = false;
    event_inherited();

    if !variable_local_exists("ammoCheck") {
        ammoCheck = 1;
        alarm[5] = owner.ammo[107];
    }
');

global.weapons[WEAPON_ATOMIZER] = Atomizer;
global.name[WEAPON_ATOMIZER] = "Atomizer (Unfinished)";
