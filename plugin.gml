global.serverPluginsRequired=1
//namespace
globalvar randomizer, pluginFilePath;
randomizer = id;
pluginFilePath = argument0;

//Loading up other files
execute_file(pluginFilePath + "\projectile_init.gml");	//Creates projectile objects

// TODO: make a method that goes over each file in the weapons dir and adds them automatically
execute_file(pluginFilePath + "\weapons\shared\scattergun.gml");
//execute_file(pluginFilePath + "\weapons\shared\flamethrower.gml");
execute_file(pluginFilePath + "\weapons\shared\rocketlauncher.gml");
execute_file(pluginFilePath + "\weapons\shared\minigun.gml");
//execute_file(pluginFilePath + "\weapons\shared\minegun.gml");
execute_file(pluginFilePath + "\weapons\shared\shotgun.gml");
//execute_file(pluginFilePath + "\weapons\shared\revolver.gml");
execute_file(pluginFilePath + "\weapons\shared\rifle.gml");
execute_file(pluginFilePath + "\weapons\shared\pistol.gml");
//execute_file(pluginFilePath + "\weapons\shared\grenadelauncher.gml");
//execute_file(pluginFilePath + "\weapons\shared\needlegun.gml");
//execute_file(pluginFilePath + "\weapons\shared\healbeam.gml");
//execute_file(pluginFilePath + "\weapons\shared\nailgun.gml");
//execute_file(pluginFilePath + "\weapons\shared\knife.gml");
execute_file(pluginFilePath + "\weapons\shared\smg.gml");
execute_file(pluginFilePath + "\weapons\shared\melee.gml");
//execute_file(pluginFilePath + "\weapons\shared\throwable.gml");
execute_file(pluginFilePath + "\weapons\shared\flashlight.gml");
//execute_file(pluginFilePath + "\weapons\shared\flaregun.gml");
execute_file(pluginFilePath + "\weapons\shared\lasergun.gml");
//execute_file(pluginFilePath + "\weapons\shared\banner.gml");
//execute_file(pluginFilePath + "\weapons\shared\consumable.gml");
//execute_file(pluginFilePath + "\weapons\shared\crossbow.gml");
//execute_file(pluginFilePath + "\weapons\shared\wrangler.gml");
//execute_file(pluginFilePath + "\weapons\shared\wear.gml");


execute_file(pluginFilePath + "\weapons\constructor\eurekaeffect.gml");
execute_file(pluginFilePath + "\weapons\constructor\frontierjustice.gml");
execute_file(pluginFilePath + "\weapons\constructor\nailgun.gml");
execute_file(pluginFilePath + "\weapons\constructor\pomson.gml");
execute_file(pluginFilePath + "\weapons\constructor\sheriff.gml");
execute_file(pluginFilePath + "\weapons\constructor\shotgun.gml");
execute_file(pluginFilePath + "\weapons\constructor\stungun.gml");
execute_file(pluginFilePath + "\weapons\constructor\widowmaker.gml");
execute_file(pluginFilePath + "\weapons\constructor\wrangler.gml");
execute_file(pluginFilePath + "\weapons\constructor\wrench.gml");

execute_file(pluginFilePath + "\weapons\detonator\doubletrouble.gml");
execute_file(pluginFilePath + "\weapons\detonator\eyelander.gml");
execute_file(pluginFilePath + "\weapons\detonator\grenade.gml");
execute_file(pluginFilePath + "\weapons\detonator\grenadelauncher.gml");
execute_file(pluginFilePath + "\weapons\detonator\minegun.gml");
execute_file(pluginFilePath + "\weapons\detonator\paintrain.gml");
execute_file(pluginFilePath + "\weapons\detonator\scottishresistance.gml");
execute_file(pluginFilePath + "\weapons\detonator\stickyjumper.gml");
execute_file(pluginFilePath + "\weapons\detonator\stickysticker.gml");
execute_file(pluginFilePath + "\weapons\detonator\tigeruppercut.gml");

execute_file(pluginFilePath + "\weapons\firebug\backburner.gml");
execute_file(pluginFilePath + "\weapons\firebug\detonator.gml");
execute_file(pluginFilePath + "\weapons\firebug\flamethrower.gml");
execute_file(pluginFilePath + "\weapons\firebug\flaregun.gml");
execute_file(pluginFilePath + "\weapons\firebug\frostbite.gml");
execute_file(pluginFilePath + "\weapons\firebug\napalm.gml");
execute_file(pluginFilePath + "\weapons\firebug\phlog.gml");
execute_file(pluginFilePath + "\weapons\firebug\shotgun.gml");
execute_file(pluginFilePath + "\weapons\firebug\transmutator.gml");
execute_file(pluginFilePath + "\weapons\firebug\wrecker.gml");

