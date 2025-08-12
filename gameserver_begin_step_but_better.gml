if(serverbalance != 0)
    balancecounter += 1;

// Register with Lobby Server every 30 seconds
if((frame mod 900) == 0 and global.run_virtual_ticks)
    sendLobbyRegistration();
    
if(global.run_virtual_ticks)
    frame += 1;

// Service all players
var i;
for(i=0; i < ds_list_size(global.players); i+=1)
{
    var player, noOfPlayers, playerId, commandLimitRemaining;
    player = ds_list_find_value(global.players, i);
    
    if(socket_has_error(player.socket) or player.kicked)
    {
        var noOfOccupiedSlots, player;
        noOfOccupiedSlots = getNumberOfOccupiedSlots();
        
        removePlayer(player);
        ServerPlayerLeave(i, global.sendBuffer);
        ServerBalanceTeams();
        i -= 1;
        
        // message lobby to update playercount if we were full before
        if(noOfOccupiedSlots == global.playerLimit)
        {
            sendLobbyRegistration();
        }
    }
    else
    {
        playerId = i;

        // To prevent players from flooding the server, limit the number of commands to process per step and player.
        commandLimitRemaining = 10;

        with(player) {
            if(!variable_local_exists("commandReceiveState")) {
                // 0: waiting for command byte.
                // 1: waiting for command data length (1 byte)
                // 2: waiting for command data.
                commandReceiveState = 0;
                commandReceiveExpectedBytes = 1;
                commandReceiveCommand = 0;
            }
        }

        while(commandLimitRemaining > 0) {
            var socket;
            socket = player.socket;
            if(!tcp_receive(socket, player.commandReceiveExpectedBytes)) {
                break;
            }
            
            switch(player.commandReceiveState)
            {
            case 0:
                player.commandReceiveCommand = read_ubyte(socket);
                switch(commandBytes[player.commandReceiveCommand]) {
                case commandBytesInvalidCommand:
                    // Invalid byte received. Wait for another command byte.
                    break;
                    
                case commandBytesPrefixLength1:
                    player.commandReceiveState = 1;
                    player.commandReceiveExpectedBytes = 1;
                    break;

                case commandBytesPrefixLength2:
                    player.commandReceiveState = 3;
                    player.commandReceiveExpectedBytes = 2;
                    break;

                default:
                    player.commandReceiveState = 2;
                    player.commandReceiveExpectedBytes = commandBytes[player.commandReceiveCommand];
                    break;
                }
                break;
                
            case 1:
                player.commandReceiveState = 2;
                player.commandReceiveExpectedBytes = read_ubyte(socket);
                break;

            case 3:
                player.commandReceiveState = 2;
                player.commandReceiveExpectedBytes = read_ushort(socket);
                break;
                
            case 2:
                player.commandReceiveState = 0;
                player.commandReceiveExpectedBytes = 1;
                commandLimitRemaining -= 1;
                
                switch(player.commandReceiveCommand)
                {
                case PLAYER_LEAVE:
                    socket_destroy(player.socket);
                    player.socket = -1;
                    break;
                    
                case PLAYER_CHANGECLASS:
                    var class;
                    class = read_ubyte(socket);
                    if(getCharacterObject(class) != -1)
                    {
                        if(player.object != -1)
                        {
                            with(player.object)
                            {
                                if (collision_point(x,y,SpawnRoom,0,0) < 0)
                                {
                                    if (!instance_exists(lastDamageDealer) || lastDamageDealer == player)
                                    {
                                        sendEventPlayerDeath(player, player, noone, DAMAGE_SOURCE_BID_FAREWELL);
                                        doEventPlayerDeath(player, player, noone, DAMAGE_SOURCE_BID_FAREWELL);
                                    }
                                    else
                                    {
                                        var assistant;
                                        assistant = secondToLastDamageDealer;
                                        if (lastDamageDealer.object)
                                            if (lastDamageDealer.object.healer)
                                                assistant = lastDamageDealer.object.healer;
                                        sendEventPlayerDeath(player, lastDamageDealer, assistant, DAMAGE_SOURCE_FINISHED_OFF);
                                        doEventPlayerDeath(player, lastDamageDealer, assistant, DAMAGE_SOURCE_FINISHED_OFF);
                                    }
                                }
                                else 
                                instance_destroy(); 
                                
                            }
                        }
                        else if(player.alarm[5]<=0)
                            player.alarm[5] = 1; // Will spawn in the same step (between Begin Step and Step)
                        class = checkClasslimits(player, player.team, class);
                        player.class = class;
                        ServerPlayerChangeclass(playerId, player.class, global.sendBuffer);
                    }
                    break;
                    
                case PLAYER_CHANGETEAM:
                    var newTeam, balance, redSuperiority;
                    newTeam = read_ubyte(socket);
                    
                    // Invalid team was requested, treat it as a random team
                    if(newTeam != TEAM_RED and newTeam != TEAM_BLUE and newTeam != TEAM_SPECTATOR)
                        newTeam = TEAM_ANY;

                    redSuperiority = 0   //calculate which team is bigger
                    with(Player)
                    {
                        if(id != player)
                        {
                            if(team == TEAM_RED)
                                redSuperiority += 1;
                            else if(team == TEAM_BLUE)
                                redSuperiority -= 1;
                        }
                    }
                    if(redSuperiority > 0)
                        balance = TEAM_RED;
                    else if(redSuperiority < 0)
                        balance = TEAM_BLUE;
                    else
                        balance = -1;
                    
                    if(newTeam == TEAM_ANY)
                    {
                        if(balance == TEAM_RED)
                            newTeam = TEAM_BLUE;
                        else if(balance == TEAM_BLUE)
                            newTeam = TEAM_RED;
                        else
                            newTeam = choose(TEAM_RED, TEAM_BLUE);
                    }
                        
                    if(balance != newTeam and newTeam != player.team)
                    {
                        if(getCharacterObject(player.class) != -1 or newTeam==TEAM_SPECTATOR)
                        {  
                            if(player.object != -1)
                            {
                                with(player.object)
                                {
                                    if (!instance_exists(lastDamageDealer) || lastDamageDealer == player)
                                    {
                                        sendEventPlayerDeath(player, player, noone, DAMAGE_SOURCE_BID_FAREWELL);
                                        doEventPlayerDeath(player, player, noone, DAMAGE_SOURCE_BID_FAREWELL);
                                    }
                                    else
                                    {
                                        var assistant;
                                        assistant = secondToLastDamageDealer;
                                        if (lastDamageDealer.object)
                                            if (lastDamageDealer.object.healer)
                                                assistant = lastDamageDealer.object.healer;
                                        sendEventPlayerDeath(player, lastDamageDealer, assistant, DAMAGE_SOURCE_FINISHED_OFF);
                                        doEventPlayerDeath(player, lastDamageDealer, assistant, DAMAGE_SOURCE_FINISHED_OFF);
                                    }
                                }
                                player.alarm[5] = global.Server_Respawntime / global.delta_factor;
                            }
                            else if(player.alarm[5]<=0)
                                player.alarm[5] = 1; // Will spawn in the same step (between Begin Step and Step)
                            var newClass;
                            newClass = checkClasslimits(player, newTeam, player.class);
                            if newClass != player.class
                            {
                                player.class = newClass;
                                ServerPlayerChangeclass(playerId, player.class, global.sendBuffer);
                            }
                            player.team = newTeam;
                            ServerPlayerChangeteam(playerId, player.team, global.sendBuffer);
                            clearPlayerDominations(player);
                            ServerBalanceTeams();
                        }
                    }
                    break;                   
                    
                case CHAT_BUBBLE:
                    var bubbleImage;
                    bubbleImage = read_ubyte(socket);
                    if(global.aFirst and bubbleImage != 45)
                    {
                        bubbleImage = 0;
                    }
                    write_ubyte(global.sendBuffer, CHAT_BUBBLE);
                    write_ubyte(global.sendBuffer, playerId);
                    write_ubyte(global.sendBuffer, bubbleImage);
                    
                    setChatBubble(player, bubbleImage);
                    break;
                    
                case BUILD_SENTRY:
                    if(player.object != -1)
                    {
                        if(player.class == CLASS_ENGINEER
                                and collision_circle(player.object.x, player.object.y, 50, Sentry, false, true) < 0
                                and player.object.nutsNBolts == 100
                                and (collision_point(player.object.x,player.object.y,SpawnRoom,0,0) < 0)
                                and !player.sentry
                                and !player.object.onCabinet)
                        {
                            write_ubyte(global.sendBuffer, BUILD_SENTRY);
                            write_ubyte(global.sendBuffer, playerId);
                            write_ushort(global.serializeBuffer, round(player.object.x*5));
                            write_ushort(global.serializeBuffer, round(player.object.y*5));
                            write_byte(global.serializeBuffer, player.object.image_xscale);
                            buildSentry(player, player.object.x, player.object.y, player.object.image_xscale);
                        }
                    }
                    break;                                       

                case DESTROY_SENTRY:
                    with(player.sentry)
                        instance_destroy();
                    break;                     
                
                case DROP_INTEL:
                    if (player.object != -1)
                    {
                        if (player.object.intel)
                        {
                            sendEventDropIntel(player);
                            doEventDropIntel(player);
                        }
                    }
                    break;     
                /*      
                case OMNOMNOMNOM:
                    if(player.object != -1) {
                        if(!player.humiliated
                            and !player.object.taunting
                            and !player.object.omnomnomnom
                            and player.object.canEat
                            and player.class==CLASS_HEAVY)
                        {                            
                            write_ubyte(global.sendBuffer, OMNOMNOMNOM);
                            write_ubyte(global.sendBuffer, playerId);
                            with(player.object)
                            {
                                omnomnomnom = true;
                                omnomnomnomindex=0;
                                omnomnomnomend=32;
                                xscale=image_xscale;
                            }             
                        }
                    }
                    break;
                */    
                case TOGGLE_ZOOM:
                    if player.object != -1 {
                        if player.class == CLASS_SNIPER {
                            if player.activeWeapon == 0 && player.object.weaponType[0] != BOW {
                                write_ubyte(global.sendBuffer, TOGGLE_ZOOM);
                                write_ubyte(global.sendBuffer, playerId);
                                toggleZoom(player.object);
                            }
                        }
                    }
                    break;
                                                              
                case PLAYER_CHANGENAME:
                    var nameLength;
                    nameLength = socket_receivebuffer_size(socket);
                    if(nameLength > MAX_PLAYERNAME_LENGTH)
                    {
                        write_ubyte(player.socket, KICK);
                        write_ubyte(player.socket, KICK_NAME);
                        socket_destroy(player.socket);
                        player.socket = -1;
                    }
                    else
                    {
                        with(player)
                        {
                            if(variable_local_exists("lastNamechange")) 
                                if(current_time - lastNamechange < 1000)
                                    break;
                            lastNamechange = current_time;
                            name = read_string(socket, nameLength);
                            write_ubyte(global.sendBuffer, PLAYER_CHANGENAME);
                            write_ubyte(global.sendBuffer, playerId);
                            write_ubyte(global.sendBuffer, string_length(name));
                            write_string(global.sendBuffer, name);
                        }
                    }
                    break;
                    
                case INPUTSTATE:
                    if(player.object != -1)
                    {
                        with(player.object)
                        {
                            keyState = read_ubyte(socket);
                            netAimDirection = read_ushort(socket);
                            aimDirection = netAimDirection*360/65536;
                            aimDistance = read_ubyte(socket)*2;
                            event_user(1);
                        }
                    }
                    break;
                
                case REWARD_REQUEST:
                    player.rewardId = read_string(socket, socket_receivebuffer_size(socket));
                    player.challenge = rewardCreateChallenge();
                    
                    write_ubyte(socket, REWARD_CHALLENGE_CODE);
                    write_binstring(socket, player.challenge);
                    break;
                    
                case REWARD_CHALLENGE_RESPONSE:
                    var answer, i, authbuffer;
                    answer = read_binstring(socket, 16);
                    
                    with(player)
                        if(variable_local_exists("challenge") and variable_local_exists("rewardId"))
                            rewardAuthStart(player, answer, challenge, true, rewardId);
                   
                    break;

                case PLUGIN_PACKET:
                    var packetID, buf, success;

                    packetID = read_ubyte(socket);
                    
                    // get packet data
                    buf = buffer_create();
                    write_buffer_part(buf, socket, socket_receivebuffer_size(socket));

                    // try to enqueue
                    success = _PluginPacketPush(packetID, buf, player);
                    
                    // if it returned false, packetID was invalid
                    if (!success)
                    {
                        // clear up buffer
                        buffer_destroy(buf);

                        // kick player
                        write_ubyte(player.socket, KICK);
                        write_ubyte(player.socket, KICK_BAD_PLUGIN_PACKET);
                        socket_destroy(player.socket);
                        player.socket = -1;
                    }
                    break;
                    
                case CLIENT_SETTINGS:
                    var mirror;
                    mirror = read_ubyte(player.socket);
                    player.queueJump = mirror;
                    
                    write_ubyte(global.sendBuffer, CLIENT_SETTINGS);
                    write_ubyte(global.sendBuffer, playerId);
                    write_ubyte(global.sendBuffer, mirror);
                    break;
                
                }
                break;
            } 
        }
    }
}

