FROM tutum/apache-php

MAINTAINER Ben Maggacis, ben.maggacis@qut.edu.au

# Install some dependencies
# NOTE: To make nano work when you run: `docker exec -it <container-id> bash`
#		run: `export TERM=xterm` in terminal first
RUN apt-get update && apt-get install -yq git nano php5-mcrypt openssl postgresql php5-pgsql php5-curl php5-gd && rm -rf /var/lib/apt/lists/*
RUN php5enmod mcrypt
RUN service apache2 restart

# Fix apache config
ADD apache_default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# www-data needs to be able to write 
RUN usermod -u 1000 www-data

# Empty /app directory (polluted by placeholder files)
RUN rm -fr /app

# Mount volumes
VOLUME "/app"

# Expose ports
EXPOSE 80 