FROM mysql:8.0

COPY docker/init-import.sh /docker-entrypoint-initdb.d/init-import.sh
RUN chmod +x /docker-entrypoint-initdb.d/init-import.sh

# Set the timezone to UK time
ENV TZ=Europe/London
