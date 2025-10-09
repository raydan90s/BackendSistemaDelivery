#!/bin/bash
set -e

# Levanta Postgres en background
docker-entrypoint.sh postgres &

# Espera a que Postgres esté listo
until pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  echo "Esperando a que Postgres esté listo..."
  sleep 2
done

echo "Postgres listo, ejecutando importación de CSVs..."
chmod +x /importar_csv.sh
/importar_csv.sh

# Mantener contenedor corriendo
wait
