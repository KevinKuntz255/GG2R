globalvar Snowflake;
Snowflake = object_add();
object_set_sprite(Snowflake, sprite_add(pluginFilePath + "\randomizer_sprites\SnowflakeS.png", 4, 1, 0, 10, 9));
object_set_parent(Snowflake, BurningProjectile);
object_event_add(Snowflake,ev_create,0,'
    hitDamage = 3.3;
    flameLife = 15;
    burnIncrease = 1;
    durationIncrease = 30;
    afterburnFalloff = true;
    isSnowflake = true;
    penetrateCap = 1;
    event_inherited();
');
object_event_add(Snowflake,ev_draw,0,'
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
');