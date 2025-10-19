const express = require('express');
const router = express.Router();
const { fetchAllDetallesTratamiento } = require('@controllers/detalleTratamientoPaciente/detalleTratamientoPaciente.controller');

console.log('📡 Rutas de detalleTratamientoPaciente cargadas');

// Traer todos los detalles
router.get('/', fetchAllDetallesTratamiento);

module.exports = router;
