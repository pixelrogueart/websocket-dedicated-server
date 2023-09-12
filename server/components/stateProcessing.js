//This script defines the state of the server and keeps all users updated, here you'll store which players are online, their position and whatever you want more.
let worldState = {};
let playerStateCollection = {};

//Whenever the player sends their data, it stores in the matching state collection.
const updatePlayerState = (playerId, playerState) => {
    if (playerStateCollection[playerId]) {
        playerStateCollection[playerId] = playerState;
    } else {
        playerStateCollection[playerId] = playerState;
    }
};

//Broadcast the current world state to all the peers.
function broadcastWorldState(wss){ 
    wss.clients.forEach(client => {
             client.send(JSON.stringify({action:'receive_world_state', data: worldState}));
        });
    };

//This is where all the checks go before broadcasting the world state to all peers.
function stateProcess(wss){
    if (Object.keys(playerStateCollection).length > 0) {
        worldState = playerStateCollection
        for (let playerId in worldState) {
            delete worldState[playerId].T
        }
        worldState.T = Date.now();
		//Verifications
		//Anti-Cheat
		//Cuts
		//Physics checks
		//Anything we might need
        broadcastWorldState(wss)
}};

module.exports = { updatePlayerState, stateProcess, playerStateCollection };