if(syncTimer == 1 || ((frame mod 3600)==0) || global.setupTimer == 180 and global.run_virtual_ticks)
{
    serializeState(CAPS_UPDATE, global.sendBuffer);
    syncTimer = 0;
}

if(global.run_virtual_ticks)
{
    if((frame mod 7) == 0)
        serializeState(QUICK_UPDATE, global.sendBuffer);
    else
        serializeState(INPUTSTATE, global.sendBuffer);
}

if(impendingMapChange > 0 and global.run_virtual_ticks)
    impendingMapChange -= 1; // countdown until a map change

if(global.winners != -1 and !global.mapchanging)
{
    if(global.winners == TEAM_RED and global.currentMapArea < global.totalMapAreas)
    {
        global.currentMapArea += 1;
        global.nextMap = global.currentMap;
    }
    else
    {
        global.currentMapArea = 1;
        global.nextMap = nextMapInRotation();
    }
    
    global.mapchanging = true;
    impendingMapChange = 300; // in 300 ticks (ten seconds), we'll do a map change
    
    write_ubyte(global.sendBuffer, MAP_END);
    write_ubyte(global.sendBuffer, string_length(global.nextMap));
    write_string(global.sendBuffer, global.nextMap);
    write_ubyte(global.sendBuffer, global.winners);
    write_ubyte(global.sendBuffer, global.currentMapArea);
    
    if(!instance_exists(ScoreTableController))
        instance_create(0,0,ScoreTableController);
    instance_create(0,0,WinBanner);
}

