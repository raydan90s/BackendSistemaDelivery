// src/controllers/usuario.controller.js
const Usuario = require('@models/usuario/usuario.model');

// POST /usuario/login
const loginUsuario = async (req, res) => {
  try {
    const { vUsuario, vClave } = req.body;

    // Validamos usuario + contraseña + permisos
    const user = await Usuario.validateLoginConPermisos(vUsuario, vClave);

    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'Usuario o clave incorrectos o inactivo',
      });
    }

    res.status(200).json({
      success: true,
      usuario: {
        vUsuario: user.vUsuario,
        vNombres: user.vNombres,
        vApellidos: user.vApellidos,
        vDireccionFoto: user.vDireccionFoto,
        bActivo: user.bActivo,
        IdDoctor: user.IdDoctor,
      },
      permisos: {
        administracion: user.bAdministracion,
        odontologia: user.bodontologia,
        facturacion: user.bFacturacion,
        inventario: user.binventario,
        contabilidad: user.bContabilidad,
        marcaciones: user.bMarcaciones,
      },
    });
  } catch (error) {
    console.error('Error en loginUsuario:', error);
    res.status(500).json({
      success: false,
      message: 'Error interno del servidor',
    });
  }
};

module.exports = {
  loginUsuario,
};
