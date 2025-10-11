const express = require('express');
const cors = require('cors');
const pool = require('./config/db');
const pacienteRoutes = require('@routes/paciente/paciente.route');
const usuarioRoutes  = require('@routes/usuario/usuario.route');

const app = express();
app.use(express.json());
app.use(cors({
  origin: ['http://localhost:5173'], 
  methods: ['GET', 'POST', 'PUT', 'DELETE'], 
  credentials: true, 
}));

app.get('/', async (req, res) => {
  const result = await pool.query('SELECT NOW()');
  res.json({ server_time: result.rows[0] });
});

app.use('/pacientes', pacienteRoutes);
app.use('/login', usuarioRoutes);

module.exports = app;
