#!/bin/sh

# Usamos DB_ENDPOINT ya que así llamamos a la variable en el entorno
echo "Esperando MySQL en $DB_ENDPOINT:3306..."

# Espera activa comprobando el puerto
until nc -z $DB_ENDPOINT 3306; do
  echo "MySQL no disponible aún..."
  sleep 3
done

echo "MySQL disponible, iniciando backend..."

# Usar 'exec' permite que Docker controle el proceso de Java correctamente
exec java -jar app.jar