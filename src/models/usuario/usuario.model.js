const pool = require('@config/db');

const Usuario = {
  async findByUsuario(vUsuario) {
    const result = await pool.query(
      'SELECT * FROM "segtblusuarios" WHERE "vusuario" = $1',
      [vUsuario]
    );
    return result.rows[0];
  },

  async getPermisosConDetalle(vUsuario) {
    const result = await pool.query(
      `SELECT 
         m."iidmodulo",
         m."vcodigo",
         m."vnombre",
         m."vdescripcion",
         p."blectura",
         p."bescritura",
         p."beliminacion",
         p."badministracion"
       FROM "segtblmodulos" m
       LEFT JOIN "segtblpermisosusuario" p
         ON m."iidmodulo" = p."iidmodulo" AND p."vusuario" = $1
       ORDER BY m."iidmodulo"`,
      [vUsuario]
    );
    return result.rows;
  },

  async setPermisos(vUsuario, permisos) {
    const client = await pool.connect();
    try {
      await client.query('BEGIN');

      for (const p of permisos) {
        await client.query(
          `INSERT INTO "segtblpermisosusuario" 
            ("vusuario", "iidmodulo", "blectura", "bescritura", "beliminacion", "badministracion")
           VALUES ($1, $2, $3, $4, $5, $6)
           ON CONFLICT ("vusuario", "iidmodulo") 
           DO UPDATE SET 
             "blectura" = EXCLUDED."blectura",
             "bescritura" = EXCLUDED."bescritura",
             "beliminacion" = EXCLUDED."beliminacion",
             "badministracion" = EXCLUDED."badministracion",
             "dfechaasignacion" = CURRENT_TIMESTAMP`,
          [vUsuario, p.iidmodulo, p.blectura, p.bescritura, p.beliminacion, p.badministracion]
        );
      }

      await client.query('COMMIT');
      return true;
    } catch (error) {
      await client.query('ROLLBACK');
      throw error;
    } finally {
      client.release();
    }
  },

  async validateLoginConPermisos(vUsuario, vClave) {
    const userResult = await pool.query(
      'SELECT * FROM "segtblusuarios" WHERE "vusuario" = $1 AND "vclave" = $2 AND "bactivo" = TRUE',
      [vUsuario, vClave]
    );
    const user = userResult.rows[0];
    if (!user) return null;

    const permisos = await this.getPermisosConDetalle(vUsuario);
    return { ...user, permisos };
  }
};

module.exports = Usuario;
