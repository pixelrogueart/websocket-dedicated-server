//This is the main script for the server.
const express = require('express');
const WebSocket = require('ws');
const { v4: uuidv4 } = require('uuid'); 

const { savePlayerData, uuidToUsername } = require('./components/dataHandler');
const { stateProcess, playerStateCollection } = require('./components/stateProcessing');
const { readyPlayer, broadcast, receivePlayerState } = require('./components/serverActions');

const app = express();

//Start server
const PORT = '8080'
const server = app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server started on port ${PORT}`);
});

const wss = new WebSocket.Server({ server });
const clients = {};

//Anything the user can call via client, should be added in the actionHandlers const below.
const actionHandlers = {
    'readyPlayer': (wss, ws, parsed) => readyPlayer(wss, ws, parsed),
    'receivePlayerState': (wss, ws, parsed) => receivePlayerState(wss, ws, parsed),
    'broadcast': (wss, ws, parsed) => broadcast(wss, ws, parsed),
};

wss.on('connection', (ws, req) => {
    ws.playerUUID = uuidv4();  //Attach UUID directly to the websocket connection.
    clients[ws.playerUUID] = ws;  
    ws.send(JSON.stringify({ action: 'assignUUID', uuid: ws.playerUUID }));

    ws.on('message', (message) => {
        //All the messages received should be in this format: {action:actionHandler, data:data}.
        const parsed = JSON.parse(message);
        const actionHandler = actionHandlers[parsed.action];
        if (actionHandler) {
            actionHandler(wss, ws, parsed);
        } else {
            ws.send(JSON.stringify({ status: 'error', message: 'Invalid action' }));
        }
    });

    //Whenever the user closes the connection, it saves its state collection, broadcast to all other players that the player left and delete its state collection and uuid.
    ws.on('close', () => {
        if (uuidToUsername[ws.playerUUID]) {
            savePlayerData(uuidToUsername[ws.playerUUID], playerStateCollection[uuidToUsername[ws.playerUUID]]);
            broadcast(wss,ws, {data:{function:'despawn_player', parameters:{username:uuidToUsername[ws.playerUUID]}}})
            delete playerStateCollection[uuidToUsername[ws.playerUUID]]
            delete uuidToUsername[ws.playerUUID];
        }
        delete clients[ws.playerUUID];  
    });
});

setInterval(() => {
    stateProcess(wss); //Here you'll run the server state processing, which will keep the game synched.
    //You can run anything else below.

}, 1);

