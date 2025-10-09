// src/models/paciente.model.js
const pool = require('@config/db');

// Función para traer todos los pacientes
const getAllPacientes = async () => {
  const query = `
    SELECT *
    FROM "odontblpaciente"
    ORDER BY iIdPaciente ASC
  `;
  const { rows } = await pool.query(query);
  return rows;
};

module.exports = {
  getAllPacientes,
};
