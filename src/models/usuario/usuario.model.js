// src/models/usuario.model.js
const pool = require('@config/db');

const Usuario = {
  async findByUsuario(vUsuario) {
    const result = await pool.query(
      'SELECT * FROM "segtblusuario" WHERE "vusuario" = $1',
      [vUsuario]
    );
    return result.rows[0];
  },

  async getPermisos(vUsuario) {
    const result = await pool.query(
      'SELECT * FROM "segusuarioaplicaciones" WHERE "vusuario" = $1',
      [vUsuario]
    );
    return result.rows[0];
  },

  async validateLoginConPermisos(vUsuario, vClave) {
    const result = await pool.query(
      `SELECT 
          u."vusuario",
          u."vnombres",
          u."vapellidos",
          u."vdireccionfoto",
          u."bactivo",
          u."iddoctor",
          p."badministracion",
          p."bodontologia",
          p."bfacturacion",
          p."binventario",
          p."bcontabilidad",
          p."bmarcaciones"
      FROM "segtblusuario" u
      LEFT JOIN "segusuarioaplicaciones" p
        ON u."vusuario" = p."vusuario"
      WHERE u."vusuario" = $1
        AND u."vclave" = $2
        AND u."bactivo" = TRUE`,
      [vUsuario, vClave]
    );

    return result.rows[0];
  },
};

module.exports = Usuario;
