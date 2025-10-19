const express = require('express');
const router = express.Router();
const { fetchAllDoctores, getDoctorByIdController } = require('@controllers/doctor/doctor.controller');

// Ruta GET para traer todos los doctores
router.get('/', fetchAllDoctores);

// Ruta GET para traer doctor por ID
router.get('/:id', getDoctorByIdController);

module.exports = router;
