global.serverPluginsRequired=1
//namespace
globalvar randomizer, pluginFilePath;
randomizer = id;
pluginFilePath = argument0;

//Loading up other files
execute_file(pluginFilePath + "\projectile_init.gml");	//Creates projectile objects
execute_file(pluginFilePath + "\weapon_init.gml");		//Creates weapon objects which relies on projectile objects
execute_file(pluginFilePath + "\ammo_init.gml");		//Adds in ammo related files and etc
execute_file(pluginFilePath + "\loadCode.gml");			//Creates basically everything else
execute_file(pluginFilePath + "\networking.gml");		//Cannot play without it
