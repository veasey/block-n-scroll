#!/bin/bash
set -e

echo "Waiting for MySQL to start..."
until mysqladmin ping -h localhost --silent; do
  sleep 1
done

echo "Creating .my.cnf"
cat > ~/.my.cnf <<EOF
[client]
user=$DB_USER
password=$DB_PASSWORD
EOF
chmod 600 ~/.my.cnf

for sql_file in /docker-entrypoint-initdb.d/sql/seed/*.sql; do
  echo "Importing $sql_file..."
  mysql "$DB_DATABASE" -e "SET FOREIGN_KEY_CHECKS=0; SOURCE $sql_file; SET FOREIGN_KEY_CHECKS=1;"
done

echo "Importing seeds in alphabetical order..."
for sql_file in /docker-entrypoint-initdb.d/sql/seed/*.sql; do
  echo "Importing $sql_file..."
  mysql "$DB_DATABASE" < "$sql_file" -e "SET FOREIGN_KEY_CHECKS=0; SOURCE $sql_file; SET FOREIGN_KEY_CHECKS=1;"
done

echo "Importing default race positions seeds in alphabetical order..."
for sql_file in /docker-entrypoint-initdb.d/sql/seed/players/*/*.sql; do
  echo "Importing $sql_file..."
  mysql "$DB_DATABASE" < "$sql_file" -e "SET FOREIGN_KEY_CHECKS=0; SOURCE $sql_file; SET FOREIGN_KEY_CHECKS=1;"
done

echo "Reseed completed."
