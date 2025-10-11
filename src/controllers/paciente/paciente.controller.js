// src/controllers/paciente.controller.js
const { getAllPacientes, getPacienteById, getPacienteByCedula } = require('@models/paciente/paciente.model');

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

// GET /pacientes/:id
const getPacienteByIdController = async (req, res) => {
  try {
    const { id } = req.params;
    const paciente = await getPacienteById(id);

    if (!paciente) {
      return res.status(404).json({ success: false, message: 'Paciente no encontrado' });
    }

    res.status(200).json({ success: true, data: paciente });
  } catch (err) {
    console.error('Error fetching paciente by ID:', err);
    res.status(500).json({ success: false, message: 'Error al obtener paciente' });
  }
};

// 🔹 Buscar por Cédula
const obtenerPacientePorCedula = async (req, res) => {
  try {
    const { cedula } = req.params;
    const paciente = await getPacienteByCedula(cedula);
    if (!paciente) return res.status(404).json({ success: false, message: 'Paciente no encontrado' });
    res.json({ success: true, data: paciente });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: 'Error del servidor' });
  }
};

module.exports = {
  fetchAllPacientes,
  getPacienteByIdController,
  obtenerPacientePorCedula
};
