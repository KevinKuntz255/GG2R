globalvar ConsumableWeapon;
ConsumableWeapon = object_add();
object_set_parent(ConsumableWeapon, Weapon);

object_event_add(ConsumableWeapon, ev_create, 0, '
    refireTime = 18;
    event_inherited();
    //owner.expectedWeaponBytes = 3; risky

    isMelee = true;

    maxAmmo = 1;
    ammoCount = maxAmmo;

    weaponGrade = UNIQUE;
    weaponType = CONSUMABLE;

    reloadTime = 300;
    reloadBuffer = refireTime;

    isThrowable = true;
    specialProjectile = Sandvich;

    if (!variable_local_exists("spriteBase")) spriteBase = "SandvichHand";

    normalSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 4, 1, 0, 0, 11);
    recoilSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 4, 1, 0, 0, 11);
    reloadSprite = sprite_add(pluginFilePath + "\randomizer_sprites\" + spriteBase + "S.png", 4, 1, 0, 0, 11);

    sprite_index = normalSprite;

    image_speed = 0;

    recoilTime = refireTime;
    recoilAnimLength = sprite_get_number(recoilSprite) / 2;
    recoilImageSpeed = recoilAnimLength / recoilTime;

    reloadAnimLength = sprite_get_number(reloadSprite) / 2;
    reloadImageSpeed = reloadAnimLength / reloadTime;
');


object_event_add(ConsumableWeapon, ev_alarm, 5, '
    event_inherited();

    ammoCount = maxAmmo;
    if meterCount != -1 meterCount = maxMeter;
');

object_event_add(ConsumableWeapon, ev_step, ev_step_normal, '
    image_index = owner.team+2*real(owner.canEat);
');


object_event_add(ConsumableWeapon, ev_draw, 0, '
    if (distance_to_point(view_xview + view_wview/2, view_yview + view_hview/2) > 800)
        exit;

    if (!owner.invisible and !owner.taunting and !owner.omnomnomnom and !owner.player.humiliated)
    {
        if (!owner.cloak)
            image_alpha = power(owner.cloakAlpha, 0.5);
        else
            image_alpha = power(owner.cloakAlpha, 2);
        draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, c_white, image_alpha);
        if (owner.ubered)
        {
            if (owner.team == TEAM_RED)
                ubercolour = c_red;
            else if (owner.team == TEAM_BLUE)
                ubercolour = c_blue;
            draw_sprite_ext(sprite_index, image_index, round(x+xoffset*image_xscale), round(y+yoffset) + owner.equipmentOffset, image_xscale, image_yscale, image_angle, ubercolour, 0.7*image_alpha);
        }
    }
');

// todo: move couple events around and globalize em