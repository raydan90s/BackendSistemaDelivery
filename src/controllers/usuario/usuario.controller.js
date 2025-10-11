const Usuario = require('@models/usuario/usuario.model');
const { generateToken, verifyToken } = require('@utils/jwt.util');

const loginUsuario = async (req, res) => {
  try {
    const { vUsuario, vClave } = req.body;

    const user = await Usuario.validateLoginConPermisos(vUsuario, vClave);

    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'Usuario o clave incorrectos o inactivo',
      });
    }

    // Generar token JWT
    const token = generateToken({
      usuario: {
        vUsuario: user.vUsuario,
        vNombres: user.vNombres,
        vApellidos: user.vApellidos,
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
      token, 
    });
  } catch (error) {
    console.error('Error en loginUsuario:', error);
    res.status(500).json({
      success: false,
      message: 'Error interno del servidor',
    });
  }
};

const tokenUsuario = (req, res) => {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ message: 'No token proporcionado' });

  const token = authHeader.split(' ')[1];
  try {
    const data = verifyToken(token);
    res.json({ usuario: data.usuario, permisos: data.permisos });
  } catch (err) {
    res.status(401).json({ message: 'Token inválido' });
  }
};

module.exports = { loginUsuario, tokenUsuario };
