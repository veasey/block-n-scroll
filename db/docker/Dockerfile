FROM mysql:8.0

COPY docker/init-import.sh /docker-entrypoint-initdb.d/init-import.sh
RUN chmod +x /docker-entrypoint-initdb.d/init-import.sh

COPY docker/reseed.sh /usr/local/bin/reseed.sh
RUN chmod +x /usr/local/bin/reseed.sh

# Set the timezone to UK time
ENV TZ=Europe/London
