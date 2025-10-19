#!/bin/bash

# Ejecuta Postgres en segundo plano
docker-entrypoint.sh postgres &

# Espera a que Postgres esté listo
echo "Esperando a que Postgres arranque..."
sleep 10

# Ejecuta la importación de SQL
echo "Importando estructura.sql..."
psql -U Arrobo -d SOAC -f /estructura.sql

echo "Importando datos.sql..."
psql -U Arrobo -d SOAC -f /datos.sql

# Mantiene el contenedor corriendo
wait
