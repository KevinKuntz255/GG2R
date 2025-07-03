global.serverPluginsRequired=1
//namespace
globalvar randomizer, pluginFilePath;
randomizer = id;
pluginFilePath = argument0;

//Loading up other files
execute_file(pluginFilePath + "\weapon_init.gml"); //Must come first
execute_file(pluginFilePath + "\loadCode.gml"); //Must come second
execute_file(pluginFilePath + "\networking.gml"); //Cannot play without it
