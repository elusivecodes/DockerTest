FROM ubuntu:latest

# Install SPC
RUN apt-get update && apt-get install -y \
    software-properties-common

# Add Repositories
RUN add-apt-repository -y ppa:ondrej/apache2

# Install Apache
RUN apt-get update && apt-get install -y apache2

# Cleanup Lists
RUN rm -rf /var/lib/apt/lists/*

# Configure Modules
RUN a2dismod mpm_event && a2enmod mpm_worker && a2enmod expires && a2enmod headers && a2enmod http2 && a2enmod rewrite && a2enmod proxy_fcgi

# Configure Site
COPY app.conf /etc/apache2/sites-available
RUN a2dissite 000-default && a2ensite app

# Configure HTTP2 & FPM
RUN { \
    echo 'Protocols h2 h2c'; \
    echo 'ProxyPassMatch "^/(.*\.php)$" "fcgi://frostphp:9000/var/www/public/"'; \
    } >> /etc/apache2/apache2.conf

# Expose HTTP Port
EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]