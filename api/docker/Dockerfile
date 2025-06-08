# Use an official PHP image with Apache
FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && \
    apt-get install -y git unzip libzip-dev python3 python3-pip && \
    docker-php-ext-install zip pdo pdo_mysql

# Enable Apache mod_rewrite if needed
RUN a2enmod rewrite

# Install Composer globally
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy PHP source code
COPY . /var/www/html

# Set Apache DocumentRoot to /var/www/html/public
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Install PHP dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# (Optional) Install Python dependencies if needed
# COPY requirements.txt .
# RUN pip3 install --no-cache-dir -r requirements.txt

# Set the default command (adjust if you use a framework or different entrypoint)
CMD ["apache2-foreground"]