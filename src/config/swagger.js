const swaggerJsdoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Sistema Delivery API',
      version: '1.0.0',
      description: 'Documentación de las APIs del proyecto Sistema Delivery',
    },
    servers: [
      {
        url: 'http://localhost:3000',
      },
    ],
  },
  apis: ['./src/routes/**/*.route.js'],
};

const specs = swaggerJsdoc(options);

module.exports = { swaggerUi, specs };
