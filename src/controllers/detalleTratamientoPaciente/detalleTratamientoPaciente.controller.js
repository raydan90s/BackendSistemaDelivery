const { getAllDetallesTratamiento } = require('@models/detalleTratamientoPaciente/detalleTratamientoPaciente.model');

const fetchAllDetallesTratamiento = async (req, res) => {
  try {
    const detalles = await getAllDetallesTratamiento();
    res.status(200).json({ success: true, data: detalles });
  } catch (err) {
    console.error('Error fetching detalles de tratamiento:', err);
    res.status(500).json({ success: false, message: 'Error al obtener detalles de tratamiento' });
  }
};

module.exports = { fetchAllDetallesTratamiento };
