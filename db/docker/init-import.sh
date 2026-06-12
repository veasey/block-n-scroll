#!/bin/bash
set -e

echo "Waiting for MySQL to start..."
# Wait until mysql is available
until mysqladmin ping -h localhost --silent; do
  sleep 1
done

MYCNF=/tmp/.my.cnf

echo "Creating .my.cnf"
cat > "$MYCNF" <<EOF
[client]
user=${MYSQL_USER:-$DB_USERNAME}
password=${MYSQL_PASSWORD:-$DB_PASSWORD}
EOF
chmod 600 "$MYCNF"

echo "Importing schema files in alphabetical order..."
for file in /docker-entrypoint-initdb.d/sql/schema/*.sql; do
    echo "Importing $(basename "$file")..."
    mysql --defaults-extra-file="$MYCNF" "${MYSQL_DATABASE:-$DB_DATABASE}" < "$file"
done

echo "Importing seeds in alphabetical order..."
for sql_file in /docker-entrypoint-initdb.d/sql/seed/*.sql; do
  echo "Importing $sql_file..."
  mysql --defaults-extra-file="$MYCNF" "${MYSQL_DATABASE:-$DB_DATABASE}" < "$sql_file"
done

echo "Importing default race positions seeds in alphabetical order..."
for sql_file in /docker-entrypoint-initdb.d/sql/seed/players/*/*.sql; do
  echo "Importing $sql_file..."
  mysql --defaults-extra-file="$MYCNF" "${MYSQL_DATABASE:-$DB_DATABASE}" < "$sql_file"
done

echo "Importing default name seeds in alphabetical order..."
for sql_file in /docker-entrypoint-initdb.d/sql/seed/default_names/*.sql; do
  echo "Importing $sql_file..."
  mysql --defaults-extra-file="$MYCNF" "${MYSQL_DATABASE:-$DB_DATABASE}" < "$sql_file"
done

# Ensure root has the expected password so the entrypoint can shut down the temporary server
if [ -n "${MYSQL_ROOT_PASSWORD:-}" ]; then
  echo "Setting root password..."
  mysql --user=root --protocol=socket --socket=/var/run/mysqld/mysqld.sock -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;" || true
fi

echo "All imports completed."
