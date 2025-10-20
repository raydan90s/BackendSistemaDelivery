const mysql = require('mysql2/promise');
require('dotenv').config({ path: '../.env' });

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT || 3306,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Verificar la conexión
pool.getConnection()
  .then(connection => {
    console.log('✅ Conexión a MySQL exitosa');
    connection.release();
  })
  .catch(err => {
    console.error('❌ Error al conectar a MySQL', err.stack);
  });

module.exports = pool;