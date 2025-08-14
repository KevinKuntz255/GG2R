globalvar ManglerShot;
ManglerShot = object_add();
object_set_parent(ManglerShot, Rocket);
object_event_add(ManglerShot,ev_create,0,'
    event_inherited();
    {
        travelDistance=0;
        firstx=x;
        firsty=y;
        
        sprite_index = sprite_add(pluginFilePath + "\randomizer_sprites\ManglerShotS.png", 2, 1, 0, 3, 3);
        
        flameLife = 15;
        burnIncrease = 1;
        durationIncrease = 30;
        
        ubercolor=c_orange;
    }
');