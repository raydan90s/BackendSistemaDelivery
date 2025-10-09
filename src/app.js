const express = require('express');
const pool = require('./config/db');

const app = express();
app.use(express.json());

app.get('/', async (req, res) => {
  const result = await pool.query('SELECT NOW()');
  res.json({ server_time: result.rows[0] });
});

module.exports = app;
