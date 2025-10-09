# 🏥 Backend — Consultorio Arrobo

Este repositorio contiene el **backend del sistema "Consultorio Arrobo"**, encargado de la **gestión de datos del consultorio odontológico**.  
Incluye la configuración de **PostgreSQL en Docker**, scripts de **importación automática de archivos CSV** y la estructura base para desarrollar las **API REST** que se conectarán con el frontend.

---

## ⚙️ Tecnologías utilizadas

- 🐘 **PostgreSQL 18**
- 🐳 **Docker & Docker Compose**
- 💻 **Bash Scripts** para inicialización e importación
- 🧩 **Estructura base para APIs (Node.js / Python)**
- 📁 **CSV Data Loader** (automatizado)


## 🚀 Puesta en marcha (desde cero)

Sigue estos pasos para levantar todo el entorno del backend:

```bash
# 1️⃣ Entra en la carpeta docker
cd docker

# 2️⃣ Construye e inicia los contenedores
docker-compose up --build -d

# 3️⃣ Observa el progreso de inicialización
docker logs -f soacDB
