const pool = require('@config/db');

// Obtener todos los detalles
const getAllDetalleTratamientos = async () => {
  const query = `
    SELECT *
    FROM "odontbldetalletratamientopaciente"
    ORDER BY iiddetalle ASC
  `;
  const { rows } = await pool.query(query);
  return rows;
};

// Obtener detalles por paciente
const getDetallePorPaciente = async (idpaciente) => {
  const query = `
    SELECT *
    FROM "odontbldetalletratamientopaciente"
    WHERE idpaciente = $1
    ORDER BY dfecha DESC
  `;
  const { rows } = await pool.query(query, [idpaciente]);
  return rows;
};

// Agregar nuevo detalle de tratamiento
const createDetalleTratamiento = async (detalle) => {
  const query = `
    INSERT INTO "odontbldetalletratamientopaciente"
    (idpaciente, iidespecialidad, sitratamiento, iidtratamientodetalle, dvalor, ddescuento, dvalorfinal, iiddoctor, iidconsultorio, vpieza, vdatopieza, vobservacion, vusuario)
    VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13)
    RETURNING *
  `;
  const values = [
    detalle.idpaciente,
    detalle.iidespecialidad,
    detalle.sitratamiento,
    detalle.iidtratamientodetalle,
    detalle.dvalor,
    detalle.ddescuento || 0,
    detalle.dvalorfinal,
    detalle.iiddoctor,
    detalle.iidconsultorio,
    detalle.vpieza || null,
    detalle.vdatopieza || null,
    detalle.vobservacion || null,
    detalle.vusuario
  ];

  const { rows } = await pool.query(query, values);
  return rows[0];
};

module.exports = {
  getAllDetalleTratamientos,
  getDetallePorPaciente,
  createDetalleTratamiento
};
