global.updateType = QUICK_UPDATE;

//send buffer
randomizer.sendBuffer = buffer_create();

//receive buffer
randomizer.recBuff = buffer_create();

//Networking constants
//Loadout Constants
randomizer.loadoutReceive = 0;
randomizer.loadoutUpdate = 1;
randomizer.loadoutRequest = 2;
//Active Weapon Constant
randomizer.activeWeapon = 3


object_event_add(Player, ev_create, 0, '
    joined = false;
    activeWeapon = 0;
');
with(Player)
{
    joined = false;
    activeWeapon = 0;
}
//Hopefully sends loadout and asks for loadouts upon server join
object_event_add(PlayerControl, ev_create, 0, '
    with(Player){
        if(!global.isHost and id == global.myself and joined == false){
            //Have to put this here
            global.myself.activeWeapon = 0;
            global.myself.playerLoadout = global.currentLoadout;

            //Send Loadout
            write_ubyte(randomizer.sendBuffer, randomizer.loadoutReceive);
            write_ushort(randomizer.sendBuffer, global.currentLoadout);
            if(global.isHost){
                PluginPacketSendTo(randomizer.packetID, randomizer.sendBuffer, global.myself);
            }else{
                PluginPacketSend(randomizer.packetID,randomizer.sendBuffer);
            }
            buffer_clear(randomizer.sendBuffer);

            //Send Active Weapon
            write_ubyte(randomizer.sendBuffer, randomizer.activeWeapon);
            write_ubyte(randomizer.sendBuffer, global.myself.activeWeapon);
            if(global.isHost){
                PluginPacketSendTo(randomizer.packetID, randomizer.sendBuffer, global.myself);
            }else{
                PluginPacketSend(randomizer.packetID,randomizer.sendBuffer);
            }
            buffer_clear(randomizer.sendBuffer);

            //Receive Loadouts
            write_ubyte(randomizer.sendBuffer, randomizer.loadoutRequest);
            if(global.isHost){
                PluginPacketSendTo(randomizer.packetID, randomizer.sendBuffer, global.myself);
            }else{
                PluginPacketSend(randomizer.packetID,randomizer.sendBuffer);
            }
            buffer_clear(randomizer.sendBuffer);
            joined = true;
        }
    }
');


object_event_add(PlayerControl, ev_step, ev_step_end, '
    if (global.isHost){
        while(PluginPacketGetBuffer(randomizer.packetID) != -1){
            var randomizerBuffer;
            randomizerBuffer = PluginPacketGetBuffer(randomizer.packetID);
            
            switch (read_ubyte(randomizerBuffer))
            {
            case randomizer.loadoutReceive:
                //Receives loadout from a client then stores it serverside
                var sender;
                sender = PluginPacketGetPlayer(randomizer.packetID);

                //Reads sent loadout
                sender.playerLoadout = read_ushort(randomizerBuffer);

                //Sends loadout to every player
                write_ubyte(randomizer.sendBuffer, randomizer.loadoutUpdate);
                write_ubyte(randomizer.sendBuffer, 1);
                write_ushort(randomizer.sendBuffer, ds_list_find_index(global.players, sender.id));
                write_ushort(randomizer.sendBuffer, sender.playerLoadout);

                PluginPacketSend(randomizer.packetID, randomizer.sendBuffer, true);
                buffer_clear(randomizer.sendBuffer);
                break;
            case randomizer.loadoutRequest:
                //Sends every players loadout to a client upon request
                var sender, i, player;
                sender = PluginPacketGetPlayer(randomizer.packetID);

                write_ubyte(randomizer.sendBuffer, randomizer.loadoutUpdate);
                write_ubyte(randomizer.sendBuffer, ds_list_size(global.players));
                for(i = 0; i < ds_list_size(global.players); i += 1) {
                    player = ds_list_find_value(global.players, i);
                    write_ushort(randomizer.sendBuffer, i);
                    with(player) {
						if(variable_local_exists("playerLoadout")) {
							write_ushort(randomizer.sendBuffer, player.playerLoadout);
						} else {
							write_ushort(randomizer.sendBuffer, 0);
						}
					}
				}
                PluginPacketSendTo(randomizer.packetID, randomizer.sendBuffer, sender);
                buffer_clear(randomizer.sendBuffer);
                break;  
            case randomizer.activeWeapon:
                //Receives the clients active weapon and stores it serverside
                var sender, i, player;
                sender = PluginPacketGetPlayer(randomizer.packetID);

                //Reads sent active weapon
                sender.activeWeapon = read_ubyte(randomizerBuffer);


                write_ubyte(randomizer.sendBuffer, randomizer.activeWeapon);
                //Make request case as this updates every characters active weapon on a client
                write_ubyte(randomizer.sendBuffer, ds_list_size(global.players));
                for(i = 0; i < ds_list_size(global.players); i += 1) {
                    player = ds_list_find_value(global.players, i);
                    write_ushort(randomizer.sendBuffer, i);
					with(player){
						if(variable_local_exists("activeWeapon")) {
							write_ushort(randomizer.sendBuffer, player.activeWeapon);
						} else {
							write_ushort(randomizer.sendBuffer, 0);
						}
					}
				}

                //write_ubyte(randomizer.sendBuffer, 1);
                //write_ushort(randomizer.sendBuffer, ds_list_find_index(global.players, sender.id));
                //write_ubyte(randomizer.sendBuffer, sender.activeWeapon);

                PluginPacketSend(randomizer.packetID, randomizer.sendBuffer);
                buffer_clear(randomizer.sendBuffer);
                break;
            }
            
            buffer_destroy(randomizerBuffer);
            PluginPacketPop(randomizer.packetID);
        }
    }else{
        while(PluginPacketGetBuffer(randomizer.packetID) != -1){
            var randomizerBuffer;
            randomizerBuffer = PluginPacketGetBuffer(randomizer.packetID);

            switch(read_ubyte(randomizerBuffer))
            {
            case randomizer.loadoutUpdate:
                //Stores received loadouts clientside
                var receivedLoadouts, i, player;

                receivedLoadouts = read_ubyte(randomizerBuffer);
                for(i = 0; i < receivedLoadouts; i += 1) {
                    player = ds_list_find_value(global.players, read_ushort(randomizerBuffer));
                    player.playerLoadout = read_ushort(randomizerBuffer);
                }
                break;
            case randomizer.activeWeapon:
                //Stores the active weapons for players clientside
                var receivedActiveWeaponStates, i, player;

                receivedActiveWeaponStates = read_ubyte(randomizerBuffer);
                for(i = 0; i < receivedActiveWeaponStates; i += 1) {
                    player = ds_list_find_value(global.players, read_ushort(randomizerBuffer));
					with(player){
						if(variable_local_exists("activeWeapon")) {
							player.activeWeapon = read_ushort(randomizerBuffer);
						} else {
							player.activeWeapon = 0;
						}
					}
                }
                break;
            }
            buffer_clear(randomizer.recBuff);
            PluginPacketPop(randomizer.packetID);
        }
    }
');
