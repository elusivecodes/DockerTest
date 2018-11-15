FROM ubuntu:latest

# Install SPC
RUN apt-get update && apt-get install -y \
    software-properties-common

# Add Repositories
RUN add-apt-repository -y ppa:ondrej/php

ARG DEBIAN_FRONTEND=noninteractive

# Install PHP
RUN apt-get update && apt-get install -y \
    php7.2 \
    php7.2-bcmath \
    php7.2-curl \
    php7.2-fpm \
    php7.2-intl \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-tidy \
    php7.2-xml \
    php7.2-xmlrpc \
    php7.2-zip

# Cleanup Lists
RUN rm -rf /var/lib/apt/lists/*

# Configure FPM
COPY docker.conf /etc/php/7.2/fpm/pool.d
COPY zz-docker.conf /etc/php/7.2/fpm/pool.d

# Create www directory
RUN mkdir /var/www

# Create run/php directory (required)
RUN mkdir /run/php

CMD ["php-fpm7.2"]