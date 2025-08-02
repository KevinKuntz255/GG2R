globalvar WEAPON_DETONATOR;
WEAPON_DETONATOR = 87;

globalvar Detonator;
Detonator = object_add();
object_set_parent(Detonator, Weapon);

object_event_add(Detonator,ev_create,0,'
    xoffset=5;
    yoffset=-3;
    refireTime=45;
    event_inherited();
    maxAmmo = 16;
    ammoCount = maxAmmo;
    reloadTime = 540;
    reloadBuffer = 20;
    idle=true;
    readyToFlare = false;

    weaponGrade = UNIQUE;
    weaponType = FLAREGUN;

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DetonatorS.png", 2, 1, 0, 8, -1);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DetonatorFS.png", 4, 1, 0, 8, -1);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\DetonatorFRS.png", 18, 1, 0, 14, 6);

    sprite_index = normalSprite;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite)/2;
    recoilImageSpeed = recoilAnimLength/recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite)/2;
    reloadImageSpeed = reloadAnimLength/reloadTime;
');
object_event_add(Detonator,ev_other,ev_user2,'
    with(DetonationFlare) {
		if ownerPlayer == other.ownerPlayer {
			event_user(5);
		}
    }
');

global.weapons[WEAPON_DETONATOR] = Detonator;
global.name[WEAPON_DETONATOR] = "Detonator";
