const pool = require('@config/db');

const getAllDetallesTratamiento = async () => {
  const query = `
    SELECT *
    FROM "odontbldetalletratamientopaciente"
    ORDER BY "iiddetalle" ASC
  `;
  const { rows } = await pool.query(query);
  return rows;
};

module.exports = { getAllDetallesTratamiento };
