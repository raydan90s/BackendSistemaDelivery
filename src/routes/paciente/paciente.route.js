// src/routes/paciente.routes.js
const express = require('express');
const router = express.Router();
const { fetchAllPacientes } = require('@controllers/paciente/paciente.controller');

// Ruta GET para traer todos los pacientes
router.get('/', fetchAllPacientes);

module.exports = router;