execute_file(pluginFilePath + "\weapons\healer\blutsauger.gml");
execute_file(pluginFilePath + "\weapons\healer\crossbow.gml");
execute_file(pluginFilePath + "\weapons\healer\kritzkrieg.gml");
execute_file(pluginFilePath + "\weapons\healer\medigun.gml");
execute_file(pluginFilePath + "\weapons\healer\needlegun.gml");
execute_file(pluginFilePath + "\weapons\healer\overhealer.gml");
execute_file(pluginFilePath + "\weapons\healer\potion.gml");
execute_file(pluginFilePath + "\weapons\healer\quickfix.gml");
execute_file(pluginFilePath + "\weapons\healer\terminalbreath.gml");
execute_file(pluginFilePath + "\weapons\healer\ubersaw.gml");

execute_file(pluginFilePath + "\weapons\infiltrator\bigearner.gml");
execute_file(pluginFilePath + "\weapons\infiltrator\diamondback.gml");
execute_file(pluginFilePath + "\weapons\infiltrator\diplomat.gml");
execute_file(pluginFilePath + "\weapons\infiltrator\etranger.gml");
execute_file(pluginFilePath + "\weapons\infiltrator\knife.gml");
execute_file(pluginFilePath + "\weapons\infiltrator\medichain.gml");
execute_file(pluginFilePath + "\weapons\infiltrator\nordicgold.gml");
execute_file(pluginFilePath + "\weapons\infiltrator\revolver.gml");
execute_file(pluginFilePath + "\weapons\infiltrator\spycicle.gml");
execute_file(pluginFilePath + "\weapons\infiltrator\zapper.gml");

execute_file(pluginFilePath + "\weapons\overweight\brassbeast.gml");
execute_file(pluginFilePath + "\weapons\overweight\chocolate.gml");
execute_file(pluginFilePath + "\weapons\overweight\familybusiness.gml");
execute_file(pluginFilePath + "\weapons\overweight\iron.gml");
execute_file(pluginFilePath + "\weapons\overweight\kgob.gml");
execute_file(pluginFilePath + "\weapons\overweight\minigun.gml");
execute_file(pluginFilePath + "\weapons\overweight\natacha.gml");
execute_file(pluginFilePath + "\weapons\overweight\sandvich.gml");
execute_file(pluginFilePath + "\weapons\overweight\shotgun.gml");
execute_file(pluginFilePath + "\weapons\overweight\tomislav.gml");

execute_file(pluginFilePath + "\weapons\rifleman\bazaarbargain.gml");
execute_file(pluginFilePath + "\weapons\rifleman\bow.gml");
execute_file(pluginFilePath + "\weapons\rifleman\huntsman.gml");
execute_file(pluginFilePath + "\weapons\rifleman\jarate.gml");
execute_file(pluginFilePath + "\weapons\rifleman\kukri.gml");
execute_file(pluginFilePath + "\weapons\rifleman\machina.gml");
execute_file(pluginFilePath + "\weapons\rifleman\rifle.gml");
execute_file(pluginFilePath + "\weapons\rifleman\shiv.gml");
execute_file(pluginFilePath + "\weapons\rifleman\smg.gml");
execute_file(pluginFilePath + "\weapons\rifleman\sydneysleeper.gml");

execute_file(pluginFilePath + "\weapons\rifleman\rocketboots.gml");

execute_file(pluginFilePath + "\weapons\rocketman\airstrike.gml");
execute_file(pluginFilePath + "\weapons\rocketman\blackbox.gml");
execute_file(pluginFilePath + "\weapons\rocketman\buffbanner.gml");
execute_file(pluginFilePath + "\weapons\rocketman\cowmangler.gml");
execute_file(pluginFilePath + "\weapons\rocketman\directhit.gml");
execute_file(pluginFilePath + "\weapons\rocketman\equalizer.gml");
execute_file(pluginFilePath + "\weapons\rocketman\rbison.gml");
execute_file(pluginFilePath + "\weapons\rocketman\reserveshooter.gml");
execute_file(pluginFilePath + "\weapons\rocketman\rocketlauncher.gml");
execute_file(pluginFilePath + "\weapons\rocketman\shotgun.gml");

execute_file(pluginFilePath + "\weapons\runner\atomizer.gml");
execute_file(pluginFilePath + "\weapons\runner\bonk.gml");
execute_file(pluginFilePath + "\weapons\runner\flashlight.gml");
execute_file(pluginFilePath + "\weapons\runner\forceanature.gml");
execute_file(pluginFilePath + "\weapons\runner\madmilk.gml");
execute_file(pluginFilePath + "\weapons\runner\pistol.gml");
execute_file(pluginFilePath + "\weapons\runner\rundown.gml");
execute_file(pluginFilePath + "\weapons\runner\sandman.gml");
execute_file(pluginFilePath + "\weapons\runner\scattergun.gml");
execute_file(pluginFilePath + "\weapons\runner\sodapopper.gml");

execute_file(pluginFilePath + "\weapons\misc.gml");

execute_file(pluginFilePath + "\weapon_init.gml");		//Creates weapon objects which relies on projectile objects

execute_file(pluginFilePath + "\ammo_init.gml");		//Adds in ammo related files and etc
execute_file(pluginFilePath + "\loadCode.gml");			//Creates basically everything else
execute_file(pluginFilePath + "\networking.gml");		//Cannot play without it
