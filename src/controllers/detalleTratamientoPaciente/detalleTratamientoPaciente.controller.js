const { getAllDetalleTratamientos, getDetallePorPaciente, createDetalleTratamiento } = require('@models/detalleTratamientoPaciente/detalleTratamientoPaciente.model');

// GET /detalle-tratamientos
const fetchAllDetalleTratamientos = async (req, res) => {
  try {
    const detalles = await getAllDetalleTratamientos();
    res.status(200).json({ success: true, data: detalles });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Error al obtener detalles' });
  }
};

// GET /detalle-tratamientos/paciente/:id
const fetchDetallePorPaciente = async (req, res) => {
  try {
    const { id } = req.params;
    const detalles = await getDetallePorPaciente(id);
    res.status(200).json({ success: true, data: detalles });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Error al obtener detalles del paciente' });
  }
};

// POST /detalle-tratamientos
const addDetalleTratamiento = async (req, res) => {
  try {
    const detalle = req.body;
    const nuevoDetalle = await createDetalleTratamiento(detalle);
    res.status(201).json({ success: true, data: nuevoDetalle });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Error al crear detalle de tratamiento' });
  }
};

module.exports = {
  fetchAllDetalleTratamientos,
  fetchDetallePorPaciente,
  addDetalleTratamiento
};
