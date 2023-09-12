//This script save and load player's data.
const fs = require('fs');
const path = require('path');
const uuidToUsername = {};

const savePlayerData = (username, data) => {
    try {
        delete data["A"]
        delete data["T"]
        const filePath = path.join(__dirname, `./player_data/${username}.json`);
        fs.writeFileSync(filePath, JSON.stringify(data));
    } catch (error){
        console.error("Error: ", error)
    }
};

const loadPlayerData = (username) => {
    const filePath = path.join(__dirname, `./player_data/${username}.json`);
    if (fs.existsSync(filePath)) {
        return JSON.parse(fs.readFileSync(filePath, 'utf-8'));
    }
    return null;
};


module.exports = { savePlayerData, loadPlayerData ,uuidToUsername };
