#!/bin/sh
set -e

echo "Waiting for MySQL to start..."
# Wait until mysql is available
until mysqladmin ping -h localhost --silent; do
  sleep 1
done

echo "Importing SQL files..."

mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /docker-entrypoint-initdb.d/schema/01_core.sql
mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /docker-entrypoint-initdb.d/seed/injuries.sql
mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /docker-entrypoint-initdb.d/seed/default_names.sql

echo "All imports completed."
