//You can add all the actions that clients can request here.
const { loadPlayerData, loadMapData ,loadPlayerInventory } = require('./dataHandler');
const { updatePlayerState } = require('./stateProcessing');
const { uuidToUsername } = require('./dataHandler')

//Here the server will match the uuid with the username, load the player data and send it back so the client can restore.
function readyPlayer(wss, ws, parsed) {
    for (let id in uuidToUsername){
        if (parsed.data.username == uuidToUsername[id]){
            ws.send(JSON.stringify({action:'broadcast', message: 'Already connected...'}));
            ws.close()
            return
        }
    }
    uuidToUsername[ws.playerUUID] = parsed.data.username;
    const data = {userData:loadPlayerData(parsed.data.username)};
    if (data) ws.send(JSON.stringify({action:'broadcast',data:{function:'load_player_state',parameters:data}}));
}

//This function will receive the player's current state, such as position, animation and etc, and it will send to all the other players online via updatePlayerState().
function receivePlayerState(wss, ws, parsed) {
    updatePlayerState(uuidToUsername[ws.playerUUID], parsed.data);
}

//This script you can use to send fast packages between players, without the need of running any backend function. All you need is create the action in the client.
function broadcast(wss, ws, parsed){
    wss.clients.forEach(client => {
        client.send(JSON.stringify({action:'broadcast', data: parsed.data}));
   });
};

module.exports = { readyPlayer, receivePlayerState, broadcast };
