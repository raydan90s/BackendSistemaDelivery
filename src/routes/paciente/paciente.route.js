// src/routes/paciente.routes.js
const express = require('express');
const router = express.Router();
const { fetchAllPacientes,  getPacienteByIdController, obtenerPacientePorCedula } = require('@controllers/paciente/paciente.controller');
console.log('📡 Rutas de paciente cargadas');

// Ruta GET para traer todos los pacientes
router.get('/', fetchAllPacientes);
router.get('/:id', getPacienteByIdController);
router.get('/cedula/:cedula', obtenerPacientePorCedula);
module.exports = router;
 