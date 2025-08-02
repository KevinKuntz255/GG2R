global.serverPluginsRequired=1
//namespace
globalvar randomizer, pluginFilePath;
randomizer = id;
pluginFilePath = argument0;

//Loading up other files
execute_file(pluginFilePath + "\projectile_init.gml");	//Creates projectile objects

// TODO: make a method that goes over each file in the weapons dir and adds them automatically
execute_file(pluginFilePath + "\weapons\shared\melee.gml");
execute_file(pluginFilePath + "\weapons\shared\shotgun.gml");

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

execute_file(pluginFilePath + "\weapon_init.gml");		//Creates weapon objects which relies on projectile objects

execute_file(pluginFilePath + "\ammo_init.gml");		//Adds in ammo related files and etc
execute_file(pluginFilePath + "\loadCode.gml");			//Creates basically everything else
execute_file(pluginFilePath + "\networking.gml");		//Cannot play without it
