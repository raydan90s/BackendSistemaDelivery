const { getAllDoctores, getDoctorById } = require('@models/doctor/doctor.model');

// GET /doctores
const fetchAllDoctores = async (req, res) => {
  try {
    const doctores = await getAllDoctores();
    res.status(200).json({
      success: true,
      data: doctores,
    });
  } catch (err) {
    console.error('Error fetching doctores:', err);
    res.status(500).json({
      success: false,
      message: 'Error al obtener doctores',
    });
  }
};

// GET /doctores/:id
const getDoctorByIdController = async (req, res) => {
  try {
    const { id } = req.params;
    const doctor = await getDoctorById(id);
    if (!doctor) {
      return res.status(404).json({ success: false, message: 'Doctor no encontrado' });
    }
    res.status(200).json({ success: true, data: doctor.nombreCompleto });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Error al obtener doctor' });
  }
};

module.exports = {
  fetchAllDoctores,
  getDoctorByIdController
};
