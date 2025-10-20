# 🍔 Backend — Sistema Delivery y Restaurante

Este repositorio contiene el **backend del sistema "Delivery y Restaurante"**, encargado de la **gestión de productos, clientes, pedidos, inventario, facturación y usuarios**.  
Permite gestionar toda la información necesaria para el funcionamiento del restaurante y el servicio de delivery, proporcionando **API REST** que se conectan con el frontend y la aplicación móvil.

---

## ⚙️ Tecnologías utilizadas

- 🐬 **MySQL** como sistema de base de datos relacional  
- 💻 **Node.js / Express** (o el framework de tu elección) para la creación de APIs REST  
- 🧩 Estructura modular para manejar **módulos de productos, clientes, pedidos, inventario, facturación y usuarios**  

---


## 🚀 Puesta en marcha (desde cero)

Sigue estos pasos para levantar el entorno del backend:

```bash
# 1️⃣ Instala dependencias
npm install

# 2️⃣ Configura la conexión a MySQL
# Edita el archivo config/db.js con tu host, usuario, contraseña y base de datos

# 3️⃣ Crea la base de datos y tablas (si aún no existen)
# Puedes usar los scripts SQL disponibles en la carpeta `db`

# 4️⃣ Inicia el servidor
cd src
node server.js

# 5️⃣ El backend estará corriendo en:
http://localhost:3000
