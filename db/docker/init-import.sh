#!/bin/bash
set -e

echo "Waiting for MySQL to start..."
# Wait until mysql is available
until mysqladmin ping -h localhost --silent; do
  sleep 1
done

echo "Importing schema files in alphabetical order..."
for file in /docker-entrypoint-initdb.d/sql/schema/*.sql; do
    echo "Importing $(basename "$file")..."
    mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < "$file"
done

echo "Importing seeds in alphabetical order..."
for sql_file in /docker-entrypoint-initdb.d/sql/seed/*.sql; do
  echo "Importing $sql_file..."
  mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < "$sql_file"
done

echo "Importing default name seeds in alphabetical order..."
for sql_file in /docker-entrypoint-initdb.d/sql/seed/default_names/*.sql; do
  echo "Importing $sql_file..."
  mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < "$sql_file"
done

echo "Importing default race positions seeds in alphabetical order..."
for sql_file in /docker-entrypoint-initdb.d/sql/seed/players/*.sql; do
  echo "Importing $sql_file..."
  mysql -u "$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < "$sql_file"
done

echo "All imports completed."
