const express = require('express');
const router = express.Router();
const { fetchAllDetalleTratamientos, fetchDetallePorPaciente, addDetalleTratamiento } = require('@controllers/detalleTratamientoPaciente/detalleTratamientoPaciente.controller');

console.log('📡 Rutas de detalleTratamientoPaciente cargadas');

router.get('/', fetchAllDetalleTratamientos);
router.get('/paciente/:id', fetchDetallePorPaciente);
router.post('/', addDetalleTratamiento);

module.exports = router;
