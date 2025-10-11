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
  
// 🔹 Obtener paciente por ID
const getPacienteById = async (id) => {
  const query = `
    SELECT 
      "iidpaciente",
      "vnombre",
      "vapellido",
      "vapellidosecundario",
      "vapellidootros",
      "vci"
    FROM "odontblpaciente"
    WHERE "iidpaciente" = $1
  `;
  const { rows } = await pool.query(query, [id]);
  if (!rows[0]) return null;

  const p = rows[0];
  const nombreCompleto = [p.vapellido, p.vapellidosecundario, p.vapellidootros, p.vnombre]
    .filter(Boolean)
    .join(' ');

  return { iidpaciente: p.iidpaciente, vci: p.vci, nombreCompleto };
};

// 🔹 Obtener paciente por cédula
const getPacienteByCedula = async (vci) => {
  const query = `
    SELECT 
      "iidpaciente",
      "vnombre",
      "vapellido",
      "vapellidosecundario",
      "vapellidootros",
      "vci"
    FROM "odontblpaciente"
    WHERE "vci" = $1
  `;
  const { rows } = await pool.query(query, [vci]);
  if (!rows[0]) return null;

  const p = rows[0];
  const nombreCompleto = [p.vapellido, p.vapellidosecundario, p.vapellidootros, p.vnombre]
    .filter(Boolean)
    .join(' ');

  return { iidpaciente: p.iidpaciente, vci: p.vci, nombreCompleto };
};

module.exports = {
  getPacienteById,
  getPacienteByCedula,
  getAllPacientes
};