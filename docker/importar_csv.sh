cat > importar_csv.sh << 'EOF'
#!/bin/bash

DB_NAME="SOAC"
DB_USER="Arrobo"
CSV_DIR="/csv/"
LOG_FILE="/tmp/import_log.txt"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "==================================================" | tee "$LOG_FILE"
echo "Importación de CSVs - $(date)" | tee -a "$LOG_FILE"
echo "==================================================" | tee -a "$LOG_FILE"

# Verifica que el directorio existe
if [ ! -d "$CSV_DIR" ]; then
    echo "ERROR: Directorio $CSV_DIR no existe" | tee -a "$LOG_FILE"
    exit 1
fi

# Cuenta archivos CSV
num_csvs=$(find "$CSV_DIR" -maxdepth 1 -name "*.csv" -type f | wc -l)
echo "Archivos CSV encontrados: $num_csvs" | tee -a "$LOG_FILE"

if [ $num_csvs -eq 0 ]; then
    echo "ERROR: No se encontraron archivos CSV en $CSV_DIR" | tee -a "$LOG_FILE"
    exit 1
fi

total=0
exitosos=0
errores=0
omitidos=0

# Lee cada archivo CSV
find "$CSV_DIR" -maxdepth 1 -name "*.csv" -type f | sort | while read csv; do
    ((total++))
    
    # Obtiene el nombre sin extensión
    base=$(basename "$csv")
    tabla_original="${base%.csv}"
    
    echo "" | tee -a "$LOG_FILE"
    echo "======================================" | tee -a "$LOG_FILE"
    echo -e "${BLUE}[$total] Archivo: $base${NC}" | tee -a "$LOG_FILE"
    
    # Intenta primero con el nombre original
    tabla_existe=$(psql -U "$DB_USER" -d "$DB_NAME" -tAc "SELECT to_regclass('\"$tabla_original\"');")
    
    if [ "$tabla_existe" = "" ] || [ "$tabla_existe" = "NULL" ]; then
        # Si no existe, intenta con minúsculas
        tabla_lower=$(echo "$tabla_original" | tr '[:upper:]' '[:lower:]')
        tabla_existe=$(psql -U "$DB_USER" -d "$DB_NAME" -tAc "SELECT to_regclass('$tabla_lower');")
        
        if [ "$tabla_existe" = "" ] || [ "$tabla_existe" = "NULL" ]; then
            echo -e "${YELLOW}⚠ Tabla no existe (intentó: $tabla_original y $tabla_lower)${NC}" | tee -a "$LOG_FILE"
            ((omitidos++))
            continue
        else
            tabla="$tabla_lower"
            echo "  → Tabla encontrada: $tabla (minúsculas)" | tee -a "$LOG_FILE"
        fi
    else
        tabla="$tabla_original"
        echo "  → Tabla encontrada: $tabla (original)" | tee -a "$LOG_FILE"
    fi
    
    # Cuenta filas antes
    filas_antes=$(psql -U "$DB_USER" -d "$DB_NAME" -tAc "SELECT COUNT(*) FROM \"$tabla\";")
    echo "  Filas actuales: $filas_antes" | tee -a "$LOG_FILE"
    
    # Procesa el CSV con Python
    tmp_csv="/tmp/${tabla}_tmp.csv"
    
    python3 - "$csv" "$tmp_csv" "$tabla" "$DB_USER" "$DB_NAME" <<'PYTHONSCRIPT'
import csv
import sys
import re
import subprocess
from datetime import datetime

input_file = sys.argv[1]
output_file = sys.argv[2]
tabla = sys.argv[3]
db_user = sys.argv[4]
db_name = sys.argv[5]

def get_column_types():
    cmd = f"psql -U {db_user} -d {db_name} -tAc \"SELECT column_name, data_type FROM information_schema.columns WHERE table_name='{tabla}' ORDER BY ordinal_position;\""
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    types = {}
    for line in result.stdout.strip().split('\n'):
        if '|' in line:
            col, dtype = line.split('|')
            types[col.strip()] = dtype.strip()
    return types

def fix_timestamp(value):
    if not value or value in ('', 'NULL', '\\N'):
        return '\\N'
    
    patterns = [
        r'^\d{1,2}:\d{1,2}\.\d+$',
        r'^\d{1,2}:\d{1,2}:\d{1,2}\s*[AP]M$',
        r'^\d{1,2}:\d{1,2}$',
        r'^\d{1,2}/\d{1,2}/\d{2}$',
    ]
    
    for pattern in patterns:
        if re.match(pattern, value, re.IGNORECASE):
            return '\\N'
    
    try:
        for fmt in ['%Y-%m-%d %H:%M:%S', '%Y-%m-%d', '%d/%m/%Y', '%m/%d/%Y']:
            try:
                datetime.strptime(value, fmt)
                return value
            except:
                continue
        return '\\N'
    except:
        return '\\N'

column_types = get_column_types()

