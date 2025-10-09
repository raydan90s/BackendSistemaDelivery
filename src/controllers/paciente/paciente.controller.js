// src/controllers/paciente.controller.js
const { getAllPacientes } = require('@models/paciente/paciente.model');

// GET /pacientes
const fetchAllPacientes = async (req, res) => {
  try {
    const pacientes = await getAllPacientes();
    res.status(200).json({
      success: true,
      data: pacientes,
    });
  } catch (err) {
    console.error('Error fetching pacientes:', err);
    res.status(500).json({
      success: false,
      message: 'Error al obtener pacientes',
    });
  }
};

module.exports = {
  fetchAllPacientes,
};
