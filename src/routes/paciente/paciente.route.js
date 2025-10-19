// src/routes/paciente.routes.js
const express = require('express');
const router = express.Router();
const { fetchAllPacientes,  getPacienteByIdController, obtenerPacientePorCedula, obtenerSiguienteFicha } = require('@controllers/paciente/paciente.controller');

// Ruta GET para traer todos los pacientes
router.get('/', fetchAllPacientes);
router.get('/next-ficha', obtenerSiguienteFicha);
router.get('/:id', getPacienteByIdController);
router.get('/cedula/:cedula', obtenerPacientePorCedula);

module.exports = router;
 