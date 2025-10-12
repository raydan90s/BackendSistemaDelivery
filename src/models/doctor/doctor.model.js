const pool = require('@config/db');

// 🔹 Traer todos los doctores
const getAllDoctores = async () => {
  const query = `
    SELECT *
    FROM "odontbldoctor"
    ORDER BY "iiddoctor" ASC
  `;
  const { rows } = await pool.query(query);

  // Generar nombre completo para cada doctor
  const doctores = rows.map(d => ({
    ...d,
    nombreCompleto: [d.vnombre, d.vapellido].filter(Boolean).join(' ')
  }));

  return doctores;
};

// 🔹 Obtener doctor por ID
const getDoctorById = async (id) => {
  const query = `
    SELECT
      "iiddoctor",
      "vnombre",
      "vapellido",
      "iidcargo",
      "btemporal",
      "cestado"
    FROM "odontbldoctor"
    WHERE "iiddoctor" = $1
  `;
  const { rows } = await pool.query(query, [id]);

  if (!rows[0]) return null;

  const doctor = rows[0];
  doctor.nombreCompleto = [doctor.vnombre, doctor.vapellido].filter(Boolean).join(' ');

  return doctor;
};

module.exports = {
  getAllDoctores,
  getDoctorById
};