with open(input_file, 'r', encoding='utf-8-sig', errors='ignore') as infile, \
     open(output_file, 'w', encoding='utf-8', newline='') as outfile:
    
    reader = csv.reader(infile)
    writer = csv.writer(outfile, lineterminator='\n')
    
    headers = None
    for i, row in enumerate(reader):
        if i == 0:
            headers = [h.strip() for h in row]
            writer.writerow(headers)
        else:
            cleaned_row = []
            for j, field in enumerate(row):
                field = field.strip().replace('\r', '').replace('\n', ' ')
                
                if j < len(headers):
                    col_name = headers[j]
                    col_type = column_types.get(col_name, '').lower()
                    
                    if 'timestamp' in col_type or 'date' in col_type:
                        field = fix_timestamp(field)
                    elif field in ('', 'NULL', '\\N'):
                        field = '\\N'
                else:
                    if field in ('', 'NULL', '\\N'):
                        field = '\\N'
                
                cleaned_row.append(field)
            writer.writerow(cleaned_row)
PYTHONSCRIPT
    
    if [ ! -f "$tmp_csv" ]; then
        echo -e "${RED}❌ Error: No se generó el archivo temporal${NC}" | tee -a "$LOG_FILE"
        ((errores++))
        continue
    fi
    
    # Importa usando \COPY
    resultado=$(psql -U "$DB_USER" -d "$DB_NAME" -c "\\COPY \"$tabla\" FROM '$tmp_csv' CSV HEADER NULL '\\N'" 2>&1)
    
    if [ $? -eq 0 ]; then
        filas_despues=$(psql -U "$DB_USER" -d "$DB_NAME" -tAc "SELECT COUNT(*) FROM \"$tabla\";")
        filas_nuevas=$((filas_despues - filas_antes))
        
        if [ $filas_nuevas -gt 0 ]; then
            echo -e "${GREEN}✔ Importadas: +$filas_nuevas filas (Total: $filas_despues)${NC}" | tee -a "$LOG_FILE"
            ((exitosos++))
        elif [ $filas_despues -gt 0 ]; then
            echo -e "${GREEN}✔ Sin cambios (Total: $filas_despues)${NC}" | tee -a "$LOG_FILE"
            ((exitosos++))
        else
            echo -e "${YELLOW}⚠ Tabla vacía después de importar${NC}" | tee -a "$LOG_FILE"
            ((exitosos++))
        fi
    else
        echo -e "${RED}❌ Error en importación${NC}" | tee -a "$LOG_FILE"
        echo "$resultado" | grep -i "error" | head -5 | tee -a "$LOG_FILE"
        
        echo "  Intentando método alternativo..." | tee -a "$LOG_FILE"
        
        psql -U "$DB_USER" -d "$DB_NAME" <<-EOSQL 2>&1 | tee -a "$LOG_FILE"
		CREATE TEMP TABLE temp_${tabla} (LIKE "$tabla");
		\\COPY temp_${tabla} FROM '$tmp_csv' CSV HEADER NULL '\\N';
		INSERT INTO "$tabla" SELECT * FROM temp_${tabla} ON CONFLICT DO NOTHING;
		DROP TABLE temp_${tabla};
EOSQL
        
        if [ $? -eq 0 ]; then
            filas_despues=$(psql -U "$DB_USER" -d "$DB_NAME" -tAc "SELECT COUNT(*) FROM \"$tabla\";")
            filas_nuevas=$((filas_despues - filas_antes))
            echo -e "${YELLOW}⚠ Importación parcial: +$filas_nuevas filas${NC}" | tee -a "$LOG_FILE"
            ((exitosos++))
        else
            echo -e "${RED}❌ Fallo total en $tabla${NC}" | tee -a "$LOG_FILE"
            ((errores++))
        fi
    fi
    
    rm -f "$tmp_csv"
done

echo "" | tee -a "$LOG_FILE"
echo "==================================================" | tee -a "$LOG_FILE"
echo "RESUMEN FINAL" | tee -a "$LOG_FILE"
echo "==================================================" | tee -a "$LOG_FILE"
echo "Total procesados: $total" | tee -a "$LOG_FILE"
echo -e "${GREEN}Exitosos: $exitosos${NC}" | tee -a "$LOG_FILE"
echo -e "${RED}Errores: $errores${NC}" | tee -a "$LOG_FILE"
echo -e "${YELLOW}Omitidos: $omitidos${NC}" | tee -a "$LOG_FILE"
echo "==================================================" | tee -a "$LOG_FILE"

echo "" | tee -a "$LOG_FILE"
echo "Tablas que siguen vacías:" | tee -a "$LOG_FILE"
psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT relname as tabla, n_live_tup as filas FROM pg_stat_user_tables WHERE n_live_tup = 0 ORDER BY relname;" | tee -a "$LOG_FILE"

echo ""
echo "Log completo guardado en: $LOG_FILE"
EOF

chmod +x importar_csv.sh