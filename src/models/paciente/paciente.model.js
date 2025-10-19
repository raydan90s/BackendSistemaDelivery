const pool = require('@config/db');

// Traer todos los pacientes
const getAllPacientes = async () => {
  const query = `
    SELECT *
    FROM "odontblpacientes"
    ORDER BY "iidpaciente" ASC
  `;
  const { rows } = await pool.query(query);
  return rows;
};

// Obtener paciente por ID
const getPacienteById = async (id) => {
  const query = `
    SELECT 
      "iidpaciente",
      "vnombres",
      "vprimerapellido",
      "vsegundoapellido",
      "votrosapellidos",
      "vcedula"
    FROM "odontblpacientes"
    WHERE "iidpaciente" = $1
  `;
  const { rows } = await pool.query(query, [id]);
  if (!rows[0]) return null;

  const p = rows[0];
  const nombreCompleto = [p.vprimerapellido, p.vsegundoapellido, p.votrosapellidos, p.vnombres]
    .filter(Boolean)
    .join(' ');

  return { 
    iidpaciente: p.iidpaciente, 
    vcedula: p.vcedula, 
    nombreCompleto 
  };
};

// Obtener paciente por cédula
const getPacienteByCedula = async (cedula) => {
  const query = `
    SELECT 
      "iidpaciente",
      "vnombres",
      "vprimerapellido",
      "vsegundoapellido",
      "votrosapellidos",
      "vcedula"
    FROM "odontblpacientes"
    WHERE "vcedula" = $1
  `;
  const { rows } = await pool.query(query, [cedula]);
  if (!rows[0]) return null;

  const p = rows[0];
  const nombreCompleto = [p.vprimerapellido, p.vsegundoapellido, p.votrosapellidos, p.vnombres]
    .filter(Boolean)
    .join(' ');

  return { 
    iidpaciente: p.iidpaciente, 
    vcedula: p.vcedula, 
    nombreCompleto 
  };
};

const getNextIidPaciente = async () => {
  const query = `SELECT MAX("iidpaciente") AS maxId FROM "odontblpacientes"`;
  const { rows } = await pool.query(query);
  const nextId = (rows[0].maxid ?? 0) + 1; // si no hay pacientes empieza en 1
  return nextId;
};

module.exports = {
  getPacienteById,
  getPacienteByCedula,
  getAllPacientes,
  getNextIidPaciente
};
