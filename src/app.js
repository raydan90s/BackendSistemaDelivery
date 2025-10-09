const express = require('express');
const pool = require('./config/db');
const pacienteRoutes = require('@routes/paciente/paciente.route');

const app = express();
app.use(express.json());

app.get('/', async (req, res) => {
  const result = await pool.query('SELECT NOW()');
  res.json({ server_time: result.rows[0] });
});

app.use('/pacientes', pacienteRoutes);

module.exports = app;
