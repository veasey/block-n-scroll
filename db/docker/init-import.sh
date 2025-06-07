#!/bin/bash
set -e

echo "Waiting for MySQL to start..."
# Wait until mysql is available
until mysqladmin ping -h localhost --silent; do
  sleep 1
done

echo "Importing SQL files..."

echo "Importing core schema..."
mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /docker-entrypoint-initdb.d/sql/schema/01_core.sql

echo "Importing name schema..."
mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /docker-entrypoint-initdb.d/sql/schema/06_names.sql


for sql_file in /docker-entrypoint-initdb.d/sql/seed/default_names/*.sql; do
  echo "Importing $sql_file..."
  mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < "$sql_file"
done

echo "All imports completed."
