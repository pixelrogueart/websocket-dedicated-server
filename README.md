# Multiplayer Game Godot 4.1

## Table Of Contents
- [About](#about)
- [Installation](#installation)
- [Projects](#projects)
  - [Documentation](#documentation)
  - [Database](#database)
  - [Websocket Server](#websocket-server)
  - [Client](#client)
  - [Website](#website)
  - [Docker](#docker)
- [Contributing](#contributing)

## About
A base for MMO games using Godot 4.1. It includes a database, websocket server, dockerfiles for easy and fast deployment, website for account confirmation and documentation. Although it runs in Godot 4.1, I'm almost 100% sure that it can run with other engines.

To run this project you will need:
  - Node.js
  - Git Bash
  - Docker

## Installation
```bash
git clone https://github.com/pixelrogueart/websocket-dedicated-server.git
cd websocket-dedicated-server
```

## Projects
### Documentation
**Description**: Swagger application for the database & AsyncAPI for the websocket server.

**Usage**:
- To install all libraries run the following command:
```bash
npm install
```
- To run the database documentation locally simply run the command below.
```bash
node database-swagger
```
- For AsyncAPI, copy what's inside of the file asyncapi-server-documentation.yml and paste [HERE](https://studio.asyncapi.com).


### Database
**Description**: Database to login, register and code confirmation.

**Usage**:
- To install all libraries run the following command:
```bash
npm install
```
- To run the database, you'll need:
    - MongoDB Account
    - MongoDB URI, which should be something like this: mongodb+srv://username:password@server.wfidclc.mongodb.net/collectionName;
    - SMTP Service (I recommend Hostinger)
- After your MongoDB and SMTP Service is setup, change the .env variables accordingly.
- To run the database locally, simply run the command below: By default the port is 8080, you can change the variable PORT inside server.js. You need to change to 8081 or any other port to avoid conflict with the websocket server.
```bash
node db
```

### Websocket Server
**Description**: Server to allow communication between peers. It also keeps stored player's last position.


**Usage**:
- To install all libraries run the following command:
```bash
npm install
```
- To run the server locally, simply run the command below. By default the port is 8080, you can change the variable PORT inside server.js.
```bash
node server
```

### Client
**Description**: Godot 4.1 Project to connect with the database & server. [Live Preview](https://pixelrogueart.com/mmo-example)

**Usage**:
- Run the project.godot inside the client folder. 
- In Database.gd, change the variable dbURL to the database URL. If you're running locally, it will be: http://localhost:8080 or another port if you changed.
- In ServerHeader.gd, change the variable _server_url to the Websocket URL. If you're running locally, it will be: http://localhost:8080 or another port if you changed.

### Website
**Description**: Website to allow the user to activate its account to be able to play. [Live Preview](https://pixelrogueart.com/confirm)

**Usage**:
- To install all libraries run the following command:
```bash
npm install
```
- To run the website locally, run the command below. The URL will be http://localhost:3000.
```bash
npm run dev
```

### Docker
**Description**: The docker folder contains a file named 'deploy.sh', which will allow you to easily deploy the database and websocket server into your Google Cloud Run.

**Usage**:
- To run the file you will need: 
    - Git Bash Installed
    - Google Cloud account logged in your local machine
- Then open the GitBash in the docker folder, by right clicking and selecting 'Open Git Bash Here'.
- Run the command below.
```bash
./deploy.sh <GCLOUD_PROJECT_ID> <YOUR_REGION> <DATABASE_PROJECT_NAME> <SERVER_PROJECT_NAME>
```

## Contributing
Thanks for being here! You're welcome to fork and adapt this project however you wish as long as it's nothing NSFW! If you have any feedback, feel free to join my [discord](https://discord.gg/Q9VMwds4tX)!

