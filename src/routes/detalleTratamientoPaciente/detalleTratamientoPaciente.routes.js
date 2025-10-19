const express = require('express');
const router = express.Router();
const { fetchAllDetalleTratamientos, fetchDetallePorPaciente, addDetalleTratamiento } = require('@controllers/detalleTratamientoPaciente/detalleTratamientoPaciente.controller');

router.get('/', fetchAllDetalleTratamientos);
router.get('/paciente/:id', fetchDetallePorPaciente);
router.post('/', addDetalleTratamiento);

module.exports = router;
