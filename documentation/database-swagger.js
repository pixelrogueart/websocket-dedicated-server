const swaggerUi = require('swagger-ui-express');
const express = require('express');
const swaggerJsdoc = require('swagger-jsdoc');
const app = express();

const options = {
  swaggerDefinition: {
    openapi: "3.0.0",
    info: {
      title: "Database API",
      version: "1.0.0",
      description: "This API connects to your database and allows account creation, confirmation and login.",
    },
    servers: [
      {
        url: "http://localhost:8080/",
        description:"Websocket Server"
      },
      {
        url: "http://localhost:8081/",
        description:"Database Connection API"
      },
      {
        url: "http://localhost:3000/",
        description:"Account Confirmation"
      },
    ],
  },
  apis: ["./routes/*.js"],
};

const specs = swaggerJsdoc(options);
const PORT = '8081'
app.use("/server-docs", swaggerUi.serve, swaggerUi.setup(specs));
app.listen(PORT,'0.0.0.0', () => {
  console.log(`Database documentation is running on http://localhost:${PORT}/server-docs`);
});