// src/routes/usuario/usuario.route.js
const express = require('express');
const router = express.Router();
const { loginUsuario } = require('@controllers/usuario/usuario.controller');

router.post('/', loginUsuario);

module.exports = router;