// if map change timer hits 0, do a map change
if(impendingMapChange == 0)
{
    global.mapchanging = false;
    serverGotoMap(global.nextMap);
    ServerChangeMap(global.currentMap, global.currentMapMD5, global.sendBuffer);
    impendingMapChange = -1;
    
    with(Player)
    {
        if(global.currentMapArea == 1)
        {
            stats[KILLS] = 0;
            stats[DEATHS] = 0;
            stats[CAPS] = 0;
            stats[ASSISTS] = 0;
            stats[DESTRUCTION] = 0;
            stats[STABS] = 0;
            stats[HEALING] = 0;
            stats[DEFENSES] = 0;
            stats[INVULNS] = 0;
            stats[BONUS] = 0;
            stats[DOMINATIONS] = 0;
            stats[REVENGE] = 0;
            stats[POINTS] = 0;
            roundStats[KILLS] = 0;
            roundStats[DEATHS] = 0;
            roundStats[CAPS] = 0;
            roundStats[ASSISTS] = 0;
            roundStats[DESTRUCTION] = 0;
            roundStats[STABS] = 0;
            roundStats[HEALING] = 0;
            roundStats[DEFENSES] = 0;
            roundStats[INVULNS] = 0;
            roundStats[BONUS] = 0;
            roundStats[DOMINATIONS] = 0;
            roundStats[REVENGE] = 0;
            roundStats[POINTS] = 0;
            team = TEAM_SPECTATOR;
        }
        timesChangedCapLimit = 0;
        alarm[5] = 1; // Will spawn in the same step (between Begin Step and Step)
    }
    // message lobby to update map name
    sendLobbyRegistration();
}