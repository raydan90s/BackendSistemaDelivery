#!/bin/bash

# Ejecuta Postgres en segundo plano
docker-entrypoint.sh postgres &

# Espera unos segundos a que Postgres esté listo
echo "Esperando a que Postgres arranque..."
sleep 10

# Ejecuta la importación de CSV
echo "Ejecutando importar_csv.sh..."
/importar_csv.sh

# Mantiene el contenedor corriendo
wait
