FROM php:8.2-apache

# Set the working directory to /app
WORKDIR /app

# Install OS-level dependencies needed for PHP extensions and envsubst
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libcurl4-openssl-dev \
    libzip-dev \
    libxml2-dev \
    libonig-dev \
    gettext \
    iputils-ping \
 && rm -rf /var/lib/apt/lists/*

# Configure GD extension with Freetype and JPEG support, and install required PHP extensions:
# - pdo and pdo_mysql for MySQL connectivity
# - xml for DOM and SimpleXML (requires libxml2-dev)
# - gd for image processing with JPEG, PNG, and GIF support
# - mbstring for multibyte string handling (requires libonig-dev)
# - curl for HTTP requests
# - zip for ZipArchive support
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install \
        pdo \
        pdo_mysql \
        xml \
        gd \
        mbstring \
        curl \
        zip


# Enable Apache rewrite module
RUN a2enmod rewrite
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy the Apache virtual host template
COPY vhost.conf.template /etc/apache2/sites-available/vhost.conf.template

# Copy the entrypoint script and ensure it is executable
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint to perform environment substitution and then start Apache
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["apache2-foreground"]
