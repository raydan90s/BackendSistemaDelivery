const express = require('express');
const cors = require('cors');
const pool = require('./config/db');
const pacienteRoutes = require('@routes/paciente/paciente.route');
const usuarioRoutes  = require('@routes/usuario/usuario.route');
const morgan = require('morgan');
const doctorRoutes   = require('@routes/doctor/doctor.route');
const detalleTratamientoPacienteRoutes = require('@routes/detalleTratamientoPaciente/detalleTratamientoPaciente.routes');


const app = express();
app.use(morgan('dev'));


// ✅ Middleware para permitir peticiones del frontend
app.use(express.json());
app.use(cors({
  origin: ['http://localhost:5173'], 
  methods: ['GET', 'POST', 'PUT', 'DELETE'], 
  credentials: true, 
}));

// 🔹 Ruta de prueba para ver si el backend responde
app.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({ server_time: result.rows[0] });
  } catch (error) {
    console.error('Error consultando la BD:', error);
    res.status(500).json({ message: 'Error al conectar con la base de datos' });
  }
});

app.use('/pacientes', pacienteRoutes);
app.use('/login', usuarioRoutes);
app.use('/doctores', doctorRoutes);
app.use('/detalles', detalleTratamientoPacienteRoutes);
module.exports = app;
